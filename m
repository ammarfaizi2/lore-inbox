Return-Path: <linux-kernel-owner+w=401wt.eu-S1161275AbXAMGSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbXAMGSx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 01:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161296AbXAMGSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 01:18:53 -0500
Received: from xenotime.net ([66.160.160.81]:33722 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161275AbXAMGSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 01:18:52 -0500
Date: Fri, 12 Jan 2007 22:19:09 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: reiserfs-dev@namesys.com
Subject: reiserfs BUGs
Message-Id: <20070112221909.1283e6a1.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running fsx-linux (akpm ext3-tools version) on reiserfs,
2.6.20-rc5 on x86_64.

[ 4496.964604] ------------[ cut here ]------------
[ 4496.964614] Kernel BUG at ffffffff880b4499 [verbose debug info unavailable]
[ 4496.964621] invalid opcode: 0000 [1] SMP
[ 4496.964629] CPU 2
[ 4496.964635] Modules linked in: reiserfs xfs jfs loop
[ 4496.964650] Pid: 298, comm: pdflush Not tainted 2.6.20-rc5 #1
[ 4496.964655] RIP: 0010:[<ffffffff880b4499>]  [<ffffffff880b4499>] :reiserfs:flush_commit_list+0x532/0x60a
[ 4496.964684] RSP: 0018:ffff81011fa47bf0  EFLAGS: 00010246
[ 4496.964690] RAX: 0000000000000000 RBX: ffffc2001090f240 RCX: 0000000000000000
[ 4496.964697] RDX: 0000000000000000 RSI: 00000000000072b3 RDI: ffffc2001090f240
[ 4496.964703] RBP: ffff81011fa47c60 R08: ffff81011e521000 R09: 0000000000000000
[ 4496.964710] R10: ffff810005044100 R11: 00000000fffffffa R12: ffff81011d497180
[ 4496.964716] R13: ffff81011e521000 R14: 0000000000000088 R15: 0000000000000000
[ 4496.964723] FS:  0000000000000000(0000) GS:ffff81011fc78cc0(0000) knlGS:0000000000000000
[ 4496.964730] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 4496.964737] CR2: 00002b370e2a3000 CR3: 000000011e118000 CR4: 00000000000006e0
[ 4496.964744] Process pdflush (pid: 298, threadinfo ffff81011fa46000, task ffff81011fb02140)
[ 4496.964749] Stack:  0000000300000000 0000000100000282 0000000000000058 0000000000000282
[ 4496.964767]  0000000000000058 ffffc20010884000 000000001fa47c60 ffffffff8012ddcb
[ 4496.964785]  ffff81011a3abf00 ffff810117180980 0000000045a858b5 0000000000000000
[ 4496.964798] Call Trace:
[ 4496.964815]  [<ffffffff8012ddcb>] __wake_up+0x43/0x50
[ 4496.964834]  [<ffffffff880b7385>] :reiserfs:do_journal_end+0xc95/0xced
[ 4496.964845]  [<ffffffff8012d21d>] find_busiest_group+0x24e/0x68f
[ 4496.964856]  [<ffffffff801484d7>] keventd_create_kthread+0x0/0x79
[ 4496.964875]  [<ffffffff880b7452>] :reiserfs:journal_end_sync+0x75/0x7e
[ 4496.964886]  [<ffffffff80169a39>] pdflush+0x0/0x1d4
[ 4496.964904]  [<ffffffff880a8e4a>] :reiserfs:reiserfs_sync_fs+0x41/0x67
[ 4496.964922]  [<ffffffff880a8e7e>] :reiserfs:reiserfs_write_super+0xe/0x10
[ 4496.964932]  [<ffffffff8018579d>] sync_supers+0x67/0xb6
[ 4496.964942]  [<ffffffff8016968e>] wb_kupdate+0x4d/0x133
[ 4496.964951]  [<ffffffff80169a39>] pdflush+0x0/0x1d4
[ 4496.964958]  [<ffffffff80169b62>] pdflush+0x129/0x1d4
[ 4496.964967]  [<ffffffff80169641>] wb_kupdate+0x0/0x133
[ 4496.964975]  [<ffffffff8014875c>] kthread+0xd8/0x10c
[ 4496.964984]  [<ffffffff801318b0>] schedule_tail+0x45/0xad
[ 4496.964994]  [<ffffffff8010a488>] child_rip+0xa/0x12
[ 4496.965002]  [<ffffffff801484d7>] keventd_create_kthread+0x0/0x79
[ 4496.965011]  [<ffffffff80148684>] kthread+0x0/0x10c
[ 4496.965019]  [<ffffffff8010a47e>] child_rip+0x0/0x12
[ 4496.965030] 
[ 4496.965031] Code: 0f 0b eb fe 48 8b 03 f0 0f ba 30 10 48 8b 13 8b 02 a9 00 00
[ 4496.965073] RIP  [<ffffffff880b4499>] :reiserfs:flush_commit_list+0x532/0x60a
[ 4496.965094]  RSP <ffff81011fa47bf0>
[ 4496.965395]  BUG: at kernel/exit.c:860 do_exit()
[ 4496.965407]
[ 4496.965409] Call Trace:
[ 4496.965420]  [<ffffffff801368a8>] profile_task_exit+0x15/0x17
[ 4496.965430]  [<ffffffff80138345>] do_exit+0x55/0x81f
[ 4496.965439]  [<ffffffff8010ae4b>] kernel_math_error+0x0/0x96
[ 4496.965450]  [<ffffffff8043c102>] do_trap+0xdc/0xeb
[ 4496.965458]  [<ffffffff8043da98>] notifier_call_chain+0x29/0x3e
[ 4496.965468]  [<ffffffff8010b450>] do_invalid_op+0xa7/0xb3
[ 4496.965488]  [<ffffffff880b4499>] :reiserfs:flush_commit_list+0x532/0x60a
[ 4496.965498]  [<ffffffff80439f0f>] __wait_on_bit+0x67/0x77
[ 4496.965508]  [<ffffffff801a2bc3>] sync_buffer+0x0/0x42
[ 4496.965516]  [<ffffffff801a2bc3>] sync_buffer+0x0/0x42
[ 4496.965525]  [<ffffffff8043bb0d>] error_exit+0x0/0x84
[ 4496.965545]  [<ffffffff880b4499>] :reiserfs:flush_commit_list+0x532/0x60a
[ 4496.965556]  [<ffffffff8012ddcb>] __wake_up+0x43/0x50
[ 4496.965581]  [<ffffffff880b7385>] :reiserfs:do_journal_end+0xc95/0xced
[ 4496.965591]  [<ffffffff8012d21d>] find_busiest_group+0x24e/0x68f
[ 4496.965601]  [<ffffffff801484d7>] keventd_create_kthread+0x0/0x79
[ 4496.965620]  [<ffffffff880b7452>] :reiserfs:journal_end_sync+0x75/0x7e
[ 4496.965630]  [<ffffffff80169a39>] pdflush+0x0/0x1d4
[ 4496.965649]  [<ffffffff880a8e4a>] :reiserfs:reiserfs_sync_fs+0x41/0x67
[ 4496.965668]  [<ffffffff880a8e7e>] :reiserfs:reiserfs_write_super+0xe/0x10
[ 4496.965678]  [<ffffffff8018579d>] sync_supers+0x67/0xb6
[ 4496.965687]  [<ffffffff8016968e>] wb_kupdate+0x4d/0x133
[ 4496.965696]  [<ffffffff80169a39>] pdflush+0x0/0x1d4
[ 4496.965705]  [<ffffffff80169b62>] pdflush+0x129/0x1d4
[ 4496.965713]  [<ffffffff80169641>] wb_kupdate+0x0/0x133
[ 4496.965722]  [<ffffffff8014875c>] kthread+0xd8/0x10c
[ 4496.965731]  [<ffffffff801318b0>] schedule_tail+0x45/0xad
[ 4496.965740]  [<ffffffff8010a488>] child_rip+0xa/0x12
[ 4496.965748]  [<ffffffff801484d7>] keventd_create_kthread+0x0/0x79
[ 4496.965758]  [<ffffffff80148684>] kthread+0x0/0x10c
[ 4496.965772]  [<ffffffff8010a47e>] child_rip+0x0/0x12

msg log: http://oss.oracle.com/~rdunlap/kerneltest/logs/2620-rc5-reis-fsx.log
config:  http://oss.oracle.com/~rdunlap/kerneltest/configs/config-2620-rc5-reis-fsx

---
~Randy
