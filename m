Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUFIPcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUFIPcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUFIPcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:32:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20442 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266166AbUFIPbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:31:00 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 3/5: Fix error cleanup in dm_create_persistent()
Date: Wed, 9 Jun 2004 10:31:52 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091031.52249.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-exception-store.c: Fix error cleanup in dm_create_persistent().
This was originally found by chrisw during code review.

From: Dave Olien <dmo@osdl.org>
Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-exception-store.c	2004-06-09 08:47:09.210467016 +0000
+++ source/drivers/md/dm-exception-store.c	2004-06-09 08:49:14.167470664 +0000
@@ -569,8 +569,8 @@
       bad:
 	dm_io_put(sectors_to_pages(chunk_size));
 	if (ps) {
-		if (ps->callbacks)
-			vfree(ps->callbacks);
+		if (ps->area)
+			free_area(ps);
 
 		kfree(ps);
 	}
