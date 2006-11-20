Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755784AbWKTK5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbWKTK5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbWKTK5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:57:14 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:2468 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1755784AbWKTK5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:57:13 -0500
Date: Mon, 20 Nov 2006 11:56:13 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: GoogleEarth triggers 99% System Load... DRI/X problem?
Message-ID: <20061120115613.04676c09@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, when using GoogleEarth, X gets stuck (only the cursor can go
around).

Kernel version: it's not a new thing, I've seen this happen for quite
some time (oh, and the -dirty in my current kernel is just because of
a fix for APIC: http://lkml.org/lkml/2006/11/18/84).


The system otherwise works and using SSH I've seen that GE runs for
99%-100% of the time in Kernel Mode.


With Sysrq-P and SSH I have extracted this:

[10234.202497] SysRq : Show Regs
[10234.202505] CPU 0:
[10234.202507] Modules linked in: xt_state ip_conntrack ip_queue iptable_filter ip_tables
[10234.202516] Pid: 13251, comm: googleearth-bin Not tainted 2.6.19-rc6-ge030f829-dirty #23
[10234.202519] RIP: 0010:[<ffffffff802f2bd6>]  [<ffffffff802f2bd6>] __delay+0xc/0x15
[10234.202530] RSP: 0018:ffff810018c0fd08  EFLAGS: 00000297
[10234.202533] RAX: 00000000ac2588b9 RBX: ffff810018c0fd08 RCX: 00000000ac258571
[10234.202536] RDX: 000000000000148a RSI: 0000000000000100 RDI: 000000000000089b
[10234.202540] RBP: ffff810018c0fd08 R08: 0000000000000001 R09: 00000000ffeeed68
[10234.202543] R10: ffff810018c0e000 R11: 0000000000000286 R12: 000000000004dda8
[10234.202547] R13: ffff81001f993c00 R14: ffffffff804a086a R15: ffff810018c0fc78
[10234.202552] FS:  00002ae4f268a6d0(0000) GS:ffffffff805f6000(0063) knlGS:00000000f62fe6b0
[10234.202555] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
[10234.202558] CR2: 00002add26650000 CR3: 000000000a240000 CR4: 00000000000006e0
[10234.202560] 
[10234.202561] Call Trace:
[10234.202567]  [<ffffffff802f2bfb>] __const_udelay+0x1c/0x1e
[10234.202574]  [<ffffffff803698d5>] radeon_freelist_get+0xf1/0x136
[10234.202578]  [<ffffffff8036b365>] radeon_cp_buffers+0x108/0x194
[10234.202582]  [<ffffffff8036b25d>] radeon_cp_buffers+0x0/0x194
[10234.202586]  [<ffffffff80361ee0>] drm_ioctl+0x171/0x1bd
[10234.202591]  [<ffffffff8036896a>] compat_drm_dma+0xe5/0x12b
[10234.202596]  [<ffffffff80368885>] compat_drm_dma+0x0/0x12b
[10234.202600]  [<ffffffff80367c46>] drm_compat_ioctl+0x42/0x70
[10234.202604]  [<ffffffff80376f8a>] radeon_compat_ioctl+0x21/0x7b
[10234.202609]  [<ffffffff8029752d>] compat_sys_ioctl+0xb0/0x29e
[10234.202614]  [<ffffffff8021ad84>] cstar_do_call+0x1b/0x65
[10234.202616] 




After killing GoogleEarth the "stuck in kernel mode" process becomes X:

[10674.161398] SysRq : Show Regs
[10674.161405] CPU 0:
[10674.161407] Modules linked in: xt_state ip_conntrack ip_queue iptable_filter ip_tables
[10674.161414] Pid: 18378, comm: X Not tainted 2.6.19-rc6-ge030f829-dirty #23
[10674.161417] RIP: 0010:[<ffffffff80369b74>]  [<ffffffff80369b74>] radeon_do_wait_for_idle+0x55/0x87
[10674.161426] RSP: 0018:ffff810013225de8  EFLAGS: 00000283
[10674.161430] RAX: 0000000080010140 RBX: ffff810013225df8 RCX: 00000000bce7d340
[10674.161433] RDX: 000000000000156c RSI: ffffc20001180000 RDI: 000000000000089b
[10674.161435] RBP: 0000000000000000 R08: 00000000000001de R09: 0000000000000000
[10674.161438] R10: 0000000000000000 R11: 0000000000003246 R12: 0000000000000000
[10674.161442] R13: 0000000000003246 R14: ffff810013225dc8 R15: ffff810013225dc8
[10674.161446] FS:  00002abc77c11ae0(0000) GS:ffffffff805f6000(0000) knlGS:00000000f7ba56b0
[10674.161449] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[10674.161452] CR2: 00002add26650000 CR3: 0000000013be9000 CR4: 00000000000006e0
[10674.161454] 
[10674.161455] Call Trace:
[10674.161459]  [<ffffffff80369b96>] radeon_do_wait_for_idle+0x77/0x87
[10674.161463]  [<ffffffff8036a22a>] radeon_do_cp_idle+0x170/0x175
[10674.161467]  [<ffffffff8036a2b0>] radeon_cp_idle+0x81/0x89
[10674.161470]  [<ffffffff8036a22f>] radeon_cp_idle+0x0/0x89
[10674.161475]  [<ffffffff80361ee0>] drm_ioctl+0x171/0x1bd
[10674.161481]  [<ffffffff802774d2>] do_ioctl+0x5e/0x77
[10674.161484]  [<ffffffff802774ea>] do_ioctl+0x76/0x77
[10674.161488]  [<ffffffff80277741>] vfs_ioctl+0x256/0x273
[10674.161492]  [<ffffffff804a05cc>] thread_return+0x0/0xf9
[10674.161496]  [<ffffffff804a069f>] thread_return+0xd3/0xf9
[10674.161500]  [<ffffffff802777a0>] sys_ioctl+0x42/0x66
[10674.161504]  [<ffffffff802098be>] system_call+0x7e/0x83
[10674.161507] 



Hardware:
01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)


Does it look like "just" an X problem or the kernel can be involved?

I can collect more data next time this happens, just ask what you want
to see.

-- 
	Paolo Ornati
	Linux 2.6.19-rc6-ge030f829-dirty on x86_64
