Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUCUOJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUCUOJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:09:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2789 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263653AbUCUOJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:09:41 -0500
Date: Sun, 21 Mar 2004 15:09:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: rmk@arm.linux.org.uk, David Hinds <dhinds@sonic.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix two PCMCIA warnings
Message-ID: <20040321140930.GA19464@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The

  Add, fix, update PCMCIA debugging.

patch in 2.6.5-rc introduced the following compile warnings with 
CONFIG_PCMCIA_DEBUG enabled:


<--  snip  -->

...
  CC      drivers/pcmcia/i82365.o
drivers/pcmcia/i82365.c:71: warning: `version' defined but not used
...
  CC      drivers/pcmcia/tcic.o
drivers/pcmcia/tcic.c:64: warning: `version' defined but not used
...

<--  snip  -->


Since the version strings are unused and seem to be quite outdated, I 
propose the patch below to remove them.

I've tested both the modular and the non-modular compilation with this 
patch applied.

Please apply
Adrian


--- linux-2.6.5-rc2-mm1-full/drivers/pcmcia/i82365.c.old	2004-03-21 15:00:31.000000000 +0100
+++ linux-2.6.5-rc2-mm1-full/drivers/pcmcia/i82365.c	2004-03-21 15:00:45.000000000 +0100
@@ -68,9 +68,6 @@
 #include "o2micro.h"
 
 #ifdef DEBUG
-static const char *version =
-"i82365.c 1.265 1999/11/10 18:36:21 (David Hinds)";
-
 static int pc_debug;
 
 module_param(pc_debug, int, 0644);
--- linux-2.6.5-rc2-mm1-full/drivers/pcmcia/tcic.c.old	2004-03-21 15:01:24.000000000 +0100
+++ linux-2.6.5-rc2-mm1-full/drivers/pcmcia/tcic.c	2004-03-21 15:01:34.000000000 +0100
@@ -61,8 +61,6 @@
 
 module_param(pc_debug, int, 0644);
 MODULE_PARM(pc_debug, "i");
-static const char *version =
-"tcic.c 1.111 2000/02/15 04:13:12 (David Hinds)";
 
 #define debug(lvl, fmt, arg...) do {				\
 	if (pc_debug > (lvl))					\
