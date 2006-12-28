Return-Path: <linux-kernel-owner+w=401wt.eu-S964875AbWL1CQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWL1CQ2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 21:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWL1CQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 21:16:28 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:27709 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875AbWL1CQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 21:16:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mX1/rOVbDBx5mHQqeEYwkg/irRu/2b2UsHJ1gNfbyUt3RPkfQ6K01YyM5tSYUVDh54w+G0kmeTvd7udF8+x2uQUGloK0spuSnn+yw4Cd0WhM+l+/Iky+xweLATbXtczav3LaNwxD7HhYGj0xQQnwDKcDssBFLO7SXvEPbNcxCKw=
Message-ID: <9e4733910612271816x1ebc968auf94de2a84526aee0@mail.gmail.com>
Date: Wed, 27 Dec 2006 21:16:26 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: BUG: scheduling while atomic, new libata code
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061226175559.e280e66e.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910612261747s4b32d6ben2e5a55f88f225edf@mail.gmail.com>
	 <20061226175559.e280e66e.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still getting the bug with patch applied.


BUG: scheduling while atomic: hald-addon-stor/0x20000000/5078
 [<c02b0289>] __sched_text_start+0x5f9/0xb00
 [<c024a623>] net_rx_action+0xb3/0x180
 [<c01210f2>] __do_softirq+0x72/0xe0
 [<c0105205>] do_IRQ+0x45/0x80
 [<c0103aab>] common_interrupt+0x23/0x28
 [<c0117696>] __cond_resched+0x16/0x40
 [<c02b07b3>] cond_resched+0x23/0x30
 [<c02b225c>] __reacquire_kernel_lock+0x1c/0x3c
 [<c02b02b9>] __sched_text_start+0x629/0xb00
 [<c02b086e>] wait_for_completion+0x8e/0xc0
 [<c0117650>] default_wake_function+0x0/0x10
 [<c01b321c>] blk_execute_rq+0x7c/0xe0
 [<c0117696>] __cond_resched+0x16/0x40
 [<c02b07b3>] cond_resched+0x23/0x30
 [<c0161a36>] kmem_cache_zalloc+0x76/0x90
 [<c02181fd>] scsi_execute_req+0x3d/0xf0
 [<c01b6ce9>] sg_io+0x2a9/0x340
 [<c0218306>] scsi_test_unit_ready+0x56/0xa0
 [<f8986132>] sr_media_change+0x52/0x220 [sr_mod]
 [<c0103ad8>] reschedule_interrupt+0x28/0x30
 [<f8986320>] sr_block_media_changed+0x0/0x10 [sr_mod]
 [<f89f508d>] media_changed+0x5d/0xa0 [cdrom]
 [<c01883ac>] check_disk_change+0x1c/0x80
 [<f89f9432>] cdrom_open+0x152/0xa90 [cdrom]
 [<c0218306>] scsi_test_unit_ready+0x56/0xa0
 [<c0175619>] __d_lookup+0x89/0x100
 [<c0175b85>] dput+0xb5/0x130
 [<c016ba75>] do_lookup+0x65/0x190
 [<f8972540>] ext3_permission+0x0/0x10 [ext3]
 [<c0175b85>] dput+0xb5/0x130
 [<c016dc6a>] __link_path_walk+0xc1a/0xc90
 [<c017828e>] touch_atime+0x9e/0x110
 [<c0179b5b>] mntput_no_expire+0x1b/0x80
 [<c016dd45>] link_path_walk+0x65/0xc0
 [<c01323fe>] hrtimer_cancel+0xe/0x20
 [<c0132539>] hrtimer_nanosleep+0x49/0x110
 [<c01bdf3f>] kobject_get+0xf/0x20
 [<c01b5ce9>] get_disk+0x39/0x70
 [<c01b5d27>] exact_lock+0x7/0x10
 [<c01bdf3f>] kobject_get+0xf/0x20
 [<f89863dc>] sr_block_open+0x5c/0xa0 [sr_mod]
 [<c0188e70>] blkdev_open+0x0/0x70
 [<c0188bc9>] do_open+0x1e9/0x290
 [<c0188e70>] blkdev_open+0x0/0x70
 [<c0188ea0>] blkdev_open+0x30/0x70
 [<c016307a>] __dentry_open+0xba/0x1c0
 [<c0163235>] nameidata_to_filp+0x35/0x40
 [<c016328b>] do_filp_open+0x4b/0x60
 [<c01323fe>] hrtimer_cancel+0xe/0x20
 [<c0132539>] hrtimer_nanosleep+0x49/0x110
 [<c01632ea>] do_sys_open+0x4a/0xe0
 [<c01633bc>] sys_open+0x1c/0x20
 [<c010309a>] sysenter_past_esp+0x5f/0x85
 =======================


-- 
Jon Smirl
jonsmirl@gmail.com
