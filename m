Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVBWV4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVBWV4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVBWV4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:56:32 -0500
Received: from scrat.cs.umu.se ([130.239.40.18]:51412 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S261613AbVBWVzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:55:15 -0500
Date: Wed, 23 Feb 2005 22:55:08 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, trivial@rustcorp.com.au
Subject: [PATCH] A few more sparse fixes
Message-ID: <20050223215508.GC21912@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the sparse warnings about using plain integer as NULL pointer in
the following files:

arch/i386/oprofile/backtrace.c
drivers/char/isicom.c
drivers/char/drm/radeon_state.c
drivers/mtd/maps/nettel.c
drivers/net/wireless/prism54/isl_ioctl.c
drivers/serial/8250_early.c
fs/reiserfs/namei.c


Signed-off-by: Peter Hagervall <hager@cs.umu.se>

--


===== arch/i386/oprofile/backtrace.c 1.1 vs edited =====
--- 1.1/arch/i386/oprofile/backtrace.c	2005-01-05 03:48:23 +01:00
+++ edited/arch/i386/oprofile/backtrace.c	2005-02-21 16:02:15 +01:00
@@ -27,7 +27,7 @@
 	/* frame pointers should strictly progress back up the stack
 	 * (towards higher addresses) */
 	if (head >= head->ebp)
-		return 0;
+		return NULL;
 
 	return head->ebp;
 }
===== drivers/char/isicom.c 1.41 vs edited =====
--- 1.41/drivers/char/isicom.c	2005-01-06 19:53:25 +01:00
+++ edited/drivers/char/isicom.c	2005-02-21 15:57:22 +01:00
@@ -1271,7 +1271,7 @@
 	}	
 	port->flags &= ~ASYNC_INITIALIZED;
 	/* 3rd October 2000 : Vinayak P Risbud */
-	port->tty = 0;
+	port->tty = NULL;
 	spin_unlock_irqrestore(&card->card_lock, flags);
 	
 	/*Fix done by Anil .S on 30-04-2001
===== drivers/char/drm/radeon_state.c 1.44 vs edited =====
--- 1.44/drivers/char/drm/radeon_state.c	2005-02-08 10:57:35 +01:00
+++ edited/drivers/char/drm/radeon_state.c	2005-02-21 15:55:24 +01:00
@@ -1842,7 +1842,7 @@
 				dev_priv->surfaces[s->surface_index].refcount--;
 				if (dev_priv->surfaces[s->surface_index].refcount == 0)
 					dev_priv->surfaces[s->surface_index].flags = 0;
-				s->filp = 0;
+				s->filp = NULL;
 				radeon_apply_surface_regs(s->surface_index, dev_priv);
 				return 0;
 			}
===== drivers/mtd/maps/nettel.c 1.8 vs edited =====
--- 1.8/drivers/mtd/maps/nettel.c	2005-01-05 18:17:45 +01:00
+++ edited/drivers/mtd/maps/nettel.c	2005-02-21 15:58:36 +01:00
@@ -479,7 +479,7 @@
 	}
 	if (nettel_intel_map.virt) {
 		iounmap(nettel_intel_map.virt);
-		nettel_intel_map.virt = 0;
+		nettel_intel_map.virt = NULL;
 	}
 #endif
 }
===== drivers/net/wireless/prism54/isl_ioctl.c 1.28 vs edited =====
--- 1.28/drivers/net/wireless/prism54/isl_ioctl.c	2004-10-09 14:43:06 +02:00
+++ edited/drivers/net/wireless/prism54/isl_ioctl.c	2005-02-21 16:00:41 +01:00
@@ -1750,7 +1750,7 @@
 	u8 wpa_ie[MAX_WPA_IE_LEN];
 	int wpa_ie_len;
 	size_t len = 0; /* u16, better? */
-	u8 *payload = 0, *pos = 0;
+	u8 *payload = NULL, *pos = NULL;
 	int ret;
 
 	/* I think all trapable objects are listed here.
===== drivers/serial/8250_early.c 1.1 vs edited =====
--- 1.1/drivers/serial/8250_early.c	2004-11-19 08:03:10 +01:00
+++ edited/drivers/serial/8250_early.c	2005-02-21 16:01:48 +01:00
@@ -164,7 +164,7 @@
 
 	if ((options = strchr(options, ','))) {
 		options++;
-		device->baud = simple_strtoul(options, 0, 0);
+		device->baud = simple_strtoul(options, NULL, 0);
 		length = min(strcspn(options, " "), sizeof(device->options));
 		strncpy(device->options, options, length);
 	} else {
===== fs/reiserfs/namei.c 1.66 vs edited =====
--- 1.66/fs/reiserfs/namei.c	2005-01-05 03:48:14 +01:00
+++ edited/fs/reiserfs/namei.c	2005-02-21 16:03:36 +01:00
@@ -608,7 +608,7 @@
         goto out_failed;
     }
 
-    retval = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
+    retval = reiserfs_new_inode (&th, dir, mode, NULL, 0/*i_size*/, dentry, inode);
     if (retval)
         goto out_failed;
 	
