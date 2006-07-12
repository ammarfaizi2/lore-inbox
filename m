Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWGLXbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWGLXbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWGLXbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:31:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:10469 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932468AbWGLXaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:30:52 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/5] [PATCH] The scheduled unexport of insert_resource
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:26:54 -0700
Message-Id: <11527468263212-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11527468231110-git-send-email-greg@kroah.com>
References: <20060712232343.GA22672@kroah.com> <1152746814664-git-send-email-greg@kroah.com> <11527468173384-git-send-email-greg@kroah.com> <11527468203373-git-send-email-greg@kroah.com> <11527468231110-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

Implement the scheduled unexport of insert_resource.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/feature-removal-schedule.txt |    8 --------
 include/linux/ioport.h                     |    2 +-
 kernel/resource.c                          |    2 --
 3 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index ee28798..47d714d 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -55,14 +55,6 @@ Who:	Mauro Carvalho Chehab <mchehab@brtu
 
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
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5612dfe..d42c833 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -97,7 +97,7 @@ extern struct resource iomem_resource;
 extern int request_resource(struct resource *root, struct resource *new);
 extern struct resource * ____request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
-extern __deprecated_for_modules int insert_resource(struct resource *parent, struct resource *new);
+extern int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     resource_size_t size, resource_size_t min,
 			     resource_size_t max, resource_size_t align,
diff --git a/kernel/resource.c b/kernel/resource.c
index 129cf04..0dd3a85 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -404,8 +404,6 @@ int insert_resource(struct resource *par
 	return result;
 }
 
-EXPORT_SYMBOL(insert_resource);
-
 /*
  * Given an existing resource, change its start and size to match the
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of
-- 
1.4.1

