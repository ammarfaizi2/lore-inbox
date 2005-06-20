Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVFTXAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVFTXAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVFTXAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:00:32 -0400
Received: from coderock.org ([193.77.147.115]:23961 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261747AbVFTVzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:48 -0400
Message-Id: <20050620215156.762797000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:57 +0200
From: domen@coderock.org
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 1/1] backend.c - vfree() checking cleanups
Content-Disposition: inline; filename=vfree-drivers_char_agp_backend.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: jlamanna@gmail.com



backend.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 backend.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: quilt/drivers/char/agp/backend.c
===================================================================
--- quilt.orig/drivers/char/agp/backend.c
+++ quilt/drivers/char/agp/backend.c
@@ -206,10 +206,9 @@ static void agp_backend_cleanup(struct a
 		bridge->driver->cleanup();
 	if (bridge->driver->free_gatt_table)
 		bridge->driver->free_gatt_table(bridge);
-	if (bridge->key_list) {
-		vfree(bridge->key_list);
-		bridge->key_list = NULL;
-	}
+
+	vfree(bridge->key_list);
+	bridge->key_list = NULL;
 
 	if (bridge->driver->agp_destroy_page &&
 	    bridge->driver->needs_scratch_page)

--
