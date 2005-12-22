Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVLVSiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVLVSiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVLVSiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:38:00 -0500
Received: from ns1.siteground.net ([207.218.208.2]:6363 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030181AbVLVSh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:37:59 -0500
Date: Thu, 22 Dec 2005 10:37:50 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, clameter@sgi.com,
       anton@samba.org, shai@scalex86.org, sonnyrao@us.ibm.com,
       alokk@calsoftinc.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051222183750.GA3704@localhost.localdomain>
References: <20051219051659.GA6299@kevlar.burdell.org> <20051222092743.GE3915@localhost.localdomain> <20051222173700.GA5723@localhost.localdomain> <20051222175311.GA22393@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222175311.GA22393@kevlar.burdell.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:53:11PM -0500, Sonny Rao wrote:
> On Thu, Dec 22, 2005 at 11:37:00AM -0600, Sonny Rao wrote:
> > On Thu, Dec 22, 2005 at 01:27:43AM -0800, Ravikiran G Thirumalai wrote:
> > > On Mon, Dec 19, 2005 at 12:16:59AM -0500, Sonny Rao wrote:
> > > > (apologies if this is a dup)
> > > ...
> > > Sonny,
> > > Does this patch fix the issue?   This one applies cleanly on 2.6.15-rc6
> > > unlike the one that was sent to you earlier.
> > 
> > Hi, thanks, now I'm getting a slightly different error, 
> > hitting a BUG in the slab debug code:
> > 
> > ihplus:~ # echo 0 > /sys/devices/system/cpu/cpu14/online 
> > cpu 0x4: Vector: 700 (Program Check) at [c0000003a8c233f0]
> >     pc: c00000000009bb2c: .check_slabp+0x130/0x188
> >     lr: c00000000009bb28: .check_slabp+0x12c/0x188
> >     sp: c0000003a8c23670
> >    msr: 8000000000021032
> >   current = 0xc0000001b95297f0
> >   paca    = 0xc0000000005d7000
> >     pid   = 11116, comm = bash
> > kernel BUG in check_slabp at mm/slab.c:2368!
> > enter ? for help
> > 
> > 
> > 4:mon> t
> > [c0000003a8c23700] c00000000009d918 .free_block+0x168/0x294
> > [c0000003a8c237e0] c00000000009d1dc .kfree+0x2b8/0x2d4
> > [c0000003a8c238a0] c0000000000a1644 .cpuup_callback+0x144/0x618
> > [c0000003a8c239b0] c0000000004a0780 .notifier_call_chain+0x68/0x9c
> > [c0000003a8c23a40] c00000000007d608 .cpu_down+0x1fc/0x358
> > [c0000003a8c23b30] c0000000002bb4ec .store_online+0x88/0xe8
> > [c0000003a8c23bc0] c0000000002b5c14 .sysdev_store+0x4c/0x68
> > [c0000003a8c23c40] c000000000119c6c .sysfs_write_file+0x118/0x1bc
> > [c0000003a8c23cf0] c0000000000c6078 .vfs_write+0x100/0x200
> > [c0000003a8c23d90] c0000000000c6288 .sys_write+0x54/0x9c
> > [c0000003a8c23e30] c000000000008600 syscall_exit+0x0/0x18
> > --- Exception: c01 (System Call) at 000000000fe5ec10
> > SP (ff865560) is in userspace
> 
> More details: 
> 
> The above crash was with SMT on, and I had already off-lined the SMT
> sibling thread.  
> 
> When I boot with SMT off, I get a slightly different crash:

I think i missed the first reply above. (I can't seem to find it on lkml
either).  So just to confirm, both these crashes are with the new patch on
top of rc6?

Thanks,
Kiran
 
> 
> ihplus:~ # echo 0 > /sys/devices/system/cpu/cpu14/online 
> cpu 0x0: Vector: 700 (Program Check) at [c0000003afa13480]
>     pc: c00000000009d960: .free_block+0x1b0/0x294
>     lr: c00000000009d95c: .free_block+0x1ac/0x294
>     sp: c0000003afa13700
>    msr: 8000000000021032
>   current = 0xc0000003afe04000
>   paca    = 0xc0000000005d5000
>     pid   = 10998, comm = bash
> kernel BUG in free_block at mm/slab.c:2664!
> enter ? for help
> 
> 0:mon> t
> [c0000003afa137e0] c00000000009d1dc .kfree+0x2b8/0x2d4
> [c0000003afa138a0] c0000000000a1644 .cpuup_callback+0x144/0x618
> [c0000003afa139b0] c0000000004a0780 .notifier_call_chain+0x68/0x9c
> [c0000003afa13a40] c00000000007d608 .cpu_down+0x1fc/0x358
> [c0000003afa13b30] c0000000002bb4ec .store_online+0x88/0xe8
> [c0000003afa13bc0] c0000000002b5c14 .sysdev_store+0x4c/0x68
> [c0000003afa13c40] c000000000119c6c .sysfs_write_file+0x118/0x1bc
> [c0000003afa13cf0] c0000000000c6078 .vfs_write+0x100/0x200
> [c0000003afa13d90] c0000000000c6288 .sys_write+0x54/0x9c
> [c0000003afa13e30] c000000000008600 syscall_exit+0x0/0x18
> --- Exception: c01 (System Call) at 000000000fe5ec10
> SP (ff8b4560) is in userspace
> 
> This one points to a double free somewhere
> 
> 
