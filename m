Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbWF0Qma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbWF0Qma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWF0Qhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:45 -0400
Received: from ns1.suse.de ([195.135.220.2]:30166 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161182AbWF0Qhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:41 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 11/17] [PATCH] 64bit resource: introduce resource_size_t for the start and end of struct resource
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:47 -0700
Message-Id: <11514260692919-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260651070-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com> <11514260612035-git-send-email-greg@kroah.com> <11514260651070-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

But do not change it from what it currently is (unsigned long)

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/ioport.h |    4 +++-
 include/linux/types.h  |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index cd6bd00..535bd95 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -9,13 +9,15 @@ #ifndef _LINUX_IOPORT_H
 #define _LINUX_IOPORT_H
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
  */
 struct resource {
+	resource_size_t start;
+	resource_size_t end;
 	const char *name;
-	unsigned long start, end;
 	unsigned long flags;
 	struct resource *parent, *sibling, *child;
 };
diff --git a/include/linux/types.h b/include/linux/types.h
index a5e46e7..a021e15 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -177,6 +177,8 @@ #endif
 
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
+
+typedef unsigned long resource_size_t;
 #endif
 
 struct ustat {
-- 
1.4.0

