Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbTIVAWO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTIVAUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:20:22 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18061 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262726AbTIVATx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:19:53 -0400
Date: Sun, 21 Sep 2003 20:12:52 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921201252.GH24897@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030921200935.GB24897@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921200935.GB24897@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/09/21	ambx1@neo.rr.com	1.1360
# [PNPBIOS] return proper error codes on init failure
# --------------------------------------------
#
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Sep 21 19:45:42 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Sep 21 19:45:42 2003
@@ -484,15 +484,17 @@
 	pnpbios_calls_init(pnp_bios_install);
 
 	/* read the node info */
-	if (pnp_bios_dev_node_info(&node_info)) {
+	ret = pnp_bios_dev_node_info(&node_info);
+	if (ret) {
 		printk(KERN_ERR "PnPBIOS: Unable to get node info.  Aborting.\n");
-		return -EIO;
+		return ret;
 	}
 
 	/* register with the pnp layer */
-	if (pnp_register_protocol(&pnpbios_protocol)) {
+	ret = pnp_register_protocol(&pnpbios_protocol);
+	if (ret) {
 		printk(KERN_ERR "PnPBIOS: Unable to register driver.  Aborting.\n");
-		return -EIO;
+		return ret;
 	}
 
 	/* start the proc interface */
