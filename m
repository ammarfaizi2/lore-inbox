Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264593AbTCZDZS>; Tue, 25 Mar 2003 22:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264586AbTCZDYz>; Tue, 25 Mar 2003 22:24:55 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:56462 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264582AbTCZDXc>;
	Tue, 25 Mar 2003 22:23:32 -0500
Date: Tue, 25 Mar 2003 22:37:22 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030325223722.GH1083@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030325223319.GC1083@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325223319.GC1083@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1001  -> 1.1002 
#	drivers/pnp/manager.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/25	ambx1@neo.rr.com	1.1002
# Silently Ignore if the device is already active/disabled
# 
# Some drivers will try to activate a device even though it is already
# active.  Instead of returning an error, the resource manager will now
# just ignore this.  This should solve some of the recently seen problems.
# Also it doesn't make sense to return an error if the device is already
# in the correct state.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Tue Mar 25 21:44:41 2003
+++ b/drivers/pnp/manager.c	Tue Mar 25 21:44:41 2003
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
