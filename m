Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVFUCVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVFUCVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVFUCS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:18:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:31204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261723AbVFTW7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:47 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Fix up USB to use klist_node_attached() instead of list_empty() on lists that will go away.
In-Reply-To: <11193083653258@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <1119308365401@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix up USB to use klist_node_attached() instead of list_empty() on lists that will go away.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Index: gregkh-2.6/drivers/usb/core/usb.c
===================================================================

---
commit d4a7537122fa47a6ce41c5fdab53d844c78d7023
tree e4ae3e20f27497c90fca268260c591f117356a3e
parent 8b0c250be489dcbf1a3a33bb4ec4c7f33735a365
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 13:00:16 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:17 -0700

 drivers/usb/core/usb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -293,7 +293,7 @@ int usb_driver_claim_interface(struct us
 	/* if interface was already added, bind now; else let
 	 * the future device_add() bind it, bypassing probe()
 	 */
-	if (!list_empty (&dev->bus_list))
+	if (!klist_node_attached (&dev->knode_bus))
 		device_bind_driver(dev);
 
 	return 0;
@@ -323,7 +323,7 @@ void usb_driver_release_interface(struct
 		return;
 
 	/* don't disconnect from disconnect(), or before dev_add() */
-	if (!list_empty (&dev->driver_list) && !list_empty (&dev->bus_list))
+	if (!klist_node_attached(&dev->knode_driver) && !klist_node_attached(&dev->knode_bus))
 		device_release_driver(dev);
 
 	dev->driver = NULL;

