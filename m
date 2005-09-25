Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVIYSpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVIYSpr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 14:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVIYSp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 14:45:28 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:3526 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932262AbVIYSpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 14:45:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/3][Fix] swsusp: prevent possible memory leak
Date: Sun, 25 Sep 2005 20:30:04 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200509252018.36867.rjw@sisk.pl>
In-Reply-To: <200509252018.36867.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509252030.04712.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch prevents swsusp from leaking some memory in case of
an error in read_pagedir().  It also prevents the BUG_ON() from triggering
if there's an error while reading swap.

Please apply,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc2-git3.orig/kernel/power/swsusp.c	2005-09-25 18:49:00.000000000 +0200
+++ linux-2.6.14-rc2-git3/kernel/power/swsusp.c	2005-09-25 18:52:48.000000000 +0200
@@ -1437,9 +1437,9 @@
 	}
 
 	if (error)
-		free_page((unsigned long)pblist);
-
-	BUG_ON(i != swsusp_info.pagedir_pages);
+		free_pagedir(pblist);
+	else
+		BUG_ON(i != swsusp_info.pagedir_pages);
 
 	return error;
 }

