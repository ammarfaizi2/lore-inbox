Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287804AbSAFKiu>; Sun, 6 Jan 2002 05:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287802AbSAFKij>; Sun, 6 Jan 2002 05:38:39 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11023
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287794AbSAFKiY>; Sun, 6 Jan 2002 05:38:24 -0500
Date: Sun, 6 Jan 2002 02:33:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>, Matthias Hanisch <mjh@vr-web.de>,
        Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <20020106112129.D8673@suse.de>
Message-ID: <Pine.LNX.4.10.10201060232210.24436-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Jens Axboe wrote:

> On Sat, Jan 05 2002, Davide Libenzi wrote:
> > > > (*) 100MHz 486DX4, 28MB ram, no L2 cache, two old and slow IDE disks,
> > > > small custom no-nonsense RedHat 7.2, kernels compiled with gcc 2.95.3.
> > >
> > > Is this ISA (maybe it has something to do with ISA bouncing)? Mine is:
> > >
> > > 486 DX/2 ISA, Adaptec 1542, two slow scsi disks and a self-made
> > > slackware-based system.
> > >
> > > Can you also backout the scheduler changes to verify this? I have a
> > > backout patch for 2.5.2-pre6, if you don't want to do this for yourself.
> > 
> > There should be some part of the kernel that assume a certain scheduler
> > behavior. There was a guy that reported a bad  hdparm  performance and i
> > tried it. By running  hdparm -t  my system has a context switch of 20-30
> > and an irq load of about 100-110.
> > The scheduler itself, even if you code it in visual basic, cannot make
> > this with such loads.
> > Did you try to profile the kernel ?
> 
> Davide,
> 
> If this is caused by ISA bounce problems, then you should be able to
> reproduce by doing something ala
> 
> [ drivers/ide/ide-dma.c ]
> 
> ide_toggle_bounce()
> {
> 	...
> 
> +	addr = BLK_BOUNCE_ISA;
> 	blk_queue_bounce_limit(&drive->queue, addr);
> }

Jens, how about getting a hardware list because I have prime2/3 ISA DMA
cards.  Just not ready to test in 2.5.

Regards,


Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

