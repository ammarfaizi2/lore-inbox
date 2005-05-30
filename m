Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVE3U67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVE3U67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVE3U5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:57:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23822 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261749AbVE3U4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:46 -0400
Date: Mon, 30 May 2005 22:56:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: irda-users@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/irda/: passible cleanups
Message-ID: <20050530205643.GU10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global function static:
  - irnet/irnet_ppp.c: irnet_init
- remove the following unneeded EXPORT_SYMBOL's:
  - irlmp.c: sysctl_discovery_timeout
  - irlmp.c: irlmp_reasons
  - irlmp.c: irlmp_dup
  - irqueue.c: hashbin_find_next

Please review which of these changes do make sense and which conflict 
with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 7 May 2005

 net/irda/irlmp.c           |    3 ---
 net/irda/irnet/irnet.h     |    3 ---
 net/irda/irnet/irnet_ppp.c |    2 +-
 net/irda/irqueue.c         |    1 -
 4 files changed, 1 insertion(+), 8 deletions(-)

--- linux-2.6.12-rc3-mm3-full/net/irda/irnet/irnet.h.old	2005-05-05 22:38:59.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/irda/irnet/irnet.h	2005-05-05 22:39:12.000000000 +0200
@@ -517,9 +517,6 @@
 	irda_irnet_init(void);		/* Initialise IrDA part of IrNET */
 extern void
 	irda_irnet_cleanup(void);	/* Teardown IrDA part of IrNET */
-/* ---------------------------- MODULE ---------------------------- */
-extern int
-	irnet_init(void);		/* Initialise IrNET module */
 
 /**************************** VARIABLES ****************************/
 
--- linux-2.6.12-rc3-mm3-full/net/irda/irnet/irnet_ppp.c.old	2005-05-05 22:39:21.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/irda/irnet/irnet_ppp.c	2005-05-05 22:39:29.000000000 +0200
@@ -1107,7 +1107,7 @@
 /*
  * Module main entry point
  */
-int __init
+static int __init
 irnet_init(void)
 {
   int err;
--- linux-2.6.12-rc3-mm3-full/net/irda/irlmp.c.old	2005-05-05 22:46:47.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/irda/irlmp.c	2005-05-05 22:50:52.000000000 +0200
@@ -53,7 +53,6 @@
 /* These can be altered by the sysctl interface */
 int  sysctl_discovery         = 0;
 int  sysctl_discovery_timeout = 3; /* 3 seconds by default */
-EXPORT_SYMBOL(sysctl_discovery_timeout);
 int  sysctl_discovery_slots   = 6; /* 6 slots by default */
 int  sysctl_lap_keepalive_time = LM_IDLE_TIMEOUT * 1000 / HZ;
 char sysctl_devname[65];
@@ -67,7 +66,6 @@
 	"LM_INIT_DISCONNECT",
 	"ERROR, NOT USED",
 };
-EXPORT_SYMBOL(irlmp_reasons);
 
 /*
  * Function irlmp_init (void)
@@ -675,7 +673,6 @@
 
 	return new;
 }
-EXPORT_SYMBOL(irlmp_dup);
 
 /*
  * Function irlmp_disconnect_request (handle, userdata)
--- linux-2.6.12-rc3-mm3-full/net/irda/irqueue.c.old	2005-05-05 22:48:55.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/irda/irqueue.c	2005-05-05 22:49:03.000000000 +0200
@@ -822,7 +822,6 @@
 
 	return entry;
 }
-EXPORT_SYMBOL(hashbin_find_next);
 
 /*
  * Function hashbin_get_first (hashbin)

