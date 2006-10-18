Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWJRR6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWJRR6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWJRR6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:58:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:50091 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422719AbWJRR6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:58:36 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <45366515.4050308@yahoo.com.au>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	 <45364CE9.7050002@yahoo.com.au>
	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	 <45366515.4050308@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 10:58:23 -0700
Message-Id: <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 03:32 +1000, Nick Piggin wrote:
> Badari Pulavarty wrote:
> > On Thu, 2006-10-19 at 01:48 +1000, Nick Piggin wrote:
> > 
> >>Badari Pulavarty wrote:
> >>
> >>>On Mon, 2006-10-16 at 23:06 -0700, Andrew Morton wrote:
> >>>
> >>>
> >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
> >>>>
> >>>>
> >>>>- Added the hwmon and i2c trees to the -mm lineup.  These are quilt-style
> >>>> trees, maintained by Jean Delvare.
> >>>
> >>>
> >>>
> >>>LTP writev tests seems to lockup the machine. reiserfs issue ?
> >>
...
> > 
> > No. seems to be generic issue .. (happens with ext3 also) :(
> 
> I think I may have missed a fix for ext3 ordered and journalled too
> (I've just sent a patch to Andrew privately).
> 
> Sorry. Can you try with ext2? Alternatively, try with ext3 or reiserfs
> and change the line in mm/filemap.c:generic_file_buffered_write from
> 
> 		status = a_ops->commit_write(file, page, offset, offset+copied);
> to
> 		status = a_ops->commit_write(file, page, offset, offset+bytes);
> 
> and see if that solves your problem (that will result in rubbish being
> temporarily visible, but there is a similar problem upstream anyway, so it
> shouldn't cause other failures in your test).

No. Above change didn't help either :(

Thanks,
Badari

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


