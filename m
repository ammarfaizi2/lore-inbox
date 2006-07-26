Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWGZPej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWGZPej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWGZPej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:34:39 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:42169
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751005AbWGZPei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:34:38 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] hwrng: fix intel probe error unwind
Date: Wed, 26 Jul 2006 17:34:19 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607261734.19307.mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The intel hwrng leaks an iomapped resource, if hwrng_register() failes.
This fixes it.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

Index: linux-2.6/drivers/char/hw_random/intel-rng.c
===================================================================
--- linux-2.6.orig/drivers/char/hw_random/intel-rng.c	2006-07-26 17:30:47.000000000 +0200
+++ linux-2.6/drivers/char/hw_random/intel-rng.c	2006-07-26 17:31:51.000000000 +0200
@@ -164,7 +164,7 @@
 	if (err) {
 		printk(KERN_ERR PFX "RNG registering failed (%d)\n",
 		       err);
-		goto out;
+		goto err_unmap;
 	}
 out:
 	return err;

-- 
Greetings Michael.
