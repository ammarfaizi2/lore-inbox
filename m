Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVFWGrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVFWGrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVFWGpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:45:53 -0400
Received: from [24.22.56.4] ([24.22.56.4]:28902 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262329AbVFWGTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:02 -0400
Message-Id: <20050623061755.954580000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:01 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 09/38] CKRM e18: Add missing read_unlock
Content-Disposition: inline; filename=03a-missing_unlock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function returns without unlocking the readlock in a case.
This patch fixes it.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 ckrm.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm.c	2005-06-20 13:08:29.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm.c	2005-06-20 13:08:36.000000000 -0700
@@ -106,6 +106,7 @@ void *ckrm_classobj(char *classname, int
 			if (core->name && !strcmp(core->name, classname)) {
 				/* FIXME:   should grep reference. */
 				*classtype_id = ctype->type_id;
+				read_unlock(&ckrm_class_lock);
 				return core;
 			}
 		}

--
