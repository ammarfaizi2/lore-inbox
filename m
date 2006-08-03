Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWHCSvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWHCSvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWHCSvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:51:50 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:52628 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S964846AbWHCSvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:51:49 -0400
Subject: [Patch] percpu_alloc: correct function prototypes
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 03 Aug 2006 20:51:28 +0200
Message-Id: <1154631088.2963.9.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects a couple of inconsistencies regarding percpu_*()
function prototypes (type and name of parameters), which didn't cause
any harm, though.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 percpu.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -ur a/include/linux/percpu.h b/include/linux/percpu.h
--- a/include/linux/percpu.h	29 Jul 2006 11:38:25 -0000	1.10
+++ b/include/linux/percpu.h	29 Jul 2006 13:13:09 -0000	1.11
@@ -41,7 +41,7 @@
 extern int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
 				cpumask_t mask);
 extern void percpu_depopulate_mask(void *__pdata, cpumask_t mask);
-extern void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t map);
+extern void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t mask);
 extern void percpu_free(void *__pdata);
 
 #else /* CONFIG_SMP */
@@ -63,12 +63,12 @@
 }
 
 static inline int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
-				       int cpu)
+				       cpumask_t mask)
 {
 	return 0;
 }
 
-static inline void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t map)
+static inline void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t mask)
 {
 	return kzalloc(size, gfp);
 }


