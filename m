Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUDWWGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUDWWGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUDWWGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:06:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:30359 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261498AbUDWWGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:06:02 -0400
Date: Fri, 23 Apr 2004 15:08:06 -0700
From: Dave Olien <dmo@osdl.org>
To: linux-lvm@redhat.com, linux-kernel@vger.kernel.org
Cc: thornber@redhat.com
Subject: [PATCH] trivial patch to trivial patch to dm-table.c
Message-ID: <20040423220806.GA29188@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, Joe

Here's a trivial patch to call to dm_vcalloc().  The patch doesn't
actually change the behavior of the code.  But I think this change
makes the call more in the spirit of the declaration for dm_vcallc().

this is to your latest udm1 patch to 2.6.6-rc2.


diff -ur rc2-mm1-UDM1-original/drivers/md/dm-table.c rc2-mm1-UDM1-patched/drivers/md/dm-table.c
--- rc2-mm1-UDM1-original/drivers/md/dm-table.c	2004-04-23 14:53:20.000000000 -0700
+++ rc2-mm1-UDM1-patched/drivers/md/dm-table.c	2004-04-23 14:57:20.000000000 -0700
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
 

