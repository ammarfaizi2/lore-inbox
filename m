Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUAOVwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUAOVwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:52:38 -0500
Received: from AGrenoble-101-1-1-214.w193-251.abo.wanadoo.fr ([193.251.23.214]:52712
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S262652AbUAOVwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:52:37 -0500
Subject: [PATCH] bug waiting to happen in rq_for_each_bio
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074203537.20197.77.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 22:52:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug would have been caught at compile time anyway, unless somebody
uses a weird name for bio.

--- ./include/linux/blkdev.h.orig       2004-01-15 22:43:29.000000000 +0100
+++ ./include/linux/blkdev.h    2004-01-15 22:44:23.000000000 +0100
@@ -493,9 +493,9 @@
 }
 #endif /* CONFIG_MMU */
  
-#define rq_for_each_bio(bio, rq)       \
+#define rq_for_each_bio(_bio, rq)      \
        if ((rq->bio))                  \
-               for (bio = (rq)->bio; bio; bio = bio->bi_next)
+               for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
  
 struct sec_size {
        unsigned block_size;


