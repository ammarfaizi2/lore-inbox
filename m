Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWDOM10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWDOM10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 08:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWDOM1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 08:27:25 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:29826 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S932502AbWDOM1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 08:27:25 -0400
Date: Sat, 15 Apr 2006 14:27:17 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.5 smp oops in find_or_create_page()
Message-ID: <20060415122717.GA1822@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of our servers (a p3 smp machine) with 2.6.16.5 vanilla crashed last
night.  Kernel output enclosed below.

-- 
Tomas Szepe <szepe@pinerecords.com>

Apr 15 03:56:57 louise kernel: Unable to handle kernel paging request at virtual address 00008000
Apr 15 03:56:57 louise kernel:  printing eip:
Apr 15 03:56:57 louise kernel: c01405fd
Apr 15 03:56:57 louise kernel: *pde = 00000000
Apr 15 03:56:57 louise kernel: Oops: 0000 [#1]
Apr 15 03:56:57 louise kernel: SMP 
Apr 15 03:56:57 louise kernel: Modules linked in: tun ipt_multiport xt_tcpudp xt_state ip_conntrack nfnetlink iptable_filter ip_tables x_tables 3c59x mii loop psmouse non_fatal reiserfs raid1 ide_disk piix ide_core sd_mod aic7xxx scsi_transport_spi scsi_mod
Apr 15 03:56:57 louise kernel: CPU:    1
Apr 15 03:56:57 louise kernel: EIP:    0060:[<c01405fd>]    Not tainted VLI
Apr 15 03:56:57 louise kernel: EFLAGS: 00010006   (2.6.16.5 #1) 
Apr 15 03:56:57 louise kernel: EIP is at find_lock_page+0x3d/0x90
Apr 15 03:56:57 louise kernel: eax: 00008000   ebx: 00008000   ecx: 00000000   edx: 00000001
Apr 15 03:56:57 louise kernel: esi: d831b764   edi: 000000d8   ebp: d831b768   esp: d12cbc4c
Apr 15 03:56:57 louise kernel: ds: 007b   es: 007b   ss: 0068
Apr 15 03:56:57 louise kernel: Process postmaster (pid: 32399, threadinfo=d12ca000 task=c95b8570)
Apr 15 03:56:57 louise kernel: Stack: <0>d831b774 d12cbe0c 00000000 000200d2 000000d8 c0140cfb 00000014 d831b764 
Apr 15 03:56:57 louise kernel:        c0316848 00000002 d12cbe0c 00000000 00000000 d831b764 f090dda5 d12cbc84 
Apr 15 03:56:57 louise kernel:        f0926d56 00003f26 00000000 00000000 00000000 00000001 000d8000 00000000 
Apr 15 03:56:57 louise kernel: Call Trace:
Apr 15 03:56:57 louise kernel:  [<c0140cfb>] find_or_create_page+0x3b/0xc0
Apr 15 03:56:57 louise kernel:  [<f090dda5>] reiserfs_prepare_file_region_for_write+0xb5/0x860 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<f0926d56>] do_journal_end+0x1a6/0xce0 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<f090d224>] reiserfs_check_for_tail_and_convert+0x34/0x220 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c0177319>] file_update_time+0x39/0xb0
Apr 15 03:56:57 louise kernel:  [<f090eb58>] reiserfs_file_write+0x608/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c0106350>] do_gettimeofday+0x20/0xd0
Apr 15 03:56:57 louise kernel:  [<c012358d>] getnstimeofday+0xd/0x30
Apr 15 03:56:57 louise kernel:  [<c0106350>] do_gettimeofday+0x20/0xd0
Apr 15 03:56:57 louise kernel:  [<c012358d>] getnstimeofday+0xd/0x30
Apr 15 03:56:57 louise kernel:  [<c0134e9f>] ktime_get_ts+0x1f/0x60
Apr 15 03:56:57 louise kernel:  [<c01354b6>] ktime_get+0x16/0x40
Apr 15 03:56:57 louise kernel:  [<c01353e2>] hrtimer_run_queues+0x42/0x100
Apr 15 03:56:57 louise kernel:  [<c0127feb>] run_timer_softirq+0x3b/0x1a0
Apr 15 03:56:57 louise kernel:  [<c015e316>] vfs_write+0xa6/0x160
Apr 15 03:56:57 louise kernel:  [<f090e550>] reiserfs_file_write+0x0/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c015ecc1>] sys_write+0x41/0x70
Apr 15 03:56:57 louise kernel:  [<c0102e3d>] syscall_call+0x7/0xb
Apr 15 03:56:57 louise kernel: Code: 6e 04 e8 c7 a7 18 00 eb 13 90 8d 74 26 00 89 d8 e8 69 fe ff ff 89 d8 e8 f2 70 00 00 89 fa 89 e8 e8 b9 ad 07 00 85 c0 89 c3 74 36 <8b> 00 89 da f6 c4 40 75 3a f0 ff 42 04 f0 0f ba 2b 00 19 c0 85 
Apr 15 03:56:57 louise kernel:  
Apr 15 03:56:57 louise kernel: ==========================================
Apr 15 03:56:57 louise kernel: [ BUG: lock recursion deadlock detected! |
Apr 15 03:56:57 louise kernel: ------------------------------------------
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: postmaster/32399 is trying to acquire this lock:
Apr 15 03:56:57 louise kernel:  [d831b718] {inode_init_once}
Apr 15 03:56:57 louise kernel: .. held by:        postmaster:32399 [c95b8570, 119]
Apr 15 03:56:57 louise kernel: ... acquired at:               reiserfs_file_write+0x341/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel: ... trying at:                 reiserfs_file_release+0x4e/0x400 [reiserfs]
Apr 15 03:56:57 louise kernel: ------------------------------
Apr 15 03:56:57 louise kernel: | showing all locks held by: |  (postmaster/32399 [c95b8570, 119]):
Apr 15 03:56:57 louise kernel: ------------------------------
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: #001:             [d831b718] {inode_init_once}
Apr 15 03:56:57 louise kernel: ... acquired at:               reiserfs_file_write+0x341/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: postmaster/32399's [current] stackdump:
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel:  [<c01368d7>] report_deadlock+0x127/0x150
Apr 15 03:56:57 louise kernel:  [<c0136a96>] check_deadlock+0x196/0x1c0
Apr 15 03:56:57 louise kernel:  [<f090d93e>] reiserfs_file_release+0x4e/0x400 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c0136af8>] debug_mutex_add_waiter+0x38/0xc0
Apr 15 03:56:57 louise kernel:  [<f090d93e>] reiserfs_file_release+0x4e/0x400 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c025f52c>] sk_reset_timer+0xc/0x20
Apr 15 03:56:57 louise kernel:  [<c02ca139>] __mutex_lock_slowpath+0x79/0x3e0
Apr 15 03:56:57 louise kernel:  [<f090d93e>] reiserfs_file_release+0x4e/0x400 [reiserfs]
Apr 15 03:56:57 louise last message repeated 2 times
Apr 15 03:56:57 louise kernel:  [<c016277a>] invalidate_inode_buffers+0xa/0x60
Apr 15 03:56:57 louise kernel:  [<c015f1db>] __fput+0x8b/0x170
Apr 15 03:56:57 louise kernel:  [<c015c377>] filp_close+0x47/0x90
Apr 15 03:56:57 louise kernel:  [<c0120005>] put_files_struct+0x75/0xd0
Apr 15 03:56:57 louise kernel:  [<c01210c3>] do_exit+0x123/0x810
Apr 15 03:56:57 louise kernel:  [<c01c82ab>] vgacon_set_cursor_size+0x3b/0xf0
Apr 15 03:56:57 louise kernel:  [<c011f7bb>] printk+0x1b/0x20
Apr 15 03:56:57 louise kernel:  [<c01045e9>] die+0x229/0x230
Apr 15 03:56:57 louise kernel:  [<c0116b36>] do_page_fault+0x356/0x610
Apr 15 03:56:57 louise kernel:  [<c01167e0>] do_page_fault+0x0/0x610
Apr 15 03:56:57 louise kernel:  [<c0103963>] error_code+0x4f/0x54
Apr 15 03:56:57 louise kernel:  [<f091007b>] reiserfs_file_write+0x1b2b/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c01405fd>] find_lock_page+0x3d/0x90
Apr 15 03:56:57 louise kernel:  [<c0140cfb>] find_or_create_page+0x3b/0xc0
Apr 15 03:56:57 louise kernel:  [<f090dda5>] reiserfs_prepare_file_region_for_write+0xb5/0x860 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<f0926d56>] do_journal_end+0x1a6/0xce0 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<f090d224>] reiserfs_check_for_tail_and_convert+0x34/0x220 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c0177319>] file_update_time+0x39/0xb0
Apr 15 03:56:57 louise kernel:  [<f090eb58>] reiserfs_file_write+0x608/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c0106350>] do_gettimeofday+0x20/0xd0
Apr 15 03:56:57 louise kernel:  [<c012358d>] getnstimeofday+0xd/0x30
Apr 15 03:56:57 louise kernel:  [<c0106350>] do_gettimeofday+0x20/0xd0
Apr 15 03:56:57 louise kernel:  [<c012358d>] getnstimeofday+0xd/0x30
Apr 15 03:56:57 louise kernel:  [<c0134e9f>] ktime_get_ts+0x1f/0x60
Apr 15 03:56:57 louise kernel:  [<c01354b6>] ktime_get+0x16/0x40
Apr 15 03:56:57 louise kernel:  [<c01353e2>] hrtimer_run_queues+0x42/0x100
Apr 15 03:56:57 louise kernel:  [<c0127feb>] run_timer_softirq+0x3b/0x1a0
Apr 15 03:56:57 louise kernel:  [<c015e316>] vfs_write+0xa6/0x160
Apr 15 03:56:57 louise kernel:  [<f090e550>] reiserfs_file_write+0x0/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel:  [<c015ecc1>] sys_write+0x41/0x70
Apr 15 03:56:57 louise kernel:  [<c0102e3d>] syscall_call+0x7/0xb
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: Showing all blocking locks in the system:
Apr 15 03:56:57 louise kernel: S            init:    1 [eff03a70, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S     migration/0:    2 [eff03030,   0] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S     ksoftirqd/0:    3 [c16fea90, 134] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      watchdog/0:    4 [c16fe570,   0] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S     migration/1:    5 [c16fe050,   0] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S     ksoftirqd/1:    6 [c16f7ab0, 134] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      watchdog/1:    7 [c16f7590,   0] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S        events/0:    8 [c16f7070, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S        events/1:    9 [effeca70, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         khelper:   10 [effec550, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         kthread:   11 [effec030, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S       kblockd/0:   14 [effdb050, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S       kblockd/1:   15 [eff85ab0, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           khubd:   18 [eff7ea70, 114] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         pdflush:   65 [efd22030, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         pdflush:   66 [efd25a90, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           aio/0:   68 [efd25050, 114] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           aio/1:   69 [efd2bab0, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         kswapd0:   67 [efd25570, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         kseriod:  658 [eff70030, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           kirqd:  692 [eff6ca90, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S       scsi_eh_0:  720 [efe63570, 111] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S       scsi_eh_1:  755 [efe83a90, 111] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S       scsi_eh_2:  773 [efe83050, 111] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S       md0_raid1:  838 [efe36550, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      reiserfs/0:  846 [eff4e550, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      reiserfs/1:  847 [efe36030, 110] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S       kpsmoused:  915 [eff7e550, 112] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           named: 1064 [eff85590, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           vtund: 1070 [ede69070, 100] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R         syslogd: 1072 [efe36a70, 123] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R           klogd: 1090 [effdb570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           crond: 1098 [effdba90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            ntpd: 1100 [ede22590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S             atd: 1101 [efd2b070, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S     rpc.portmap: 1103 [efd22a70, 119] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          xinetd: 1107 [ede22ab0, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            sshd: 1114 [eff6c050, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      postmaster: 1130 [ef4ef570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          elaine: 1132 [edc95550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1134 [ede22070, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1135 [efe83570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1136 [edc95a70, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1137 [efd22550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1138 [eff85070, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1139 [efe63a90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1140 [ede69590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1141 [ef4efa90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1142 [efd2b590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise: 1143 [ede69ab0, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      postmaster: 1165 [eff4e030, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      postmaster: 1166 [edc95030, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      postmaster: 1167 [eb60eab0, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           spamd: 1169 [ede09a90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S        sendmail: 1173 [eff7e030, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S        sendmail: 1176 [eafd8a70, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           squid: 1178 [eff4ea70, 118] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           squid: 1180 [ece84050, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: ?         unlinkd: 1183 [eaa45570, 118] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          smartd: 1185 [eafd8030, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         distccd: 1187 [efe63050, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         distccd: 1188 [ef4ef050, 118] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1189 [eff70a70, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1190 [eff70550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1191 [ef047ab0, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1192 [ef047590, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1193 [ef047070, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1194 [eaa90a70, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1195 [eaa90550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          agetty: 1196 [eaa90030, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            sshd: 1211 [ea9fb050, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         distccd: 1214 [ea9fb570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         distccd: 1216 [ea9f8030, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S         distccd: 1217 [ea9f8550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R            sshd: 1220 [eae27590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 1221 [ea9fba90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            sshd: 1234 [eafd8550, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R            sshd: 1238 [eb60e590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 1239 [eff6c570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            sshd: 1252 [ed1a5050, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R            sshd: 1256 [eb60e070, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 1257 [ed1a5570, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            sshd: 1270 [eaa45050, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R            sshd: 1274 [eaa45a90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 1275 [e93cbab0, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            sshd: 1306 [e900ba70, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R            sshd: 1310 [ed1a5a90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 1311 [e93cb070, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S               i: 1324 [e72f8a90, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           irssi: 1325 [eae27ab0, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S      alice.conf: 1329 [ea12d590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            sshd: 6949 [dfcae070, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R            sshd: 6953 [d3720a70, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 6954 [ece62030, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            mutt: 6967 [dfcae590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          screen: 7562 [d1347550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 7563 [d1117570, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 7566 [d1117a90, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 7569 [e900b030, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 7570 [ece84570, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            mutt: 7571 [d424bab0, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           irssi: 7572 [dfcaeab0, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          screen: 9625 [d3720030, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash: 9626 [ece62a70, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            pine: 9627 [cc808550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          screen:15496 [ece84a90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash:15497 [c95b8a90, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           irssi:15503 [c75b3070, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            talk:15965 [c7a19ab0, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            talk:16158 [d424b590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           spamd:10731 [c4ed3050, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            bash:15881 [ce3cb590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S            mutt:26729 [e900b550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R          eloise:31797 [ece62550, 115] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:31805 [c95b8050, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:31809 [ea12dab0, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:31812 [d3720550, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:31814 [d1347a70, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:31818 [ce3cbab0, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:31842 [c3c77050, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32050 [c7a19590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32053 [c241d570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32088 [e93cb590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32093 [cc808030, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32238 [c75b3590, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32252 [d1117050, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S           spamd:32321 [cc808a70, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32324 [c4ed3570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32329 [ede09570, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S          eloise:32344 [d424b070, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: ?          elaine:32398 [ea9f8a70, 117] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: R      postmaster:32399 [c95b8570, 119] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: S        sendmail:32400 [ce3cb070, 116] (not blocked on mutex)
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: ---------------------------
Apr 15 03:56:57 louise kernel: | showing all locks held: |
Apr 15 03:56:57 louise kernel: ---------------------------
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: #001:             [d831b718] {inode_init_once}
Apr 15 03:56:57 louise kernel: .. held by:        postmaster:32399 [c95b8570, 119]
Apr 15 03:56:57 louise kernel: ... acquired at:               reiserfs_file_write+0x341/0x1be0 [reiserfs]
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: =============================================
Apr 15 03:56:57 louise kernel: 
Apr 15 03:56:57 louise kernel: [ turning off deadlock detection. Please report this. ]
Apr 15 03:56:57 louise kernel: 
