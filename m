Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWDRPGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWDRPGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWDRPGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:06:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49925 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932260AbWDRPGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:06:11 -0400
Date: Tue, 18 Apr 2006 17:06:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: minyard@mvista.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/ipmi/ipmi_msghandler.c: make proc_ipmi_root static
Message-ID: <20060418150609.GF11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global struct proc_ipmi_root static.

Besides this, it removes an unused #ifdef CONFIG_PROC_FS from 
include/linux/ipmi.h.

---

This patch was already sent on:
- 13 Apr 2006

BTW: Please add an entry for IPMI to MAINTAINERS.

 drivers/char/ipmi/ipmi_msghandler.c |    3 +--
 include/linux/ipmi.h                |    4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

--- linux-2.6.17-rc1-mm2-full/include/linux/ipmi.h.old	2006-04-12 22:32:08.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/linux/ipmi.h	2006-04-12 22:32:20.000000000 +0200
@@ -210,11 +210,7 @@
  */
 #include <linux/list.h>
 #include <linux/module.h>
-
-#ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
-extern struct proc_dir_entry *proc_ipmi_root;
-#endif /* CONFIG_PROC_FS */
 
 /* Opaque type for a IPMI message user.  One of these is needed to
    send and receive messages. */
--- linux-2.6.17-rc1-mm2-full/drivers/char/ipmi/ipmi_msghandler.c.old	2006-04-12 22:32:29.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/char/ipmi/ipmi_msghandler.c	2006-04-12 22:32:45.000000000 +0200
@@ -57,8 +57,7 @@
 static int initialized = 0;
 
 #ifdef CONFIG_PROC_FS
-struct proc_dir_entry *proc_ipmi_root = NULL;
-EXPORT_SYMBOL(proc_ipmi_root);
+static struct proc_dir_entry *proc_ipmi_root = NULL;
 #endif /* CONFIG_PROC_FS */
 
 #define MAX_EVENTS_IN_QUEUE	25

