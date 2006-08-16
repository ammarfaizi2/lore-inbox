Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWHPMIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWHPMIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWHPMIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:08:38 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:34867 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751132AbWHPMIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:08:37 -0400
Date: Wed, 16 Aug 2006 14:08:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [patch] s390: hypfs compiler warnings.
Message-ID: <20060816120834.GE24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] hypfs compiler warnings.

Add casts to avoid compiler warnings.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/hypfs/hypfs_diag.c linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6/arch/s390/hypfs/hypfs_diag.c	2006-08-16 13:36:47.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c	2006-08-16 13:36:47.000000000 +0200
@@ -432,12 +432,14 @@ static int diag204_probe(void)
 
 	buf = diag204_get_buffer(INFO_EXT, &pages);
 	if (!IS_ERR(buf)) {
-		if (diag204(SUBC_STIB7 | INFO_EXT, pages, buf) >= 0) {
+		if (diag204((unsigned long)SUBC_STIB7 |
+			    (unsigned long)INFO_EXT, pages, buf) >= 0) {
 			diag204_store_sc = SUBC_STIB7;
 			diag204_info_type = INFO_EXT;
 			goto out;
 		}
-		if (diag204(SUBC_STIB6 | INFO_EXT, pages, buf) >= 0) {
+		if (diag204((unsigned long)SUBC_STIB6 |
+			    (unsigned long)INFO_EXT, pages, buf) >= 0) {
 			diag204_store_sc = SUBC_STIB7;
 			diag204_info_type = INFO_EXT;
 			goto out;
@@ -452,7 +454,8 @@ static int diag204_probe(void)
 		rc = PTR_ERR(buf);
 		goto fail_alloc;
 	}
-	if (diag204(SUBC_STIB4 | INFO_SIMPLE, pages, buf) >= 0) {
+	if (diag204((unsigned long)SUBC_STIB4 |
+		    (unsigned long)INFO_SIMPLE, pages, buf) >= 0) {
 		diag204_store_sc = SUBC_STIB4;
 		diag204_info_type = INFO_SIMPLE;
 		goto out;
@@ -476,7 +479,8 @@ static void *diag204_store(void)
 	buf = diag204_get_buffer(diag204_info_type, &pages);
 	if (IS_ERR(buf))
 		goto out;
-	if (diag204(diag204_store_sc | diag204_info_type, pages, buf) < 0)
+	if (diag204((unsigned long)diag204_store_sc |
+		    (unsigned long)diag204_info_type, pages, buf) < 0)
 		return ERR_PTR(-ENOSYS);
 out:
 	return buf;
