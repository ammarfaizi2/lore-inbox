Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSKFHi3>; Wed, 6 Nov 2002 02:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSKFHi3>; Wed, 6 Nov 2002 02:38:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30675 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265066AbSKFHi2>;
	Wed, 6 Nov 2002 02:38:28 -0500
Date: Wed, 6 Nov 2002 08:44:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106074457.GE4369@suse.de>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106072223.GB4369@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06 2002, Jens Axboe wrote:
> > when the cdrecord buffer underran was surprising, though: oops below.
> > Very repeatable. Can supply copious hw details if it helps.
> 
> I'll try and reproduce that here, there's been a similar report (same
> oops) before. If you can just send me the dmesg output after a boot that
> should be fine.

Could you reproduce with this patch? I'd like to see the request state
when this happens.

===== drivers/ide/ide-cd.c 1.32 vs edited =====
--- 1.32/drivers/ide/ide-cd.c	Sun Nov  3 19:57:35 2002
+++ edited/drivers/ide/ide-cd.c	Wed Nov  6 08:44:04 2002
@@ -1722,6 +1722,11 @@
 			blen = bio_iovec(rq->bio)->bv_len;
 		}
 
+		if (!ptr) {
+			blk_dump_rq_flags(rq, "cdrom_newpc_intr");
+			break;
+		}
+
 		if (blen > thislen)
 			blen = thislen;
 

-- 
Jens Axboe

