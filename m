Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTKUWoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTKUWoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:44:22 -0500
Received: from mail.gmx.de ([213.165.64.20]:48256 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261678AbTKUWoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:44:19 -0500
X-Authenticated: #20450766
Date: Fri, 21 Nov 2003 23:42:56 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.6.0-test7 + preempt + hacking
Message-ID: <Pine.LNX.4.44.0311212157320.2772-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've enabled preemption, almost all kernel-hacking options:

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

...and got the following error / warning messages and an Oops on startup:

ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 08 00 00 23 23 38
eth0: NE2000 found at 0x300, using IRQ 3.
net/sched/sch_generic.c:502: spin_is_locked on uninitialized spinlock c200c7f0.
net/sched/sch_generic.c:504: spin_is_locked on uninitialized spinlock c200c7f0.
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
pcnet32: PCnet/PCI 79C970 at 0x7000, 00 80 5f d2 53 f0 assigned IRQ 10.
eth1: registered as PCnet/PCI 79C970
pcnet32: 1 cards_found.
------------[ cut here ]------------
kernel BUG at kernel/workqueue.c:116!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0132528>]    Not tainted
EFLAGS: 00010202
EIP is at queue_delayed_work+0x28/0x8c
eax: 00000000   ebx: 00000000   ecx: c2064618   edx: c2064600
esi: 00000005   edi: c1075f38   ebp: c1071f74   esp: c1071f68
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c1070000 task=c1074980)
Stack: c2064600 c2056340 c1075f38 c1071f80 c0132f0c 00000005 c1071f8c c2056376
       c1070000 c1071fec c013282e 00000000 c013258c 00000000 00000000 c1071fc4
       c1075f38 c1075f60 c1075f58 00000000 c2056340 00000216 c1070000 00000001
Call Trace:
 [<c2056340>] do_cache_clean+0x0/0x3c [sunrpc]
 [<c0132f0c>] schedule_delayed_work+0x14/0x1c
 [<c2056376>] do_cache_clean+0x36/0x3c [sunrpc]
 [<c013282e>] worker_thread+0x2a2/0x448
 [<c013258c>] worker_thread+0x0/0x448
 [<c2056340>] do_cache_clean+0x0/0x3c [sunrpc]
 [<c0119480>] default_wake_function+0x0/0x20
 [<c0119480>] default_wake_function+0x0/0x20
 [<c0107409>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 74 00 81 4b 2d c0 8d 42 04 39 42 04 74 08 0f 0b 75 00
 <6>note: events/0[3] exited with preempt_count 1

Is this (are these) known / fixed in 2.6.0-test<latest>? If not - any
clue? Disabling preemption OR all (except sysrq) hacking options fixes it.

100% reproducable.

Thanks
Guennadi
---
Guennadi Liakhovetski


