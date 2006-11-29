Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967484AbWK2Rbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967484AbWK2Rbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934979AbWK2Rbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:31:32 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:25520 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S935890AbWK2Rbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:31:31 -0500
Date: Wed, 29 Nov 2006 12:31:29 -0500
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18.3 SMP PREEMPT crashes (x86-64)
Message-ID: <20061129173129.GJ2418@jukie.net>
References: <20061129170253.GH2418@jukie.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129170253.GH2418@jukie.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bart Trojanowski <bart@jukie.net> [061129 12:02]:
> I finally hooked up a serial console to the box and I see the following.
> I include the initial dmesg output to show what's in the machine.

This time I booted with "maxcpus=1" and proceeded to build 2.6.19-rc again.
Again a crash... as it's different, I include the console output:

[ 2496.851726] Unable to handle kernel paging request at ffff8100aa5b69b0 RIP:
[ 2496.856340]  [<ffffffff8108dcd8>] __wake_up_common+0x28/0x80
[ 2496.864454] PGD 8063 PUD 0
[ 2496.867278] Oops: 0000 [1] PREEMPT SMP
[ 2496.871158] CPU 0
[ 2496.873192] Modules linked in: ide_cd cdrom binfmt_misc ipv6 container battery asus_acpi ac nfs lockd sunrpc af_packet rtc parport_pc lp parport
[ 2496.886410] Pid: 31767, comm: ruby Not tainted 2.6.18.3-xenon64-smp.9 #1
[ 2496.893103] RIP: 0010:[<ffffffff8108dcd8>]  [<ffffffff8108dcd8>] __wake_up_common+0x28/0x80
[ 2496.901469] RSP: 0000:ffff81002992dcc8  EFLAGS: 00010006
[ 2496.906777] RAX: ffff8100aa5b69b0 RBX: ffff8100025b6998 RCX: 0000000000000000
[ 2496.913904] RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffff8100025b6998
[ 2496.921024] RBP: ffff81002992dcf8 R08: ffff81002992dd48 R09: ffff8100022cd210
[ 2496.928151] R10: 00002b2a49319d20 R11: 0000000000000001 R12: ffff81002992dd48
[ 2496.935278] R13: 0000000000000001 R14: ffff8100025b69b0 R15: ffff81002992dd48
[ 2496.942398] FS:  00002b2a49319c90(0000) GS:ffffffff81560000(0000) knlGS:0000000000000000
[ 2496.950477] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 2496.956220] CR2: ffff8100aa5b69b0 CR3: 0000000024cb7000 CR4: 00000000000006e0
[ 2496.963347] Process ruby (pid: 31767, threadinfo ffff81002992c000, task ffff81001b33e790)
[ 2496.971512] Stack:  0000000300000000 ffff8100025b6998 ffff81002992dd48 0000000000000001
[ 2496.979584]  0000000000000213 0000000000000003 ffff81002992dd38 ffffffff81031ed3
[ 2496.987031]  ffff810001b39540 0000000000000000 ffff8100022cd210 ffff8100346c8cb0
[ 2496.994288] Call Trace:
[ 2496.996926]  [<ffffffff81031ed3>] __wake_up+0x43/0x70
[ 2497.001973]  [<ffffffff8100c438>] __wake_up_bit+0x28/0x30
[ 2497.007368]  [<ffffffff81011644>] do_wp_page+0x154/0x450
[ 2497.012677]  [<ffffffff81009178>] __handle_mm_fault+0x9d8/0xaa0
[ 2497.018593]  [<ffffffff8106ec46>] _spin_lock_irqsave+0x26/0x90
[ 2497.024420]  [<ffffffff81071617>] do_page_fault+0x4a7/0x8c0
[ 2497.029993]  [<ffffffff81069e1d>] error_exit+0x0/0x84
[ 2497.035038]
[ 2497.036532]
[ 2497.036533] Code: 48 8b 18 74 36 66 66 90 48 8d 78 e8 44 8b 60 e8 4c 89 f9 8b
[ 2497.045591] RIP  [<ffffffff8108dcd8>] __wake_up_common+0x28/0x80
[ 2497.051612]  RSP <ffff81002992dcc8>
[ 2497.055101] CR2: ffff8100aa5b69b0
[ 2497.058408]  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
[ 2497.066420] in_atomic():1, irqs_disabled():1
[ 2497.070680]
[ 2497.070680] Call Trace:
[ 2497.074614]  [<ffffffff810a69a5>] down_read+0x15/0x20
[ 2497.079663]  [<ffffffff8109dd40>] blocking_notifier_call_chain+0x20/0x50
[ 2497.086358]  [<ffffffff81015fb2>] do_exit+0x22/0x980
[ 2497.091323]  [<ffffffff81204c85>] do_unblank_screen+0x85/0x140
[ 2497.097149]  [<ffffffff81071929>] do_page_fault+0x7b9/0x8c0
[ 2497.102719]  [<ffffffff8100a5fb>] get_page_from_freelist+0x27b/0x470
[ 2497.109067]  [<ffffffff81069e1d>] error_exit+0x0/0x84
[ 2497.114117]  [<ffffffff8108dcd8>] __wake_up_common+0x28/0x80
[ 2497.119771]  [<ffffffff81031ed3>] __wake_up+0x43/0x70
[ 2497.124819]  [<ffffffff8100c438>] __wake_up_bit+0x28/0x30
[ 2497.130214]  [<ffffffff81011644>] do_wp_page+0x154/0x450
[ 2497.135522]  [<ffffffff81009178>] __handle_mm_fault+0x9d8/0xaa0
[ 2497.141439]  [<ffffffff8106ec46>] _spin_lock_irqsave+0x26/0x90
[ 2497.147266]  [<ffffffff81071617>] do_page_fault+0x4a7/0x8c0
[ 2497.152838]  [<ffffffff81069e1d>] error_exit+0x0/0x84
[ 2497.157883]
[ 2497.159424] note: ruby[31767] exited with preempt_count 2
[ 2507.151629] BUG: soft lockup detected on CPU#0!
[ 2507.156149]
[ 2507.156150] Call Trace:
[ 2507.160081]  <IRQ> [<ffffffff810b6d69>] softlockup_tick+0xf9/0x140
[ 2507.166276]  [<ffffffff8109a797>] update_process_times+0x57/0x90
[ 2507.172279]  [<ffffffff8107f403>] smp_local_timer_interrupt+0x23/0x50
[ 2507.178712]  [<ffffffff8107f968>] smp_apic_timer_interrupt+0x38/0x40
[ 2507.185059]  [<ffffffff81069cc2>] apic_timer_interrupt+0x66/0x6c
[ 2507.191059]  <EOI> [<ffffffff8106f040>] _spin_lock+0x50/0x70
[ 2507.196734]  [<ffffffff8106f02c>] _spin_lock+0x3c/0x70
[ 2507.201869]  [<ffffffff810080f3>] unmap_vmas+0x763/0x7c0
[ 2507.207181]  [<ffffffff8103f991>] exit_mmap+0x81/0x130
[ 2507.212313]  [<ffffffff81042368>] mmput+0x48/0xe0
[ 2507.217016]  [<ffffffff810161bc>] do_exit+0x22c/0x980
[ 2507.222065]  [<ffffffff81204c85>] do_unblank_screen+0x85/0x140
[ 2507.227894]  [<ffffffff81071929>] do_page_fault+0x7b9/0x8c0
[ 2507.233463]  [<ffffffff8100a5fb>] get_page_from_freelist+0x27b/0x470
[ 2507.239811]  [<ffffffff81069e1d>] error_exit+0x0/0x84
[ 2507.244861]  [<ffffffff8108dcd8>] __wake_up_common+0x28/0x80
[ 2507.250516]  [<ffffffff81031ed3>] __wake_up+0x43/0x70
[ 2507.255563]  [<ffffffff8100c438>] __wake_up_bit+0x28/0x30
[ 2507.260958]  [<ffffffff81011644>] do_wp_page+0x154/0x450
[ 2507.266268]  [<ffffffff81009178>] __handle_mm_fault+0x9d8/0xaa0
[ 2507.272183]  [<ffffffff8106ec46>] _spin_lock_irqsave+0x26/0x90
[ 2507.278010]  [<ffffffff81071617>] do_page_fault+0x4a7/0x8c0
[ 2507.283584]  [<ffffffff81069e1d>] error_exit+0x0/0x84
[ 2507.288628]
[ 2517.143985] BUG: soft lockup detected on CPU#0!
[ 2517.148512]
[ 2517.148513] Call Trace:
[ 2517.152444]  <IRQ> [<ffffffff810b6d69>] softlockup_tick+0xf9/0x140
[ 2517.158630]  [<ffffffff8109a797>] update_process_times+0x57/0x90
[ 2517.164632]  [<ffffffff8107f403>] smp_local_timer_interrupt+0x23/0x50
[ 2517.171066]  [<ffffffff8107f968>] smp_apic_timer_interrupt+0x38/0x40
[ 2517.177414]  [<ffffffff81069cc2>] apic_timer_interrupt+0x66/0x6c
[ 2517.183412]  <EOI> [<ffffffff8106f042>] _spin_lock+0x52/0x70
[ 2517.189087]  [<ffffffff8106f02c>] _spin_lock+0x3c/0x70
[ 2517.194222]  [<ffffffff810080f3>] unmap_vmas+0x763/0x7c0
[ 2517.199536]  [<ffffffff8103f991>] exit_mmap+0x81/0x130
[ 2517.204667]  [<ffffffff81042368>] mmput+0x48/0xe0
[ 2517.209370]  [<ffffffff810161bc>] do_exit+0x22c/0x980
[ 2517.214419]  [<ffffffff81204c85>] do_unblank_screen+0x85/0x140
[ 2517.220248]  [<ffffffff81071929>] do_page_fault+0x7b9/0x8c0
[ 2517.225817]  [<ffffffff8100a5fb>] get_page_from_freelist+0x27b/0x470
[ 2517.232166]  [<ffffffff81069e1d>] error_exit+0x0/0x84
[ 2517.237215]  [<ffffffff8108dcd8>] __wake_up_common+0x28/0x80
[ 2517.242869]  [<ffffffff81031ed3>] __wake_up+0x43/0x70
[ 2517.247917]  [<ffffffff8100c438>] __wake_up_bit+0x28/0x30
[ 2517.253311]  [<ffffffff81011644>] do_wp_page+0x154/0x450
[ 2517.258620]  [<ffffffff81009178>] __handle_mm_fault+0x9d8/0xaa0
[ 2517.264537]  [<ffffffff8106ec46>] _spin_lock_irqsave+0x26/0x90
[ 2517.270366]  [<ffffffff81071617>] do_page_fault+0x4a7/0x8c0
[ 2517.275937]  [<ffffffff81069e1d>] error_exit+0x0/0x84

-- 
				WebSig: http://www.jukie.net/~bart/sig/
