Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287793AbSAFKWq>; Sun, 6 Jan 2002 05:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287794AbSAFKW0>; Sun, 6 Jan 2002 05:22:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7940 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287793AbSAFKWQ>;
	Sun, 6 Jan 2002 05:22:16 -0500
Date: Sun, 6 Jan 2002 11:21:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
Message-ID: <20020106112129.D8673@suse.de>
In-Reply-To: <Pine.LNX.4.10.10201050904070.1001-100000@pingu.franken.de> <Pine.LNX.4.40.0201051506170.1607-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201051506170.1607-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05 2002, Davide Libenzi wrote:
> > > (*) 100MHz 486DX4, 28MB ram, no L2 cache, two old and slow IDE disks,
> > > small custom no-nonsense RedHat 7.2, kernels compiled with gcc 2.95.3.
> >
> > Is this ISA (maybe it has something to do with ISA bouncing)? Mine is:
> >
> > 486 DX/2 ISA, Adaptec 1542, two slow scsi disks and a self-made
> > slackware-based system.
> >
> > Can you also backout the scheduler changes to verify this? I have a
> > backout patch for 2.5.2-pre6, if you don't want to do this for yourself.
> 
> There should be some part of the kernel that assume a certain scheduler
> behavior. There was a guy that reported a bad  hdparm  performance and i
> tried it. By running  hdparm -t  my system has a context switch of 20-30
> and an irq load of about 100-110.
> The scheduler itself, even if you code it in visual basic, cannot make
> this with such loads.
> Did you try to profile the kernel ?

Davide,

If this is caused by ISA bounce problems, then you should be able to
reproduce by doing something ala

[ drivers/ide/ide-dma.c ]

ide_toggle_bounce()
{
	...

+	addr = BLK_BOUNCE_ISA;
	blk_queue_bounce_limit(&drive->queue, addr);
}

pseudo-diff, just add the addr = line. Now compare performance with and
without your scheduler changes.

-- 
Jens Axboe

