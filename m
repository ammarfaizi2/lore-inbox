Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWDDTWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWDDTWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDDTWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:22:24 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:42479 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750764AbWDDTWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:22:23 -0400
Message-ID: <4432C9C5.7090800@mvista.com>
Date: Tue, 04 Apr 2006 12:32:21 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mark.gross@intel.com,
       sebastien.bouchard@ca.kontron.com
Subject: [PATCH] MPBL0010 driver sysfs permissions wide open
Content-Type: multipart/mixed;
 boundary="------------070106090701040201020401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106090701040201020401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The MPBL0010 Telco clock driver (drivers/char/tlclk.c) uses 0222 (anyone 
can write) permissions on its writable sysfs entries. IMHO this is a bit 
too wide open for proper security. The patch (against 2.6.16.1) alters 
the permissions to 0220 (owner and group can write).

Signed-off-by: Mark Bellon <mbellon@mvista.com>

mark



--------------070106090701040201020401
Content-Type: text/plain;
 name="lkml-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lkml-patch"

diff -Naur linux-2.6.16.1-orig/drivers/char/tlclk.c linux-2.6.16.1/drivers/char/tlclk.c
--- linux-2.6.16.1-orig/drivers/char/tlclk.c	2006-03-27 23:49:02.000000000 -0700
+++ linux-2.6.16.1/drivers/char/tlclk.c	2006-04-04 12:17:14.000000000 -0700
@@ -327,7 +327,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(received_ref_clk3a, S_IWUGO, NULL,
+static DEVICE_ATTR(received_ref_clk3a, (S_IWUSR|S_IWGRP), NULL,
 		store_received_ref_clk3a);
 
 
@@ -349,7 +349,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(received_ref_clk3b, S_IWUGO, NULL,
+static DEVICE_ATTR(received_ref_clk3b, (S_IWUSR|S_IWGRP), NULL,
 		store_received_ref_clk3b);
 
 
@@ -371,7 +371,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clk3b_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clk3b_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clk3b_output);
 
 static ssize_t store_enable_clk3a_output(struct device *d,
@@ -392,7 +392,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clk3a_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clk3a_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clk3a_output);
 
 static ssize_t store_enable_clkb1_output(struct device *d,
@@ -413,7 +413,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clkb1_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clkb1_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clkb1_output);
 
 
@@ -435,7 +435,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clka1_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clka1_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clka1_output);
 
 static ssize_t store_enable_clkb0_output(struct device *d,
@@ -456,7 +456,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clkb0_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clkb0_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clkb0_output);
 
 static ssize_t store_enable_clka0_output(struct device *d,
@@ -477,7 +477,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clka0_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clka0_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clka0_output);
 
 static ssize_t store_select_amcb2_transmit_clock(struct device *d,
@@ -519,7 +519,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_amcb2_transmit_clock, S_IWUGO, NULL,
+static DEVICE_ATTR(select_amcb2_transmit_clock, (S_IWUSR|S_IWGRP), NULL,
 	store_select_amcb2_transmit_clock);
 
 static ssize_t store_select_amcb1_transmit_clock(struct device *d,
@@ -560,7 +560,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_amcb1_transmit_clock, S_IWUGO, NULL,
+static DEVICE_ATTR(select_amcb1_transmit_clock, (S_IWUSR|S_IWGRP), NULL,
 		store_select_amcb1_transmit_clock);
 
 static ssize_t store_select_redundant_clock(struct device *d,
@@ -581,7 +581,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_redundant_clock, S_IWUGO, NULL,
+static DEVICE_ATTR(select_redundant_clock, (S_IWUSR|S_IWGRP), NULL,
 		store_select_redundant_clock);
 
 static ssize_t store_select_ref_frequency(struct device *d,
@@ -602,7 +602,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_ref_frequency, S_IWUGO, NULL,
+static DEVICE_ATTR(select_ref_frequency, (S_IWUSR|S_IWGRP), NULL,
 		store_select_ref_frequency);
 
 static ssize_t store_filter_select(struct device *d,
@@ -623,7 +623,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(filter_select, S_IWUGO, NULL, store_filter_select);
+static DEVICE_ATTR(filter_select, (S_IWUSR|S_IWGRP), NULL, store_filter_select);
 
 static ssize_t store_hardware_switching_mode(struct device *d,
 		 struct device_attribute *attr, const char *buf, size_t count)
@@ -643,7 +643,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(hardware_switching_mode, S_IWUGO, NULL,
+static DEVICE_ATTR(hardware_switching_mode, (S_IWUSR|S_IWGRP), NULL,
 		store_hardware_switching_mode);
 
 static ssize_t store_hardware_switching(struct device *d,
@@ -664,7 +664,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(hardware_switching, S_IWUGO, NULL,
+static DEVICE_ATTR(hardware_switching, (S_IWUSR|S_IWGRP), NULL,
 		store_hardware_switching);
 
 static ssize_t store_refalign (struct device *d,
@@ -684,7 +684,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(refalign, S_IWUGO, NULL, store_refalign);
+static DEVICE_ATTR(refalign, (S_IWUSR|S_IWGRP), NULL, store_refalign);
 
 static ssize_t store_mode_select (struct device *d,
 		 struct device_attribute *attr, const char *buf, size_t count)
@@ -704,7 +704,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(mode_select, S_IWUGO, NULL, store_mode_select);
+static DEVICE_ATTR(mode_select, (S_IWUSR|S_IWGRP), NULL, store_mode_select);
 
 static ssize_t store_reset (struct device *d,
 		 struct device_attribute *attr, const char *buf, size_t count)
@@ -724,7 +724,7 @@
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(reset, S_IWUGO, NULL, store_reset);
+static DEVICE_ATTR(reset, (S_IWUSR|S_IWGRP), NULL, store_reset);
 
 static struct attribute *tlclk_sysfs_entries[] = {
 	&dev_attr_current_ref.attr,

--------------070106090701040201020401--
