Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWAUTo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWAUTo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWAUTo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:44:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26721 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751201AbWAUTo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:44:27 -0500
Date: Sat, 21 Jan 2006 20:46:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: use disk_stat_add instead of __disk_stat_add in __end_that_request_first
Message-ID: <20060121194632.GU13429@suse.de>
References: <20060121172233.GA18239@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121172233.GA18239@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22 2006, Tejun Heo wrote:
> Unlike end_that_request_last, caller is supposed to own the request
> when it calls __end_that_request_first and thus allowed to call from
> any context without any locking.  When SCSI EH completes requests, it
> calls __end_that_request_first from kernel thread context without
> holding any lock and none of preemption/bh/irq disabled.  This results
> in the following warning.
> 
> BUG: using smp_processor_id() in preemptible [00000001] code: scsi_eh_6/927
> caller is __end_that_request_first+0xbf/0x500
>  [<c01046e3>] show_trace+0x13/0x20
>  [<c010470e>] dump_stack+0x1e/0x20
>  [<c02231c8>] debug_smp_processor_id+0xa8/0xb0
>  [<c021167f>] __end_that_request_first+0xbf/0x500
>  [<c0211ad1>] end_that_request_chunk+0x11/0x20
>  [<c03360b2>] scsi_end_request+0x32/0x110
> -- snip --
> 
> This patch makes __end_that_request_first() use undashed
> disk_stat_add() which doesn't assume preemption is disabled.

Patch is good, however I already added this identical patch to the block
git repo last week :-)

-- 
Jens Axboe

