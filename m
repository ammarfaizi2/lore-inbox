Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTFSD47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTFSDz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:55:28 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:53124 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265374AbTFSDyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:54:39 -0400
Date: Wed, 18 Jun 2003 23:45:31 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234531.GF333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618234418.GC333@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1417  -> 1.1418 
#	drivers/pnp/pnpbios/core.c	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1418
# [PNP] PnPBIOS resource setting fix
# 
# If a device is disabled when initially read, its blank resource data will not
# be cleared and the pnp layer will assume incorrectly that the device has
# already been configured.  This patch resolves the issue by initializing the
# resource table if the device is found to be disabled.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Wed Jun 18 23:01:51 2003
+++ b/drivers/pnp/pnpbios/core.c	Wed Jun 18 23:01:51 2003
@@ -935,6 +935,10 @@
 		dev->capabilities |= PNP_REMOVABLE;
 	dev->protocol = &pnpbios_protocol;
 
+	/* clear out the damaged flags */
+	if (!dev->active)
+		pnp_init_resources(&dev->res);
+
 	pnp_add_device(dev);
 	pnpbios_interface_attach_device(node);
 
