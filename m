Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVEETOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVEETOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVEETOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:14:23 -0400
Received: from c-24-22-18-178.hsd1.or.comcast.net ([24.22.18.178]:48785 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262189AbVEES3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:29:16 -0400
Message-Id: <20050505180931.142189000@us.ibm.com>
References: <20050505180731.010896000@us.ibm.com>
Date: Thu, 05 May 2005 11:07:40 -0700
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [patch 09/21] CKRM: Add missing read_unlock
From: gh@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Content-Disposition: inline; filename=03a-missing_unlock


Function returns without unlocking the readlock in a case.
This patch fixes it.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 ckrm.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm.c
===================================================================
--- linux-2.6.12-rc3-ckrm5.orig/kernel/ckrm/ckrm.c	2005-05-05 09:35:04.000000000 -0700
+++ linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm.c	2005-05-05 09:35:14.000000000 -0700
@@ -106,6 +106,7 @@ void *ckrm_classobj(char *classname, int
 			if (core->name && !strcmp(core->name, classname)) {
 				/* FIXME:   should grep reference. */
 				*classtype_id = ctype->type_id;
+				read_unlock(&ckrm_class_lock);
 				return core;
 			}
 		}

--

