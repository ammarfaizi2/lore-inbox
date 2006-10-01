Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWJAUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWJAUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWJAUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:31:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:53218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932327AbWJAUb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:31:57 -0400
X-Authenticated: #704063
Subject: [Patch] Dereference in drivers/scsi/lpfc/lpfc_ct.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: james.smart@emulex.com
Content-Type: text/plain
Date: Sun, 01 Oct 2006 22:31:46 +0200
Message-Id: <1159734706.11887.6.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

if we fail to allocate mp->virt during the first while
loop iteration, mlist is still uninitialized, therefore
we should check if before dereferencing.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git16/drivers/scsi/lpfc/lpfc_ct.c.orig	2006-10-01 22:28:37.000000000 +0200
+++ linux-2.6.18-git16/drivers/scsi/lpfc/lpfc_ct.c	2006-10-01 22:29:10.000000000 +0200
@@ -188,7 +188,8 @@ lpfc_alloc_ct_rsp(struct lpfc_hba * phba
 
 		if (!mp->virt) {
 			kfree(mp);
-			lpfc_free_ct_rsp(phba, mlist);
+			if (mlist)
+				lpfc_free_ct_rsp(phba, mlist);
 			return NULL;
 		}
 


