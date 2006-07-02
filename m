Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWGBXHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWGBXHc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWGBXHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:07:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:15062 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750920AbWGBXHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:07:31 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:07:14 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 10/19] ieee1394: clean up declarations of hpsb_*_config_rom
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.7c598f4625df91d3@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.711) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpsb_update_config_rom() is defined in csr.c, not hosts.c.
hpsb_get_config_rom() does not exist.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/csr.h
===================================================================
--- linux.orig/drivers/ieee1394/csr.h	2006-07-01 17:42:38.000000000 +0200
+++ linux/drivers/ieee1394/csr.h	2006-07-01 18:18:42.000000000 +0200
@@ -91,4 +91,9 @@ extern struct csr1212_bus_ops csr_bus_op
 int init_csr(void);
 void cleanup_csr(void);
 
+/* hpsb_update_config_rom() is deprecated */
+struct hpsb_host;
+int hpsb_update_config_rom(struct hpsb_host *host, const quadlet_t *new_rom,
+			   size_t size, unsigned char rom_version);
+
 #endif /* _IEEE1394_CSR_H */
Index: linux/drivers/ieee1394/hosts.h
===================================================================
--- linux.orig/drivers/ieee1394/hosts.h	2006-07-01 17:42:38.000000000 +0200
+++ linux/drivers/ieee1394/hosts.h	2006-07-01 18:16:28.000000000 +0200
@@ -205,13 +205,6 @@ struct hpsb_host *hpsb_alloc_host(struct
 int hpsb_add_host(struct hpsb_host *host);
 void hpsb_remove_host(struct hpsb_host *h);
 
-/* The following 2 functions are deprecated and will be removed when the
- * raw1394/libraw1394 update is complete. */
-int hpsb_update_config_rom(struct hpsb_host *host,
-      const quadlet_t *new_rom, size_t size, unsigned char rom_version);
-int hpsb_get_config_rom(struct hpsb_host *host, quadlet_t *buffer,
-      size_t buffersize, size_t *rom_size, unsigned char *rom_version);
-
 /* Updates the configuration rom image of a host.  rom_version must be the
  * current version, otherwise it will fail with return value -1. If this
  * host does not support config-rom-update, it will return -EINVAL.


