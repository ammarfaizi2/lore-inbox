Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUFIPaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUFIPaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUFIPaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:30:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:24537 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266163AbUFIPaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:30:20 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 2/5: kcopyd: No need to lock pages
Date: Wed, 9 Jun 2004 10:31:11 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091031.11363.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to lock kcopyd pages.

From: Alasdair Kergon <agk@redhat.com>
Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/kcopyd.c	2004-06-09 08:47:38.850960976 +0000
+++ source/drivers/md/kcopyd.c	2004-06-09 08:47:44.522098832 +0000
@@ -62,13 +62,11 @@
 		return NULL;
 	}
 
-	SetPageLocked(pl->page);
 	return pl;
 }
 
 static void free_pl(struct page_list *pl)
 {
-	ClearPageLocked(pl->page);
 	__free_page(pl->page);
 	kfree(pl);
 }
