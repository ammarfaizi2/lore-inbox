Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbTIVAXc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTIVAWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:22:22 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18829 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262730AbTIVAUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:20:15 -0400
Date: Sun, 21 Sep 2003 20:13:13 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921201313.GI24897@neo.rr.com>
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
# 03/09/21	ambx1@neo.rr.com	1.1361
# [PNPBIOS] move some more functions to local include file
# 
# This patch moves some unnecessary global functions to the local
# pnpbios include file.
# 
# --------------------------------------------
#
diff -Nru a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
--- a/drivers/pnp/pnpbios/pnpbios.h	Sun Sep 21 19:45:34 2003
+++ b/drivers/pnp/pnpbios/pnpbios.h	Sun Sep 21 19:45:34 2003
@@ -25,6 +25,8 @@
 #pragma pack()
 
 extern int pnp_bios_present(void);
+extern int  pnpbios_dont_use_current_config;
+extern void *pnpbios_kmalloc(size_t size, int f);
 
 extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
 extern int pnpbios_read_resources_from_node(struct pnp_resource_table *res, struct pnp_bios_node * node);
diff -Nru a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Sun Sep 21 19:45:34 2003
+++ b/include/linux/pnpbios.h	Sun Sep 21 19:45:34 2003
@@ -131,10 +131,7 @@
 #ifdef CONFIG_PNPBIOS
 
 /* non-exported */
-extern int  pnpbios_dont_use_current_config;
 extern struct pnp_dev_node_info node_info;
-extern void *pnpbios_kmalloc(size_t size, int f);
-extern int pnpbios_init (void);
 
 extern int pnp_bios_dev_node_info (struct pnp_dev_node_info *data);
 extern int pnp_bios_get_dev_node (u8 *nodenum, char config, struct pnp_bios_node *data);
