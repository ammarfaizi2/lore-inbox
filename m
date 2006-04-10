Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWDJWO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWDJWO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWDJWO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:14:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16402 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932075AbWDJWO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:14:56 -0400
Date: Tue, 11 Apr 2006 00:14:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>,
       Greg KH <greg@kroah.com>
Subject: [2.6 patch] the scheduled unexport of insert_resource
Message-ID: <20060410221455.GH2408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled unexport of insert_resource.

Kumar Gala said that some not yet submitted code uses it [1], but since 
there is after one month still no code submission, and reverting the 
exporting it again is trivial if it is both submitted and considered 
acceptable for inclusion this shouldn't be a problem.

[1] http://lkml.org/lkml/2006/4/1/28

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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

