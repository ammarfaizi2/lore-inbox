Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263337AbTC0RZX>; Thu, 27 Mar 2003 12:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263336AbTC0RYZ>; Thu, 27 Mar 2003 12:24:25 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:18665 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263337AbTC0RXy>; Thu, 27 Mar 2003 12:23:54 -0500
Date: Thu, 27 Mar 2003 18:33:52 +0100
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: fix compilation with PCMCIA_DEBUG on
Message-ID: <20030327173352.GB1344@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-27 18:26:31.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-27 18:28:57.000000000 +0100
@@ -71,8 +71,6 @@
 #ifdef PCMCIA_DEBUG
 INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static const char *version =
-"ds.c 1.112 2001/10/13 00:08:28 (David Hinds)";
 #else
 #define DEBUG(n, args...)
 #endif
@@ -397,7 +395,7 @@
     if (!s)
 	    return -EINVAL;
 
-    DEBUG(2, "bind_request(%d, '%s')\n", i,
+    DEBUG(2, "bind_request(%d, '%s')\n", s->socket_no,
 	  (char *)bind_info->dev_info);
     driver = get_pcmcia_driver(&bind_info->dev_info);
     if (!driver)
@@ -524,7 +522,7 @@
 {
     socket_bind_t **b, *c;
 
-    DEBUG(2, "unbind_request(%d, '%s')\n", i,
+    DEBUG(2, "unbind_request(%d, '%s')\n", s->socket_no,
 	  (char *)bind_info->dev_info);
     for (b = &s->bind; *b; b = &(*b)->next)
 	if ((strcmp((char *)(*b)->driver->drv.name,
