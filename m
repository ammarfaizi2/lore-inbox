Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312510AbSCUVj6>; Thu, 21 Mar 2002 16:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312513AbSCUVjs>; Thu, 21 Mar 2002 16:39:48 -0500
Received: from harley.unix-ag.uni-siegen.de ([141.99.42.44]:61158 "EHLO
	harley.unix-ag.uni-siegen.de") by vger.kernel.org with ESMTP
	id <S312510AbSCUVja>; Thu, 21 Mar 2002 16:39:30 -0500
Date: Thu, 21 Mar 2002 22:38:24 +0100
From: Fionn Behrens <Fionn.Behrens@unix-ag.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SMP IRQ management issues in 2.4.x
Message-Id: <20020321223824.62fb6f21.fionn@unix-ag.org>
In-Reply-To: <E16o3bM-0005Jz-00@the-village.bc.nu>
Organization: United Fools Of Bugaloo
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002 14:31:36 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > After changing from 2.2.18 to 2.4.17 recently, I noticed that after
> > booting 2.4 my interrupts were routed a lot less effectively than under
> > 2.2
> 
> Can you post both 2.2 and 2.4 tables for comparison

I am afraid this will get slightly problematic since I upgraded several system components (LVM update and some ext2->ext3 partition changes amongst others) which would probably make booting back into a working 2.2 system a rather adventurous task.
I think I'll try to do it tomorrow, however. Hope nothing gets broken.

> > Needless to say that Harddrives connected to ide2 and ide3 (Promise) 
> > constantly lose interrupts when used as long as X is running (nvidia), 
> > bringing the system to crawl.
> 
> You should never be losing interrupts, even with everything on one IRQ line.
> PCI interrupts are level trigger so don't get "lost" in the same way as ISA
> ones did

As a matter of fact I keep getting the following kernel messages when accessing large chunks of data on ide2 or ide2 only while X is running:

Mar 21 09:56:41 localhost kernel: hde: drive not ready for command
Mar 21 09:56:41 localhost kernel: hde: status error: status=0x58 { DriveReady 
                                                   SeekComplete DataRequest }
Mar 21 09:56:41 localhost kernel: hde: drive not ready for command
Mar 21 09:56:41 localhost kernel: hde: write_intr error1: nr_sectors=128, 
                                                                stat=0 xd0
Mar 21 09:56:41 localhost kernel: hde: write_intr: status=0xd0 { Busy }
Mar 21 09:56:41 localhost kernel: ide2: reset: success
Mar 21 09:56:41 localhost kernel: hde: status error: status=0x58 { DriveReady                                                     SeekComplete DataRequest }

[...and so on, mostly without the write_intr error, just status errors...]

When X is not running (aka opencount 0 for nvdriver) all runs smoothly.

Alas, I can't find a way to assign that nv module to its own interrupt.

Regards,
	Fionn
-- 
I believe we have been called by history to lead the world.
                                                       G.W. Bush, 2002-03-01
