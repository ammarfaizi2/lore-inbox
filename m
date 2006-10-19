Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWJSJR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWJSJR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWJSJR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:17:56 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:22523 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030361AbWJSJRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:17:55 -0400
Message-ID: <453742B7.5080200@atmel.com>
Date: Thu, 19 Oct 2006 11:17:43 +0200
From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Organization: Atmel
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: dbrownell@users.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6.18] Correct bus_num and buffer bug in spi core
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090500030701000108050309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500030701000108050309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Included is a patch which corrects the following in driver/spi/spi.c in
function spi_busnum_to_master:
 * must allow bus_num 0, the if is really not needed.
 * correct the name buffer which is too small for bus_num >= 10000. It
should be 9 bytes big, not 8.

Sorry if I should have split the patch in two.

I am not on the linux-kernel list.

Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>

-- 
With kind regards,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab

--------------090500030701000108050309
Content-Type: text/x-patch;
 name="spi-fix-spi-busnum-to-master-buffer-and-bus_num-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="spi-fix-spi-busnum-to-master-buffer-and-bus_num-0.patch"

--- a/drivers/spi/spi.c	2006-10-19 10:37:26.000000000 +0200
+++ b/drivers/spi/spi.c	2006-10-19 10:38:59.000000000 +0200
@@ -465,15 +465,13 @@ EXPORT_SYMBOL_GPL(spi_unregister_master)
  */
 struct spi_master *spi_busnum_to_master(u16 bus_num)
 {
-	if (bus_num) {
-		char			name[8];
-		struct kobject		*bus;
-
-		snprintf(name, sizeof name, "spi%u", bus_num);
-		bus = kset_find_obj(&spi_master_class.subsys.kset, name);
-		if (bus)
-			return container_of(bus, struct spi_master, cdev.kobj);
-	}
+	char			name[9];
+	struct kobject		*bus;
+
+	snprintf(name, sizeof name, "spi%u", bus_num);
+	bus = kset_find_obj(&spi_master_class.subsys.kset, name);
+	if (bus)
+		return container_of(bus, struct spi_master, cdev.kobj);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(spi_busnum_to_master);

--------------090500030701000108050309--
