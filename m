Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWJJTMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWJJTMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWJJTMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:12:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:8129 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932240AbWJJTMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:12:52 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 10 Oct 2006 21:12:39 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.19-rc1 2/3] ieee1394: coding style in hosts.c
To: linux1394-devel@lists.sourceforge.net
cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.f3f45c410340f9b2@s5r6.in-berlin.de>
Message-ID: <tkrat.1904a2df7d282ffa@s5r6.in-berlin.de>
References: <20061010064805.GA21310@havoc.gtf.org>
 <452B5BEE.4050407@s5r6.in-berlin.de> <452B979C.9030001@garzik.org>
 <tkrat.f3f45c410340f9b2@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some 80-columns pedantry, and touch up of a // comment.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux-2.6.19-rc1/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6.19-rc1.orig/drivers/ieee1394/hosts.c	2006-10-10 19:07:36.000000000 +0200
+++ linux-2.6.19-rc1/drivers/ieee1394/hosts.c	2006-10-10 19:31:37.000000000 +0200
@@ -43,9 +43,10 @@ static void delayed_reset_bus(void * __r
 
 	CSR_SET_BUS_INFO_GENERATION(host->csr.rom, generation);
 	if (csr1212_generate_csr_image(host->csr.rom) != CSR1212_SUCCESS) {
-		/* CSR image creation failed, reset generation field and do not
-		 * issue a bus reset. */
-		CSR_SET_BUS_INFO_GENERATION(host->csr.rom, host->csr.generation);
+		/* CSR image creation failed.
+		 * Reset generation field and do not issue a bus reset. */
+		CSR_SET_BUS_INFO_GENERATION(host->csr.rom,
+					    host->csr.generation);
 		return;
 	}
 
@@ -53,7 +54,8 @@ static void delayed_reset_bus(void * __r
 
 	host->update_config_rom = 0;
 	if (host->driver->set_hw_config_rom)
-		host->driver->set_hw_config_rom(host, host->csr.rom->bus_info_data);
+		host->driver->set_hw_config_rom(host,
+						host->csr.rom->bus_info_data);
 
 	host->csr.gen_timestamp[host->csr.generation] = jiffies;
 	hpsb_reset_bus(host, SHORT_RESET);
@@ -69,7 +71,8 @@ static int dummy_devctl(struct hpsb_host
 	return -1;
 }
 
-static int dummy_isoctl(struct hpsb_iso *iso, enum isoctl_cmd command, unsigned long arg)
+static int dummy_isoctl(struct hpsb_iso *iso, enum isoctl_cmd command,
+			unsigned long arg)
 {
 	return -1;
 }
@@ -150,7 +151,7 @@ struct hpsb_host *hpsb_alloc_host(struct
 	init_timer(&h->timeout);
 	h->timeout.data = (unsigned long) h;
 	h->timeout.function = abort_timedouts;
-	h->timeout_interval = HZ / 20; // 50ms by default
+	h->timeout_interval = HZ / 20; /* 50ms, half of minimum SPLIT_TIMEOUT */
 
 	h->topology_map = h->csr.topology_map + 3;
 	h->speed_map = (u8 *)(h->csr.speed_map + 2);
@@ -225,7 +240,8 @@ int hpsb_update_config_rom_image(struct 
 	if (time_before(jiffies, host->csr.gen_timestamp[next_gen] + 60 * HZ))
 		/* Wait 60 seconds from the last time this generation number was
 		 * used. */
-		reset_delay = (60 * HZ) + host->csr.gen_timestamp[next_gen] - jiffies;
+		reset_delay =
+			(60 * HZ) + host->csr.gen_timestamp[next_gen] - jiffies;
 	else
 		/* Wait 1 second in case some other code wants to change the
 		 * Config ROM in the near future. */


