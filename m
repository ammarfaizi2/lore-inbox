Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbTGSCKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 22:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270473AbTGSCKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 22:10:30 -0400
Received: from ip144-173-busy.ott.istop.com ([66.11.173.144]:9478 "EHLO
	worf.vpn") by vger.kernel.org with ESMTP id S270439AbTGSCK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 22:10:28 -0400
Date: Fri, 18 Jul 2003 22:25:25 -0400
From: Christian Mautner <linux@mautner.ca>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at kernel/timer.c:380!
Message-ID: <20030719022525.GA18446@mautner.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a very reproducible problem with 2.6.0-test1. 
The system is a fairly recent installation of Debian Sarge.

Linux version 2.6.0-test1 (chm@data) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Thu Jul 17 18:03:58 EDT 2003

The hardware is a VIA board. Can't tell what exactly it is, it's not
mine. I have no manual.

vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Ezra
stepping        : 8
cpu MHz         : 665.148

eth0, eth1, eth2: RealTek RTL8139 Fast Ethernet (8139too.c)

I am experimenting with the ethernet bridging code. I do:

% brctl addbr br0
% brctl stp br0 off
% brctl addif br0 eth1
% brctl addif br0 eth2
% 
% ifconfig eth1 up
% ifconfig eth2 up
% ifconfig br0 up

At which point the kernel tells me:

--------------------------------------------------------------------------------

kernel BUG at kernel/timer.c:380!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0126c6a>]    Not tainted
EFLAGS: 00010007
EIP is at cascade+0x3e/0x48
eax: cc171074   ebx: cc171074   ecx: 00048600   edx: cf757e98
esi: c02fb850   edi: c02fb000   ebp: c035ff28   esp: c035ff1c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c035e000 task=c02f8420)
Stack: 00000000 c0396608 c035e000 c035ff58 c012736e c02fb000 c02fb820 00000006 
       c02f9ec0 c035ff40 c035ff40 c035ff68 00000001 c0396608 fffffffd c035ff74 
       c012283b c0396608 00000046 c035e000 c035e000 00000002 c035ff94 c010d6b1 
Call Trace:
 [<c012736e>] run_timer_softirq+0x316/0x3c8
 [<c012283b>] do_softirq+0x9f/0xa4
 [<c010d6b1>] do_IRQ+0x221/0x328
 [<c0108a2c>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0xd0
 [<c010bbd4>] common_interrupt+0x18/0x20
 [<c0108a2c>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0xd0
 [<c0108a52>] default_idle+0x26/0x30
 [<c0108abd>] cpu_idle+0x29/0x3c
 [<c03606b1>] start_kernel+0x1c5/0x224

Code: 0f 0b 7c 01 07 dd 2c c0 eb d7 0f bf 05 36 c0 2f c0 55 03 05 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

--------------------------------------------------------------------------------

If I do the steps mentioned above in different order, e.g. ifconfig
eth[12] up first, then it might not happen. But if I do it exactly as
said, the bug happens reliably.

The .config is available at http://66.11.173.144/tmp/config-2.6.0-test1
everything else on request.

chm.

-- 
christian mautner -- chm bei istop punkt com -- ottawa, canada
