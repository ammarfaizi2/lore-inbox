Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWDRWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWDRWHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDRWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:07:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5642 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750744AbWDRWHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:07:25 -0400
Date: Wed, 19 Apr 2006 00:07:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled unexport of insert_resource
Message-ID: <20060418220724.GS11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled unexport of insert_resource.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Apr 2006

 Documentation/feature-removal-schedule.txt |    8 --------
 include/linux/ioport.h                     |    2 +-
 kernel/resource.c                          |    2 --
 3 files changed, 1 insertion(+), 11 deletions(-)

--- linux-2.6.17-rc1-mm2-full/Documentation/feature-removal-schedule.txt.old	2006-04-10 20:52:23.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/Documentation/feature-removal-schedule.txt	2006-04-10 20:52:36.000000000 +0200
@@ -72,14 +72,6 @@
 
 ---------------------------
 
-What:	remove EXPORT_SYMBOL(insert_resource)
-When:	April 2006
-Files:	kernel/resource.c
-Why:	No modular usage in the kernel.
-Who:	Adrian Bunk <bunk@stusta.de>
-
----------------------------
-
 What:	PCMCIA control ioctl (needed for pcmcia-cs [cardmgr, cardctl])
 When:	November 2005
 Files:	drivers/pcmcia/: pcmcia_ioctl.c
--- linux-2.6.17-rc1-mm2-full/include/linux/ioport.h.old	2006-04-10 20:52:46.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/linux/ioport.h	2006-04-10 20:52:55.000000000 +0200
@@ -95,7 +95,7 @@
 extern int request_resource(struct resource *root, struct resource *new);
 extern struct resource * ____request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
-extern __deprecated_for_modules int insert_resource(struct resource *parent, struct resource *new);
+extern int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     u64 size,
 			     u64 min, u64 max,
--- linux-2.6.17-rc1-mm2-full/kernel/resource.c.old	2006-04-10 20:53:04.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/kernel/resource.c	2006-04-10 20:53:11.000000000 +0200
@@ -381,8 +381,6 @@
 	return result;
 }
 
-EXPORT_SYMBOL(insert_resource);
-
 /*
  * Given an existing resource, change its start and size to match the
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of

