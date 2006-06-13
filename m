Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbWFMAe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWFMAe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWFMAef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:34:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:45518 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932691AbWFMAe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:29 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/16] 64bit resource: introduce resource_size_t for the start and end of struct resource
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:13 -0700
Message-Id: <11501587153872-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501587122736-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com> <11501586982289-git-send-email-greg@kroah.com> <11501587011194-git-send-email-greg@kroah.com> <11501587043722-git-send-email-greg@kroah.com> <11501587082203-git-send-email-greg@kroah.com> <11501587122736-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

But do not change it from what it currently is (unsigned long)

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
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
index 1046c7a..047eb8b 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -178,6 +178,8 @@ #endif
 
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
+
+typedef unsigned long resource_size_t;
 #endif
 
 struct ustat {
-- 
1.4.0

