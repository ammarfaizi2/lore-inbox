Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVCFSVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVCFSVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCFSVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 13:21:48 -0500
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:42467 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261457AbVCFSVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 13:21:46 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sun, 6 Mar 2005 19:21:45 +0100
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11-mm1] ibm_emac_core: add memory allocation failure handling
Message-ID: <20050306182144.GA6428@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds failure handling for a kmalloc() in the driver for the IBM 4xx
PowerPC builtin ethernet.

Signed-off-by: <panagiotis.issaris@mech.kuleuven.ac.be>

diff -pruN linux-2.6.11-orig/drivers/net/ibm_emac/ibm_emac_core.c linux-2.6.11-pi/drivers/net/ibm_emac/ibm_emac_core.c
--- linux-2.6.11-orig/drivers/net/ibm_emac/ibm_emac_core.c	2005-03-05 03:30:09.000000000 +0100
+++ linux-2.6.11-pi/drivers/net/ibm_emac/ibm_emac_core.c	2005-03-06 19:00:10.000000000 +0100
@@ -1957,6 +1957,11 @@ static int emac_probe(struct ocp_device 
 		struct emac_def_dev *ddev;
 		/* Add this index to the deferred init table */
 		ddev = kmalloc(sizeof(struct emac_def_dev), GFP_KERNEL);
+		if (!ddev) {
+			printk(KERN_ERR "emac%d: Memory allocation failed.\n", 
+					ocpdev->def->index);
+			return -ENOMEM;
+		}
 		ddev->ocpdev = ocpdev;
 		ddev->mal = mal;
 		list_add_tail(&ddev->link, &emac_init_list);
