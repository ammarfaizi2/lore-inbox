Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUGXW6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUGXW6I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 18:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGXW6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 18:58:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29665 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263003AbUGXW6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 18:58:02 -0400
Subject: Re: max request size 1024KiB by default?
From: Lee Revell <rlrevell@joe-job.com>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040724112706.GA31077@ss1000.ms.mff.cuni.cz>
References: <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe>
	 <1090647952.1006.7.camel@mindpipe>
	 <20040724112706.GA31077@ss1000.ms.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1090709881.1194.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 18:58:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 07:27, Rudo Thomas wrote:
> > HD info:
> > /dev/hdc:
> > 
> >  Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y44K8TZE
> >  Config={ Fixed }
> >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
> >  CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=268435455
> >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes:  pio0 pio1 pio2 pio3 pio4 
> >  DMA modes:  mdma0 mdma1 mdma2 
> >  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
> >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> >  Drive conforms to: (null): 
> 

Your disk controller must not support that.  It looks like the default
is 1024KiB or whatever the max your controller supports is:

drivers/ide/ide-disk.c:

         if (drive->addressing == 1) { 
                ide_hwif_t *hwif = HWIF(drive);
                int max_s = 2048; 

                if (max_s > hwif->rqsize)
                        max_s = hwif->rqsize;

                blk_queue_max_sectors(drive->queue, max_s); 
        }


Lee

