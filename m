Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265758AbUFDL5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbUFDL5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUFDL4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:56:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26035 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265741AbUFDL4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:56:19 -0400
Date: Fri, 4 Jun 2004 13:56:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: mattia <mattia@nixlab.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: DriveReady SeekComplete Error
Message-ID: <20040604115613.GW1946@suse.de>
References: <E1BWBjw-0003QZ-1h@andromeda.hostvector.com> <20040604102258.GR1946@suse.de> <200406041344.30738.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406041344.30738.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> On Friday 04 of June 2004 12:22, Jens Axboe wrote:
> > damnit, don't trim the cc list!
> >
> > On Fri, Jun 04 2004, mattia wrote:
> > > I have the following error (kernel 2.6.6):
> > >
> > > Jun  4 08:05:43 blink kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > Jun  4 08:05:43 blink kernel: hdc: Maxtor 6Y160P0, ATA DISK drive
> > > Jun  4 08:05:43 blink kernel: hdd: Maxtor 6Y120L0, ATA DISK drive
> > > Jun  4 08:05:43 blink kernel: ide1 at 0x170-0x177,0x376 on irq 15
> > > Jun  4 08:05:43 blink kernel: hda: max request size: 128KiB
> > > Jun  4 08:05:43 blink kernel: hda: 78177792 sectors (40027 MB) w/1819KiB
> > > Cache, CHS=65535/16/63, UDMA(100)
> > > Jun  4 08:05:43 blink kernel:  hda: hda1 hda2 hda3
> > > Jun  4 08:05:43 blink kernel: hdc: max request size: 1024KiB
> > > Jun  4 08:05:43 blink kernel: hdc: 320173056 sectors (163928 MB)
> > > w/7936KiB Cache, CHS=19929/255/63, UDMA(100)
> > > Jun  4 08:05:43 blink kernel:  hdc: hdc1
> > > Jun  4 08:05:43 blink kernel: hdd: max request size: 128KiB
> > > Jun  4 08:05:43 blink kernel: hdd: 240121728 sectors (122942 MB)
> > > w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> > > Jun  4 08:05:43 blink kernel:  hdd: hdd1 hdd2 hdd3
> > > Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: status=0x51 {
> > > DriveReady SeekComplete Error }
> > > Jun  4 08:05:43 blink kernel: hdd: task_no_data_intr: error=0x04 {
> > > DriveStatusError }
> > > Jun  4 08:05:43 blink kernel: hdd: Write Cache FAILED Flushing!
> > >
> > >
> > > I found somewhere that's something wrong with that maxtor drive.
> > > However, everything works fine.
> >
> > There's nothing wrong with the drive technically, it's just odd (lba48
> > without FLUSH_CACHE_EXT). It's really a linux ide bug that's fixed in
> > newer kernels. 2.6.7 will fix your problem.
> 
> Wrong.
> 
> Bug is a combination of a very minor firmware quirk
> and lack of strict checking in Linux IDE driver.
> 
> FLUSH_CACHE_EXT bit is set but it is not supported
> (but it is not a problem because LBA48 is not supported also).

Ah my bad, I didn't realize this bit was actually set correctly (you
mean (cfs_enable_2 & 0x2400) == 0x2400 is actually true?).

> It is fixed in 2.6.7-rc1 but your IDE barrier patch has this problem
> (just reminding you that it is still not fixed in 2.6.7-rc2-mm2).

So where's the bug? I don't see it...

-- 
Jens Axboe

