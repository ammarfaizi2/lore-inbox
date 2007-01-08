Return-Path: <linux-kernel-owner+w=401wt.eu-S932402AbXAHIyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbXAHIyy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbXAHIyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:54:54 -0500
Received: from brick.kernel.dk ([62.242.22.158]:14133 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402AbXAHIyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:54:53 -0500
Date: Mon, 8 Jan 2007 09:55:24 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - git-block.patch causes hard lockups
Message-ID: <20070108085523.GS11203@kernel.dk>
References: <20070104220200.ae4e9a46.akpm@osdl.org> <200701061255.l06CtXJq011249@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701061255.l06CtXJq011249@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06 2007, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:
> 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> 
> With git-block.patch applied, my system locks up *hard* at system
> shutdown time - even alt-sysrq doesn't do anything.  Need to do the
> "power button for 5" stunt to get the system back.

Does this change anything?

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index ec40e44..bae57e0 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1542,7 +1542,7 @@ static inline void queue_sync_plugs(request_queue_t *q)
 	 * If the current process is plugged and has barriers submitted,
 	 * we will livelock if we don't unplug first.
 	 */
-	blk_unplug_current();
+	blk_replug_current_nested();
 
 	synchronize_qrcu(&q->qrcu);
 }

-- 
Jens Axboe

