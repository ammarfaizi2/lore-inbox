Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265718AbUEZRAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUEZRAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUEZRAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:00:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44428 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265718AbUEZQ7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:59:35 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 5/5: dm-table.c: proper usage of dm_vcalloc
Date: Wed, 26 May 2004 11:59:23 -0500
User-Agent: KMail/1.6
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200405261152.33233.kevcorry@us.ibm.com>
In-Reply-To: <200405261152.33233.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405261159.23033.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-table.c: Proper usage of dm_vcalloc. [Dave Olien]

--- diff/drivers/md/dm-table.c	2004-05-09 21:33:21.000000000 -0500
+++ source/drivers/md/dm-table.c	2004-05-25 11:03:14.000000000 -0500
@@ -181,8 +181,8 @@
 	/*
 	 * Allocate both the target array and offset array at once.
 	 */
-	n_highs = (sector_t *) dm_vcalloc(sizeof(struct dm_target) +
-					  sizeof(sector_t), num);
+	n_highs = (sector_t *) dm_vcalloc(num, sizeof(struct dm_target) +
+					  sizeof(sector_t));
 	if (!n_highs)
 		return -ENOMEM;
 
