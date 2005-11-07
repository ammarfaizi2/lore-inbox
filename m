Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVKGJyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVKGJyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 04:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKGJyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 04:54:38 -0500
Received: from tornado.reub.net ([202.89.145.182]:30115 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932471AbVKGJyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 04:54:37 -0500
Message-ID: <436F2452.9020207@reub.net>
Date: Mon, 07 Nov 2005 22:54:26 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051106)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 7/11/2005 3:24 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
> 
> - Added the 1394 development tree to the -mm lineup, as git-ieee1394.patch
> 
> - Re-added rmk's driver-model tree git-drvmodel.patch
> 
> - Added davem's sparc64 tree, as git-sparc64.patch
> 
> - v4l updates
> 
> - dvb updates

Just rebooted into 2.6.14-mm1 and now every few seconds I get this spewed up 
on the console:

Nov  7 22:49:47 tornado kernel: Debug: sleeping function called from invalid 
context at include/asm/semaphore.h:99
Nov  7 22:49:47 tornado kernel: in_atomic():0, irqs_disabled():1
Nov  7 22:49:47 tornado kernel:  [<c0103a50>] dump_stack+0x17/0x19
Nov  7 22:49:47 tornado kernel:  [<c011971b>] __might_sleep+0x9d/0xad
Nov  7 22:49:47 tornado kernel:  [<c028aa4b>] scsi_disk_get_from_dev+0x15/0x48
Nov  7 22:49:47 tornado kernel:  [<c028b28e>] sd_prepare_flush+0x17/0x5a
Nov  7 22:49:47 tornado kernel:  [<c027abff>] scsi_prepare_flush_fn+0x30/0x33
Nov  7 22:49:47 tornado kernel:  [<c0255332>] blk_start_pre_flush+0xd5/0x13f
Nov  7 22:49:47 tornado kernel:  [<c025490b>] elv_next_request+0x112/0x16f
Nov  7 22:49:47 tornado kernel:  [<c027b045>] scsi_request_fn+0x4b/0x2fd
Nov  7 22:49:47 tornado kernel:  [<c0254748>] __elv_add_request+0x109/0x176
Nov  7 22:49:47 tornado kernel:  [<c0257ab4>] __make_request+0x1d0/0x474
Nov  7 22:49:47 tornado kernel:  [<c0257e96>] generic_make_request+0xb3/0x128
Nov  7 22:49:47 tornado kernel:  [<c0257f54>] submit_bio+0x49/0xce
Nov  7 22:49:47 tornado kernel:  [<c02967c5>] md_super_write+0x87/0xa3
Nov  7 22:49:47 tornado kernel:  [<c0298484>] md_update_sb+0xc3/0x1a8
Nov  7 22:49:47 tornado kernel:  [<c029cbd2>] md_check_recovery+0x17b/0x425
Nov  7 22:49:47 tornado kernel:  [<c0294d73>] raid1d+0x1f/0x3b8
Nov  7 22:49:47 tornado kernel:  [<c029b397>] md_thread+0x3b/0xee
Nov  7 22:49:47 tornado kernel:  [<c012ee57>] kthread+0x99/0x9d
Nov  7 22:49:47 tornado kernel:  [<c01010bd>] kernel_thread_helper+0x5/0xb

The box has raid-1 and I'm guessing that that may be the culprit here... ?

Reuben
