Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWAICMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWAICMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWAICMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:12:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55513 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750788AbWAICMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:12:40 -0500
Date: Sun, 8 Jan 2006 21:12:30 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: vm related lock up in 2.6.15
Message-ID: <20060109021230.GA23750@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh. I booted, ran fetchmail, and after picking up ~1000 mails,
this happened..

2.6.15 is really unhappy on my em64t.

		Dave

[ 1862.015381] ----------- [cut here ] --------- [please bite here ] ---------
[ 1862.036284] Kernel BUG at mm/swap.c:215
[ 1862.047770] invalid operand: 0000 [1] SMP
[ 1862.060059] last sysfs file: /block/hdc/removable
[ 1862.074153] CPU 2
[ 1862.080169] Modules linked in: loop radeon drm nfsd exportfs lockd nfs_acl ipv6 parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc ub video button battery ac ehci_hcdd
[ 1862.238941] Pid: 19748, comm: bash Not tainted 2.6.15-1.1826.2.4_FC5 #1
[ 1862.258786] RIP: 0010:[<ffffffff8016f1f2>] <ffffffff8016f1f2>{release_pages+111}
[ 1862.280467] RSP: 0018:ffff81001755fb98  EFLAGS: 00010046
[ 1862.296909] RAX: 0000000000000003 RBX: ffff8100014d4de0 RCX: ffff81000000ba80
[ 1862.318312] RDX: 0000000000000003 RSI: 0000000000000010 RDI: ffff81000000c400
[ 1862.339715] RBP: ffff81000000ba80 R08: 0000000000000004 R09: 0000000000000246
[ 1862.361117] R10: 000000000000000a R11: ffff810001e160c0 R12: ffff810002218720
[ 1862.382523] R13: 0000000000000005 R14: 0000000000000010 R15: 0000000000000010
[ 1862.403914] FS:  0000000000000000(0000) GS:ffffffff805ce100(0000) knlGS:0000000000000000
[ 1862.428178] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1862.445400] CR2: 0000000000516dc4 CR3: 000000000499b000 CR4: 00000000000006e0
[ 1862.466806] Process bash (pid: 19748, threadinfo ffff81001755e000, task ffff810036cda050)
[ 1862.491335] Stack: 0000000000000002 0000000000000000 ffff8100016f5ca0 ffff810001373758
[ 1862.514863]        ffff810002163970 ffff81000154f168 ffff810001943968 00007fffff8cd000
[ 1862.538910]        ffff81001755fc90 ffff8100039a27f8
[ 1862.554081] Call Trace:<ffffffff8017d8bc>{free_pages_and_swap_cache+115} <ffffffff801778cd>{exit_mmap+190}
[ 1862.583146]        <ffffffff8013709a>{mmput+37} <ffffffff8019123e>{flush_old_exec+2303}
[ 1862.607213]        <ffffffff801875d3>{vfs_read+305} <ffffffff801b211e>{load_elf_binary+0}
[ 1862.631826]        <ffffffff801b2585>{load_elf_binary+1127} <ffffffff80168c3b>{__alloc_pages+117}
[ 1862.658533]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff801b211e>{load_elf_binary+0}
[ 1862.686777]        <ffffffff80190375>{search_binary_handler+177} <ffffffff801922c8>{do_execve+396}
[ 1862.713724]        <ffffffff8010fa50>{tracesys+209} <ffffffff8010e573>{sys_execve+54}
[ 1862.737257]        <ffffffff8010fcfe>{stub_execve+106}
[ 1862.753522]
[ 1862.753523] Code: 0f 0b 68 a4 ea 36 80 c2 d7 00 f0 83 43 08 ff 0f 98 c0 84 c0
[ 1862.779791] RIP <ffffffff8016f1f2>{release_pages+111} RSP <ffff81001755fb98>
[ 1862.800948]  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
[ 1862.827319] in_atomic():0, irqs_disabled():1
[ 1862.840112]
[ 1862.840113] Call Trace:<ffffffff8013aee2>{profile_task_exit+21} <ffffffff8013c935>{do_exit+34}
[ 1862.869913]        <ffffffff80261d2b>{do_unblank_screen+44} <ffffffff80111691>{kernel_math_error+0}
[ 1862.897115]        <ffffffff80111c3b>{do_invalid_op+163} <ffffffff8016f1f2>{release_pages+111}
[ 1862.923001]        <ffffffff8016a045>{blockable_page_cache_readahead+84}
[ 1862.943124]        <ffffffff801a0100>{update_atime+64} <ffffffff80164e51>{do_generic_mapping_read+1001}
[ 1862.971379]        <ffffffff8011085d>{error_exit+0} <ffffffff8016f1f2>{release_pages+111}
[ 1862.995995]        <ffffffff8016f23d>{release_pages+186} <ffffffff8017d8bc>{free_pages_and_swap_cache+115}
[ 1863.025051]        <ffffffff801778cd>{exit_mmap+190} <ffffffff8013709a>{mmput+37}
[ 1863.047564]        <ffffffff8019123e>{flush_old_exec+2303} <ffffffff801875d3>{vfs_read+305}
[ 1863.072683]        <ffffffff801b211e>{load_elf_binary+0} <ffffffff801b2585>{load_elf_binary+1127}
[ 1863.099354]        <ffffffff80168c3b>{__alloc_pages+117} <ffffffff8014e3d7>{autoremove_wake_function+0}
[ 1863.127620]        <ffffffff801b211e>{load_elf_binary+0} <ffffffff80190375>{search_binary_handler+177}
[ 1863.155607]        <ffffffff801922c8>{do_execve+396} <ffffffff8010fa50>{tracesys+209}
[ 1863.179164]        <ffffffff8010e573>{sys_execve+54} <ffffffff8010fcfe>{stub_execve+106}
[ 1863.203482]
[ 1863.214736] BUG: spinlock cpu recursion on CPU#2, kjournald/438 (Not tainted)
[ 1863.236181]  lock: ffff81000000c400, .magic: dead4ead, .owner: kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
[ 1863.507134] Call Trace:<ffffffff8020c82e>{spin_bug+177} <ffffffff8020c9d6>{_raw_spin_lock+88}
[ 1863.532790]        <ffffffff8016f695>{activate_page+36} <ffffffff8016f851>{mark_page_accessed+27}
[ 1863.559469]        <ffffffff80188bfa>{__find_get_block+354} <ffffffff80188c27>{__getblk+29}
[ 1863.584594]        <ffffffff8806c51c>{:jbd:journal_get_descriptor_buffer+50}
[ 1863.605792]        <ffffffff88067bce>{:jbd:journal_commit_transaction+1733}
[ 1863.626721]        <ffffffff803439d6>{_spin_lock_irqsave+9} <ffffffff80142270>{lock_timer_base+27}
[ 1863.653676]        <ffffffff8806bde3>{:jbd:kjournald+219} <ffffffff8806b648>{:jbd:commit_timeout+0}
[ 1863.680922]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff80134cf1>{schedule_tail+70}
[ 1863.708910]        <ffffffff80110a12>{child_rip+8} <ffffffff8800213e>{:scsi_mod:scsi_done+0}
[ 1863.734318]        <ffffffff8806bd08>{:jbd:kjournald+0} <ffffffff80110a0a>{child_rip+0}
[ 1863.758397]
[ 1863.765216] Kernel panic - not syncing: bad locking
[ 1863.779842]
[ 1863.779843] Call Trace:<ffffffff80139246>{panic+134} <ffffffff801525f0>{module_text_address+51}
[ 1863.809933]        <ffffffff8014b875>{kernel_text_address+28} <ffffffff801112bb>{show_trace+460}
[ 1863.836348]        <ffffffff80111329>{dump_stack+14} <ffffffff80189412>{sync_buffer+0}
[ 1863.860158]        <ffffffff8020c857>{spin_bug+218} <ffffffff8020c9d6>{_raw_spin_lock+88}
[ 1863.884749]        <ffffffff8016f695>{activate_page+36} <ffffffff8016f851>{mark_page_accessed+27}
[ 1863.911427]        <ffffffff80188bfa>{__find_get_block+354} <ffffffff80188c27>{__getblk+29}
[ 1863.936553]        <ffffffff8806c51c>{:jbd:journal_get_descriptor_buffer+50}
[ 1863.957747]        <ffffffff88067bce>{:jbd:journal_commit_transaction+1733}
[ 1863.978672]        <ffffffff803439d6>{_spin_lock_irqsave+9} <ffffffff80142270>{lock_timer_base+27}
[ 1864.005626]        <ffffffff8806bde3>{:jbd:kjournald+219} <ffffffff8806b648>{:jbd:commit_timeout+0}
[ 1864.032871]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff80134cf1>{schedule_tail+70}
[ 1864.060863]        <ffffffff80110a12>{child_rip+8} <ffffffff8800213e>{:scsi_mod:scsi_done+0}
[ 1864.086270]        <ffffffff8806bd08>{:jbd:kjournald+0} <ffffffff80110a0a>{child_rip+0}
[ 1864.110348]
[ 1864.117172]  NMI Watchdog detected LOCKUP on CPU 2
[ 1869.182379] CPU 2
[ 1869.188392] Modules linked in: loop radeon drm nfsd exportfs lockd nfs_acl ipv6 parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc ub video button battery ac ehci_hcdd[ 1869.347201] Pid: 438, comm: kjournald Not tainted 2.6.15-1.1826.2.4_FC5 #1
[ 1869.367817] RIP: 0010:[<ffffffff8011c436>] <ffffffff8011c436>{__smp_call_function+102}
[ 1869.391057] RSP: 0018:ffff81003ee0fb38  EFLAGS: 00000097
[ 1869.407511] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000000
[ 1869.428904] RDX: 0000000000000100 RSI: 00000000000000ff RDI: 00000000000000c0
[ 1869.450300] RBP: 0000000000000000 R08: ffff81003ee0fa98 R09: 0000000000000004
[ 1869.471700] R10: 0000000000000004 R11: 0000000000000004 R12: 0000000000000003
[ 1869.493096] R13: ffffffff8011c3c4 R14: 0000000000000000 R15: 0000000000000000
[ 1869.514498] FS:  0000000000000000(0000) GS:ffffffff805ce100(0000) knlGS:0000000000000000
[ 1869.538776] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1869.555997] CR2: 00002aaaaacdc970 CR3: 000000003dbd2000 CR4: 00000000000006e0
[ 1869.577400] Process kjournald (pid: 438, threadinfo ffff81003ee0e000, task ffff81003fae0050)
[ 1869.602710] Stack: ffffffff8011c3c4 0000000000000000 ffff810000000002 ffffffff00000000
[ 1869.626234]        ffff81000221d220 ffffffff8037705e ffff81000000c400 ffffffff80377140
[ 1869.650285]        ffff81000221d220 ffffffff8011c4b1
[ 1869.665443] Call Trace:<ffffffff8011c3c4>{smp_really_stop_cpu+0} <ffffffff8011c4b1>{smp_send_stop+86}
[ 1869.693154]        <ffffffff80139259>{panic+153} <ffffffff801525f0>{module_text_address+51}
[ 1869.718271]        <ffffffff8014b875>{kernel_text_address+28} <ffffffff801112bb>{show_trace+460}
[ 1869.744667]        <ffffffff80111329>{dump_stack+14} <ffffffff80189412>{sync_buffer+0}
[ 1869.768460]        <ffffffff8020c857>{spin_bug+218} <ffffffff8020c9d6>{_raw_spin_lock+88}
[ 1869.793029]        <ffffffff8016f695>{activate_page+36} <ffffffff8016f851>{mark_page_accessed+27}
[ 1869.819686]        <ffffffff80188bfa>{__find_get_block+354} <ffffffff80188c27>{__getblk+29}
[ 1869.844794]        <ffffffff8806c51c>{:jbd:journal_get_descriptor_buffer+50}
[ 1869.865968]        <ffffffff88067bce>{:jbd:journal_commit_transaction+1733}
[ 1869.886878]        <ffffffff803439d6>{_spin_lock_irqsave+9} <ffffffff80142270>{lock_timer_base+27}
[ 1869.913817]        <ffffffff8806bde3>{:jbd:kjournald+219} <ffffffff8806b648>{:jbd:commit_timeout+0}
[ 1869.941032]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff80134cf1>{schedule_tail+70}
[ 1869.968997]        <ffffffff80110a12>{child_rip+8} <ffffffff8800213e>{:scsi_mod:scsi_done+0}
[ 1869.994385]        <ffffffff8806bd08>{:jbd:kjournald+0} <ffffffff80110a0a>{child_rip+0}
[ 1870.018441]
[ 1870.025252]
[ 1870.025253] Code: 8b 44 24 10 44 39 e0 75 f5 85 db 75 04 eb 0b f3 90 8b 44 24
[ 1870.051513] console shuts up ...
[ 1870.061179]  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
[ 1870.087542] in_atomic():1, irqs_disabled():1
[ 1870.100330]
[ 1870.100330] Call Trace: <NMI> <ffffffff8013aee2>{profile_task_exit+21} <ffffffff8013c935>{do_exit+34}
[ 1870.131951]        <ffffffff80261d2b>{do_unblank_screen+44} <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1870.159657]        <ffffffff8011156a>{__die+0} <ffffffff8011e4d8>{nmi_watchdog_tick+239}
[ 1870.183969]        <ffffffff80112080>{default_do_nmi+136} <ffffffff8011e907>{do_nmi+69}
[ 1870.208035]        <ffffffff80110b93>{nmi+127} <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1870.232336]        <ffffffff8011c436>{__smp_call_function+102}  <EOE> <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1870.262675]        <ffffffff8011c4b1>{smp_send_stop+86} <ffffffff80139259>{panic+153}
[ 1870.286211]        <ffffffff801525f0>{module_text_address+51} <ffffffff8014b875>{kernel_text_address+28}
[ 1870.314718]        <ffffffff801112bb>{show_trace+460} <ffffffff80111329>{dump_stack+14}
[ 1870.338776]        <ffffffff80189412>{sync_buffer+0} <ffffffff8020c857>{spin_bug+218}
[ 1870.362292]        <ffffffff8020c9d6>{_raw_spin_lock+88} <ffffffff8016f695>{activate_page+36}
[ 1870.387905]        <ffffffff8016f851>{mark_page_accessed+27} <ffffffff80188bfa>{__find_get_block+354}
[ 1870.415601]        <ffffffff80188c27>{__getblk+29} <ffffffff8806c51c>{:jbd:journal_get_descriptor_buffer+50}
[ 1870.445158]        <ffffffff88067bce>{:jbd:journal_commit_transaction+1733}
[ 1870.466078]        <ffffffff803439d6>{_spin_lock_irqsave+9} <ffffffff80142270>{lock_timer_base+27}
[ 1870.493012]        <ffffffff8806bde3>{:jbd:kjournald+219} <ffffffff8806b648>{:jbd:commit_timeout+0}
[ 1870.520233]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff80134cf1>{schedule_tail+70}
[ 1870.548205]        <ffffffff80110a12>{child_rip+8} <ffffffff8800213e>{:scsi_mod:scsi_done+0}
[ 1870.573580]        <ffffffff8806bd08>{:jbd:kjournald+0} <ffffffff80110a0a>{child_rip+0}
[ 1870.597642]
[ 1870.604456] Kernel panic - not syncing: Aiee, killing interrupt handler!
[ 1870.624547]
[ 1870.624548] Call Trace: <NMI> <ffffffff80139246>{panic+134} <ffffffff80343996>{_spin_unlock_irq+12}
[ 1870.655687]        <ffffffff80343348>{__down_read+52} <ffffffff803439d6>{_spin_lock_irqsave+9}
[ 1870.681579]        <ffffffff80209633>{__up_read+19} <ffffffff8013c9a5>{do_exit+146}
[ 1870.704591]        <ffffffff80261d2b>{do_unblank_screen+44} <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1870.732300]        <ffffffff8011156a>{__die+0} <ffffffff8011e4d8>{nmi_watchdog_tick+239}
[ 1870.756613]        <ffffffff80112080>{default_do_nmi+136} <ffffffff8011e907>{do_nmi+69}
[ 1870.780681]        <ffffffff80110b93>{nmi+127} <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1870.804989]        <ffffffff8011c436>{__smp_call_function+102}  <EOE> <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1870.835335]        <ffffffff8011c4b1>{smp_send_stop+86} <ffffffff80139259>{panic+153}
[ 1870.858877]        <ffffffff801525f0>{module_text_address+51} <ffffffff8014b875>{kernel_text_address+28}
[ 1870.887390]        <ffffffff801112bb>{show_trace+460} <ffffffff80111329>{dump_stack+14}
[ 1870.911453]        <ffffffff80189412>{sync_buffer+0} <ffffffff8020c857>{spin_bug+218}
[ 1870.934987]        <ffffffff8020c9d6>{_raw_spin_lock+88} <ffffffff8016f695>{activate_page+36}
[ 1870.960592]        <ffffffff8016f851>{mark_page_accessed+27} <ffffffff80188bfa>{__find_get_block+354}
[ 1870.988286]        <ffffffff80188c27>{__getblk+29} <ffffffff8806c51c>{:jbd:journal_get_descriptor_buffer+50}
[ 1871.017851]        <ffffffff88067bce>{:jbd:journal_commit_transaction+1733}
[ 1871.038762]        <ffffffff803439d6>{_spin_lock_irqsave+9} <ffffffff80142270>{lock_timer_base+27}
[ 1871.065706]        <ffffffff8806bde3>{:jbd:kjournald+219} <ffffffff8806b648>{:jbd:commit_timeout+0}
[ 1871.092932]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff80134cf1>{schedule_tail+70}
[ 1871.120893]        <ffffffff80110a12>{child_rip+8} <ffffffff8800213e>{:scsi_mod:scsi_done+0}
[ 1871.146272]        <ffffffff8806bd08>{:jbd:kjournald+0} <ffffffff80110a0a>{child_rip+0}
[ 1871.170332]
[ 1871.177150]  NMI Watchdog detected LOCKUP on CPU 3
[ 1876.660542] CPU 3
[ 1876.666559] Modules linked in: loop radeon drm nfsd exportfs lockd nfs_acl ipv6 parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc ub video button battery ac ehci_hcdd[ 1876.825395] Pid: 19749, comm: bash Not tainted 2.6.15-1.1826.2.4_FC5 #1
[ 1876.845225] RIP: 0010:[<ffffffff8020c9ed>] <ffffffff8020c9ed>{_raw_spin_lock+111}
[ 1876.867169] RSP: 0000:ffff810015ca3d38  EFLAGS: 00000046
[ 1876.883616] RAX: 0000000000000000 RBX: ffff81000000c400 RCX: 0000000000000001
[ 1876.905017] RDX: 0000000012c452fd RSI: 0000000000000100 RDI: ffff81000000c400
[ 1876.926425] RBP: ffff8100014c4fe8 R08: 0000000000000004 R09: 00000000000036a3
[ 1876.947831] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8100022251a0
[ 1876.969230] R13: 0000000000000000 R14: ffff81003daef060 R15: ffff8100210d7d40
[ 1876.990628] FS:  00002aaaaaf03d70(0000) GS:ffffffff805ce180(0000) knlGS:0000000000000000
[ 1877.014898] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1877.032126] CR2: 00002aaaaaeff274 CR3: 000000001bec7000 CR4: 00000000000006e0
[ 1877.053525] Process bash (pid: 19749, threadinfo ffff810015ca2000, task ffff810039bc7090)
[ 1877.078055] Stack: ffff81000000ba80 ffffffff8016f380 0000000000000000 ffff810001401160
[ 1877.101579]        ffff8100015f53c8 ffff8100166997f8 ffff81000164db18 ffffffff80173a4c
[ 1877.125625]        ffff8100134a4ad0 ffff81000ce8bab8
[ 1877.140783] Call Trace:<ffffffff8016f380>{__pagevec_lru_add_active+80} <ffffffff80173a4c>{do_wp_page+896}
[ 1877.169536]        <ffffffff801754ed>{__handle_mm_fault+2785} <ffffffff80344db4>{do_page_fault+1087}
[ 1877.197019]        <ffffffff8011085d>{error_exit+0} <ffffffff80160e40>{audit_syscall_exit+279}
[ 1877.222919]        <ffffffff8011085d>{error_exit+0}
[ 1877.238405]
[ 1877.238406] Code: 85 c0 7f 60 48 ff c2 48 69 05 51 47 22 00 fa 00 00 00 48 39
[ 1877.264670] console shuts up ...
[ 1877.274335]  Badness in panic at kernel/panic.c:139 (Not tainted)
[ 1877.292617]
[ 1877.292618] Call Trace: <NMI> <ffffffff801393a3>{panic+483} <ffffffff80343996>{_spin_unlock_irq+12}
[ 1877.323730]        <ffffffff80343348>{__down_read+52} <ffffffff803439d6>{_spin_lock_irqsave+9}
[ 1877.349616]        <ffffffff80209633>{__up_read+19} <ffffffff8013c9a5>{do_exit+146}
[ 1877.372622]        <ffffffff80261d2b>{do_unblank_screen+44} <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1877.400322]        <ffffffff8011156a>{__die+0} <ffffffff8011e4d8>{nmi_watchdog_tick+239}
[ 1877.424626]        <ffffffff80112080>{default_do_nmi+136} <ffffffff8011e907>{do_nmi+69}
[ 1877.448695]        <ffffffff80110b93>{nmi+127} <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1877.472996]        <ffffffff8011c436>{__smp_call_function+102}  <EOE> <ffffffff8011c3c4>{smp_really_stop_cpu+0}
[ 1877.503339]        <ffffffff8011c4b1>{smp_send_stop+86} <ffffffff80139259>{panic+153}
[ 1877.526876]        <ffffffff801525f0>{module_text_address+51} <ffffffff8014b875>{kernel_text_address+28}
[ 1877.555376]        <ffffffff801112bb>{show_trace+460} <ffffffff80111329>{dump_stack+14}
[ 1877.579423]        <ffffffff80189412>{sync_buffer+0} <ffffffff8020c857>{spin_bug+218}
[ 1877.602949]        <ffffffff8020c9d6>{_raw_spin_lock+88} <ffffffff8016f695>{activate_page+36}
[ 1877.628555]        <ffffffff8016f851>{mark_page_accessed+27} <ffffffff80188bfa>{__find_get_block+354}
[ 1877.656241]        <ffffffff80188c27>{__getblk+29} <ffffffff8806c51c>{:jbd:journal_get_descriptor_buffer+50}
[ 1877.685817]        <ffffffff88067bce>{:jbd:journal_commit_transaction+1733}
[ 1877.706730]        <ffffffff803439d6>{_spin_lock_irqsave+9} <ffffffff80142270>{lock_timer_base+27}
[ 1877.733656]        <ffffffff8806bde3>{:jbd:kjournald+219} <ffffffff8806b648>{:jbd:commit_timeout+0}
[ 1877.760880]        <ffffffff8014e3d7>{autoremove_wake_function+0} <ffffffff80134cf1>{schedule_tail+70}
[ 1877.788834]        <ffffffff80110a12>{child_rip+8} <ffffffff8800213e>{:scsi_mod:scsi_done+0}
[ 1877.814216]        <ffffffff8806bd08>{:jbd:kjournald+0} <ffffffff80110a0a>{child_rip+0}
[ 1877.838258]

