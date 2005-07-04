Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVGDSDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVGDSDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVGDSDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:03:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36264 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261517AbVGDSCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:02:53 -0400
Date: Mon, 4 Jul 2005 20:04:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Mokrejs <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two 2.6.13-rc1 kernel crashes
Message-ID: <20050704180426.GS1444@suse.de>
References: <42C96047.60602@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C96047.60602@ribosome.natur.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Martin Mokrejs wrote:
> Hi,
>   I use on i686 architecture Gentoo linux with XFS filesystem.
> Recently it happened to me 3 time that the machine locked,
> although at least once sys-rq+b worked. Here is the log
> from remote console. I don't remeber having such problems
> with 2.6.12-rc6-git2, which was my previous testing kernel.
> The problems appear under heavy load when I compile/install
> some packages and maybe it's just a bad coincidence or not,
> when I move my usb mouse in fvwm2 environment. The machine
> locks.

You need this fix from Hugh.

--- 2.6.13-rc1/drivers/block/ll_rw_blk.c	2005-06-29 11:54:08.000000000 +0100
+++ linux/drivers/block/ll_rw_blk.c	2005-06-29 14:41:04.000000000 +0100
@@ -1917,10 +1917,9 @@ get_rq:
 	 * limit of requests, otherwise we could have thousands of requests
 	 * allocated with any setting of ->nr_requests
 	 */
-	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
-		spin_unlock_irq(q->queue_lock);
+	if (rl->count[rw] >= (3 * q->nr_requests / 2))
 		goto out;
-	}
+

-- 
Jens Axboe

