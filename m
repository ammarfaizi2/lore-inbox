Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTI2RRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTI2RGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:06:34 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:42935 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263801AbTI2RE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:59 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] logic thinko in i2c
Message-Id: <E1A41Rq-0000ND-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/i2c/i2c-sensor.c linux-2.5/drivers/i2c/i2c-sensor.c
--- bk-linus/drivers/i2c/i2c-sensor.c	2003-09-27 16:42:51.000000000 +0100
+++ linux-2.5/drivers/i2c/i2c-sensor.c	2003-09-28 13:18:20.000000000 +0100
@@ -133,7 +133,7 @@ int i2c_detect(struct i2c_adapter *adapt
 		     i += 2) {
 			if (((adapter_id == address_data->probe[i]) ||
 			     ((address_data->
-			       probe[i] == ANY_I2C_BUS) & !is_isa))
+			       probe[i] == ANY_I2C_BUS) && !is_isa))
 			    && (addr == address_data->probe[i + 1])) {
 				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
@@ -141,7 +141,7 @@ int i2c_detect(struct i2c_adapter *adapt
 		}
 		for (i = 0; !found && (address_data->probe_range[i] != I2C_CLIENT_END); i += 3) {
 			if ( ((adapter_id == address_data->probe_range[i]) ||
-			      ((address_data->probe_range[i] == ANY_I2C_BUS) & !is_isa)) &&
+			      ((address_data->probe_range[i] == ANY_I2C_BUS) && !is_isa)) &&
 			     (addr >= address_data->probe_range[i + 1]) &&
 			     (addr <= address_data->probe_range[i + 2])) {
 				found = 1;
