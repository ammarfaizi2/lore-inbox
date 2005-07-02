Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVGBVwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVGBVwW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGBVwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:52:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6666 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261300AbVGBVvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:51:13 -0400
Date: Sat, 2 Jul 2005 23:51:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ipw2100-admin@linux.intel.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] drivers/net/wireless/ipw2200.c: remove division by zero
Message-ID: <20050702215111.GE5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc correctly complained about a division by zero for HZ < 1000.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1-full/drivers/net/wireless/ipw2200.c.old	2005-07-02 23:14:39.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/net/wireless/ipw2200.c	2005-07-02 23:15:39.000000000 +0200
@@ -1170,7 +1170,7 @@
 		HOST_COMPLETE_TIMEOUT);
 	if (rc == 0) {
 		IPW_DEBUG_INFO("Command completion failed out after %dms.\n",
-			       HOST_COMPLETE_TIMEOUT / (HZ / 1000));
+			       (1000 * HOST_COMPLETE_TIMEOUT) / HZ);
 		priv->status &= ~STATUS_HCMD_ACTIVE;
 		return -EIO;
 	}

