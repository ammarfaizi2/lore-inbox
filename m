Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSJJRDi>; Thu, 10 Oct 2002 13:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSJJRDi>; Thu, 10 Oct 2002 13:03:38 -0400
Received: from smtp.urbanet.ch ([195.202.193.135]:44963 "HELO smtp.urbanet.ch")
	by vger.kernel.org with SMTP id <S261657AbSJJRDh>;
	Thu, 10 Oct 2002 13:03:37 -0400
From: Sylvain Pasche <sylvain_pasche@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15781.46151.531066.683163@yahoo.fr>
Date: Thu, 10 Oct 2002 19:09:27 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 Autofs4: bad: scheduling while atomic!
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bad: scheduling while atomic!
Call Trace:
 [<c01161b1>] schedule+0x3d/0x4d4
 [<c01123fd>] smp_apic_timer_interrupt+0x111/0x124
 [<c0107595>] need_resched+0x1f/0x2a
 [<c01a0068>] sysvipc_sem_read_proc+0x1b0/0x227
 [<c01acba5>] serial_in+0x45/0x4c
 [<c01aeadd>] serial8250_console_write+0x5d/0x1cc
 [<c011ba26>] __call_console_drivers+0x3e/0x50
 [<c011ba8b>] _call_console_drivers+0x53/0x58
 [<c011bb45>] call_console_drivers+0xb5/0xe0
 [<c011bed7>] release_console_sem+0xc3/0x164
 [<c011bd7f>] printk+0x1a7/0x1f4
 [<c011890f>] __might_sleep+0x4f/0x58
 [<c013b57e>] kmalloc+0x5a/0x324
 [<c014de8b>] wake_up_buffer+0xb/0x28
 [<f887ebeb>] autofs4_wait+0x8f/0x330 [autofs4]
 [<f887d723>] try_to_fill_dentry+0x3b/0x178 [autofs4]
 [<f887d9b2>] autofs4_root_revalidate+0x152/0x1a4 [autofs4]
 [<f887db85>] autofs4_root_lookup+0xe9/0x1e0 [autofs4]
 [<c0158e08>] real_lookup+0x60/0xe8
 [<c0159240>] do_lookup+0xe8/0x2d0
 [<c0159a8e>] link_path_walk+0x666/0xa8c
 [<c015a31b>] path_lookup+0x207/0x20c
 [<c015a454>] __user_walk+0x28/0x40
 [<c015543a>] vfs_lstat+0x16/0x44
 [<c01559a7>] sys_lstat64+0x13/0x30
 [<c01337e4>] sys_brk+0xc4/0xf0
 [<c0108015>] error_code+0x2d/0x38
 [<c01075d3>] syscall_call+0x7/0xb


Really not sure about it, but there is a lock_kernel() call in
the autofs4_root_lookup(). Maybe that's what is creating the atomic
context ?
