Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbTCWDlw>; Sat, 22 Mar 2003 22:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTCWDlw>; Sat, 22 Mar 2003 22:41:52 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:36939
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262276AbTCWDlu>; Sat, 22 Mar 2003 22:41:50 -0500
Date: Sat, 22 Mar 2003 22:49:19 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2
In-Reply-To: <Pine.LNX.4.50.0303212048200.28519-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303222240330.18911-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303210202080.2133-100000@montezuma.mastecende.com>
 <411800000.1048276482@aslan.btc.adaptec.com>
 <Pine.LNX.4.50.0303211842370.28519-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0303212042000.28519-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0303212048200.28519-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Zwane Mwaikambo wrote:

> Actually, please disregard that last oops i looked at the version numbers 
> and they can't have been right. i don't think i booted the right image.
> 
> Here are some oopses with 6.2.30, there does appear to be a relation wrt 
> interrupt routing because if i boot with noapic it passes the boot test 
> and appears to be functional. If you have any more suggestions please send 
> them my way, i shall also be trying a number of things.

Hi Justin,
	Ok i enabled the second IOAPIC on my system which didn't make a 
difference really apart from changing the IRQ assignments. However booting 
the same SMP kernel with maxcpus=1 (IRQ assignments remains the same and 
devices are serviced by IOAPIC) i can't reproduce the oopses. Here is 
one w/o maxcpus... The reason why noapic worked before is because only one cpu was 
servicing interrupts, however we are serialized per irq line...

Starting system logger: Unable to handle kernel paging request at virtual 
address 6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<6b6b6b6b>]    Not tainted
EFLAGS: 00010002 VLI
EIP is at 0x6b6b6b6b
eax: c17bda10   ebx: 00000000   ecx: cbe31290   edx: 00000000
esi: 00000001   edi: c0511fa0   ebp: 0000001d   esp: c0511f20
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0510000 task=c04a12a0)
Stack: c02ff2dc c17bda10 c17bda10 cbe31290 c0305807 cbe31290 c17bda10 00000296 
       c011bceb c0511f44 cbffe4f4 04000001 c010bb0d 0000001d cbe31290 c0511fa0 
       c05063a0 c0510000 c0510000 0000001d c010be49 0000001d c0511fa0 cbffe4f4 
Call Trace:
 [<c02ff2dc>] ahc_linux_run_complete_queue+0x3c/0x50
 [<c0305807>] ahc_linux_isr+0x1d7/0x3a0
 [<c011bceb>] rebalance_tick+0x3b/0x100
 [<c010bb0d>] handle_IRQ_event+0x2d/0x50
 [<c010be49>] do_IRQ+0x109/0x210
 [<c0106ea0>] default_idle+0x0/0x40
 [<c010a398>] common_interrupt+0x18/0x20
 [<c0106ea0>] default_idle+0x0/0x40
 [<c0106ece>] default_idle+0x2e/0x40
 [<c0106f5a>] cpu_idle+0x3a/0x50
 [<c0105000>] rest_init+0x0/0x80

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

-- 
function.linuxpower.ca
