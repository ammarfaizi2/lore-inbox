Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVFWH6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVFWH6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVFWHzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:55:23 -0400
Received: from [24.22.56.4] ([24.22.56.4]:11750 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262244AbVFWGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:40 -0400
Message-Id: <20050623061800.281028000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:22 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 30/38] CKRM e18: use sizeof instead of #define for the array size in taskclass
Content-Disposition: inline; filename=use_sizeof_instead_of_define_for_the_array_size_in_taskclass
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While creating the config files for taskclass, instead of using #define
use sizeof so that when the array size changes, things still work as
expected.

Note: Socketclass already follows this model.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Gerrit Huizenga <gh@us.ibm.com>

Index: linux-2.6.12-ckrm1/fs/rcfs/tc_magic.c
===================================================================
--- linux-2.6.12-ckrm1.orig/fs/rcfs/tc_magic.c	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/fs/rcfs/tc_magic.c	2005-06-20 15:37:43.000000000 -0700
@@ -34,8 +34,7 @@
 
 #define TC_FILE_MODE (S_IFREG | S_IRUGO | S_IWUSR)
 
-#define NR_TCROOTMF  7
-struct rcfs_magf tc_rootdesc[NR_TCROOTMF] = {
+struct rcfs_magf tc_rootdesc[] = {
 	/* First entry must be root */
 	{
 	/* .name = should not be set, copy from classtype name */
@@ -89,5 +88,5 @@ struct rcfs_magf tc_rootdesc[NR_TCROOTMF
 
 struct rcfs_mfdesc tc_mfdesc = {
 	.rootmf = tc_rootdesc,
-	.rootmflen = NR_TCROOTMF,
+	.rootmflen = (sizeof(tc_rootdesc) / sizeof(struct rcfs_magf)),
 };

--
