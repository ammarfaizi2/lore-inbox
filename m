Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbUKKRsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUKKRsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbUKKRrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:47:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262301AbUKKRot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:44:49 -0500
Date: Thu, 11 Nov 2004 17:44:44 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: dm-crypt fix for zero-length key
Message-ID: <20041111174444.GB8857@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-crypt fix for zero-length key.

Signed-Off-By: Christophe Saout <christophe@saout.de>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-crypt.c	2004-11-10 15:05:04.000000000 +0000
+++ source/drivers/md/dm-crypt.c	2004-11-10 15:05:24.000000000 +0000
@@ -569,8 +569,8 @@
 	}
 
 	cc->key_size = key_size;
-	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
-	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
+	if ((!key_size && strcmp(argv[1], "-") != 0) ||
+	    (key_size && crypt_decode_key(cc->key, argv[1], key_size) < 0)) {
 		ti->error = PFX "Error decoding key";
 		goto bad1;
 	}
