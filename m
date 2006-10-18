Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161137AbWJRPdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbWJRPdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbWJRPdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:33:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:48108 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161137AbWJRPdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:33:35 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061016230645.fed53c5b.akpm@osdl.org>
References: <20061016230645.fed53c5b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 08:33:19 -0700
Message-Id: <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 23:06 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
> 
> 
> - Added the hwmon and i2c trees to the -mm lineup.  These are quilt-style
>   trees, maintained by Jean Delvare.


LTP writev tests seems to lockup the machine. reiserfs issue ?
Didn't you have a patch to dump other CPUs also when this happens ?

Thanks,
Badari

BUG: soft lockup detected on CPU#2!

Call Trace:
 <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
 [<ffffffff8022e10f>] __do_softirq+0x5f/0xd0
 [<ffffffff80232067>] update_process_times+0x57/0x90
 [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff80326ce0>] __copy_user_nocache+0x20/0x150
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff802b8de0>] reiserfs_get_block+0x0/0x10c0
 [<ffffffff80295198>] __block_prepare_write+0x158/0x470
 [<ffffffff802b8de0>] reiserfs_get_block+0x0/0x10c0
 [<ffffffff802954ca>] block_prepare_write+0x1a/0x30
 [<ffffffff802b7cea>] reiserfs_prepare_write+0xca/0x140
 [<ffffffff8024e9d2>] generic_file_buffered_write+0x2b2/0x610
 [<ffffffff8022d84b>] current_fs_time+0x3b/0x40
 [<ffffffff8024f157>] __generic_file_aio_write_nolock+0x427/0x4b0
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8024f247>] generic_file_aio_write+0x67/0xd0
 [<ffffffff8024f1e0>] generic_file_aio_write+0x0/0xd0
 [<ffffffff80271f53>] do_sync_readv_writev+0xc3/0x110
 [<ffffffff8023d910>] autoremove_wake_function+0x0/0x30
 [<ffffffff8035c18d>] tty_default_put_char+0x1d/0x30
 [<ffffffff803618c4>] write_chan+0x374/0x3a0
 [<ffffffff80271daa>] rw_copy_check_uvector+0x8a/0x130
 [<ffffffff802726ef>] do_readv_writev+0xef/0x200
 [<ffffffff8035e349>] tty_write+0x219/0x250
 [<ffffffff80272d43>] sys_writev+0x53/0xc0
 [<ffffffff80209c1e>] system_call+0x7e/0x83

BUG: soft lockup detected on CPU#2!

Call Trace:
 <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
 [<ffffffff80232067>] update_process_times+0x57/0x90
 [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff8025f3e2>] find_vma+0x12/0x70
 [<ffffffff8021e6e5>] do_page_fault+0x3c5/0x870
 [<ffffffff802bc2e1>] reiserfs_commit_page+0xe1/0x220
 [<ffffffff8048012d>] error_exit+0x0/0x84
 [<ffffffff8024e89e>] generic_file_buffered_write+0x17e/0x610
 [<ffffffff8024eb47>] generic_file_buffered_write+0x427/0x610
 [<ffffffff8022d84b>] current_fs_time+0x3b/0x40
 [<ffffffff8024f157>] __generic_file_aio_write_nolock+0x427/0x4b0
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8024f247>] generic_file_aio_write+0x67/0xd0
 [<ffffffff8024f1e0>] generic_file_aio_write+0x0/0xd0
 [<ffffffff80271f53>] do_sync_readv_writev+0xc3/0x110
 [<ffffffff8023d910>] autoremove_wake_function+0x0/0x30
 [<ffffffff8035c18d>] tty_default_put_char+0x1d/0x30
 [<ffffffff803618c4>] write_chan+0x374/0x3a0
 [<ffffffff80271daa>] rw_copy_check_uvector+0x8a/0x130
 [<ffffffff802726ef>] do_readv_writev+0xef/0x200
 [<ffffffff8035e349>] tty_write+0x219/0x250
 [<ffffffff80272d43>] sys_writev+0x53/0xc0
 [<ffffffff80209c1e>] system_call+0x7e/0x83

BUG: soft lockup detected on CPU#2!

Call Trace:
 <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
 [<ffffffff8022e10f>] __do_softirq+0x5f/0xd0
 [<ffffffff80232067>] update_process_times+0x57/0x90
 [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff80256320>] mark_page_accessed+0x30/0x40
 [<ffffffff8024eb3f>] generic_file_buffered_write+0x41f/0x610
 [<ffffffff8022d84b>] current_fs_time+0x3b/0x40
 [<ffffffff8024f157>] __generic_file_aio_write_nolock+0x427/0x4b0
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8024f247>] generic_file_aio_write+0x67/0xd0
 [<ffffffff8024f1e0>] generic_file_aio_write+0x0/0xd0
 [<ffffffff80271f53>] do_sync_readv_writev+0xc3/0x110
 [<ffffffff8023d910>] autoremove_wake_function+0x0/0x30
 [<ffffffff8035c18d>] tty_default_put_char+0x1d/0x30
 [<ffffffff803618c4>] write_chan+0x374/0x3a0
 [<ffffffff80271daa>] rw_copy_check_uvector+0x8a/0x130
 [<ffffffff802726ef>] do_readv_writev+0xef/0x200
 [<ffffffff8035e349>] tty_write+0x219/0x250
 [<ffffffff80272d43>] sys_writev+0x53/0xc0
 [<ffffffff80209c1e>] system_call+0x7e/0x83



