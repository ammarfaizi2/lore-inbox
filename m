Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965412AbWI1NHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965412AbWI1NHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965421AbWI1NHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:07:40 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:13738 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965412AbWI1NHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:07:40 -0400
Date: Thu, 28 Sep 2006 15:07:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] hypfs sparse warnings.
Message-ID: <20060928130737.GB1120@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] hypfs sparse warnings.

sparse complains, if we use bitwise operations on enums. Cast enum to
long in order to fix that problem!

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs_diag.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/hypfs/hypfs_diag.c linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6/arch/s390/hypfs/hypfs_diag.c	2006-09-28 14:58:39.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c	2006-09-28 14:58:52.000000000 +0200
@@ -403,7 +403,8 @@ static void *diag204_get_buffer(enum dia
 		*pages = 1;
 		return diag204_alloc_rbuf();
 	} else {/* INFO_EXT */
-		*pages = diag204(SUBC_RSI | INFO_EXT, 0, NULL);
+		*pages = diag204((unsigned long)SUBC_RSI |
+				 (unsigned long)INFO_EXT, 0, NULL);
 		if (*pages <= 0)
 			return ERR_PTR(-ENOSYS);
 		else
