Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWCWWJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWCWWJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWCWWJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:09:04 -0500
Received: from mail.gmx.de ([213.165.64.20]:31974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932483AbWCWWJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:09:02 -0500
X-Authenticated: #704063
Subject: Re: [Patch] Fix compilation for sound/oss/vwsnd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1143151469.13816.1.camel@alice>
References: <1143151469.13816.1.camel@alice>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 23:09:01 +0100
Message-Id: <1143151741.14516.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry,

fixed patch below between all the switching i forgot to remove
the declaration in li_create()

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.16-git6/sound/oss/vwsnd.c	2006-03-23 23:07:15.000000000 +0100
+++ linux-2.6.16-git6.new/sound/oss/vwsnd.c	2006-03-23 23:07:32.000000000 +0100
@@ -247,27 +247,6 @@ typedef struct lithium {
 } lithium_t;
 
 /*
- * li_create initializes the lithium_t structure and sets up vm mappings
- * to access the registers.
- * Returns 0 on success, -errno on failure.
- */
-
-static int __init li_create(lithium_t *lith, unsigned long baseaddr)
-{
-	static void li_destroy(lithium_t *);
-
-	spin_lock_init(&lith->lock);
-	lith->page0 = ioremap_nocache(baseaddr + LI_PAGE0_OFFSET, PAGE_SIZE);
-	lith->page1 = ioremap_nocache(baseaddr + LI_PAGE1_OFFSET, PAGE_SIZE);
-	lith->page2 = ioremap_nocache(baseaddr + LI_PAGE2_OFFSET, PAGE_SIZE);
-	if (!lith->page0 || !lith->page1 || !lith->page2) {
-		li_destroy(lith);
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-/*
  * li_destroy destroys the lithium_t structure and vm mappings.
  */
 
@@ -288,6 +267,25 @@ static void li_destroy(lithium_t *lith)
 }
 
 /*
+ * li_create initializes the lithium_t structure and sets up vm mappings
+ * to access the registers.
+ * Returns 0 on success, -errno on failure.
+ */
+
+static int __init li_create(lithium_t *lith, unsigned long baseaddr)
+{
+	spin_lock_init(&lith->lock);
+	lith->page0 = ioremap_nocache(baseaddr + LI_PAGE0_OFFSET, PAGE_SIZE);
+	lith->page1 = ioremap_nocache(baseaddr + LI_PAGE1_OFFSET, PAGE_SIZE);
+	lith->page2 = ioremap_nocache(baseaddr + LI_PAGE2_OFFSET, PAGE_SIZE);
+	if (!lith->page0 || !lith->page1 || !lith->page2) {
+		li_destroy(lith);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/*
  * basic register accessors - read/write long/byte
  */
 


