Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVKYNmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVKYNmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVKYNmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:42:36 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:17843 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932448AbVKYNmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:42:35 -0500
Date: Fri, 25 Nov 2005 14:42:26 +0100
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [BUG linux-2.6.15-rc] process events connector - soft lockup
 detected
Message-ID: <20051125144226.37778246@frecb000711.frec.bull.fr>
Organization: BULL SA.
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/11/2005 14:41:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/11/2005 14:41:58,
	Serialize complete at 25/11/2005 14:41:58
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I compiled a kernel 2.6.15-rc1 and a 2.6.15-rc2 with Process Events
Connector enabled. The machine has two processors. When I use the
process events connector, a soft lockup is detected (for both releases):

---------B<---------------------------------------
Pid: 2770, comm:                   sh
EIP: 0060:[<c039ae28>] CPU: 1
EIP is at __read_lock_failed+0x8/0x14
 EFLAGS: 00000297    Not tainted  (2.6.15-rc2)
EAX: c046fc00 EBX: f5946000 ECX: f5947f7c EDX: 00000286
ESI: 00000000 EDI: ffffffff EBP: f5946000 DS: 007b ES: 007b
CR0: 8005003b CR2: 080e173c CR3: 358a0000 CR4: 000006d0
 [<c039c566>] _read_lock+0xb/0xc
 [<c011e7ee>] do_wait+0x9d/0x40c
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c011ec32>] sys_wait4+0x43/0x45
 [<c0102e39>] syscall_call+0x7/0xb
BUG: soft lockup detected on CPU#1!

Pid: 2770, comm:                   sh
EIP: 0060:[<c039ae28>] CPU: 1
EIP is at __read_lock_failed+0x8/0x14
 EFLAGS: 00000297    Not tainted  (2.6.15-rc2)
EAX: c046fc00 EBX: f5946000 ECX: f5947f7c EDX: 00000286
ESI: 00000000 EDI: ffffffff EBP: f5946000 DS: 007b ES: 007b
CR0: 8005003b CR2: 080e173c CR3: 358a0000 CR4: 000006d0
 [<c039c566>] _read_lock+0xb/0xc
 [<c011e7ee>] do_wait+0x9d/0x40c
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c011ec32>] sys_wait4+0x43/0x45
 [<c0102e39>] syscall_call+0x7/0xb
BUG: soft lockup detected on CPU#1!

Pid: 2770, comm:                   sh
EIP: 0060:[<c039ae28>] CPU: 1
EIP is at __read_lock_failed+0x8/0x14
 EFLAGS: 00000297    Not tainted  (2.6.15-rc2)
EAX: c046fc00 EBX: f5946000 ECX: f5947f7c EDX: 00000286
ESI: 00000000 EDI: ffffffff EBP: f5946000 DS: 007b ES: 007b
CR0: 8005003b CR2: 080e173c CR3: 358a0000 CR4: 000006d0
 [<c039c566>] _read_lock+0xb/0xc
 [<c011e7ee>] do_wait+0x9d/0x40c
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c011ec32>] sys_wait4+0x43/0x45
 [<c0102e39>] syscall_call+0x7/0xb
BUG: soft lockup detected on CPU#1!

Pid: 2770, comm:                   sh
EIP: 0060:[<c039ae25>] CPU: 1
EIP is at __read_lock_failed+0x5/0x14
 EFLAGS: 00000297    Not tainted  (2.6.15-rc2)
EAX: c046fc00 EBX: f5946000 ECX: f5947f7c EDX: 00000286
ESI: 00000000 EDI: ffffffff EBP: f5946000 DS: 007b ES: 007b
CR0: 8005003b CR2: 080e173c CR3: 358a0000 CR4: 000006d0
 [<c039c566>] _read_lock+0xb/0xc
 [<c011e7ee>] do_wait+0x9d/0x40c
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c0116fd0>] default_wake_function+0x0/0x12
 [<c011ec32>] sys_wait4+0x43/0x45
 [<c0102e39>] syscall_call+0x7/0xb

.... etc, etc where EIP is sometimes equal to 0060:[<c039ae25>] CPU: 1
and sometimes equal to 0060:[<c039ae28>] CPU: 1
---------------------------------------------------

  I think that the problem is in kernel/fork.c. The function
proc_fork_connector(p) is called inside a
write_lock_irq(&tasklist_lock). The
cn_netlink_send(msg,CN_IDX_PROC,GFP_KERNEL) is called by the
proc_fork_connector(). Thus, the alloc_skb(size,GFP_KERNEL) is called
within a write_lock_irq(&tasklist_lock)... is it the problem? 

  If I replace GFP_KERNEL by GFP_ATOMIC the soft lockup disappear (but I
don't know if this solution is right...)


Best regards,

Guillaume 
