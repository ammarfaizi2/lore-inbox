Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUG0HPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUG0HPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUG0HPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:15:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5762 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266303AbUG0HNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:13:09 -0400
Date: Tue, 27 Jul 2004 03:15:24 -0200
From: Jens Axboe <axboe@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: max request size 1024KiB by default?
Message-ID: <20040727051524.GD1433@suse.de>
References: <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu> <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu> <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe> <1090647952.1006.7.camel@mindpipe> <20040724112706.GA31077@ss1000.ms.mff.cuni.cz> <1090709881.1194.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090709881.1194.28.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24 2004, Lee Revell wrote:
> On Sat, 2004-07-24 at 07:27, Rudo Thomas wrote:
> > > HD info:
> > > /dev/hdc:
> > > 
> > >  Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y44K8TZE
> > >  Config={ Fixed }
> > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
> > >  CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=268435455
> > >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> > >  PIO modes:  pio0 pio1 pio2 pio3 pio4 
> > >  DMA modes:  mdma0 mdma1 mdma2 
> > >  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
> > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> > >  Drive conforms to: (null): 
> > 
> 
> Your disk controller must not support that.  It looks like the default
> is 1024KiB or whatever the max your controller supports is:
> 
> drivers/ide/ide-disk.c:
> 
>          if (drive->addressing == 1) { 
>                 ide_hwif_t *hwif = HWIF(drive);
>                 int max_s = 2048; 
> 
>                 if (max_s > hwif->rqsize)
>                         max_s = hwif->rqsize;
> 
>                 blk_queue_max_sectors(drive->queue, max_s); 
>         }

It's the drive. lba28 cannot do more than 256 sectors, while lba48 can
do 65536. The controller only has an impact on this if it's buggy.

-- 
Jens Axboe

