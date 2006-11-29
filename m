Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967571AbWK2TIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967571AbWK2TIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967572AbWK2TIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:08:18 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:50139 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S967571AbWK2TIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:08:17 -0500
Date: Wed, 29 Nov 2006 14:08:15 -0500
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18.3 soft lockups and 2.6.19-rc6 rwlock OOPs on SMP x86-64
Message-ID: <20061129190815.GK2418@jukie.net>
References: <20061129170253.GH2418@jukie.net> <20061129173129.GJ2418@jukie.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129173129.GJ2418@jukie.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more update.  I rebuilt 2.6.19-rc6 and turned off CONFIG_PREEMPT_BKL.
It didn't help much.

I am still getting BUG dumps from the kernel, however they don't cause
freezes immediately.  It takes a few minutes of console output before
the computer stops responding to my input.

As I was writing the above I tried building again under 2.6.19-rc6.  The
kernel OOPSed with a NULL pointer dereference.

-Bart

[ 1273.206537] Unable to handle kernel NULL pointer dereference at 0000000000000005 RIP:
[ 1273.212025]  [<ffffffff8100784f>] _raw_spin_lock+0x1f/0x140
[ 1273.220130] PGD 15465067 PUD 15427067 PMD 0
[ 1273.224477] Oops: 0000 [1] SMP
[ 1273.227681] CPU 0
[ 1273.229733] Modules linked in: ide_cd cdrom binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[ 1273.243012] Pid: 13785, comm: make Not tainted 2.6.19-rc6-xenon64-smp.10 #1
[ 1273.249991] RIP: 0010:[<ffffffff8100784f>]  [<ffffffff8100784f>] _raw_spin_lock+0x1f/0x140
[ 1273.258313] RSP: 0018:ffffffff8155af38  EFLAGS: 00010092
[ 1273.263649] RAX: 0000000000009e40 RBX: 0000000000000001 RCX: 0000000000000000
[ 1273.270802] RDX: 0000000000000001 RSI: ffffffff814f7d80 RDI: 0000000000000001
[ 1273.277955] RBP: ffffffff81447060 R08: 0000000000000001 R09: 0000000000000000
[ 1273.285107] R10: 0000000000004008 R11: 0000000000000000 R12: 0000000000000000
[ 1273.292253] R13: 0000000000000001 R14: 00000000ffffffff R15: 0000000000000001
[ 1273.299407] FS:  00002b6c23c6cae0(0000) GS:ffffffff814f7000(0000) knlGS:0000000000000000
[ 1273.307530] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1273.313296] CR2: 0000000000000005 CR3: 0000000014066000 CR4: 00000000000006e0
[ 1273.320442] Process make (pid: 13785, threadinfo ffff8100132d2000, task ffff81001845f0c0)
[ 1273.328651] Stack:  ffffffff814f7d80 ffffffff81447060 0000000000000000 0000000000000001
[ 1273.336784]  00000000ffffffff ffffffff810b6f09 ffffffff8106624c ffffffff81554c30
[ 1273.344292]  0000000000000020 0000000000000000 ffff8100185cbda0 ffffffff81073f0a
[ 1273.351584] Call Trace:
[ 1273.354269]  <IRQ>  [<ffffffff810b6f09>] handle_edge_irq+0x119/0x150
[ 1273.360672]  [<ffffffff8106624c>] call_softirq+0x1c/0x28
[ 1273.366007]  [<ffffffff81073f0a>] do_IRQ+0x8a/0xe0
[ 1273.370819]  [<ffffffff81065641>] ret_from_intr+0x0/0xa
[ 1273.376066]  <EOI>  [<ffffffff81069f67>] __mutex_lock_slowpath+0x1d7/0x1f0
[ 1273.382990]  [<ffffffff81023409>] dbg_redzone1+0x19/0x30
[ 1273.388323]  [<ffffffff810cfa45>] pipe_read+0x75/0x400
[ 1273.393485]  [<ffffffff8106b129>] _spin_unlock_irq+0x9/0x10
[ 1273.399079]  [<ffffffff8100ca1f>] do_sync_read+0xcf/0x120
[ 1273.404503]  [<ffffffff810a06a0>] autoremove_wake_function+0x0/0x30
[ 1273.410787]  [<ffffffff8103f739>] remove_wait_queue+0x19/0x60
[ 1273.416554]  [<ffffffff8106b129>] _spin_unlock_irq+0x9/0x10
[ 1273.422151]  [<ffffffff8102b33a>] do_sigaction+0x1aa/0x1d0
[ 1273.427656]  [<ffffffff8100b08b>] vfs_read+0xdb/0x1a0
[ 1273.432733]  [<ffffffff81011db3>] sys_read+0x53/0x90
[ 1273.437720]  [<ffffffff8106511e>] system_call+0x7e/0x83
[ 1273.442967]
[ 1273.444481]
[ 1273.444482] Code: 81 7f 04 ad 4e ad de 74 0c 48 c7 c6 dc 30 3c 81 e8 1c c2 00
[ 1273.453619] RIP  [<ffffffff8100784f>] _raw_spin_lock+0x1f/0x140
[ 1273.459577]  RSP <ffffffff8155af38>
[ 1273.463085] CR2: 0000000000000005
[ 1273.466569]  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
[ 1273.474672] in_atomic():1, irqs_disabled():1
[ 1273.478984]
[ 1273.478985] Call Trace:
[ 1273.483002]  <IRQ>  [<ffffffff810a2e85>] down_read+0x15/0x30
[ 1273.488747]  [<ffffffff81099b80>] blocking_notifier_call_chain+0x20/0x50
[ 1273.495484]  [<ffffffff81015c52>] do_exit+0x22/0x8c0
[ 1273.500491]  [<ffffffff8106b169>] _spin_lock_irqsave+0x9/0x10
[ 1273.506277]  [<ffffffff811d17b6>] vgacon_set_cursor_size+0x36/0xf0
[ 1273.512494]  [<ffffffff8106d809>] do_page_fault+0x7a9/0x8b0
[ 1273.518107]  [<ffffffff81063908>] blk_run_queue+0x28/0x80
[ 1273.523546]  [<ffffffff812561bb>] scsi_next_command+0x3b/0x60
[ 1273.529330]  [<ffffffff8106b58d>] error_exit+0x0/0x84
[ 1273.534422]  [<ffffffff8100784f>] _raw_spin_lock+0x1f/0x140
[ 1273.540035]  [<ffffffff810b6f09>] handle_edge_irq+0x119/0x150
[ 1273.545817]  [<ffffffff8106624c>] call_softirq+0x1c/0x28
[ 1273.551171]  [<ffffffff81073f0a>] do_IRQ+0x8a/0xe0
[ 1273.556002]  [<ffffffff81065641>] ret_from_intr+0x0/0xa
[ 1273.561267]  <EOI>  [<ffffffff81069f67>] __mutex_lock_slowpath+0x1d7/0x1f0
[ 1273.568224]  [<ffffffff81023409>] dbg_redzone1+0x19/0x30
[ 1273.573574]  [<ffffffff810cfa45>] pipe_read+0x75/0x400
[ 1273.578754]  [<ffffffff8106b129>] _spin_unlock_irq+0x9/0x10
[ 1273.584365]  [<ffffffff8100ca1f>] do_sync_read+0xcf/0x120
[ 1273.589804]  [<ffffffff810a06a0>] autoremove_wake_function+0x0/0x30
[ 1273.596108]  [<ffffffff8103f739>] remove_wait_queue+0x19/0x60
[ 1273.601894]  [<ffffffff8106b129>] _spin_unlock_irq+0x9/0x10
[ 1273.607505]  [<ffffffff8102b33a>] do_sigaction+0x1aa/0x1d0
[ 1273.613030]  [<ffffffff8100b08b>] vfs_read+0xdb/0x1a0
[ 1273.618124]  [<ffffffff81011db3>] sys_read+0x53/0x90
[ 1273.623128]  [<ffffffff8106511e>] system_call+0x7e/0x83
[ 1273.628393]
[ 1273.629960] Kernel panic - not syncing: Aiee, killing interrupt handler!

-- 
				WebSig: http://www.jukie.net/~bart/sig/
