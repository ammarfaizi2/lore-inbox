Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVIVUxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVIVUxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVIVUxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:53:53 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:10683 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751185AbVIVUxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:53:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH][Fix] swsusp: do not trigger BUG_ON() if there is not enough memory
Date: Thu, 22 Sep 2005 22:54:03 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509222254.03386.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch makes swsusp avoid triggering the BUG_ON() in swsusp_suspend()
if there is not enough memory for suspend.  Please apply.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc2.orig/kernel/power/swsusp.c	2005-09-22 22:22:39.000000000 +0200
+++ linux-2.6.14-rc2/kernel/power/swsusp.c	2005-09-22 22:23:10.000000000 +0200
@@ -918,6 +918,7 @@
 
 	pagedir_nosave = NULL;
 	nr_copy_pages = calc_nr(nr_copy_pages);
+	nr_copy_pages_check = nr_copy_pages;
 
 	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
 		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
@@ -940,7 +941,6 @@
 		return error;
 	}
 
-	nr_copy_pages_check = nr_copy_pages;
 	return 0;
 }
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
