Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVGIDHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVGIDHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 23:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbVGIDHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 23:07:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33799 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263097AbVGIDHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 23:07:16 -0400
Date: Sat, 9 Jul 2005 05:07:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ipw2100-admin@linux.intel.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] drivers/net/wireless/ipw2200.c: remove division by zero
Message-ID: <20050709030713.GA28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc correctly complained about a division by zero for HZ < 1000.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Jul 2005

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

