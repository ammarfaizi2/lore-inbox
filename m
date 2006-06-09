Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbWFIVXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbWFIVXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWFIVXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:23:34 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:30909 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030514AbWFIVXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:23:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fjn/P8u+0hcWmNwA/iagWXgX4S1l4RGRiXOe33RUKcdbrHuKj4RsyFN5lXMjDDKCKOy8+Zx33SUUKYFb0E54y7lI8+F0+bG0Kf6WCUV/7yFmZxGt4QcP2WKdw9C86+2f13c8VgxjI5fMWAQgCq+0MDwUQfZmBgKgW55o6iSYm74=
Message-ID: <d5d4185b0606091423w1b9a943fk786d2cabcdb6953e@mail.gmail.com>
Date: Fri, 9 Jun 2006 14:23:32 -0700
From: "Jeremy Utley" <jerutley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panics from FC4 Server
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.

We have some web servers in production running FC4, which are
exibiting intermittent crashes due to a kernel panic.  The panics
occur at random, and can not be attributed to any one specific act.
Thanks to a serial console setup and conserver, I was able to get the
following output from the console:

Unable to handle kernel NULL pointer dereference at 0000000000000002 RIP:
<ffffffff801655ec>{find_get_pages+67}
PGD c9661067 PUD 9f7ca067 PMD 0
Oops: 0000 [1] SMP
last sysfs file: /class/vc/vcs1/dev
CPU 1
Modules linked in: ipv6 autofs4 sunrpc xfs exportfs dm_mod video
button battery ac ohci_hcd i2c_amd8111 i2c_core hw_random tg3 floppy
ext3 jbd sata_sil libata sd_mod scsi_mod
Pid: 307, comm: reformime Not tainted 2.6.15-1.1831_FC4smp #1
RIP: 0010:[<ffffffff801655ec>] <ffffffff801655ec>{find_get_pages+67}
RSP: 0018:ffff810024a13d38  EFLAGS: 00010046
RAX: 0000000000000004 RBX: 0000000000000004 RCX: ffff810024a13d98
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000004
RBP: ffff810024a13d98 R08: 0000000000000000 R09: 0000000000000040
R10: ffff81003ffff900 R11: 0000000000000004 R12: 000000000000000e
R13: 0000000000000001 R14: ffff8100be64b820 R15: 0000000000000001
FS:  00002aaaaaab93c0(0000) GS:ffffffff8059b080(0000) knlGS:00000000f7ff06c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000002 CR3: 0000000097be2000 CR4: 00000000000006e0
Process reformime (pid: 307, threadinfo ffff810024a12000, task ffff8100327ed110)
Stack: ffff810024a13d88 0000000000000001 ffff8100a6124128 0007ffffffffffff
       ffff8100be64b808 ffffffff80170e27 0000000000000000 ffffffff80171937
       0000000000000000 0000000000001000
Call Trace:<ffffffff80170e27>{pagevec_lookup+23}
<ffffffff80171937>{truncate_inode_pages+219}
       <ffffffff8818fefe>{:xfs:xfs_bmap_last_offset+226}
<ffffffff881b4424>{:xfs:xfs_file_last_byte+39}
       <ffffffff80215991>{__up_read+19}
<ffffffff881cbd81>{:xfs:xfs_inactive_free_eofblocks+263}
       <ffffffff881cbee4>{:xfs:xfs_release+143}
<ffffffff881d5c7a>{:xfs:linvfs_release+28}
       <ffffffff8018aecb>{__fput+183} <ffffffff801884f2>{filp_close+91}
       <ffffffff80188a63>{sys_close+158} <ffffffff8010fc60>{tracesys+209}


Code: 8b 02 89 c0 f6 c4 40 74 04 48 8b 52 10 f0 ff 42 08 83 c6 01
RIP <ffffffff801655ec>{find_get_pages+67} RSP <ffff810024a13d38>
CR2: 0000000000000002
 <3>Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1

Call Trace:<ffffffff8013d9e5>{profile_task_exit+21}
<ffffffff8013ef9e>{do_exit+34}
       <ffffffff80357a88>{_spin_lock_irqsave+9}
<ffffffff80228bf4>{vgacon_set_cursor_size+54}
       <ffffffff8035928b>{do_page_fault+1851}
<ffffffff88193e73>{:xfs:xfs_bmapi+805}
       <ffffffff80141d9a>{current_fs_time+64}
<ffffffff80357a88>{_spin_lock_irqsave+9}
       <ffffffff80110a6d>{error_exit+0} <ffffffff801655ec>{find_get_pages+67}
       <ffffffff801655de>{find_get_pages+53}
<ffffffff80170e27>{pagevec_lookup+23}
       <ffffffff80171937>{truncate_inode_pages+219}
<ffffffff8818fefe>{:xfs:xfs_bmap_last_offset+226}
       <ffffffff881b4424>{:xfs:xfs_file_last_byte+39}
<ffffffff80215991>{__up_read+19}
       <ffffffff881cbd81>{:xfs:xfs_inactive_free_eofblocks+263}
       <ffffffff881cbee4>{:xfs:xfs_release+143}
<ffffffff881d5c7a>{:xfs:linvfs_release+28}
       <ffffffff8018aecb>{__fput+183} <ffffffff801884f2>{filp_close+91}
       <ffffffff80188a63>{sys_close+158} <ffffffff8010fc60>{tracesys+209}


NMI Watchdog detected LOCKUP on CPU 1
CPU 1
Modules linked in: ipv6 autofs4 sunrpc xfs exportfs dm_mod video
button battery ac ohci_hcd i2c_amd8111 i2c_core hw_random tg3 floppy
ext3 jbd sata_sil libata sd_mod scsi_mod
Pid: 163, comm: pdflush Not tainted 2.6.15-1.1831_FC4smp #1
RIP: 0010:[<ffffffff802196ee>] <ffffffff802196ee>{_raw_write_lock+151}
RSP: 0000:ffff8100fb94d988  EFLAGS: 00000006
RAX: 0000000076c5d58e RBX: ffff8100be64b820 RCX: 0000000012eed80a
RDX: 0000000000799f93 RSI: 0000000000000001 RDI: ffff8100be64b820
RBP: ffff8100be64b808 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000853 R11: 0000000000000000 R12: 0000000000001000
R13: ffff8100be64b820 R14: 0000000000000001 R15: ffff8100fb94dab8
FS:  00002aaaaaabbde0(0000) GS:ffffffff8059b080(0000) knlGS:00000000f7ff06c0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000982018 CR3: 0000000093ec0000 CR4: 00000000000006e0
Process pdflush (pid: 163, threadinfo ffff8100fb94c000, task
ffff810082afb090)Stack: 0000000000000282 ffffffff80357ab0
ffff810081caf408 ffffffff8016c008
       ffff810081caf408 ffff810081caf408 0000000000001000 0000000000000001
       0000000000000001 ffffffff881d282c
Call Trace:<ffffffff80357ab0>{_write_lock_irqsave+9}
<ffffffff8016c008>{test_set_page_writeback+58}
       <ffffffff881d282c>{:xfs:xfs_submit_page+68}
<ffffffff881d338f>{:xfs:xfs_page_state_convert+1272}
       <ffffffff881d3636>{:xfs:linvfs_writepage+170}
<ffffffff801ae5af>{mpage_writepages+471}
       <ffffffff881d8dad>{:xfs:xfs_bdstrat_cb+59}
<ffffffff881d358c>{:xfs:linvfs_writepage+0}
       <ffffffff80357a88>{_spin_lock_irqsave+9} <ffffffff80215991>{__up_read+19}
       <ffffffff881bb765>{:xfs:xfs_log_move_tail+83}
<ffffffff801acd5c>{__writeback_single_inode+456}
       <ffffffff881c7252>{:xfs:xfs_trans_first_ail+18}
<ffffffff881bdfa1>{:xfs:xfs_log_need_covered+167}
       <ffffffff801ad2de>{sync_sb_inodes+498} <ffffffff8016c261>{pdflush+0}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801ad600>{writeback_inodes+153}
       <ffffffff8016ba45>{wb_kupdate+283} <ffffffff8016c413>{pdflush+434}
       <ffffffff8016b92a>{wb_kupdate+0} <ffffffff801524ea>{kthread+276}
       <ffffffff801387c8>{schedule_tail+70} <ffffffff80110c22>{child_rip+8}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801523d6>{kthread+0}
       <ffffffff80110c1a>{child_rip+0}

Code: f3 90 f0 81 2b 00 00 00 01 0f 94 c0 84 c0 75 7d f0 81 03 00
console shuts up ...
 <3>Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace: <NMI> <ffffffff8013d9e5>{profile_task_exit+21}
<ffffffff8013ef9e>{do_exit+34}
       <ffffffff80272c2d>{do_unblank_screen+40}
<ffffffff801117a3>{bad_intr+0}
<ffffffff8011f4de>{nmi_watchdog_tick+242}
<ffffffff80111a5b>{default_do_nmi+137}
       <ffffffff8011f607>{do_nmi+69} <ffffffff80110da3>{nmi+127}
       <ffffffff802196ee>{_raw_write_lock+151}  <EOE>
<ffffffff80357ab0>{_write_lock_irqsave+9}
       <ffffffff8016c008>{test_set_page_writeback+58}
<ffffffff881d282c>{:xfs:xfs_submit_page+68}
       <ffffffff881d338f>{:xfs:xfs_page_state_convert+1272}
       <ffffffff881d3636>{:xfs:linvfs_writepage+170}
<ffffffff801ae5af>{mpage_writepages+471}
       <ffffffff881d8dad>{:xfs:xfs_bdstrat_cb+59}
<ffffffff881d358c>{:xfs:linvfs_writepage+0}
       <ffffffff80357a88>{_spin_lock_irqsave+9} <ffffffff80215991>{__up_read+19}
       <ffffffff881bb765>{:xfs:xfs_log_move_tail+83}
<ffffffff801acd5c>{__writeback_single_inode+456}
       <ffffffff881c7252>{:xfs:xfs_trans_first_ail+18}
<ffffffff881bdfa1>{:xfs:xfs_log_need_covered+167}
       <ffffffff801ad2de>{sync_sb_inodes+498} <ffffffff8016c261>{pdflush+0}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801ad600>{writeback_inodes+153}
       <ffffffff8016ba45>{wb_kupdate+283} <ffffffff8016c413>{pdflush+434}
       <ffffffff8016b92a>{wb_kupdate+0} <ffffffff801524ea>{kthread+276}
       <ffffffff801387c8>{schedule_tail+70} <ffffffff80110c22>{child_rip+8}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801523d6>{kthread+0}
       <ffffffff80110c1a>{child_rip+0}
Kernel panic - not syncing: Aiee, killing interrupt handler!

Call Trace: <NMI> <ffffffff8013c1d1>{panic+133}
<ffffffff80357aea>{_spin_unlock_irq+14}
       <ffffffff8035746c>{__down_read+50}
<ffffffff80357a88>{_spin_lock_irqsave+9}
       <ffffffff80215991>{__up_read+19} <ffffffff8013effb>{do_exit+127}
       <ffffffff80272c2d>{do_unblank_screen+40}
<ffffffff801117a3>{bad_intr+0}
<ffffffff8011f4de>{nmi_watchdog_tick+242}
<ffffffff80111a5b>{default_do_nmi+137}
       <ffffffff8011f607>{do_nmi+69} <ffffffff80110da3>{nmi+127}
       <ffffffff802196ee>{_raw_write_lock+151}  <EOE>
<ffffffff80357ab0>{_write_lock_irqsave+9}
       <ffffffff8016c008>{test_set_page_writeback+58}
<ffffffff881d282c>{:xfs:xfs_submit_page+68}
       <ffffffff881d338f>{:xfs:xfs_page_state_convert+1272}
       <ffffffff881d3636>{:xfs:linvfs_writepage+170}
<ffffffff801ae5af>{mpage_writepages+471}
       <ffffffff881d8dad>{:xfs:xfs_bdstrat_cb+59}
<ffffffff881d358c>{:xfs:linvfs_writepage+0}
       <ffffffff80357a88>{_spin_lock_irqsave+9} <ffffffff80215991>{__up_read+19}
       <ffffffff881bb765>{:xfs:xfs_log_move_tail+83}
<ffffffff801acd5c>{__writeback_single_inode+456}
       <ffffffff881c7252>{:xfs:xfs_trans_first_ail+18}
<ffffffff881bdfa1>{:xfs:xfs_log_need_covered+167}
       <ffffffff801ad2de>{sync_sb_inodes+498} <ffffffff8016c261>{pdflush+0}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801ad600>{writeback_inodes+153}
       <ffffffff8016ba45>{wb_kupdate+283} <ffffffff8016c413>{pdflush+434}
       <ffffffff8016b92a>{wb_kupdate+0} <ffffffff801524ea>{kthread+276}
       <ffffffff801387c8>{schedule_tail+70} <ffffffff80110c22>{child_rip+8}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801523d6>{kthread+0}
       <ffffffff80110c1a>{child_rip+0}
 Badness in panic at kernel/panic.c:139 (Not tainted)

Call Trace: <NMI> <ffffffff8013c348>{panic+508}
<ffffffff80357aea>{_spin_unlock_irq+14}
       <ffffffff8035746c>{__down_read+50}
<ffffffff80357a88>{_spin_lock_irqsave+9}
       <ffffffff80215991>{__up_read+19} <ffffffff8013effb>{do_exit+127}
       <ffffffff80272c2d>{do_unblank_screen+40}
<ffffffff801117a3>{bad_intr+0}
<ffffffff8011f4de>{nmi_watchdog_tick+242}
<ffffffff80111a5b>{default_do_nmi+137}
       <ffffffff8011f607>{do_nmi+69} <ffffffff80110da3>{nmi+127}
       <ffffffff802196ee>{_raw_write_lock+151}  <EOE>
<ffffffff80357ab0>{_write_lock_irqsave+9}
       <ffffffff8016c008>{test_set_page_writeback+58}
<ffffffff881d282c>{:xfs:xfs_submit_page+68}
       <ffffffff881d338f>{:xfs:xfs_page_state_convert+1272}
       <ffffffff881d3636>{:xfs:linvfs_writepage+170}
<ffffffff801ae5af>{mpage_writepages+471}
       <ffffffff881d8dad>{:xfs:xfs_bdstrat_cb+59}
<ffffffff881d358c>{:xfs:linvfs_writepage+0}
       <ffffffff80357a88>{_spin_lock_irqsave+9} <ffffffff80215991>{__up_read+19}
       <ffffffff881bb765>{:xfs:xfs_log_move_tail+83}
<ffffffff801acd5c>{__writeback_single_inode+456}
       <ffffffff881c7252>{:xfs:xfs_trans_first_ail+18}
<ffffffff881bdfa1>{:xfs:xfs_log_need_covered+167}
       <ffffffff801ad2de>{sync_sb_inodes+498} <ffffffff8016c261>{pdflush+0}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801ad600>{writeback_inodes+153}
       <ffffffff8016ba45>{wb_kupdate+283} <ffffffff8016c413>{pdflush+434}
       <ffffffff8016b92a>{wb_kupdate+0} <ffffffff801524ea>{kthread+276}
       <ffffffff801387c8>{schedule_tail+70} <ffffffff80110c22>{child_rip+8}
       <ffffffff801522e0>{keventd_create_kthread+0}
<ffffffff801523d6>{kthread+0}
       <ffffffff80110c1a>{child_rip+0}

This particular machine is a Dual Opteron 246 at 2GHz, with 2GB
physical ram, and 2 1GB swap partitions on the hard drive.  We're
using the 64-bit edition of Fedora Core 4, with kernel
2.6.15-1.1831_FC4smp.  More info is available upon request.

Does anyone have any ideas what could be causing this?

I'm not subscribed to LKML due to the volume, but I will try to
monitor any replies over the web.  If possible, please CC me.

Jeremy Utley
