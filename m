Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265715AbUEZQ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUEZQ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbUEZQ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:58:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52898 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265715AbUEZQ6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:58:23 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 1/5: dm-ioctl.c: fix off-by-one error
Date: Wed, 26 May 2004 11:58:05 -0500
User-Agent: KMail/1.6
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200405261152.33233.kevcorry@us.ibm.com>
In-Reply-To: <200405261152.33233.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405261158.05742.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-ioctl.c: Fix an OB1 error when calculating an output buffer size,
that could cause a missing null termininator in the 'list devices'
ioctl results.  [Steffan Paletta]

--- diff/drivers/md/dm-ioctl.c	2004-05-09 21:32:26.000000000 -0500
+++ source/drivers/md/dm-ioctl.c	2004-05-25 10:13:20.000000000 -0500
@@ -377,7 +377,7 @@
 	for (i = 0; i < NUM_BUCKETS; i++) {
 		list_for_each_entry (hc, _name_buckets + i, name_list) {
 			needed += sizeof(struct dm_name_list);
-			needed += strlen(hc->name);
+			needed += strlen(hc->name) + 1;
 			needed += ALIGN_MASK;
 		}
 	}
