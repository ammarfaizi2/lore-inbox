Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945898AbWJRWgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbWJRWgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945899AbWJRWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:36:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:44980 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1945898AbWJRWgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:36:20 -0400
Subject: 2.6.19-rc2-mm1 unwinder issues ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Beulich <jbeulich@novell.com>, ak@suse.de
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 15:36:06 -0700
Message-Id: <1161210966.18117.33.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I am not getting stack traces properly on 2.6.19-rc2-mm1 again 
(on my amd64 box).

Wondering, if the unwinder code changed again ??

Thanks,
Badari

Without CONFIG_STACK_UNWIND:
BUG: soft lockup detected on CPU#1!

Call Trace:
 <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
 [<ffffffff8022e10f>] __do_softirq+0x5f/0xd0
 [<ffffffff80232067>] update_process_times+0x57/0x90
 [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff802ea27f>] journal_dirty_data+0x2f/0x200
 [<ffffffff8048012d>] error_exit+0x0/0x84
 [<ffffffff802d922d>] ext3_journal_dirty_data+0x1d/0x50
 [<ffffffff802d84b8>] walk_page_buffers+0x68/0xb0
 [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff802db488>] ext3_ordered_commit_write+0x58/0xd0
 [<ffffffff8024eb29>] generic_file_buffered_write+0x409/0x610
 [<ffffffff8022d84b>] current_fs_time+0x3b/0x40
 [<ffffffff8022023c>] task_rq_lock+0x4c/0x90
 [<ffffffff8024f157>] __generic_file_aio_write_nolock+0x427/0x4b0
 [<ffffffff8022192c>] try_to_wake_up+0x39c/0x3c0
 [<ffffffff8021fad4>] __wake_up_common+0x44/0x80
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8024f247>] generic_file_aio_write+0x67/0xd0
 [<ffffffff802d7153>] ext3_file_write+0x23/0xc0
 [<ffffffff802d7130>] ext3_file_write+0x0/0xc0
 [<ffffffff80271f53>] do_sync_readv_writev+0xc3/0x110
 [<ffffffff8023d910>] autoremove_wake_function+0x0/0x30
 [<ffffffff8035c18d>] tty_default_put_char+0x1d/0x30
 [<ffffffff803618c4>] write_chan+0x374/0x3a0
 [<ffffffff80271daa>] rw_copy_check_uvector+0x8a/0x130
 [<ffffffff802726ef>] do_readv_writev+0xef/0x200
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff80272d43>] sys_writev+0x53/0xc0
 [<ffffffff80209c1e>] system_call+0x7e/0x83




With CONFIG_STACK_UNWIND:

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]


