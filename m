Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVAUSR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVAUSR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVAUSNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:13:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262441AbVAUSMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:12:08 -0500
Date: Fri, 21 Jan 2005 18:12:03 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: device-mapper: fix TB stripe data corruption
Message-ID: <20050121181203.GI10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing cast thought to cause data corruption on devices with stripes > ~1TB.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-stripe.c	2005-01-20 17:32:37.000000000 +0000
+++ source/drivers/md/dm-stripe.c	2005-01-20 17:32:26.000000000 +0000
@@ -179,7 +179,7 @@
 
 	bio->bi_bdev = sc->stripe[stripe].dev->bdev;
 	bio->bi_sector = sc->stripe[stripe].physical_start +
-	    (chunk << sc->chunk_shift) + (offset & sc->chunk_mask);
+	    ((sector_t) chunk << sc->chunk_shift) + (offset & sc->chunk_mask);
 	return 1;
 }
 
@@ -212,7 +212,7 @@
 
 static struct target_type stripe_target = {
 	.name   = "striped",
-	.version= {1, 0, 1},
+	.version= {1, 0, 2},
 	.module = THIS_MODULE,
 	.ctr    = stripe_ctr,
 	.dtr    = stripe_dtr,
