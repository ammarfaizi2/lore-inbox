Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTKPFa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 00:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTKPFa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 00:30:26 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:34464 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262190AbTKPFaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 00:30:25 -0500
Date: Sun, 16 Nov 2003 00:26:20 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Fixes for 2.6.0-test9
Message-ID: <20031116002620.GB13220@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/11/15	ambx1@neo.rr.com	1.1447
# [PnP] reserve resources specified by the PnPBIOS properly
# 
# A bug prevents the PnP layer from reserving some of the resources
# specified by the PnPBIOS.  As a result some systems will have
# unpredicable (random crashes etc.) problems because of resource
# conflicts, especially when PCMCIA support is enabled.  This patch
# fixes the problem by ensuring that the proper resource data is
# reserved.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Sun Nov 16 00:25:14 2003
+++ b/drivers/pnp/system.c	Sun Nov 16 00:25:14 2003
@@ -54,7 +54,7 @@
 	int i;
 
 	for (i=0;i<PNP_MAX_PORT;i++) {
-		if (pnp_port_valid(dev, i))
+		if (!pnp_port_valid(dev, i))
 			/* end of resources */
 			continue;
 		if (pnp_port_start(dev, i) == 0)
