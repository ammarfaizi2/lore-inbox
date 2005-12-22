Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVLVTpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVLVTpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 14:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVLVTpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 14:45:52 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:14830
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S965043AbVLVTpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 14:45:51 -0500
Date: Thu, 22 Dec 2005 14:45:11 -0500
From: Sonny Rao <sonny@burdell.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, clameter@sgi.com,
       anton@samba.org, shai@scalex86.org, sonnyrao@us.ibm.com,
       alokk@calsoftinc.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051222194511.GB24385@kevlar.burdell.org>
References: <20051219051659.GA6299@kevlar.burdell.org> <20051222092743.GE3915@localhost.localdomain> <20051222173700.GA5723@localhost.localdomain> <20051222175311.GA22393@kevlar.burdell.org> <20051222183750.GA3704@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222183750.GA3704@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 10:37:50AM -0800, Ravikiran G Thirumalai wrote:
> On Thu, Dec 22, 2005 at 12:53:11PM -0500, Sonny Rao wrote:
> > On Thu, Dec 22, 2005 at 11:37:00AM -0600, Sonny Rao wrote:
> > > On Thu, Dec 22, 2005 at 01:27:43AM -0800, Ravikiran G Thirumalai wrote:
> > > > On Mon, Dec 19, 2005 at 12:16:59AM -0500, Sonny Rao wrote:
> > > > > (apologies if this is a dup)
> > > > ...
> > > > Sonny,
> > > > Does this patch fix the issue?   This one applies cleanly on 2.6.15-rc6
> > > > unlike the one that was sent to you earlier.
> > > 
> > > Hi, thanks, now I'm getting a slightly different error, 
> > > hitting a BUG in the slab debug code:
> > > 
> > > ihplus:~ # echo 0 > /sys/devices/system/cpu/cpu14/online 
> > > cpu 0x4: Vector: 700 (Program Check) at [c0000003a8c233f0]
> > >     pc: c00000000009bb2c: .check_slabp+0x130/0x188
> > >     lr: c00000000009bb28: .check_slabp+0x12c/0x188
> > >     sp: c0000003a8c23670
> > >    msr: 8000000000021032
> > >   current = 0xc0000001b95297f0
> > >   paca    = 0xc0000000005d7000
> > >     pid   = 11116, comm = bash
> > > kernel BUG in check_slabp at mm/slab.c:2368!
> > > enter ? for help
> > > 
> > > 
> > > 4:mon> t
> > > [c0000003a8c23700] c00000000009d918 .free_block+0x168/0x294
> > > [c0000003a8c237e0] c00000000009d1dc .kfree+0x2b8/0x2d4
> > > [c0000003a8c238a0] c0000000000a1644 .cpuup_callback+0x144/0x618
> > > [c0000003a8c239b0] c0000000004a0780 .notifier_call_chain+0x68/0x9c
> > > [c0000003a8c23a40] c00000000007d608 .cpu_down+0x1fc/0x358
> > > [c0000003a8c23b30] c0000000002bb4ec .store_online+0x88/0xe8
> > > [c0000003a8c23bc0] c0000000002b5c14 .sysdev_store+0x4c/0x68
> > > [c0000003a8c23c40] c000000000119c6c .sysfs_write_file+0x118/0x1bc
> > > [c0000003a8c23cf0] c0000000000c6078 .vfs_write+0x100/0x200
> > > [c0000003a8c23d90] c0000000000c6288 .sys_write+0x54/0x9c
> > > [c0000003a8c23e30] c000000000008600 syscall_exit+0x0/0x18
> > > --- Exception: c01 (System Call) at 000000000fe5ec10
> > > SP (ff865560) is in userspace
> > 
> > More details: 
> > 
> > The above crash was with SMT on, and I had already off-lined the SMT
> > sibling thread.  
> > 
> > When I boot with SMT off, I get a slightly different crash:
> 
> I think i missed the first reply above. (I can't seem to find it on lkml
> either).  So just to confirm, both these crashes are with the new patch on
> top of rc6?
> 
> Thanks,
> Kiran
>  
> > 
> > ihplus:~ # echo 0 > /sys/devices/system/cpu/cpu14/online 
> > cpu 0x0: Vector: 700 (Program Check) at [c0000003afa13480]
> >     pc: c00000000009d960: .free_block+0x1b0/0x294
> >     lr: c00000000009d95c: .free_block+0x1ac/0x294
> >     sp: c0000003afa13700
> >    msr: 8000000000021032
> >   current = 0xc0000003afe04000
> >   paca    = 0xc0000000005d5000
> >     pid   = 10998, comm = bash
> > kernel BUG in free_block at mm/slab.c:2664!
> > enter ? for help
> > 
> > 0:mon> t
> > [c0000003afa137e0] c00000000009d1dc .kfree+0x2b8/0x2d4
> > [c0000003afa138a0] c0000000000a1644 .cpuup_callback+0x144/0x618
> > [c0000003afa139b0] c0000000004a0780 .notifier_call_chain+0x68/0x9c
> > [c0000003afa13a40] c00000000007d608 .cpu_down+0x1fc/0x358
> > [c0000003afa13b30] c0000000002bb4ec .store_online+0x88/0xe8
> > [c0000003afa13bc0] c0000000002b5c14 .sysdev_store+0x4c/0x68
> > [c0000003afa13c40] c000000000119c6c .sysfs_write_file+0x118/0x1bc
> > [c0000003afa13cf0] c0000000000c6078 .vfs_write+0x100/0x200
> > [c0000003afa13d90] c0000000000c6288 .sys_write+0x54/0x9c
> > [c0000003afa13e30] c000000000008600 syscall_exit+0x0/0x18
> > --- Exception: c01 (System Call) at 000000000fe5ec10
> > SP (ff8b4560) is in userspace
> > 
> > This one points to a double free somewhere

Hi, I think I've found the double free in the rc6 kernel + your patch :

starting on line 949 of the patched slab.c

                        if ((shared = l3->shared)) {
                                free_block(cachep, l3->shared->entry,
                                                l3->shared->avail, node);
                                kfree(l3->shared);
                                l3->shared = NULL;
                        }

                        alien = l3->alien;
                        l3->alien = NULL;

                        spin_unlock(&l3->list_lock);

                        kfree(nc);
                        kfree(shared);


You conditionally free l3->shared after assigning it to the auto var "shared"
then below that you call kfree on "shared" again == double free.

So, I got rid of the extra free.  I don't know if this was correct but
I tried it anyway.  Unfortunately this still does not work correctly.
The system hangs for a period of time and then drops into the debugger
again: 

0:mon> t
[c00000000f71f890] c00000000049e5ec ._spin_lock+0x10/0x24
[c00000000f71f910] c00000000009d550 .kmem_cache_free+0x270/0x2a4
[c00000000f71f9d0] c0000000003f35e8 .kfree_skbmem+0xa0/0xfc
[c00000000f71fa50] c00000000044d01c .udp_rcv+0x7ac/0x818
[c00000000f71fb60] c000000000420b14 .ip_local_deliver+0xf8/0x3f0
[c00000000f71fbf0] c000000000420328 .ip_rcv+0x3a8/0x724
[c00000000f71fc90] c0000000003fa054 .netif_receive_skb+0x378/0x3d0
[c00000000f71fd30] c0000000003fa1c4 .process_backlog+0x118/0x254
[c00000000f71fe10] c0000000003f7d3c .net_rx_action+0x188/0x2b8
[c00000000f71fed0] c000000000060f18 .__do_softirq+0xd4/0x1b8
[c00000000f71ff90] c00000000002c78c .call_do_softirq+0x14/0x24
[c0000000005ab870] c00000000000bd30 .do_softirq+0x8c/0x9c
[c0000000005ab900] c00000000006143c .irq_exit+0x6c/0x84
[c0000000005ab980] c00000000000c060 .do_IRQ+0xe8/0x194
[c0000000005aba10] c000000000004134 hardware_interrupt_entry+0x8/0x54
--- Exception: 501 (Hardware Interrupt) at c000000000040670
.pseries_dedicated_idle+0x114/0x268
[c0000000005abde0] c000000000021048 .cpu_idle+0x4c/0x60
[c0000000005abe50] c0000000000091f4 .rest_init+0x44/0x5c
[c0000000005abed0] c00000000054e7f4 .start_kernel+0x29c/0x318
[c0000000005abf90] c000000000008494 .hmt_init+0x0/0x6c
0:mon> 

0:mon> e
cpu 0x0: Vector: 300 (Data Access) at [c00000000f71f580]
    pc: c000000000238db4: ._raw_spin_lock+0x2c/0x1d0
    lr: c00000000049e5ec: ._spin_lock+0x10/0x24
    sp: c00000000f71f800
   msr: 8000000000001032
   dar: 4c
 dsisr: 40000000
  current = 0xc00000000061b2f0
  paca    = 0xc0000000005d5000
    pid   = 0, comm = swapper
0:mon> 


