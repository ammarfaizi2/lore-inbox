Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTDDRzo (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDDRzo (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:55:44 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:60688 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263552AbTDDRzm (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 12:55:42 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Keep de2104x quiet
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 04 Apr 2003 20:01:53 +0200
Message-ID: <wrpsmsydtv2.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

The included patch tries to keep the de2104x driver quiet if there is
link change. Without this patch, I'm getting lots of :

eth0: link up, media 10baseT-HD
eth0: link up, media 10baseT-HD
eth0: link up, media 10baseT-HD

about one a minute... Quite annoying. With this patch, the driver only
logs when state changes (which is already taken care of in
de_link_up()).

Tested on an AlphaStation-500 (21040, UP).

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1004  -> 1.1005 
#	drivers/net/tulip/de2104x.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/04	maz@hina.wild-wind.fr.eu.org	1.1005
# Keep the de2104x driver quiet if link stays up.
# --------------------------------------------
#
diff -Nru a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
--- a/drivers/net/tulip/de2104x.c	Fri Apr  4 19:56:27 2003
+++ b/drivers/net/tulip/de2104x.c	Fri Apr  4 19:56:27 2003
@@ -984,11 +984,7 @@
 		add_timer(&de->media_timer);
 		if (!netif_carrier_ok(dev))
 			de_link_up(de);
-		else
-			if (netif_msg_timer(de))
-				printk(KERN_INFO "%s: %s link ok, status %x\n",
-				       dev->name, media_name[de->media_type],
-				       status);
+		
 		return;
 	}
 

-- 
Places change, faces change. Life is so very strange.
