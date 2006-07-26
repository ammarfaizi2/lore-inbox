Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWGZPi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWGZPi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWGZPi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:38:57 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:57018
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751540AbWGZPi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:38:56 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] hwrng: fix geode probe error unwind
Date: Wed, 26 Jul 2006 17:37:56 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261737.56481.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The geode hwrng leaks an iomapped resource, if hwrng_register() failes.
This fixes it.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

Index: linux-2.6/drivers/char/hw_random/geode-rng.c
===================================================================
--- linux-2.6.orig/drivers/char/hw_random/geode-rng.c	2006-07-26 17:35:13.000000000 +0200
+++ linux-2.6/drivers/char/hw_random/geode-rng.c	2006-07-26 17:36:52.000000000 +0200
@@ -107,10 +107,14 @@
 	if (err) {
 		printk(KERN_ERR PFX "RNG registering failed (%d)\n",
 		       err);
-		goto out;
+		goto err_unmap;
 	}
 out:
 	return err;
+
+err_unmap:
+	iounmap(mem);
+	goto out;
 }
 
 static void __exit mod_exit(void)

-- 
Greetings Michael.
