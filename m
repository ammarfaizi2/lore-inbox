Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWJRRQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWJRRQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWJRRQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:16:01 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:5083 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161226AbWJRRQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:16:00 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <45364CE9.7050002@yahoo.com.au>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	 <45364CE9.7050002@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 10:15:47 -0700
Message-Id: <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 01:48 +1000, Nick Piggin wrote:
> Badari Pulavarty wrote:
> > On Mon, 2006-10-16 at 23:06 -0700, Andrew Morton wrote:
> > 
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
> >>
> >>
> >>- Added the hwmon and i2c trees to the -mm lineup.  These are quilt-style
> >>  trees, maintained by Jean Delvare.
> > 
> > 
> > 
> > LTP writev tests seems to lockup the machine. reiserfs issue ?
> 
> ...
> 
> > BUG: soft lockup detected on CPU#2!
> > 
> > Call Trace:
> >  <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
> >  [<ffffffff8022e10f>] __do_softirq+0x5f/0xd0
> >  [<ffffffff80232067>] update_process_times+0x57/0x90
> >  [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
> >  [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
> >  [<ffffffff80326ce0>] __copy_user_nocache+0x20/0x150
> >  [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
> >  <EOI>  [<ffffffff802b8de0>] reiserfs_get_block+0x0/0x10c0
> >  [<ffffffff80295198>] __block_prepare_write+0x158/0x470
> >  [<ffffffff802b8de0>] reiserfs_get_block+0x0/0x10c0
> >  [<ffffffff802954ca>] block_prepare_write+0x1a/0x30
> >  [<ffffffff802b7cea>] reiserfs_prepare_write+0xca/0x140
> >  [<ffffffff8024e9d2>] generic_file_buffered_write+0x2b2/0x610
> 
> This is likely to be a reiserfs interaction with the pagecache write
> deadlock fixes. Chris Mason just now identified a couple of issues
> and is going to work on a fix.
> 

No. seems to be generic issue .. (happens with ext3 also) :(

BUG: soft lockup detected on CPU#3!

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
 [<ffffffff8024eb1c>] generic_file_buffered_write+0x3fc/0x610
 [<ffffffff8022d84b>] current_fs_time+0x3b/0x40
 [<ffffffff8024f157>] __generic_file_aio_write_nolock+0x427/0x4b0
 [<ffffffff80284a13>] dput+0x23/0x170
 [<ffffffff8027c437>] __link_path_walk+0xbd7/0xd40
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8024f247>] generic_file_aio_write+0x67/0xd0
 [<ffffffff802d7153>] ext3_file_write+0x23/0xc0
 [<ffffffff802d7130>] ext3_file_write+0x0/0xc0
 [<ffffffff80271f53>] do_sync_readv_writev+0xc3/0x110
 [<ffffffff8023d910>] autoremove_wake_function+0x0/0x30
 [<ffffffff80271daa>] rw_copy_check_uvector+0x8a/0x130
 [<ffffffff802726ef>] do_readv_writev+0xef/0x200
 [<ffffffff80272d43>] sys_writev+0x53/0xc0
 [<ffffffff80209d91>] tracesys+0xd1/0xe0

BUG: soft lockup detected on CPU#3!

Call Trace:
 <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
 [<ffffffff8022e10f>] __do_softirq+0x5f/0xd0
 [<ffffffff80232067>] update_process_times+0x57/0x90
 [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff802da0a0>] ext3_get_block+0x0/0x120
 [<ffffffff8021e637>] do_page_fault+0x317/0x870
 [<ffffffff8021e61b>] do_page_fault+0x2fb/0x870
 [<ffffffff8021e93f>] do_page_fault+0x61f/0x870
 [<ffffffff80231f2c>] __mod_timer+0xac/0xc0
 [<ffffffff8048012d>] error_exit+0x0/0x84
 [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff802da0a0>] ext3_get_block+0x0/0x120
 [<ffffffff80326ce0>] __copy_user_nocache+0x20/0x150
 [<ffffffff8024cc6b>] __filemap_copy_from_user_iovec_inatomic+0x4b/0x70
 [<ffffffff8024eade>] generic_file_buffered_write+0x3be/0x610
 [<ffffffff8022d84b>] current_fs_time+0x3b/0x40
 [<ffffffff8024f157>] __generic_file_aio_write_nolock+0x427/0x4b0
 [<ffffffff80284a13>] dput+0x23/0x170
 [<ffffffff8027c437>] __link_path_walk+0xbd7/0xd40
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8024f247>] generic_file_aio_write+0x67/0xd0
 [<ffffffff802d7153>] ext3_file_write+0x23/0xc0
 [<ffffffff802d7130>] ext3_file_write+0x0/0xc0
 [<ffffffff80271f53>] do_sync_readv_writev+0xc3/0x110
 [<ffffffff8023d910>] autoremove_wake_function+0x0/0x30
 [<ffffffff80271daa>] rw_copy_check_uvector+0x8a/0x130
 [<ffffffff802726ef>] do_readv_writev+0xef/0x200
 [<ffffffff80272d43>] sys_writev+0x53/0xc0
 [<ffffffff80209d91>] tracesys+0xd1/0xe0

BUG: soft lockup detected on CPU#3!

Call Trace:
 <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
 [<ffffffff80232067>] update_process_times+0x57/0x90
 [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8024e89e>] generic_file_buffered_write+0x17e/0x610
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff8027fa21>] do_sys_poll+0x351/0x410
 [<ffffffff8024e89e>] generic_file_buffered_write+0x17e/0x610
 [<ffffffff8021ef82>] search_extable+0x42/0x70
 [<ffffffff8023b2fd>] search_exception_tables+0x1d/0x40
 [<ffffffff8021e93f>] do_page_fault+0x61f/0x870
 [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff8048012d>] error_exit+0x0/0x84
 [<ffffffff802d9210>] ext3_journal_dirty_data+0x0/0x50
 [<ffffffff8024e89e>] generic_file_buffered_write+0x17e/0x610
 [<ffffffff8024eb47>] generic_file_buffered_write+0x427/0x610
 [<ffffffff8022d84b>] current_fs_time+0x3b/0x40
 [<ffffffff8024f157>] __generic_file_aio_write_nolock+0x427/0x4b0
 [<ffffffff80284a13>] dput+0x23/0x170
 [<ffffffff8027c437>] __link_path_walk+0xbd7/0xd40
 [<ffffffff8047ee5f>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8024f247>] generic_file_aio_write+0x67/0xd0
 [<ffffffff802d7153>] ext3_file_write+0x23/0xc0
 [<ffffffff802d7130>] ext3_file_write+0x0/0xc0
 [<ffffffff80271f53>] do_sync_readv_writev+0xc3/0x110
 [<ffffffff8023d910>] autoremove_wake_function+0x0/0x30
 [<ffffffff80271daa>] rw_copy_check_uvector+0x8a/0x130
 [<ffffffff802726ef>] do_readv_writev+0xef/0x200
 [<ffffffff80272d43>] sys_writev+0x53/0xc0
 [<ffffffff80209d91>] tracesys+0xd1/0xe0


