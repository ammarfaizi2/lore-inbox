Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUA3FSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUA3FQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:16:32 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:53380 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266515AbUA3FOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:14:11 -0500
Date: Thu, 29 Jan 2004 23:59:00 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040129235900.GF12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the PnP ID declarations to mod_devicetable.h like most of the
other buses.  It is from Takashi Iwai <tiwai@suse.de>.

--- a/include/linux/mod_devicetable.h	2004-01-09 07:00:05.000000000 +0000
+++ b/include/linux/mod_devicetable.h	2004-01-28 22:50:13.000000000 +0000
@@ -148,4 +148,21 @@
 #define CCW_DEVICE_ID_MATCH_DEVICE_MODEL	0x08
 
 
+#define PNP_ID_LEN	8
+#define PNP_MAX_DEVICES	8
+
+struct pnp_device_id {
+	__u8 id[PNP_ID_LEN];
+	kernel_ulong_t driver_data;
+};
+
+struct pnp_card_device_id {
+	__u8 id[PNP_ID_LEN];
+	kernel_ulong_t driver_data;
+	struct {
+		__u8 id[PNP_ID_LEN];
+	} devs[PNP_MAX_DEVICES];
+};
+
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
--- a/include/linux/pnp.h	2004-01-23 15:19:25.000000000 +0000
+++ b/include/linux/pnp.h	2004-01-28 22:48:36.000000000 +0000
@@ -12,13 +12,12 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/mod_devicetable.h>
 
 #define PNP_MAX_PORT		8
 #define PNP_MAX_MEM		4
 #define PNP_MAX_IRQ		2
 #define PNP_MAX_DMA		2
-#define PNP_MAX_DEVICES		8
-#define PNP_ID_LEN		8
 #define PNP_NAME_LEN		50
 
 struct pnp_protocol;
@@ -287,19 +286,6 @@
 	struct pnp_id * next;
 };
 
-struct pnp_device_id {
-	char id[PNP_ID_LEN];
-	unsigned long driver_data;	/* data private to the driver */
-};
-
-struct pnp_card_device_id {
-	char id[PNP_ID_LEN];
-	unsigned long driver_data;	/* data private to the driver */
-	struct {
-		char id[PNP_ID_LEN];
-	} devs[PNP_MAX_DEVICES];	/* logical devices */
-};
-
 struct pnp_driver {
 	char * name;
 	const struct pnp_device_id *id_table;
