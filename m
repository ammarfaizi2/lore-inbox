Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVCYF4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVCYF4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVCYFy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:54:59 -0500
Received: from digitalimplant.org ([64.62.235.95]:3795 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261413AbVCYFym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:42 -0500
Date: Thu, 24 Mar 2005 21:54:35 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [4/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242151130.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2242, 2005-03-24 13:00:16-08:00, mochel@digitalimplant.org
  [usb] Fix up USB to use klist_node_attached() instead of list_empty() on lists that will go away.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-03-24 20:33:38 -08:00
+++ b/drivers/usb/core/usb.c	2005-03-24 20:33:38 -08:00
@@ -300,7 +300,7 @@
 	/* if interface was already added, bind now; else let
 	 * the future device_add() bind it, bypassing probe()
 	 */
-	if (!list_empty (&dev->bus_list))
+	if (!klist_node_attached (&dev->knode_bus))
 		device_bind_driver(dev);

 	return 0;
@@ -330,7 +330,7 @@
 		return;

 	/* don't disconnect from disconnect(), or before dev_add() */
-	if (!list_empty (&dev->driver_list) && !list_empty (&dev->bus_list))
+	if (!klist_node_attached(&dev->knode_driver) && !klist_node_attached(&dev->knode_bus))
 		device_release_driver(dev);

 	dev->driver = NULL;
