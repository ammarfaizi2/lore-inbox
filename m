Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTFBMKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbTFBMKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:10:46 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:12555 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S262223AbTFBMKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:10:44 -0400
Date: Mon, 2 Jun 2003 08:20:17 -0400
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk
Subject: [patch 2.5.70][alpha] compile fix for agp_memory struct definitition change
Message-ID: <20030602082017.A14476@dsnt25.mro.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-OriginalArrivalTime: 27 May 2003 16:29:40.0019 (UTC) FILETIME=[2BBA9830:01C3246D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.70, the agp_memory struct changed from:
   typedef struct agp_memory
to:
   struct agp_memory

This patch propagates that change into include/asm-alpha/agp_backend.h and
arch/alpha/kernel/core_{titan,marvel}.c

/jeff

---
diff -Nuar linux-2.5.70/arch/alpha/kernel/core_marvel.c alpha_agp/arch/alpha/kernel/core_marvel.c
--- linux-2.5.70/arch/alpha/kernel/core_marvel.c	Mon May 26 21:00:22 2003
+++ alpha_agp/arch/alpha/kernel/core_marvel.c	Tue May 27 09:13:14 2003
@@ -980,7 +980,7 @@
 }
 
 static int 
-marvel_agp_bind_memory(alpha_agp_info *agp, off_t pg_start, agp_memory *mem)
+marvel_agp_bind_memory(alpha_agp_info *agp, off_t pg_start, struct agp_memory *mem)
 {
 	struct marvel_agp_aperture *aper = agp->aperture.sysdata;
 	return iommu_bind(aper->arena, aper->pg_start + pg_start, 
@@ -988,7 +988,7 @@
 }
 
 static int 
-marvel_agp_unbind_memory(alpha_agp_info *agp, off_t pg_start, agp_memory *mem)
+marvel_agp_unbind_memory(alpha_agp_info *agp, off_t pg_start, struct agp_memory *mem)
 {
 	struct marvel_agp_aperture *aper = agp->aperture.sysdata;
 	return iommu_unbind(aper->arena, aper->pg_start + pg_start,
diff -Nuar linux-2.5.70/arch/alpha/kernel/core_titan.c alpha_agp/arch/alpha/kernel/core_titan.c
--- linux-2.5.70/arch/alpha/kernel/core_titan.c	Mon May 26 21:00:27 2003
+++ alpha_agp/arch/alpha/kernel/core_titan.c	Tue May 27 09:14:12 2003
@@ -679,7 +679,7 @@
 }
 
 static int 
-titan_agp_bind_memory(alpha_agp_info *agp, off_t pg_start, agp_memory *mem)
+titan_agp_bind_memory(alpha_agp_info *agp, off_t pg_start, struct agp_memory *mem)
 {
 	struct titan_agp_aperture *aper = agp->aperture.sysdata;
 	return iommu_bind(aper->arena, aper->pg_start + pg_start, 
@@ -687,7 +687,7 @@
 }
 
 static int 
-titan_agp_unbind_memory(alpha_agp_info *agp, off_t pg_start, agp_memory *mem)
+titan_agp_unbind_memory(alpha_agp_info *agp, off_t pg_start, struct agp_memory *mem)
 {
 	struct titan_agp_aperture *aper = agp->aperture.sysdata;
 	return iommu_unbind(aper->arena, aper->pg_start + pg_start,
diff -Nuar linux-2.5.70/include/asm-alpha/agp_backend.h alpha_agp/include/asm-alpha/agp_backend.h
--- linux-2.5.70/include/asm-alpha/agp_backend.h	Mon May 26 21:00:19 2003
+++ alpha_agp/include/asm-alpha/agp_backend.h	Tue May 27 09:12:28 2003
@@ -33,8 +33,8 @@
 	int (*setup)(alpha_agp_info *);
 	void (*cleanup)(alpha_agp_info *);
 	int (*configure)(alpha_agp_info *);
-	int (*bind)(alpha_agp_info *, off_t, agp_memory *);
-	int (*unbind)(alpha_agp_info *, off_t, agp_memory *);
+	int (*bind)(alpha_agp_info *, off_t, struct agp_memory *);
+	int (*unbind)(alpha_agp_info *, off_t, struct agp_memory *);
 	unsigned long (*translate)(alpha_agp_info *, dma_addr_t);
 };
 
