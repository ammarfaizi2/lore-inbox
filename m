Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUAMGza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 01:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUAMGza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 01:55:30 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:43661 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263777AbUAMGzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 01:55:24 -0500
Date: Mon, 12 Jan 2004 22:51:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: thomasz@hostmaster.org
Subject: [Bug 1855] New: de4x5 does not work with SMP 
Message-ID: <901390000.1073976719@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1855

           Summary: de4x5 does not work with SMP
    Kernel Version: 2.6.1
            Status: NEW
          Severity: high
             Owner: jgarzik@pobox.com
         Submitter: thomasz@hostmaster.org


I am successfully using a "Digital Equipment Corporation DECchip 21041[Tulip
Pass 3] (rev 11)" with the de4x5 driver under linux 2.4.*. Linux 2.6.1 works
fine when compiled for UP but when compiled for SMP it does lockup within
milliseconds after bringing up the network interface. After enabling the NMI
watchdog I received the following oops message (copied manually, case not
preserved, typos possible):

NMI watchdog detected lockup on cpu0, eip e29a1528, registers:
cpu0: 0
eip: 0060:[<e29a1528>] not tainted
eflags: 00000086
eip is at .text.lock.de4x5+0x30/0x78 [de4x5]
eax: 00000040 ebx: 00000282 ecx: c03ef194 edx: 00000000
esi: df5a1200 edi: df5a1000 ebp: 0000c400 esp: c047bee0
ds: 007b es: 007b ss: 0068
process swapper (pid: 0, threadinfo=c047a000 task=c03ec980)
Stack: df5a1000 df5a1200 00000001 df5a1000 000000fa e299a873 df5a1000 00001010
00001010 0000ef01 0000ff3f 00000008 00000960 df5a1200 df5a1000 000000fa
c047bf50 e299955c df5a1000 00000007 e29994d0 df5a16f8 c150b520 c0127717
call trace:
e299a873 dc21041_autoconf+0x223/0x630 de4x5
e299955c de4x5_ast+0x8c/0xb0 de4x5
e29994d0 de4x5_ast+0x0/0xb0 de4x5
c0127717 run_timer_softirq+0xd7/0x190
c0122fc7 do_softirq+0xc7/0xd0
c0115bfd smp_apic_timer_interrupt+0xcd/0x140
c0105000 rest_init+0x0/0x50
c0109a0e apic_timer_interrupt+0x1a/0x20
c0106cb0 default_idle+0x0/0x40
c0105000 rest_init+0x0/0x50
c0106cdc default_idle+0x2c/0x40
c0106d6b cpu_idle+0x3b/0x50
c047c8ed start_kernel+0x15d/0x170
c047c4a0 unknown_bootoption+0x0/0x120
code: f3 90 80 be 0c 02 00 00 00 7e f5 e9 6a b3 ff ff f3 90 80 bb

Using the de2104x driver is not an option as it fails to receive or transmit any
packets according to tcpdump and even in UP mode.


