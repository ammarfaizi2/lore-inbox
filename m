Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbRCUOHV>; Wed, 21 Mar 2001 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbRCUOHM>; Wed, 21 Mar 2001 09:07:12 -0500
Received: from darkstar.internet-factory.de ([195.122.142.9]:17280 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S131468AbRCUOG7>; Wed, 21 Mar 2001 09:06:59 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: UDMA 100 / PIIX4 question
Date: Wed, 21 Mar 2001 15:06:15 +0100
Organization: Internet Factory AG
Message-ID: <3AB8B557.F384D0F7@internet-factory.de>
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com> <3AB65F14.26628BEF@coplanar.net> <20010319222113Z131588-406+1752@vger.kernel.org> <3AB7811D.97601E82@internet-factory.de> <3AB79464.A7A95A54@coplanar.net>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 985183575 833 195.122.142.158 (21 Mar 2001 14:06:15 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 21 Mar 2001 14:06:15 GMT
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:

> Yes this is why I originally replied to the post... but he's not using a PIIXx at
> all,
> but the IDE chip on an Intel 815 motherboard.  I'm not sure if they use the same
> driver
> , but I don't think so.

I only know i810 systems from experience, but they use a 82801AA which
is still reported as PIIX4 in /proc/ide/piix (so probably is quite
similar, apart from supporting UDMA/66). I assumed that might be the
same for i815.

> > hdparm speed measurements differ by filesystem (i have no idea why,
> 
> this is false.  They may differ by partition, since different parts (zones) of a

i know. i found it hard to believe myself, but the numbers are
consistently lower even on the same partition. i used to have a spare
partition for things like this (hda6 below), unfortunately i cannot
repeat the tests right
now because it is currently in use.

but if it were a matter of different disk zones, only the buffered disk
reads should get slower, not the buffer-cache reads.

> include output of fdisk so we can see partition layout, and results of hdparm on
> different areas.

Disk /dev/hda: 255 heads, 63 sectors, 5606 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       255   2048256    6  FAT16
/dev/hda2           256      5606  42981907+   5  Extended
/dev/hda5           256       511   2056288+  83  Linux
/dev/hda6           512       767   2056288+  83  Linux
/dev/hda7           768      1023   2056288+  83  Linux
/dev/hda8          1024      1089    530113+  82  Linux swap
/dev/hda9          1090      5606  36282771   83  Linux

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.41 seconds = 90.78 MB/sec
 Timing buffered disk reads:  64 MB in  3.04 seconds = 21.05 MB/sec

/dev/hda1:
 Timing buffer-cache reads:   128 MB in  1.66 seconds = 77.11 MB/sec
 Timing buffered disk reads:  64 MB in  3.51 seconds = 18.23 MB/sec

/dev/hda5:
 Timing buffer-cache reads:   128 MB in  1.20 seconds =106.67 MB/sec
 Timing buffered disk reads:  64 MB in  2.32 seconds = 27.59 MB/sec

/dev/hda6:
 Timing buffer-cache reads:   128 MB in  1.20 seconds =106.67 MB/sec
 Timing buffered disk reads:  64 MB in  2.37 seconds = 27.00 MB/sec

/dev/hda7:
 Timing buffer-cache reads:   128 MB in  1.20 seconds =106.67 MB/sec
 Timing buffered disk reads:  64 MB in  2.33 seconds = 27.47 MB/sec

/dev/hda8:
 Timing buffer-cache reads:   128 MB in  1.21 seconds =105.79 MB/sec
 Timing buffered disk reads:  64 MB in  2.31 seconds = 27.71 MB/sec

/dev/hda9:
 Timing buffer-cache reads:   128 MB in  1.21 seconds =105.79 MB/sec
 Timing buffered disk reads:  64 MB in  2.30 seconds = 27.83 MB/sec

the kernel is 2.4.2ac18 btw. i know its not the most recent, but that
shouldn't matter. this behaviour has been there for a long time. i am
not even sure if this was ever any different.

holger
