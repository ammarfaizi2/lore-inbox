Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbTFSD7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265386AbTFSD5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:57:39 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:56196 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265399AbTFSD4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:56:51 -0400
Date: Wed, 18 Jun 2003 23:47:44 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234744.GJ333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618234418.GC333@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1421  -> 1.1422 
#	drivers/pnp/support.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1422
# [PNP] Important Resource Parsing Fixes
# 
# In some cases, we're reading the wrong bits for large tags.  This patch corrects
# the issue by setting the affected bits forward by an offset of 2 (skipping over
# the size portion of the tag).
# --------------------------------------------
#
diff -Nru a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Wed Jun 18 23:01:17 2003
+++ b/drivers/pnp/support.c	Wed Jun 18 23:01:17 2003
@@ -257,11 +257,11 @@
 	mem = pnp_alloc(sizeof(struct pnp_mem));
 	if (!mem)
 		return;
-	mem->min = ((p[3] << 8) | p[2]) << 8;
-	mem->max = ((p[5] << 8) | p[4]) << 8;
-	mem->align = (p[7] << 8) | p[6];
-	mem->size = ((p[9] << 8) | p[8]) << 8;
-	mem->flags = p[1];
+	mem->min = ((p[5] << 8) | p[4]) << 8;
+	mem->max = ((p[7] << 8) | p[6]) << 8;
+	mem->align = (p[9] << 8) | p[8];
+	mem->size = ((p[11] << 8) | p[10]) << 8;
+	mem->flags = p[3];
 	pnp_register_mem_resource(option,mem);
 	return;
 }
@@ -272,11 +272,11 @@
 	mem = pnp_alloc(sizeof(struct pnp_mem));
 	if (!mem)
 		return;
-	mem->min = (p[5] << 24) | (p[4] << 16) | (p[3] << 8) | p[2];
-	mem->max = (p[9] << 24) | (p[8] << 16) | (p[7] << 8) | p[6];
-	mem->align = (p[13] << 24) | (p[12] << 16) | (p[11] << 8) | p[10];
-	mem->size = (p[17] << 24) | (p[16] << 16) | (p[15] << 8) | p[14];
-	mem->flags = p[1];
+	mem->min = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
+	mem->max = (p[11] << 24) | (p[10] << 16) | (p[9] << 8) | p[8];
+	mem->align = (p[15] << 24) | (p[14] << 16) | (p[13] << 8) | p[12];
+	mem->size = (p[19] << 24) | (p[18] << 16) | (p[17] << 8) | p[16];
+	mem->flags = p[3];
 	pnp_register_mem_resource(option,mem);
 	return;
 }
@@ -287,10 +287,10 @@
 	mem = pnp_alloc(sizeof(struct pnp_mem));
 	if (!mem)
 		return;
-	mem->min = mem->max = (p[5] << 24) | (p[4] << 16) | (p[3] << 8) | p[2];
-	mem->size = (p[9] << 24) | (p[8] << 16) | (p[7] << 8) | p[6];
+	mem->min = mem->max = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
+	mem->size = (p[11] << 24) | (p[10] << 16) | (p[9] << 8) | p[8];
 	mem->align = 0;
-	mem->flags = p[1];
+	mem->flags = p[3];
 	pnp_register_mem_resource(option,mem);
 	return;
 }
@@ -486,12 +486,12 @@
 {
 	unsigned long base = res->start;
 	unsigned long len = res->end - res->start + 1;
-	p[2] = (base >> 8) & 0xff;
-	p[3] = ((base >> 8) >> 8) & 0xff;
 	p[4] = (base >> 8) & 0xff;
 	p[5] = ((base >> 8) >> 8) & 0xff;
-	p[8] = (len >> 8) & 0xff;
-	p[9] = ((len >> 8) >> 8) & 0xff;
+	p[6] = (base >> 8) & 0xff;
+	p[7] = ((base >> 8) >> 8) & 0xff;
+	p[10] = (len >> 8) & 0xff;
+	p[11] = ((len >> 8) >> 8) & 0xff;
 	return;
 }
 
@@ -499,32 +499,32 @@
 {
 	unsigned long base = res->start;
 	unsigned long len = res->end - res->start + 1;
-	p[2] = base & 0xff;
-	p[3] = (base >> 8) & 0xff;
-	p[4] = (base >> 16) & 0xff;
-	p[5] = (base >> 24) & 0xff;
-	p[6] = base & 0xff;
-	p[7] = (base >> 8) & 0xff;
-	p[8] = (base >> 16) & 0xff;
-	p[9] = (base >> 24) & 0xff;
-	p[14] = len & 0xff;
-	p[15] = (len >> 8) & 0xff;
-	p[16] = (len >> 16) & 0xff;
-	p[17] = (len >> 24) & 0xff;
+	p[4] = base & 0xff;
+	p[5] = (base >> 8) & 0xff;
+	p[6] = (base >> 16) & 0xff;
+	p[7] = (base >> 24) & 0xff;
+	p[8] = base & 0xff;
+	p[9] = (base >> 8) & 0xff;
+	p[10] = (base >> 16) & 0xff;
+	p[11] = (base >> 24) & 0xff;
+	p[16] = len & 0xff;
+	p[17] = (len >> 8) & 0xff;
+	p[18] = (len >> 16) & 0xff;
+	p[19] = (len >> 24) & 0xff;
 	return;
 }
 
 static void write_fixed_mem32(unsigned char *p, struct resource * res)
 {	unsigned long base = res->start;
 	unsigned long len = res->end - res->start + 1;
-	p[2] = base & 0xff;
-	p[3] = (base >> 8) & 0xff;
-	p[4] = (base >> 16) & 0xff;
-	p[5] = (base >> 24) & 0xff;
-	p[6] = len & 0xff;
-	p[7] = (len >> 8) & 0xff;
-	p[8] = (len >> 16) & 0xff;
-	p[9] = (len >> 24) & 0xff;
+	p[4] = base & 0xff;
+	p[5] = (base >> 8) & 0xff;
+	p[6] = (base >> 16) & 0xff;
+	p[7] = (base >> 24) & 0xff;
+	p[8] = len & 0xff;
+	p[9] = (len >> 8) & 0xff;
+	p[10] = (len >> 16) & 0xff;
+	p[11] = (len >> 24) & 0xff;
 	return;
 }
 
