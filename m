Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRCTQMK>; Tue, 20 Mar 2001 11:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRCTQMA>; Tue, 20 Mar 2001 11:12:00 -0500
Received: from darkstar.internet-factory.de ([195.122.142.9]:16010 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S130457AbRCTQLx>; Tue, 20 Mar 2001 11:11:53 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: UDMA 100 / PIIX4 question
Date: Tue, 20 Mar 2001 17:11:09 +0100
Organization: Internet Factory AG
Message-ID: <3AB7811D.97601E82@internet-factory.de>
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com> <3AB65F14.26628BEF@coplanar.net> <20010319222113Z131588-406+1752@vger.kernel.org>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 985104670 23556 195.122.142.158 (20 Mar 2001 16:11:10 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 20 Mar 2001 16:11:10 GMT
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quintaq@yahoo.co.uk wrote:
> 
> On Mon, 19 Mar 2001 12:17:38 -0800
> Tim Moore <timothymoore@bigfoot.com> wrote:
> 
> > Apologies for the too brief answer.  Sustained real world transfer rates
> > for the PIIX4 under ideal
> > setup conditions and a quiet bus are 14-18MB/s.

I dare to disagree. These numbers are from an Asus P2L97-DS (Dual P2,
Intel 440LX chipset with PIIX4) with an IBM DTLA 307045:

/dev/hda5:
 Timing buffer-cache reads:   128 MB in  1.21 seconds =105.79 MB/sec
 Timing buffered disk reads:  64 MB in  2.30 seconds = 27.83 MB/sec

/dev/hda5 is the outermost linux partition, starting at cyl 256.

(if you don't count hdparm measurements as real world transfer rates -
linear read as measured by bonnie is 26.3 MB/s).

> There is a Win partition - so I do not think I am at the start of the drive.
> 
> Then  hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.04 seconds =123.08 MB/sec
>  Timing buffered disk reads:  64 MB in  4.08 seconds = 15.69 MB/sec

Would your windows partition by any chance be at the beginning of the
disk?
hdparm speed measurements differ by filesystem (i have no idea why,
since they don't go through it - maybe some interaction with the
buffering code).

if you are testing a windows partition, you can expect to see
significantly lower values for hdparm:

/dev/hda1:
 Timing buffer-cache reads:   128 MB in  1.65 seconds = 77.58 MB/sec
 Timing buffered disk reads:  64 MB in  3.48 seconds = 18.39 MB/sec

Remarkably /dev/hda benches slightly better, even though the 64 MB read
are nearly the same as for hda1:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.40 seconds = 91.43 MB/sec
 Timing buffered disk reads:  64 MB in  3.06 seconds = 20.92 MB/sec

I also noticed that operations on a lot of files (like scanning for all
files in a filesystem as done by updatedb) got really slow with the 2.4
vfat fs, with a very high percentage (in the 90s) of CPU time attributed
to "system". Has anybody else noticed this?

Holger
