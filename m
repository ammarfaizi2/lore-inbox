Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRCTRlE>; Tue, 20 Mar 2001 12:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRCTRko>; Tue, 20 Mar 2001 12:40:44 -0500
Received: from smtp2.sentex.ca ([199.212.134.9]:34574 "EHLO smtp2.sentex.ca")
	by vger.kernel.org with ESMTP id <S130531AbRCTRke>;
	Tue, 20 Mar 2001 12:40:34 -0500
Message-ID: <3AB79464.A7A95A54@coplanar.net>
Date: Tue, 20 Mar 2001 12:33:25 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Holger Lubitz <h.lubitz@internet-factory.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com> <3AB65F14.26628BEF@coplanar.net> <20010319222113Z131588-406+1752@vger.kernel.org> <3AB7811D.97601E82@internet-factory.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Lubitz wrote:

> quintaq@yahoo.co.uk wrote:
> >
> > On Mon, 19 Mar 2001 12:17:38 -0800
> > Tim Moore <timothymoore@bigfoot.com> wrote:
> >
> > > Apologies for the too brief answer.  Sustained real world transfer rates
> > > for the PIIX4 under ideal
> > > setup conditions and a quiet bus are 14-18MB/s.
>
> I dare to disagree. These numbers are from an Asus P2L97-DS (Dual P2,
> Intel 440LX chipset with PIIX4) with an IBM DTLA 307045:

Yes this is why I originally replied to the post... but he's not using a PIIXx at
all,
but the IDE chip on an Intel 815 motherboard.  I'm not sure if they use the same
driver
, but I don't think so.

>
>
> /dev/hda5:
>  Timing buffer-cache reads:   128 MB in  1.21 seconds =105.79 MB/sec
>  Timing buffered disk reads:  64 MB in  2.30 seconds = 27.83 MB/sec
>
> /dev/hda5 is the outermost linux partition, starting at cyl 256.
>
> (if you don't count hdparm measurements as real world transfer rates -
> linear read as measured by bonnie is 26.3 MB/s).
>
> > There is a Win partition - so I do not think I am at the start of the drive.
> >
> > Then  hdparm -tT /dev/hda
> >
> > /dev/hda:
> >  Timing buffer-cache reads:   128 MB in  1.04 seconds =123.08 MB/sec
> >  Timing buffered disk reads:  64 MB in  4.08 seconds = 15.69 MB/sec
>
> Would your windows partition by any chance be at the beginning of the
> disk?
> hdparm speed measurements differ by filesystem (i have no idea why,

this is false.  They may differ by partition, since different parts (zones) of a
modern disk have different recording densities and therefore transfer rates.
IBM's spec sheet says rates vary from 15MB/sec to 31MB/sec... it he's seeing
15MB/sec, maybe he should try the other end of the disk.  can you verify this?
try hdparm -t /dev/hda1 instead of hda5 (if those are on opposite ends of the
disk)

include output of fdisk so we can see partition layout, and results of hdparm on
different areas.

>
> since they don't go through it - maybe some interaction with the
> buffering code).
>
> if you are testing a windows partition, you can expect to see
> significantly lower values for hdparm:
>
> /dev/hda1:
>  Timing buffer-cache reads:   128 MB in  1.65 seconds = 77.58 MB/sec
>  Timing buffered disk reads:  64 MB in  3.48 seconds = 18.39 MB/sec

please show us your partition table.

>
>
> Remarkably /dev/hda benches slightly better, even though the 64 MB read
> are nearly the same as for hda1:
>
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.40 seconds = 91.43 MB/sec
>  Timing buffered disk reads:  64 MB in  3.06 seconds = 20.92 MB/sec
>
> I also noticed that operations on a lot of files (like scanning for all
> files in a filesystem as done by updatedb) got really slow with the 2.4
> vfat fs, with a very high percentage (in the 90s) of CPU time attributed
> to "system". Has anybody else noticed this?

