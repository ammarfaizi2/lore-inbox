Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUI1PYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUI1PYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUI1PX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:23:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62376 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267876AbUI1PXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:23:54 -0400
Date: Tue, 28 Sep 2004 17:21:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Jay Lan <jlan@engr.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc2 1/2] enhanced I/O accounting data collection
Message-ID: <20040928152123.GD2385@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Index: linux/drivers/block/ll_rw_blk.c
> ===================================================================
> --- linux.orig/drivers/block/ll_rw_blk.c	2004-09-12 22:31:31.000000000 -0700
> +++ linux/drivers/block/ll_rw_blk.c	2004-09-27 12:37:04.374234677 -0700
> @@ -1741,6 +1741,7 @@
> {
> 	DEFINE_WAIT(wait);
> 	struct request *rq;
>+	unsigned long start_wait = jiffies;
> 
> 	generic_unplug_device(q);
> 	do {
>@@ -1769,6 +1770,7 @@
> 		finish_wait(&rl->wait[rw], &wait);
> 	} while (!rq);
> 
>+	current->bwtime += (unsigned long) jiffies - start_wait;
> 	return rq;
> }

What is the purpose of this hunk alone as block io accounting? It
doesn't make any sense to me - you are accounting the time a process
spends sleeping on a congested queue, it has nothing to do with the
bandwidth time it used. Which, btw, isn't so easy to account on queueing
hardware.

Just curious on what you are trying to achieve here.
 
-- 
Jens Axboe

