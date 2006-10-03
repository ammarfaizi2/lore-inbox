Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWJCRkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWJCRkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWJCRkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:40:25 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:13458 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030369AbWJCRkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:40:24 -0400
Subject: Re: 2.6.18-mm2 networking problem + IRQ panic
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, suka@us.ibm.com
In-Reply-To: <20061002162227.1096ac17.akpm@osdl.org>
References: <1159830432.5039.16.camel@dyn9047017100.beaverton.ibm.com>
	 <20061002162227.1096ac17.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 10:39:54 -0700
Message-Id: <1159897194.9569.4.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 16:22 -0700, Andrew Morton wrote:
..
> yes, this is probably the insert-ioapics-and-local-apic-into-resource-map
> patch.  Does mainline crash too?  It should.  Or at least, it should have
> the same resource allocation errors.

Here is the update. I took -mm2 and backed out that patch. Networking
came up fine. But I still get panic on shutdown :( 

I tried -mm3 and got a panic on boot (so can't really test it).

do_IRQ: cannot handle IRQ -1
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at arch/x86_64/kernel/irq.c:118
invalid opcode: 0000 [1] SMP
last sysfs file: /block/sdo/size
CPU 0
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc
scsi_mod acpi_cpufreq ipv6 thermal processor fan button battery ac
dm_mod floppy parport_pc lp parport
Pid: 30830, comm: init Not tainted 2.6.18-mm2 #3
RIP: 0010:[<ffffffff8020ced0>]  [<ffffffff8020ced0>] do_IRQ+0x60/0xb0
RSP: 0018:ffffffff80733e58  EFLAGS: 00010092
RAX: 0000000000000020 RBX: 00000000ffffffff RCX: ffffffff805f3768
RDX: ffffffff805f3768 RSI: 0000000000000082 RDI: ffffffff805f3760
RBP: ffffffff80733e68 R08: 0000000000000000 R09: ffff81018013fc20
R10: ffffffffffffffff R11: 0000000000000000 R12: ffffffff80733e58
R13: ffff8101c7b63b98 R14: 0000000000000000 R15: 0000000000000004
FS:  000000000058b850(0063) GS:ffffffff80676000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000463f00 CR3: 00000001ccdd4000 CR4: 00000000000006e0
Process init (pid: 30830, threadinfo ffff8101c7b62000, task
ffff8101d14b2780)
Stack:  ffff810175e2a800 0000000000000000 ffffffff80733e80
ffffffff8020a141
 ffffffff80733e80 ffffffff80733f48 0000000000000016 0000000008000000
 00000000000000a7 ffffffff8073d418 0000000000000000 00000000000009a7
Call Trace:
 [<ffffffff8020a141>] ret_from_intr+0x0/0xa
 [<ffffffff803e1c61>] serial8250_interrupt+0x1/0x100
 [<ffffffff80255e03>] handle_IRQ_event+0x33/0x70
 [<ffffffff8025777c>] handle_edge_irq+0x10c/0x160
 [<ffffffff8020cf00>] do_IRQ+0x90/0xb0
 [<ffffffff8020a141>] ret_from_intr+0x0/0xa
 [<ffffffff804da62c>] _spin_unlock_irqrestore+0xc/0x10
 [<ffffffff803e1b39>] serial8250_startup+0x539/0x5c0
 [<ffffffff803dc9fd>] uart_startup+0x8d/0x170
 [<ffffffff803dce21>] uart_open+0x221/0x520
 [<ffffffff803c4ece>] tty_open+0x1ce/0x3b0
 [<ffffffff80285762>] chrdev_open+0x182/0x1d0
 [<ffffffff802806c1>] __dentry_open+0xf1/0x210
 [<ffffffff8028088d>] nameidata_to_filp+0x2d/0x50
 [<ffffffff802808e9>] do_filp_open+0x39/0x50
 [<ffffffff8028095a>] do_sys_open+0x5a/0xf0
 [<ffffffff80280a1b>] sys_open+0x1b/0x20
 [<ffffffff80209c2e>] system_call+0x7e/0x83
 [<0000000000416e22>]


> 
> I've backed that out and applied an updated version.  My current rollup
> (which actually seems to mostly compile now) is at
> 
> http://userweb.kernel.org/~akpm/badari.bz2
> 
> That's against 2.6.18.  Can you see if that fixes things?

I am going to try it now..

Thanks,
Badari



