Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTIOW5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTIOW5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:57:35 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:63180 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP id S261648AbTIOW5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:57:30 -0400
Date: Mon, 15 Sep 2003 17:57:19 -0500
From: Stuart Hayes <Stuart_Hayes@dell.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide-tape locks up when loaded in kernel 2.4.22
Message-ID: <20030915225719.GB18225@tux.linuxdev.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending patch... the text got mangled on the last message.
Thanks
Stuart
Stuart_Hayes@Dell.com



diff -BurN linux-vanilla/drivers/ide/ide-tape.c linux-idetape-quickpatch/drivers/ide/ide-tape.c
--- linux-vanilla/drivers/ide/ide-tape.c	2003-06-13 09:51:33.000000000 -0500
+++ linux-idetape-quickpatch/drivers/ide/ide-tape.c	2003-09-15 13:08:36.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-tape.c		Version 1.17b	Dec, 2002
+ * linux/drivers/ide/ide-tape.c		Version 1.17c	Sep, 2003
  *
  * Copyright (C) 1995 - 1999 Gadi Oxman <gadio@netvision.net.il>
  *
@@ -313,6 +313,9 @@
  *			Cosmetic fixes to miscellaneous debugging output messages.
  *			Set the minimum /proc/ide/hd?/settings values for "pipeline",
  *			 "pipeline_min", and "pipeline_max" to 1.
+ * Ver 1.17c Sep 2003	Stuart Hayes <stuart_hayes@dell.com>
+ *			Initialized "feature" in idetape_issue_packet_command
+ *			 (this was causing lockups on certain systems)
  *
  * Here are some words from the first releases of hd.c, which are quoted
  * in ide.c and apply here as well:
@@ -422,7 +425,7 @@
  *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
  */
 
-#define IDETAPE_VERSION "1.17b-ac1"
+#define IDETAPE_VERSION "1.17c"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -2367,6 +2370,8 @@
 	atapi_feature_t feature;
 	atapi_bcount_t bcount;
 
+	feature.all = 0;
+
 #if IDETAPE_DEBUG_BUGS
 	if (tape->pc->c[0] == IDETAPE_REQUEST_SENSE_CMD &&
 	    pc->c[0] == IDETAPE_REQUEST_SENSE_CMD) {
