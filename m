Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbTDDE4j (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 23:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTDDE4i (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:56:38 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:21125 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261558AbTDDEzy (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:55:54 -0500
Date: Fri, 4 Apr 2003 00:11:08 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404001108.GG11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030404000731.GB11574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404000731.GB11574@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Thu Apr  3 23:40:57 2003
+++ b/drivers/pnp/manager.c	Thu Apr  3 23:40:57 2003
@@ -632,8 +632,7 @@
 	if (!dev)
 		return -EINVAL;
 	if (dev->active) {
-		pnp_info("res: The PnP device '%s' is already active.", dev->dev.bus_id);
-		return -EBUSY;
+		return 0; /* the device is already active */
 	}
 	/* If this condition is true, advanced configuration failed, we need to get this device up and running
 	 * so we use the simple config engine which ignores cold conflicts, this of course may lead to new failures */
@@ -698,8 +697,7 @@
         if (!dev)
                 return -EINVAL;
 	if (!dev->active) {
-		pnp_info("res: The PnP device '%s' is already disabled.", dev->dev.bus_id);
-		return -EINVAL;
+		return 0; /* the device is already disabled */
 	}
 	if (dev->status != PNP_READY){
 		pnp_info("res: Disable failed becuase the PnP device '%s' is busy.", dev->dev.bus_id);
