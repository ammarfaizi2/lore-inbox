Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWINVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWINVsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWINVsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:48:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751224AbWINVsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:48:15 -0400
Date: Thu, 14 Sep 2006 22:48:06 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Bryn Reeves <breeves@redhat.com>
Subject: [PATCH 16/25] dm: add debug macro
Message-ID: <20060914214806.GX3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Bryn Reeves <breeves@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryn Reeves <breeves@redhat.com>

Add CONFIG_DM_DEBUG and DMDEBUG() macro.

Signed-off-by: Bryn Reeves <breeves@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/Kconfig
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/Kconfig	2006-09-14 20:20:55.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/Kconfig	2006-09-14 21:00:46.000000000 +0100
@@ -199,6 +199,14 @@ config BLK_DEV_DM
 
 	  If unsure, say N.
 
+config DM_DEBUG
+	boolean "Device mapper debugging support"
+	depends on BLK_DEV_DM && EXPERIMENTAL
+	---help---
+	  Enable this for messages that may help debug device-mapper problems.
+
+	  If unsure, say N.
+
 config DM_CRYPT
 	tristate "Crypt target support"
 	depends on BLK_DEV_DM && EXPERIMENTAL
Index: linux-2.6.18-rc7/drivers/md/dm.h
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm.h	2006-09-14 20:20:55.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm.h	2006-09-14 21:00:46.000000000 +0100
@@ -21,6 +21,11 @@
 #define DMERR(f, arg...) printk(KERN_ERR DM_NAME ": " DM_MSG_PREFIX ": " f "\n", ## arg)
 #define DMWARN(f, arg...) printk(KERN_WARNING DM_NAME ": " DM_MSG_PREFIX ": " f "\n", ## arg)
 #define DMINFO(f, arg...) printk(KERN_INFO DM_NAME ": " DM_MSG_PREFIX ": " f "\n", ## arg)
+#ifdef CONFIG_DM_DEBUG
+#  define DMDEBUG(f, arg...) printk(KERN_DEBUG DM_NAME ": " DM_MSG_PREFIX " DEBUG: " f "\n", ## arg)
+#else
+#  define DMDEBUG(f, arg...) do {} while (0)
+#endif
 
 #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
 			  0 : scnprintf(result + sz, maxlen - sz, x))
