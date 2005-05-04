Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVEDR2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEDR2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEDR0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:26:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56991 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261172AbVEDRNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:13:44 -0400
Date: Wed, 4 May 2005 18:13:37 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Olien <dmo@osdl.org>
Subject: [PATCH] device-mapper dm-emc: Fix a memset
Message-ID: <20050504171337.GT10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Dave Olien <dmo@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dm emc hardware handler code memset the hardware handler
structure to zero AFTER it had initialized the structure's
spinlock field.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Dave Olien <dmo@osdl.org>

--- diff/drivers/md/dm-emc.c	2005-04-21 18:48:40.000000000 +0100
+++ source/drivers/md/dm-emc.c	2005-04-21 18:48:29.000000000 +0100
@@ -223,8 +223,10 @@
 {
 	struct emc_handler *h = kmalloc(sizeof(*h), GFP_KERNEL);
 
-	if (h)
+	if (h) {
+		memset(h, 0, sizeof(*h));
 		spin_lock_init(&h->lock);
+	}
 
 	return h;
 }
@@ -259,8 +261,6 @@
 	if (!h)
 		return -ENOMEM;
 
-	memset(h, 0, sizeof(*h));
-
 	hwh->context = h;
 
 	if ((h->short_trespass = short_trespass))
