Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVKGKJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVKGKJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVKGKJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:09:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932477AbVKGKJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:09:32 -0500
Date: Mon, 7 Nov 2005 02:09:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.6.14-mm1
Message-Id: <20051107020905.69c0b6dc.akpm@osdl.org>
In-Reply-To: <436F2452.9020207@reub.net>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F2452.9020207@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Hi again,
> 
> On 7/11/2005 3:24 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
> > 
> > - Added the 1394 development tree to the -mm lineup, as git-ieee1394.patch
> > 
> > - Re-added rmk's driver-model tree git-drvmodel.patch
> > 
> > - Added davem's sparc64 tree, as git-sparc64.patch
> > 
> > - v4l updates
> > 
> > - dvb updates
> 
> Just rebooted into 2.6.14-mm1 and now every few seconds I get this spewed up 
> on the console:
> 
> Nov  7 22:49:47 tornado kernel: Debug: sleeping function called from invalid 
> context at include/asm/semaphore.h:99
> Nov  7 22:49:47 tornado kernel: in_atomic():0, irqs_disabled():1
> Nov  7 22:49:47 tornado kernel:  [<c0103a50>] dump_stack+0x17/0x19
> Nov  7 22:49:47 tornado kernel:  [<c011971b>] __might_sleep+0x9d/0xad
> Nov  7 22:49:47 tornado kernel:  [<c028aa4b>] scsi_disk_get_from_dev+0x15/0x48
> Nov  7 22:49:47 tornado kernel:  [<c028b28e>] sd_prepare_flush+0x17/0x5a
> Nov  7 22:49:47 tornado kernel:  [<c027abff>] scsi_prepare_flush_fn+0x30/0x33
> Nov  7 22:49:47 tornado kernel:  [<c0255332>] blk_start_pre_flush+0xd5/0x13f
> Nov  7 22:49:47 tornado kernel:  [<c025490b>] elv_next_request+0x112/0x16f
> Nov  7 22:49:47 tornado kernel:  [<c027b045>] scsi_request_fn+0x4b/0x2fd
> Nov  7 22:49:47 tornado kernel:  [<c0254748>] __elv_add_request+0x109/0x176
> Nov  7 22:49:47 tornado kernel:  [<c0257ab4>] __make_request+0x1d0/0x474
> Nov  7 22:49:47 tornado kernel:  [<c0257e96>] generic_make_request+0xb3/0x128
> Nov  7 22:49:47 tornado kernel:  [<c0257f54>] submit_bio+0x49/0xce
> Nov  7 22:49:47 tornado kernel:  [<c02967c5>] md_super_write+0x87/0xa3
> Nov  7 22:49:47 tornado kernel:  [<c0298484>] md_update_sb+0xc3/0x1a8
> Nov  7 22:49:47 tornado kernel:  [<c029cbd2>] md_check_recovery+0x17b/0x425
> Nov  7 22:49:47 tornado kernel:  [<c0294d73>] raid1d+0x1f/0x3b8
> Nov  7 22:49:47 tornado kernel:  [<c029b397>] md_thread+0x3b/0xee
> Nov  7 22:49:47 tornado kernel:  [<c012ee57>] kthread+0x99/0x9d
> Nov  7 22:49:47 tornado kernel:  [<c01010bd>] kernel_thread_helper+0x5/0xb
> 
> The box has raid-1 and I'm guessing that that may be the culprit here... ?
> 

It's not immediately obvious.  Could you enable CONFIG_DEBUG_PREEMPT? 
That'll tell us where the thread went into atomic mode.

