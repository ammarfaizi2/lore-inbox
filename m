Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbRE3TCh>; Wed, 30 May 2001 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbRE3TCS>; Wed, 30 May 2001 15:02:18 -0400
Received: from adsl-64-171-5-35.dsl.sntc01.pacbell.net ([64.171.5.35]:62340
	"EHLO k2-400.office") by vger.kernel.org with ESMTP
	id <S261839AbRE3TCL>; Wed, 30 May 2001 15:02:11 -0400
Date: Wed, 30 May 2001 12:02:07 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
To: linux-kernel@vger.kernel.org
Subject: OOpses in memory allocator with 2.4.5-ac2
Message-ID: <Pine.LNX.4.21.0105301159420.17672-100000@k2-400.office>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is a series of oopses that kept my server not responding for a
while this morning. Running lots of services amoung them a hub for the
openproject IRC network:

May 30 07:58:01 melchi kernel: invalid operand: 0000
May 30 07:58:01 melchi kernel: CPU:    0
May 30 07:58:01 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 07:58:01 melchi kernel: EFLAGS: 00010202
May 30 07:58:01 melchi kernel: eax: 00000048   ebx: 00000002   ecx: c01d9e54   edx: 00004000
May 30 07:58:01 melchi kernel: esi: c10bca18   edi: c01d9e84   ebp: 00000001   esp: c241fef8
May 30 07:58:01 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 07:58:01 melchi kernel: Process cron (pid: 238, stackpage=c241f000)
May 30 07:58:01 melchi kernel: Stack: c01d9e54 c01da04c 00000002 00000001 00001c62 00000282 c01d9e84 00000001 
May 30 07:58:01 melchi kernel:        c01d9e54 c01231d1 00000080 c01da054 00000001 c241ffbc c012328f c01da048 
May 30 07:58:01 melchi kernel:        00000001 00000002 00000000 c241e000 c241e000 c241ffa8 c241ffbc 00000007 
May 30 07:58:01 melchi kernel: Call Trace: [__alloc_pages_limit+105/128] [__alloc_pages+167/556] [__get_free_pages+20/32] [do_fork+140/1632] [sys_fork+20/28] 
May 30 07:58:01 melchi kernel:    [system_call+51/64] 
May 30 07:58:01 melchi kernel: 
May 30 07:58:01 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 07:59:10 melchi kernel:  invalid operand: 0000
May 30 07:59:10 melchi kernel: CPU:    0
May 30 07:59:10 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 07:59:10 melchi kernel: EFLAGS: 00010202
May 30 07:59:10 melchi kernel: eax: 00000048   ebx: 00000002   ecx: c01d9e54   edx: 00004000
May 30 07:59:10 melchi kernel: esi: c10c3018   edi: c01d9e84   ebp: 00000001   esp: c1e6bf1c
May 30 07:59:10 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 07:59:10 melchi kernel: Process apache (pid: 264, stackpage=c1e6b000)
May 30 07:59:10 melchi kernel: Stack: 00000060 c01da04c 00000001 c1e6bfbc 00001de2 00000292 c01d9e84 00000001 
May 30 07:59:10 melchi kernel:        c01d9e54 c0123241 c1e6a000 c1e6a000 c1e6bfa8 c1e6bfbc 00000007 00000000 
May 30 07:59:10 melchi kernel:        c01da048 c0123428 c010f6e8 c1e6a000 00000002 bffffc5c c1e6bfbc c1e6bf94 
May 30 07:59:10 melchi kernel: Call Trace: [__alloc_pages+89/556] [__get_free_pages+20/32] [do_fork+140/1632] [sys_fork+20/28] [system_call+51/64] 
May 30 07:59:10 melchi kernel:    [startup_32+43/165] 
May 30 07:59:10 melchi kernel: 
May 30 07:59:10 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 07:59:17 melchi kernel:  invalid operand: 0000
May 30 07:59:17 melchi kernel: CPU:    0
May 30 07:59:17 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 07:59:17 melchi kernel: EFLAGS: 00010202
May 30 07:59:17 melchi kernel: eax: 0000004c   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 07:59:17 melchi kernel: esi: c10be310   edi: c01d9e78   ebp: 00000000   esp: c0f9dd3c
May 30 07:59:17 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 07:59:17 melchi kernel: Process apache (pid: 6325, stackpage=c0f9d000)
May 30 07:59:17 melchi kernel: Stack: 00000060 c01d9ffc 00000000 00041704 00001cc0 00000292 c01d9e78 00000000 
May 30 07:59:17 melchi kernel:        c01d9e54 c0123241 00000000 00001000 00000000 00041704 00000003 00000001 
May 30 07:59:17 melchi kernel:        c01d9ff8 c012b4ee 00000000 00000006 00001601 00041704 00000000 c01298f1 
May 30 07:59:17 melchi kernel: Call Trace: [__alloc_pages+89/556] [grow_buffers+62/320] [refill_freelist+41/84] [getblk+242/264] [ext2_getblk+123/316] 
May 30 07:59:17 melchi kernel:    [ext2_getblk+123/316] [cached_lookup+16/84] [path_walk+1569/1768] [ext2_find_entry+121/776] [cached_lookup+16/84] [ext2_lookup+48/128] 
May 30 07:59:17 melchi kernel:    [real_lookup+83/196] [path_walk+1225/1768] [open_namei+120/1376] [filp_open+51/84] [sys_open+54/152] [system_call+51/64] 
May 30 07:59:17 melchi kernel:    [startup_32+43/165] 
May 30 07:59:17 melchi kernel: 
May 30 07:59:17 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 07:59:26 melchi kernel:  invalid operand: 0000
May 30 07:59:26 melchi kernel: CPU:    0
May 30 07:59:26 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 07:59:26 melchi kernel: EFLAGS: 00010202
May 30 07:59:26 melchi kernel: eax: 0000004c   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 07:59:26 melchi kernel: esi: c10d5a20   edi: c01d9e78   ebp: 00000000   esp: c0f9fe88
May 30 07:59:26 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 07:59:26 melchi kernel: Process apache (pid: 6324, stackpage=c0f9f000)
May 30 07:59:26 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 00002244 00000282 c01d9e84 00000000 
May 30 07:59:26 melchi kernel:        c01d9e54 c0123241 c1025e38 c1000010 ffffffff 00000001 00000005 00000001 
May 30 07:59:26 melchi kernel:        c01da020 c011a0d6 080f301c c1d22540 ffffffff 00000001 c011a7cb c1d22540 
May 30 07:59:26 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 07:59:26 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [rm_sig_from_queue+20/24] [do_sigaction+154/220] [sys_rt_sigaction+144/236] [error_code+52/64] 
May 30 07:59:26 melchi kernel:    [<ffff0007>] [startup_32+43/165] 
May 30 07:59:26 melchi kernel: 
May 30 07:59:26 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 07:59:26 melchi kernel:  invalid operand: 0000
May 30 07:59:26 melchi kernel: CPU:    0
May 30 07:59:26 melchi kernel: EIP:    0010:[__free_pages_ok+17/552]
May 30 07:59:26 melchi kernel: EFLAGS: 00010286
May 30 07:59:26 melchi kernel: eax: c10d5a20   ebx: c10d5a20   ecx: c10d5a20   edx: 00000000
May 30 07:59:26 melchi kernel: esi: 03244025   edi: 00000000   ebp: 00001000   esp: c0f9fd00
May 30 07:59:26 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 07:59:26 melchi kernel: Process apache (pid: 6324, stackpage=c0f9f000)
May 30 07:59:26 melchi kernel: Stack: c10d5a20 03244025 00007000 00001000 005f4000 00003b00 00002000 c01195e8 
May 30 07:59:26 melchi kernel:        c012347e c01195d9 c270fde0 c1d22540 40207000 00007000 00607000 c0998404 
May 30 07:59:26 melchi kernel:        40607000 c0998404 c0386820 00000002 00000000 0020e000 00000000 4020e000 
May 30 07:59:26 melchi kernel: Call Trace: [zap_page_range+464/628] [__free_pages+26/28] [zap_page_range+449/628] [exit_mmap+181/288] [mmput+38/60] 
May 30 07:59:26 melchi kernel:    [do_exit+130/464] [do_invalid_op+0/136] [die+82/84] [do_invalid_op+127/136] [rmqueue+552/592] [ip_finish_output2+0/180] 
May 30 07:59:26 melchi kernel:    [dev_queue_xmit+220/488] [ip_finish_output2+121/180] [nf_hook_slow+238/308] [ei_interrupt+197/452] [error_code+52/64] [rmqueue+552/592] 
May 30 07:59:26 melchi kernel:    [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] [<ffff0007>] 
May 30 07:59:26 melchi kernel:    [do_page_fault+0/1112] [rm_sig_from_queue+20/24] [do_sigaction+154/220] [sys_rt_sigaction+144/236] [error_code+52/64] [<ffff0007>] 
May 30 07:59:26 melchi kernel:    [startup_32+43/165] 
May 30 07:59:26 melchi kernel: 
May 30 07:59:26 melchi kernel: Code: 0f 0b 83 7b 08 00 74 02 0f 0b 89 da 2b 15 b8 61 23 c0 89 d0 
May 30 07:59:37 melchi kernel:  invalid operand: 0000
May 30 07:59:37 melchi kernel: CPU:    0
May 30 07:59:37 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 07:59:37 melchi kernel: EFLAGS: 00010202
May 30 07:59:37 melchi kernel: eax: 0000004c   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 07:59:37 melchi kernel: esi: c10d59dc   edi: c01d9e78   ebp: 00000000   esp: c1369ec0
May 30 07:59:37 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 07:59:37 melchi kernel: Process apache (pid: 6138, stackpage=c1369000)
May 30 07:59:37 melchi kernel: Stack: 00000060 c01da024 00000000 c1127440 00002243 00000282 c01d9e78 00000000 
May 30 07:59:37 melchi kernel:        c01d9e54 c0123241 c106e27c c2f45328 00003131 c1127440 00000005 00000001 
May 30 07:59:37 melchi kernel:        c01da020 c011c902 c0e61660 c106e27c 00003111 c2f45328 00003131 0000001f 
May 30 07:59:37 melchi kernel: Call Trace: [__alloc_pages+89/556] [generic_file_readahead+478/644] [do_generic_file_read+494/1192] [generic_file_read+99/124] [file_read_actor+0/104] 
May 30 07:59:37 melchi kernel:    [sys_read+150/204] [system_call+51/64] 
May 30 07:59:37 melchi kernel: 
May 30 07:59:37 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 08:19:46 melchi -- MARK --
May 30 08:32:09 melchi kernel:  invalid operand: 0000
May 30 08:32:09 melchi kernel: CPU:    0
May 30 08:32:09 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 08:32:09 melchi kernel: EFLAGS: 00010202
May 30 08:32:09 melchi kernel: eax: 00000048   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 08:32:09 melchi kernel: esi: c10dd494   edi: c01d9e78   ebp: 00000000   esp: c2ce3e88
May 30 08:32:09 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 08:32:09 melchi kernel: Process sshd (pid: 6616, stackpage=c2ce3000)
May 30 08:32:09 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 00002411 00000282 c01d9e84 00000000 
May 30 08:32:09 melchi kernel:        c01d9e54 c0123241 c105b720 c105b748 00000000 00000001 00000005 00000001 
May 30 08:32:09 melchi kernel:        c01da020 c011a0d6 40051244 c11cef20 ffffffff 00000001 c011a7cb c11cef20 
May 30 08:32:09 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 08:32:09 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [do_munmap+533/548] [<ffff0001>] [sys_munmap+53/84] [error_code+52/64] 
May 30 08:32:09 melchi kernel:    [<ffff0007>] 
May 30 08:32:09 melchi kernel: 
May 30 08:32:09 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 08:32:40 melchi kernel:  invalid operand: 0000
May 30 08:32:40 melchi kernel: CPU:    0
May 30 08:32:40 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 08:32:40 melchi kernel: EFLAGS: 00010202
May 30 08:32:40 melchi kernel: eax: 0000004c   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 08:32:40 melchi kernel: esi: c10dd450   edi: c01d9e78   ebp: 00000000   esp: c1b95e88
May 30 08:32:40 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 08:32:40 melchi kernel: Process rsync (pid: 6619, stackpage=c1b95000)
May 30 08:32:40 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 00002410 00000282 c01d9e78 00000000 
May 30 08:32:40 melchi kernel:        c01d9e54 c0123241 c1004520 c1000010 ffffffff 00000001 00000005 00000001 
May 30 08:32:40 melchi kernel:        c01da020 c011a0d6 4012d108 c11cef20 ffffffff 00000001 c011a7cb c11cef20 
May 30 08:32:40 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 08:32:41 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [do_munmap+533/548] [<ffff0001>] [sys_munmap+53/84] [error_code+52/64] 
May 30 08:32:41 melchi kernel:    [<ffff0007>] 
May 30 08:32:41 melchi kernel: 
May 30 08:32:41 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 08:58:52 melchi kernel:  invalid operand: 0000
May 30 08:58:52 melchi kernel: CPU:    0
May 30 08:58:52 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 08:58:52 melchi kernel: EFLAGS: 00010206
May 30 08:58:52 melchi kernel: eax: 00000808   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 08:58:52 melchi kernel: esi: c10bec5c   edi: c01d9e78   ebp: 00000000   esp: c1b95e88
May 30 08:58:52 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 08:58:52 melchi kernel: Process watchdog (pid: 6724, stackpage=c1b95000)
May 30 08:58:52 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 00001ce3 00000282 c01d9e84 00000000 
May 30 08:58:52 melchi kernel:        c01d9e54 c0123241 c10f84c0 c1000010 ffffffff 00000001 00000005 00000001 
May 30 08:58:52 melchi kernel:        c01da020 c011a0d6 4012573c c11cef20 ffffffff 00000001 c011a7cb c11cef20 
May 30 08:58:52 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 08:58:52 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [filp_close+92/100] [do_exit+454/464] [error_code+52/64] [<ffff0007>] 
May 30 08:58:52 melchi kernel:    [startup_32+43/165] 
May 30 08:58:52 melchi kernel: 
May 30 08:58:52 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 08:58:57 melchi kernel:  invalid operand: 0000
May 30 08:58:57 melchi kernel: CPU:    0
May 30 08:58:57 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 08:58:57 melchi kernel: EFLAGS: 00010202
May 30 08:58:57 melchi kernel: eax: 00000048   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 08:58:57 melchi kernel: esi: c10d0278   edi: c01d9e78   ebp: 00000000   esp: c1b95e60
May 30 08:58:57 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 08:58:57 melchi kernel: Process sh (pid: 6725, stackpage=c1b95000)
May 30 08:58:57 melchi kernel: Stack: 00000060 c01da024 00000000 c3519674 000020fa 00000282 c01d9e84 00000000 
May 30 08:58:57 melchi kernel:        c01d9e54 c0123241 c2c64960 c2c64960 c11cef20 c3519674 00000005 00000001 
May 30 08:58:57 melchi kernel:        c01da020 c011a5de c2c64960 c11cef20 00000001 c3519674 c011a67f c11cef20 
May 30 08:58:57 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_anonymous_page+50/164] [do_no_page+47/232] [handle_mm_fault+91/196] [do_page_fault+0/1112] 
May 30 08:58:57 melchi kernel:    [do_page_fault+348/1112] [do_page_fault+0/1112] [do_mmap_pgoff+601/1020] [old_mmap+244/300] [error_code+52/64] 
May 30 08:58:57 melchi kernel: 
May 30 08:58:57 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 09:09:24 melchi kernel:  invalid operand: 0000
May 30 09:09:24 melchi kernel: CPU:    0
May 30 09:09:24 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 09:09:24 melchi kernel: EFLAGS: 00010202
May 30 09:09:24 melchi kernel: eax: 0000004c   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 09:09:24 melchi kernel: esi: c10d0234   edi: c01d9e78   ebp: 00000000   esp: c3a5de88
May 30 09:09:24 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:09:24 melchi kernel: Process proftpd (pid: 6726, stackpage=c3a5d000)
May 30 09:09:24 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 000020f9 00000282 c01d9e78 00000000 
May 30 09:09:24 melchi kernel:        c01d9e54 c0123241 c106b158 c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:09:24 melchi kernel:        c01da020 c011a0d6 0808269c c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:09:24 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:09:24 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [rm_sig_from_queue+20/24] [do_sigaction+154/220] [sys_rt_sigaction+144/236] [error_code+52/64] 
May 30 09:09:24 melchi kernel:    [<ffff0007>] 
May 30 09:09:24 melchi kernel: 
May 30 09:09:24 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 09:19:18 melchi kernel:  invalid operand: 0000
May 30 09:19:18 melchi kernel: CPU:    0
May 30 09:19:18 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 09:19:18 melchi kernel: EFLAGS: 00010202
May 30 09:19:18 melchi kernel: eax: 00000298   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 09:19:18 melchi kernel: esi: c10e1960   edi: c01d9e78   ebp: 00000000   esp: c3a5de88
May 30 09:19:18 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:19:18 melchi kernel: Process proftpd (pid: 6727, stackpage=c3a5d000)
May 30 09:19:18 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 00002514 00000282 c01d9e84 00000000 
May 30 09:19:18 melchi kernel:        c01d9e54 c0123241 c102b4d0 c102b4f8 00000000 00000001 00000005 00000001 
May 30 09:19:18 melchi kernel:        c01da020 c011a0d6 40172364 c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:19:18 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:19:18 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [unix_release_sock+442/472] [permission+42/48] [open_namei+774/1376] [dentry_open+192/324] 
May 30 09:19:18 melchi kernel:    [filp_open+74/84] [sys_open+108/152] [error_code+52/64] [<ffff0007>] 
May 30 09:19:18 melchi kernel: 
May 30 09:19:18 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 09:19:18 melchi kernel:  invalid operand: 0000
May 30 09:19:18 melchi kernel: CPU:    0
May 30 09:19:18 melchi kernel: EIP:    0010:[rmqueue+552/592]
May 30 09:19:18 melchi kernel: EFLAGS: 00010202
May 30 09:19:18 melchi kernel: eax: 0000004c   ebx: 00000001   ecx: c01d9e54   edx: 00004000
May 30 09:19:18 melchi kernel: esi: c10e191c   edi: c01d9e78   ebp: 00000000   esp: c2451e88
May 30 09:19:18 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:19:18 melchi kernel: Process proftpd (pid: 235, stackpage=c2451000)
May 30 09:19:18 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 00002513 00000282 c01d9e78 00000000 
May 30 09:19:18 melchi kernel:        c01d9e54 c0123241 c10aa670 c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:19:18 melchi kernel:        c01da020 c011a0d6 0809093c c11ce820 ffffffff 00000001 c011a7cb c11ce820 
May 30 09:19:18 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:19:18 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [do_fork+1453/1632] [filp_close+92/100] [sys_close+67/84] [error_code+52/64] 
May 30 09:19:18 melchi kernel:    [<ffff0007>] 
May 30 09:19:18 melchi kernel: 
May 30 09:19:18 melchi kernel: Code: 0f 0b 89 f0 eb 1a 47 83 44 24 18 0c 83 ff 09 0f 86 eb fd ff 
May 30 09:19:27 melchi kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000020
May 30 09:19:27 melchi kernel:  printing eip:
May 30 09:19:27 melchi kernel: c013a3fc
May 30 09:19:27 melchi kernel: Oops: 0000
May 30 09:19:27 melchi kernel: CPU:    0
May 30 09:19:27 melchi kernel: EIP:    0010:[find_inode+32/76]
May 30 09:19:27 melchi kernel: EFLAGS: 00010213
May 30 09:19:27 melchi kernel: eax: 00000000   ebx: 00000000   ecx: 0000000c   edx: c1118000
May 30 09:19:27 melchi kernel: esi: 00000000   edi: 00000000   ebp: 0031e7e2   esp: c3a5debc
May 30 09:19:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:19:27 melchi kernel: Process proftpd (pid: 6728, stackpage=c3a5d000)
May 30 09:19:27 melchi kernel: Stack: 0031e7e2 c1118d68 0031e7e2 c3da9800 c013a7d4 c3da9800 0031e7e2 c1118d68 
May 30 09:19:27 melchi kernel:        00000000 00000000 0031e7e2 c2ccb0c0 c1d98a20 c32326a0 c01481c3 c3da9800 
May 30 09:19:27 melchi kernel:        0031e7e2 00000000 00000000 fffffff4 c1d98a20 c2ccb0c0 c1b1d028 c013160b 
May 30 09:19:27 melchi kernel: Call Trace: [iget4+64/212] [ext2_lookup+91/128] [real_lookup+83/196] [path_walk+1225/1768] [getname+91/152] 
May 30 09:19:27 melchi kernel:    [__user_walk+60/88] [sys_lstat64+22/112] [sys_flock+173/180] [system_call+51/64] 
May 30 09:19:27 melchi kernel: 
May 30 09:19:27 melchi kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 90 00 00 00 75 e3 85 ff 74 
May 30 09:29:40 melchi kernel:  invalid operand: 0000
May 30 09:29:40 melchi kernel: CPU:    0
May 30 09:29:40 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:29:40 melchi kernel: EFLAGS: 00010087
May 30 09:29:40 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:29:40 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:29:40 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:29:40 melchi kernel: Process sshd (pid: 6729, stackpage=c3a5d000)
May 30 09:29:40 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c112d8c8 00000282 c01d9e84 00000000 
May 30 09:29:40 melchi kernel:        c01d9e54 c0123241 c10e3fa0 c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:29:40 melchi kernel:        c01da020 c011a0d6 4022cdf8 c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:29:40 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:29:40 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [do_sigaction+154/220] [sockfd_lookup+17/120] [sys_setsockopt+80/128] [sys_setsockopt+116/128] 
May 30 09:29:40 melchi kernel:    [sys_socketcall+200/512] [error_code+52/64] [<ffff0007>] 
May 30 09:29:40 melchi kernel: 
May 30 09:29:40 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:29:47 melchi kernel:  invalid operand: 0000
May 30 09:29:47 melchi kernel: CPU:    0
May 30 09:29:47 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:29:47 melchi kernel: EFLAGS: 00010087
May 30 09:29:47 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:29:47 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:29:47 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:29:47 melchi kernel: Process sshd (pid: 6730, stackpage=c3a5d000)
May 30 09:29:47 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c11206a8 00000282 c01d9e84 00000000 
May 30 09:29:47 melchi kernel:        c01d9e54 c0123241 c105e04c c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:29:47 melchi kernel:        c01da020 c011a0d6 bfffd4cc c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:29:47 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:29:47 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [do_sigaction+154/220] [sockfd_lookup+17/120] [sys_setsockopt+80/128] [sys_setsockopt+116/128] 
May 30 09:29:47 melchi kernel:    [sys_socketcall+220/512] [error_code+52/64] [<ffff0007>] 
May 30 09:29:47 melchi kernel: 
May 30 09:29:47 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:30:01 melchi kernel:  invalid operand: 0000
May 30 09:30:01 melchi kernel: CPU:    0
May 30 09:30:01 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:30:01 melchi kernel: EFLAGS: 00010087
May 30 09:30:01 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:30:01 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 0804d8c8   esp: c3a5ddc4
May 30 09:30:01 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:30:01 melchi kernel: Process inetd (pid: 6731, stackpage=c3a5d000)
May 30 09:30:01 melchi kernel: Stack: 00000060 c01da024 00000000 0804d8c8 00000080 00000286 c01d9e84 00000000 
May 30 09:30:01 melchi kernel:        c01d9e54 c0123241 0000007c 0000000f c3a5deec 0804d8c8 00000005 00000001 
May 30 09:30:01 melchi kernel:        c01da020 c012f879 c3a5c000 c0000000 c3a5deec 0804d8c8 00000fed c3a5deec 
May 30 09:30:01 melchi kernel: Call Trace: [__alloc_pages+89/556] [copy_strings+197/408] [copy_strings_kernel+39/48] [do_execve+313/488] [sys_execve+47/96] 
May 30 09:30:01 melchi kernel:    [system_call+51/64] 
May 30 09:30:01 melchi kernel: 
May 30 09:30:01 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:30:27 melchi kernel:  invalid operand: 0000
May 30 09:30:27 melchi kernel: CPU:    0
May 30 09:30:27 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:30:27 melchi kernel: EFLAGS: 00010087
May 30 09:30:27 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:30:27 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:30:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:30:27 melchi kernel: Process inetd (pid: 6732, stackpage=c3a5d000)
May 30 09:30:27 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c1120840 00000282 c01d9e84 00000000 
May 30 09:30:27 melchi kernel:        c01d9e54 c0123241 c10b4dc8 c10b4df0 00000000 00000001 00000005 00000001 
May 30 09:30:27 melchi kernel:        c01da020 c011a0d6 40126df8 c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:30:27 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:30:27 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [do_munmap+533/548] [<ffff0001>] [sys_munmap+53/84] [error_code+52/64] 
May 30 09:30:27 melchi kernel:    [<ffff0007>] 
May 30 09:30:27 melchi kernel: 
May 30 09:30:27 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:30:41 melchi kernel:  invalid operand: 0000
May 30 09:30:41 melchi kernel: CPU:    0
May 30 09:30:41 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:30:41 melchi kernel: EFLAGS: 00010087
May 30 09:30:41 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:30:41 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: c1452228   esp: c3a5de60
May 30 09:30:41 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:30:41 melchi kernel: Process sshd (pid: 6733, stackpage=c3a5d000)
May 30 09:30:41 melchi kernel: Stack: 00000060 c01da024 00000000 c1452228 00002a47 00000282 c01d9e84 00000000 
May 30 09:30:41 melchi kernel:        c01d9e54 c0123241 c3da5360 c3da5360 c11ce420 c1452228 00000005 00000001 
May 30 09:30:41 melchi kernel:        c01da020 c011a5de c3da5360 c11ce420 00000001 c1452228 c011a67f c11ce420 
May 30 09:30:41 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_anonymous_page+50/164] [do_no_page+47/232] [handle_mm_fault+91/196] [do_page_fault+0/1112] 
May 30 09:30:41 melchi kernel:    [do_page_fault+348/1112] [<ffff0006>] [do_page_fault+0/1112] [do_sigaction+154/220] [sockfd_lookup+17/120] [sys_setsockopt+80/128] 
May 30 09:30:41 melchi kernel:    [sys_setsockopt+116/128] [sys_socketcall+430/512] [error_code+52/64] [<ffff0006>] 
May 30 09:30:41 melchi kernel: 
May 30 09:30:41 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:13 melchi kernel:  invalid operand: 0000
May 30 09:31:13 melchi kernel: CPU:    0
May 30 09:31:13 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:13 melchi kernel: EFLAGS: 00010087
May 30 09:31:13 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:13 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:31:13 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:13 melchi kernel: Process sshd (pid: 6734, stackpage=c3a5d000)
May 30 09:31:13 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 00001450 00000282 c01d9e84 00000000 
May 30 09:31:13 melchi kernel:        c01d9e54 c0123241 c1105b60 c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:31:13 melchi kernel:        c01da020 c011a0d6 0808923c c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:31:13 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:31:13 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [do_sigaction+154/220] [sockfd_lookup+17/120] [sys_setsockopt+80/128] [sys_setsockopt+116/128] 
May 30 09:31:13 melchi kernel:    [sys_socketcall+430/512] [error_code+52/64] [<ffff0007>] 
May 30 09:31:13 melchi kernel: 
May 30 09:31:13 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:18 melchi kernel:  invalid operand: 0000
May 30 09:31:18 melchi kernel: CPU:    0
May 30 09:31:18 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:18 melchi kernel: EFLAGS: 00010087
May 30 09:31:18 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:18 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:31:18 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:18 melchi kernel: Process inetd (pid: 6735, stackpage=c3a5d000)
May 30 09:31:18 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c112315c 00000282 c01d9e84 00000000 
May 30 09:31:18 melchi kernel:        c01d9e54 c0123241 c108d3bc c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:31:18 melchi kernel:        c01da020 c011a0d6 4015abc0 c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:31:18 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:31:18 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [insert_vm_struct+35/52] [do_munmap+88/548] [do_brk+173/356] [sys_brk+166/208] 
May 30 09:31:18 melchi kernel:    [error_code+52/64] [<ffff0007>] 
May 30 09:31:18 melchi kernel: 
May 30 09:31:18 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:29 melchi kernel:  invalid operand: 0000
May 30 09:31:29 melchi kernel: CPU:    0
May 30 09:31:29 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:29 melchi kernel: EFLAGS: 00010087
May 30 09:31:29 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:29 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:31:29 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:29 melchi kernel: Process inetd (pid: 6736, stackpage=c3a5d000)
May 30 09:31:29 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c1120858 00000282 c01d9e84 00000000 
May 30 09:31:29 melchi kernel:        c01d9e54 c0123241 c10d119c c10d11c4 00000000 00000001 00000005 00000001 
May 30 09:31:29 melchi kernel:        c01da020 c011a0d6 4012a66c c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:31:29 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:31:29 melchi kernel:    [do_page_fault+0/1112] [insert_vm_struct+35/52] [do_munmap+88/548] [do_brk+173/356] [sys_brk+166/208] [error_code+52/64] 
May 30 09:31:29 melchi kernel: 
May 30 09:31:29 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:32 melchi kernel:  invalid operand: 0000
May 30 09:31:32 melchi kernel: CPU:    0
May 30 09:31:32 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:32 melchi kernel: EFLAGS: 00010087
May 30 09:31:32 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:32 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:31:32 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:32 melchi kernel: Process inetd (pid: 6737, stackpage=c3a5d000)
May 30 09:31:32 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c3a5ded4 00000282 c01d9e84 00000000 
May 30 09:31:32 melchi kernel:        c01d9e54 c0123241 c10e26ec c10e2714 00000000 00000001 00000005 00000001 
May 30 09:31:32 melchi kernel:        c01da020 c011a0d6 bfffefbc c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:31:32 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:31:32 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [generic_file_read+99/124] [file_read_actor+0/104] [sys_read+195/204] [error_code+52/64] 
May 30 09:31:32 melchi kernel:    [<ffff0007>] 
May 30 09:31:32 melchi kernel: 
May 30 09:31:32 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:38 melchi kernel:  invalid operand: 0000
May 30 09:31:38 melchi kernel: CPU:    0
May 30 09:31:38 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:38 melchi kernel: EFLAGS: 00010087
May 30 09:31:38 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:38 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:31:38 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:38 melchi kernel: Process inetd (pid: 6738, stackpage=c3a5d000)
May 30 09:31:38 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c1120850 00000282 c01d9e84 00000000 
May 30 09:31:38 melchi kernel:        c01d9e54 c0123241 c10f3488 c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:31:38 melchi kernel:        c01da020 c011a0d6 0804f79c c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:31:38 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:31:38 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [generic_file_read+99/124] [file_read_actor+0/104] [error_code+52/64] [<ffff0007>] 
May 30 09:31:38 melchi kernel: 
May 30 09:31:38 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:48 melchi kernel:  invalid operand: 0000
May 30 09:31:48 melchi kernel: CPU:    0
May 30 09:31:48 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:48 melchi kernel: EFLAGS: 00010087
May 30 09:31:48 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:48 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: c3a6c080   esp: c373de88
May 30 09:31:48 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:48 melchi kernel: Process inetd (pid: 161, stackpage=c373d000)
May 30 09:31:48 melchi kernel: Stack: 00000060 c01da04c 00000000 c3a6c080 00002a6d 00000282 c01d9e84 00000000 
May 30 09:31:48 melchi kernel:        c01d9e54 c0123241 00000000 08048000 c373b120 c3a6c080 00000007 00000001 
May 30 09:31:48 melchi kernel:        c01da048 c0123428 c011a840 c11cc7a0 c11cc7e0 c373b120 08048000 c0119349 
May 30 09:31:48 melchi kernel: Call Trace: [__alloc_pages+89/556] [__get_free_pages+20/32] [pte_alloc+60/152] [copy_page_range+221/428] [dup_mmap+254/372] 
May 30 09:31:48 melchi kernel:    [copy_mm+247/376] [do_fork+1055/1632] [sys_fork+20/28] [system_call+51/64] 
May 30 09:31:48 melchi kernel: 
May 30 09:31:48 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:48 melchi kernel:  invalid operand: 0000
May 30 09:31:48 melchi kernel: CPU:    0
May 30 09:31:48 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:48 melchi kernel: EFLAGS: 00010087
May 30 09:31:48 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:48 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000001   esp: c3a5de88
May 30 09:31:48 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:48 melchi kernel: Process tcpd (pid: 6739, stackpage=c3a5d000)
May 30 09:31:48 melchi kernel: Stack: 00000060 c01da024 00000000 00000001 c1120aa8 00000282 c01d9e84 00000000 
May 30 09:31:48 melchi kernel:        c01d9e54 c0123241 c104ab1c c1000010 ffffffff 00000001 00000005 00000001 
May 30 09:31:48 melchi kernel:        c01da020 c011a0d6 4012c9c4 c11ce420 ffffffff 00000001 c011a7cb c11ce420 
May 30 09:31:48 melchi kernel: Call Trace: [__alloc_pages+89/556] [do_wp_page+346/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] [do_page_fault+348/1112] 
May 30 09:31:48 melchi kernel:    [<ffff0007>] [do_page_fault+0/1112] [insert_vm_struct+35/52] [do_mmap_pgoff+862/1020] [old_mmap+244/300] [filp_close+92/100] 
May 30 09:31:48 melchi kernel:    [sys_close+67/84] [error_code+52/64] [<ffff0007>] 
May 30 09:31:48 melchi kernel: 
May 30 09:31:48 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:49 melchi kernel:  invalid operand: 0000
May 30 09:31:49 melchi kernel: CPU:    0
May 30 09:31:49 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:49 melchi kernel: EFLAGS: 00010087
May 30 09:31:49 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:49 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: c290e1ac   esp: c27adea8
May 30 09:31:49 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:49 melchi kernel: Process sshd (pid: 219, stackpage=c27ad000)
May 30 09:31:49 melchi kernel: Stack: 00000060 c01da04c 00000000 c290e1ac ffffffff 00000286 c01d9e84 00000000 
May 30 09:31:49 melchi kernel:        c01d9e54 c0123241 00000000 c27adf68 c37cbba0 c290e1ac 00000007 00000001 
May 30 09:31:49 melchi kernel:        c01da048 c0123428 c01353c7 c31760a0 c37cbba0 c3176178 c27adf70 c018cd9e 
May 30 09:31:49 melchi kernel: Call Trace: [__alloc_pages+89/556] [__get_free_pages+20/32] [__pollwait+51/140] [tcp_poll+46/324] [<ffff0007>] 
May 30 09:31:49 melchi kernel:    [sock_poll+35/40] [do_select+226/476] [sys_select+820/1156] [system_call+51/64] 
May 30 09:31:49 melchi kernel: 
May 30 09:31:49 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:31:49 melchi kernel:  invalid operand: 0000
May 30 09:31:49 melchi kernel: CPU:    0
May 30 09:31:49 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 09:31:49 melchi kernel: EFLAGS: 00010087
May 30 09:31:49 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 09:31:49 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000000   esp: c3a5de50
May 30 09:31:49 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 09:31:49 melchi kernel: Process sshd (pid: 6741, stackpage=c3a5d000)
May 30 09:31:49 melchi kernel: Stack: 00000060 c01da024 00000000 00000000 0000273a 00000286 c01d9e84 00000000 
May 30 09:31:49 melchi kernel:        c01d9e54 c0123241 00000000 00000000 0002eb00 00000000 00000005 00000001 
May 30 09:31:49 melchi kernel:        c01da020 c0123945 00000000 0000000b 00000010 c011a418 0002eb00 00000000 
May 30 09:31:49 melchi kernel: Call Trace: [__alloc_pages+89/556] [read_swap_cache_async+49/140] [swapin_readahead+136/192] [do_swap_page+38/348] [handle_mm_fault+108/196] 
May 30 09:31:49 melchi kernel:    [do_page_fault+0/1112] [do_page_fault+348/1112] [<ffff0004>] [do_page_fault+0/1112] [ip_rcv_finish+0/440] [net_rx_action+309/528] 
May 30 09:31:49 melchi kernel:    [do_softirq+64/100] [do_IRQ+161/176] [error_code+52/64] [<ffff0004>] 
May 30 09:31:49 melchi kernel: 
May 30 09:31:49 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 09:59:45 melchi -- MARK --
May 30 10:11:27 melchi kernel:  invalid operand: 0000
May 30 10:11:27 melchi kernel: CPU:    0
May 30 10:11:27 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 10:11:27 melchi kernel: EFLAGS: 00010087
May 30 10:11:27 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 10:11:27 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: c1f6878c   esp: c215bea8
May 30 10:11:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 10:11:27 melchi kernel: Process ssh (pid: 253, stackpage=c215b000)
May 30 10:11:27 melchi kernel: Stack: 00000060 c01da04c 00000000 c1f6878c 000b1a00 00000286 c01d9e84 00000000 
May 30 10:11:27 melchi kernel:        c01d9e54 c0123241 00000000 c215bf68 c20bef80 c1f6878c 00000007 00000001 
May 30 10:11:27 melchi kernel:        c01da048 c0123428 c01353c7 c2400a80 c20bef80 c2400b58 c215bf70 c018cd9e 
May 30 10:11:27 melchi kernel: Call Trace: [__alloc_pages+89/556] [__get_free_pages+20/32] [__pollwait+51/140] [tcp_poll+46/324] [sock_poll+35/40] 
May 30 10:11:27 melchi kernel:    [do_select+226/476] [sys_select+820/1156] [system_call+51/64] 
May 30 10:11:27 melchi kernel: 
May 30 10:11:27 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 10:11:27 melchi kernel:  invalid operand: 0000
May 30 10:11:27 melchi kernel: CPU:    0
May 30 10:11:27 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 10:11:27 melchi kernel: EFLAGS: 00010087
May 30 10:11:27 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 10:11:27 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000000   esp: c2197e50
May 30 10:11:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 10:11:27 melchi kernel: Process closedhub (pid: 251, stackpage=c2197000)
May 30 10:11:27 melchi kernel: Stack: 00000060 c01da024 00000000 00000000 0000115a 00000286 c01d9e84 00000000 
May 30 10:11:27 melchi kernel:        c01d9e54 c0123241 00000000 00000000 00051700 00000000 00000005 00000001 
May 30 10:11:27 melchi kernel:        c01da020 c0123945 00000000 00000007 0000000c c011a418 00051700 00000000 
May 30 10:11:27 melchi kernel: Call Trace: [__alloc_pages+89/556] [read_swap_cache_async+49/140] [swapin_readahead+136/192] [do_swap_page+38/348] [handle_mm_fault+108/196] 
May 30 10:11:27 melchi kernel:    [do_page_fault+0/1112] [do_page_fault+348/1112] [<ffff0004>] [do_page_fault+0/1112] [error_code+52/64] [__free_pages+26/28] 
May 30 10:11:27 melchi kernel:    [free_pages+36/40] [release_task+295/336] [sys_wait4+902/912] [error_code+52/64] [<ffff0004>] 
May 30 10:11:27 melchi kernel: 
May 30 10:11:27 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 10:11:27 melchi kernel:  invalid operand: 0000
May 30 10:11:27 melchi kernel: CPU:    0
May 30 10:11:27 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 10:11:27 melchi kernel: EFLAGS: 00010087
May 30 10:11:27 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 10:11:27 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000000   esp: c22abde4
May 30 10:11:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 10:11:27 melchi kernel: Process closedhub (pid: 247, stackpage=c22ab000)
May 30 10:11:27 melchi kernel: Stack: 00000060 c01da024 00000000 00000000 00001192 00000282 c01d9e84 00000000 
May 30 10:11:27 melchi kernel:        c01d9e54 c0123241 00000000 00000000 0008d400 00000000 00000005 00000001 
May 30 10:11:27 melchi kernel:        c01da020 c0123945 00000000 00000004 00000007 c011a418 0008d400 00000000 
May 30 10:11:27 melchi kernel: Call Trace: [__alloc_pages+89/556] [read_swap_cache_async+49/140] [swapin_readahead+136/192] [do_swap_page+38/348] [handle_mm_fault+108/196] 
May 30 10:11:27 melchi kernel:    [do_page_fault+0/1112] [do_page_fault+348/1112] [do_page_fault+0/1112] [do_wp_page+543/580] [handle_mm_fault+147/196] [do_page_fault+0/1112] 
May 30 10:11:27 melchi kernel:    [do_page_fault+348/1112] [<ffff0007>] [do_page_fault+0/1112] [error_code+52/64] [sys_wait4+554/912] [system_call+51/64] 
May 30 10:11:27 melchi kernel: 
May 30 10:11:27 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 10:11:27 melchi kernel:  invalid operand: 0000
May 30 10:11:27 melchi kernel: CPU:    0
May 30 10:11:27 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 10:11:27 melchi kernel: EFLAGS: 00010087
May 30 10:11:27 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 10:11:27 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000000   esp: c23b1e50
May 30 10:11:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 10:11:27 melchi kernel: Process cron (pid: 244, stackpage=c23b1000)
May 30 10:11:27 melchi kernel: Stack: 00000060 c01da024 00000000 00000000 00001246 00000286 c01d9e84 00000000 
May 30 10:11:27 melchi kernel:        c01d9e54 c0123241 00000000 00000000 0001b600 00000000 00000005 00000001 
May 30 10:11:27 melchi kernel:        c01da020 c0123945 00000000 00000006 0000000c c011a418 0001b600 00000000 
May 30 10:11:27 melchi kernel: Call Trace: [__alloc_pages+89/556] [read_swap_cache_async+49/140] [swapin_readahead+136/192] [do_swap_page+38/348] [handle_mm_fault+108/196] 
May 30 10:11:27 melchi kernel:    [do_page_fault+0/1112] [do_page_fault+348/1112] [<ffff0004>] [do_page_fault+0/1112] [pipe_wait+137/164] [pipe_read+175/488] 
May 30 10:11:27 melchi kernel:    [sys_read+195/204] [error_code+52/64] [<ffff0004>] 
May 30 10:11:27 melchi kernel: 
May 30 10:11:27 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 10:11:27 melchi kernel:  invalid operand: 0000
May 30 10:11:27 melchi kernel: CPU:    0
May 30 10:11:27 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 10:11:27 melchi kernel: EFLAGS: 00010087
May 30 10:11:27 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 10:11:27 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000000   esp: c22ade50
May 30 10:11:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 10:11:27 melchi kernel: Process dancer (pid: 246, stackpage=c22ad000)
May 30 10:11:27 melchi kernel: Stack: 00000060 c01da024 00000000 00000000 c2c978e0 00000286 c01d9e84 00000000 
May 30 10:11:27 melchi kernel:        c01d9e54 c0123241 00000000 00000000 00468000 00000000 00000005 00000001 
May 30 10:11:27 melchi kernel:        c01da020 c0123945 00000000 00000000 00000001 c011a418 00468000 00000000 
May 30 10:11:27 melchi kernel: Call Trace: [__alloc_pages+89/556] [read_swap_cache_async+49/140] [swapin_readahead+136/192] [do_swap_page+38/348] [handle_mm_fault+108/196] 
May 30 10:11:27 melchi kernel:    [do_page_fault+0/1112] [do_page_fault+348/1112] [<ffff0004>] [do_page_fault+0/1112] [ei_interrupt+197/452] [handle_IRQ_event+47/88] 
May 30 10:11:27 melchi kernel:    [end_8259A_irq+24/28] [do_IRQ+140/176] [error_code+52/64] [<ffff0004>] [startup_32+43/165] 
May 30 10:11:27 melchi kernel: 
May 30 10:11:27 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 10:11:27 melchi kernel:  invalid operand: 0000
May 30 10:11:27 melchi kernel: CPU:    0
May 30 10:11:27 melchi kernel: EIP:    0010:[rmqueue+121/592]
May 30 10:11:27 melchi kernel: EFLAGS: 00010087
May 30 10:11:27 melchi kernel: eax: c01d9e78   ebx: 00000060   ecx: c01d9e84   edx: c01d9e54
May 30 10:11:27 melchi kernel: esi: c01d9e78   edi: 00000001   ebp: 00000000   esp: c23c5e50
May 30 10:11:27 melchi kernel: ds: 0018   es: 0018   ss: 0018
May 30 10:11:27 melchi kernel: Process cron (pid: 242, stackpage=c23c5000)
May 30 10:11:27 melchi kernel: Stack: 00000060 c01da024 00000000 00000000 00001210 00000286 c01d9e84 00000000 
May 30 10:11:27 melchi kernel:        c01d9e54 c0123241 00000000 00000000 00059f00 00000000 00000005 00000001 
May 30 10:11:27 melchi kernel:        c01da020 c0123945 00000000 0000000f 00000010 c011a418 00059f00 00000000 
May 30 10:11:27 melchi kernel: Call Trace: [__alloc_pages+89/556] [read_swap_cache_async+49/140] [swapin_readahead+136/192] [do_swap_page+38/348] [handle_mm_fault+108/196] 
May 30 10:11:27 melchi kernel:    [do_page_fault+0/1112] [do_page_fault+348/1112] [<ffff0004>] [do_page_fault+0/1112] [error_code+52/64] [__free_pages+26/28] 
May 30 10:11:27 melchi kernel:    [free_pages+36/40] [sys_wait4+902/912] [error_code+52/64] [<ffff0004>] 
May 30 10:11:27 melchi kernel: 
May 30 10:11:27 melchi kernel: Code: 0f 0b 8b 56 04 8b 06 89 50 04 89 02 8b 54 24 20 89 f0 2b 82 
May 30 10:22:48 melchi syslogd 1.4.1#2: restart.
May 30 10:22:48 melchi kernel: klogd 1.4.1#2, log source = /proc/kmsg started.
May 30 10:22:48 melchi kernel: Inspecting /boot/System.map-2.4.5-ac2
May 30 10:22:49 melchi kernel: Loaded 10758 symbols from /boot/System.map-2.4.5-ac2.
May 30 10:22:49 melchi kernel: Symbols match kernel version 2.4.5.
May 30 10:22:49 melchi kernel: No module symbols loaded - kernel modules not enabled. 
May 30 10:22:49 melchi kernel: Linux version 2.4.5-ac2 (root@melchi) (gcc version 2.95.4 20010506 (Debian prerelease)) #4 Sun May 27 22:49:34 PDT 2001
May 30 10:22:49 melchi kernel: BIOS-provided physical RAM map:
May 30 10:22:49 melchi kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
May 30 10:22:49 melchi kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
May 30 10:22:49 melchi kernel:  BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
May 30 10:22:49 melchi kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
May 30 10:22:49 melchi kernel: On node 0 totalpages: 16384
May 30 10:22:49 melchi kernel: zone(0): 4096 pages.
May 30 10:22:49 melchi kernel: zone(1): 12288 pages.
May 30 10:22:49 melchi kernel: zone(2): 0 pages.
May 30 10:22:49 melchi kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=303
May 30 10:22:49 melchi kernel: Initializing CPU#0
May 30 10:22:49 melchi kernel: Console: colour VGA+ 80x25
May 30 10:22:49 melchi kernel: Calibrating delay loop... 149.50 BogoMIPS
May 30 10:22:49 melchi kernel: Memory: 62664k/65536k available (750k kernel code, 2488k reserved, 165k data, 176k init, 0k highmem)
May 30 10:22:49 melchi kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
May 30 10:22:49 melchi kernel: Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
May 30 10:22:49 melchi kernel: Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
May 30 10:22:49 melchi kernel: Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
May 30 10:22:49 melchi kernel: Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
May 30 10:22:49 melchi kernel: Enabling CPUID on Cyrix processor.
May 30 10:22:49 melchi kernel: CPU: Cyrix 6x86L 2x Core/Bus Clock stepping 02
May 30 10:22:49 melchi kernel: Checking 'hlt' instruction... OK.
May 30 10:22:49 melchi kernel: POSIX conformance testing by UNIFIX
May 30 10:22:49 melchi kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=0
May 30 10:22:49 melchi kernel: PCI: Using configuration type 1
May 30 10:22:49 melchi kernel: PCI: Probing PCI hardware
May 30 10:22:49 melchi kernel: Activating ISA DMA hang workarounds.
May 30 10:22:49 melchi kernel: Linux NET4.0 for Linux 2.4
May 30 10:22:49 melchi kernel: Based upon Swansea University Computer Society NET3.039
May 30 10:22:49 melchi kernel: Starting kswapd v1.8
May 30 10:22:49 melchi kernel: pty: 256 Unix98 ptys configured
May 30 10:22:49 melchi kernel: Software Watchdog Timer: 0.05, timer margin: 60 sec
May 30 10:22:49 melchi kernel: block: queued sectors max/low 41576kB/13858kB, 128 slots per queue
May 30 10:22:49 melchi kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
May 30 10:22:49 melchi kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 30 10:22:49 melchi kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
May 30 10:22:49 melchi kernel: VP_IDE: chipset revision 2
May 30 10:22:49 melchi kernel: VP_IDE: not 100%% native mode: will probe irqs later
May 30 10:22:49 melchi kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 30 10:22:49 melchi kernel: VP_IDE: VIA vt82c586 (rev 02) IDE MWDMA16 controller on pci00:07.1
May 30 10:22:49 melchi kernel:     ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:DMA, hdb:DMA
May 30 10:22:49 melchi kernel:     ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:DMA, hdd:pio
May 30 10:22:49 melchi kernel: keyboard: Timeout - AT keyboard not present?
May 30 10:22:49 melchi kernel: keyboard: Timeout - AT keyboard not present?
May 30 10:22:49 melchi kernel: hda: Maxtor 91728D8, ATA DISK drive
May 30 10:22:49 melchi kernel: hdb: WDC AC31000H, ATA DISK drive
May 30 10:22:49 melchi kernel: hdc: ST328040A, ATA DISK drive
May 30 10:22:49 melchi kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 30 10:22:49 melchi kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 30 10:22:49 melchi kernel: hda: 33750864 sectors (17280 MB) w/512KiB Cache, CHS=33483/16/63, (U)DMA
May 30 10:22:49 melchi kernel: hdb: 2116800 sectors (1084 MB) w/128KiB Cache, CHS=2100/16/63, DMA
May 30 10:22:49 melchi kernel: hdc: 55704096 sectors (28520 MB) w/512KiB Cache, CHS=55262/16/63, (U)DMA
May 30 10:22:49 melchi kernel: Partition check:
May 30 10:22:49 melchi kernel:  hda: hda1 hda2 hda3
May 30 10:22:49 melchi kernel:  hdb: hdb1 hdb2 hdb3 hdb4
May 30 10:22:49 melchi kernel:  hdc: hdc1
May 30 10:22:49 melchi kernel: Floppy drive(s): fd0 is 1.44M
May 30 10:22:49 melchi kernel: FDC 0 is an 8272A
May 30 10:22:49 melchi kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
May 30 10:22:49 melchi kernel: Last modified Nov 1, 2000 by Paul Gortmaker
May 30 10:22:49 melchi kernel: NE*000 ethercard probe at 0x340: 00 00 e8 c4 30 47
May 30 10:22:49 melchi kernel: eth0: NE2000 found at 0x340, using IRQ 10.
May 30 10:22:49 melchi kernel: loop: loaded (max 8 devices)
May 30 10:22:49 melchi kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 30 10:22:49 melchi kernel: IP Protocols: ICMP, UDP, TCP, IGMP
May 30 10:22:49 melchi kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
May 30 10:22:49 melchi kernel: TCP: Hash tables configured (established 4096 bind 4096)
May 30 10:22:49 melchi kernel: ip_conntrack (512 buckets, 4096 max)
May 30 10:22:49 melchi kernel: ip_tables: (c)2000 Netfilter core team
May 30 10:22:49 melchi kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
May 30 10:22:49 melchi kernel: VFS: Mounted root (ext2 filesystem) readonly.
May 30 10:22:49 melchi kernel: Freeing unused kernel memory: 176k freed
May 30 10:22:49 melchi kernel: Adding Swap: 130748k swap-space (priority -1)
May 30 10:42:48 melchi -- MARK --
May 30 11:02:48 melchi -- MARK --
May 30 11:22:47 melchi -- MARK --
May 30 11:42:47 melchi -- MARK --

