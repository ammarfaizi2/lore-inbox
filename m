Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUIOLSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUIOLSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUIOLSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:18:20 -0400
Received: from gprs214-49.eurotel.cz ([160.218.214.49]:19585 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264726AbUIOLSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:18:14 -0400
Date: Wed, 15 Sep 2004 13:18:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Untangle code in bio.c
Message-ID: <20040915111802.GA20222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

bio.c uses quite ugly code with goto's, completely
unneccessarily. Please apply,
								Pavel

--- clean-mm/fs/bio.c	2004-09-15 12:58:10.000000000 +0200
+++ linux-mm/fs/bio.c	2004-09-15 13:00:51.000000000 +0200
@@ -143,7 +143,7 @@
 
 	bio = mempool_alloc(bio_pool, gfp_mask);
 	if (unlikely(!bio))
-		goto out;
+		return NULL;
 
 	bio_init(bio);
 
@@ -157,13 +157,11 @@
 noiovec:
 		bio->bi_io_vec = bvl;
 		bio->bi_destructor = bio_destructor;
-out:
 		return bio;
 	}
 
 	mempool_free(bio, bio_pool);
-	bio = NULL;
-	goto out;
+	return NULL;
 }
 
 /**
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
