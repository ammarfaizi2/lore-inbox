Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270470AbUJUOFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270470AbUJUOFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUJUNjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:39:07 -0400
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:30368 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S266613AbUJTOwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:52:09 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF793FA554.AC89BCAF-ON86256F33.004F3082@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 20 Oct 2004 09:49:47 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/20/2004 09:49:50 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -U8 Real-Time Preemption patch:
>
>
http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8

First attempt at booting this version, made it to single user OK but
telinit 3 stopped while starting up the network with the following messages
on console...

INIT: Switching to runlevel: 3
INIT: Sending processes the TERM signal
INIT: Sending processes the KILL signal
Applying Intel IA32 Microcode update:   [ OK ]
Checking for new hardware ----------------[ cut here ]---------------
kernel BUG at include/asm/atomic.h:135!
Invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: 8139too mii floppy sg scsi_mod microcode dm_mod uhci_hcd
ext3 jbd
CPU:    0
EIP:    0060:[<c02b8426>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc4-mm1-RT-U8)
EIP is at qdisc_destroy+0x76/0x80
eax: 00000000   ebx: dedf9000   ecx: c037ede0   edx: c037ede0
esi: dedf9000   edi: c03747a8   ebp: df3d9e68   esp: df3d9e64
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process modprobe (pid: 1594, threadinfo=df3d8000 task=db708690)
Stack: dedf9000 df3d9e84 c02b863d c037ede0 df3d9e74 df3d9e74 c03423e4
dedf9000
       df3d9ea8 c02a9bdb dedf9000 c01148b0 e0836b10 dedf9420 dedf9000
e083b148
       0807a804 df3d9eb8 c024192e dedf9000 dedf9000 df3d9ed8 e0836b3a
dedf9000
Call Trace:
 [<c02b863d>] dev_shutdown+0x3d/0xa0 (12)
 [<c02a9bdb>] unregister_netdevice+0x13b/0x280 (28)
 [<c01148b0>] mcount+0x14/0x18 (8)
 [<e0836b10>] rtl8139_remove_one+0x0/0xa0 [8139too] (4)
 [<c024192e>] unregister_netdev+0x1e/0x30 (24)
 [<e0836b3a>] rtl8139_remove_one+0x2a/0xa0 [8139too] (16)
 [<c01148b0>] mcount+0x14/0x18 (12)
 [<c01e3a06>] pci_device_remove+0x76/0x80 (20)
 [<c02300bb>] device_detach_shutdown+0xb/0x40 (12)
 [<c022d207>] device_release_driver+0x67/0x70 (12)
 [<c022d23b>] device_detach+0x2b/0x40 (24)
 [<c022d6af>] bus_remove_driver+0x3f/0x70 (20)
 [<c022dbb9>] driver_unregister+0x19/0x30 (20)
 [<c01e3cac>] pci_unregister_driver+0x1c/0x30 (16)
 [<e0838ae7>] rtl8139_cleanup_module+0x17/0x1b [8139too] (16)
 [<c013c751>] sys_delete_module+0x121/0x150 (12)
 [<c01594f4>] sys_munmap+0x54/0x70 (64)
 [<c0118560>] do_page_fault+0x0/0x6d0 (16)
 [<c0107b49>] sysenter_past_esp+0x52/0x71 (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x1f/0x80 / (die+0x44/0x190)
.. entry 2: print_traces_0x1d/0x60 / (show_stack+0x8f/0xb0)

Code: 00 ba c0 82 2b c0 c7 43 04 00 02 20 00 5b 5d e9 81 bf e7 ff 0f 0b a5
00 e9
 4d 32 c0 eb cd 0f 0b a4 00 e9 4d 32 c0 eb b8 5b 5d c3 <0f> 0b 87 00 0d 4e
32 c0
 eb 93 55 89 e5 83 ec 10 89 5d f8 89 75

Updating /etc/fstab             [ OK ]
Setting network parameters:     [ OK ]
Bringing up loopback interface:

(no further console output at this point)

Alt-Sysrq-L showed active tasks were swapper (CPU 1) and IRQ 1 (CPU 0) at
cpu_idle and nmi_show_all_regs respectively. Able to repeat this more than
once with the same results each time. Tasks listed by Alt-Sysrq-T included
IRQ 6, S10network, minlogd, initlog, ifup, ip, and grep (all I could see
on the scrollback).

Synced disks (Alt-Sysrq-S) and rebooted (Alt-Sysrq-B) to try again. This
time
turning on syslog before telinit 3. Same results. Will send whatever showed
up
on disk separately.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

