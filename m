Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283462AbRK3B6R>; Thu, 29 Nov 2001 20:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283464AbRK3B6H>; Thu, 29 Nov 2001 20:58:07 -0500
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.23]:32692 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S283462AbRK3B5z>; Thu, 29 Nov 2001 20:57:55 -0500
Date: Thu, 29 Nov 2001 20:57:28 -0500
From: Alex Valys <avalys@optonline.net>
Subject: PATCH: Replaces bio_size macro in drivers/block/rd.c
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Message-id: <0GNL00GN0C3GX3@mta8.srv.hcvlny.cv.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found an unresolved symbol in rd.c while compiling 2.5.1-pre4.   


--- drivers/block/rd.c     Thu Nov 29 20:50:17 2001
+++ drivers/block/rd.c  Thu Nov 29 20:51:30 2001
@@ -239,7 +239,7 @@

        index = sbh->bi_sector >> (PAGE_CACHE_SHIFT - 9);
        offset = (sbh->bi_sector << 9) & ~PAGE_CACHE_MASK;
-       size = bio_size(sbh);
+       size = sbh->bi_size;

        do {
                int count;
@@ -323,7 +323,7 @@
                goto fail;

        offset = sbh->bi_sector << 9;
-       len = bio_size(sbh);
+       len = sbh->bi_size;

        if ((offset + len) > rd_length[minor])
                goto fail;


