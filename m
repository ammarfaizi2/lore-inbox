Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVCJBeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVCJBeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVCJBYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:24:14 -0500
Received: from fmr21.intel.com ([143.183.121.13]:35817 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262602AbVCJBL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:11:29 -0500
Message-Id: <200503100111.j2A1BBg27931@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 17:11:11 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUk+bD55dicvFqwR+qO9QCsBRySRAAE+pyg
In-Reply-To: <20050309144458.2cbc554e.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, March 09, 2005 2:45 PM
> >
> > > Did you generate a kernel profile?
> >
> >  Top 40 kernel hot functions, percentage is normalized to kernel utilization.
> >
> >  _spin_unlock_irqrestore		23.54%
> >  _spin_unlock_irq			19.27%
>
> Cripes.
>
> Is that with CONFIG_PREEMPT?  If so, and if you disable CONFIG_PREEMPT,
> this cost should be accounting the the spin_unlock() caller and we can see
> who the culprit is.   Perhaps dio->bio_lock.

CONFIG_PREEMPT is off.

Sorry for all the confusion, I probably shouldn't post the first profile
to confuse people.  See 2nd profile that I posted earlier (copied here again).

scsi_request_fn		7.54%
finish_task_switch	6.25%
__blockdev_direct_IO	4.97%
__make_request		3.87%
scsi_end_request		3.54%
dio_bio_end_io		2.70%
follow_hugetlb_page	2.39%
__wake_up			2.37%
aio_complete		1.82%
kmem_cache_alloc		1.68%
__mod_timer			1.63%
e1000_clean			1.57%
__generic_file_aio_read	1.42%
mempool_alloc		1.37%
put_page			1.35%
e1000_intr			1.31%
schedule			1.25%
dio_bio_complete		1.20%
scsi_device_unbusy	1.07%
kmem_cache_free		1.06%
__copy_user			1.04%
scsi_dispatch_cmd		1.04%
__end_that_request_first1.04%
generic_make_request	1.02%
kfree				0.94%
__aio_get_req		0.93%
sys_pread64			0.83%
get_request			0.79%
put_io_context		0.76%
dnotify_parent		0.73%
vfs_read			0.73%
update_atime		0.73%
finished_one_bio		0.63%
generic_file_aio_write_nolock	0.63%
scsi_put_command		0.62%
break_fault			0.62%
e1000_xmit_frame		0.62%
aio_read_evt		0.59%
scsi_io_completion	0.59%
inode_times_differ	0.58%


