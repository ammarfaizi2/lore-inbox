Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWDMXRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWDMXRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWDMXRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:17:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20174 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932476AbWDMXIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:08:15 -0400
Date: Thu, 13 Apr 2006 16:07:06 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, mbellon@mvista.com,
       mark.gross@intel.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/22] MPBL0010 driver sysfs permissions wide open
Message-ID: <20060413230706.GD5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mpbl0010-driver-sysfs-permissions-wide-open.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Mark Bellon <mbellon@mvista.com>

The MPBL0010 Telco clock driver (drivers/char/tlclk.c) uses 0222 (anyone
can write) permissions on its writable sysfs entries.  Alter the
permissions to 0220 (owner and group can write).

The use case for this driver is to configure the fail over behavior of the
clock hardware.  That should be done by the more privileged users.

Signed-off-by: Mark Bellon <mbellon@mvista.com>
Acked-by: Gross Mark <mark.gross@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/tlclk.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- linux-2.6.16.5.orig/drivers/char/tlclk.c
+++ linux-2.6.16.5/drivers/char/tlclk.c
@@ -327,7 +327,7 @@ static ssize_t store_received_ref_clk3a(
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(received_ref_clk3a, S_IWUGO, NULL,
+static DEVICE_ATTR(received_ref_clk3a, (S_IWUSR|S_IWGRP), NULL,
 		store_received_ref_clk3a);
 
 
@@ -349,7 +349,7 @@ static ssize_t store_received_ref_clk3b(
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(received_ref_clk3b, S_IWUGO, NULL,
+static DEVICE_ATTR(received_ref_clk3b, (S_IWUSR|S_IWGRP), NULL,
 		store_received_ref_clk3b);
 
 
@@ -371,7 +371,7 @@ static ssize_t store_enable_clk3b_output
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clk3b_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clk3b_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clk3b_output);
 
 static ssize_t store_enable_clk3a_output(struct device *d,
@@ -392,7 +392,7 @@ static ssize_t store_enable_clk3a_output
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clk3a_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clk3a_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clk3a_output);
 
 static ssize_t store_enable_clkb1_output(struct device *d,
@@ -413,7 +413,7 @@ static ssize_t store_enable_clkb1_output
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clkb1_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clkb1_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clkb1_output);
 
 
@@ -435,7 +435,7 @@ static ssize_t store_enable_clka1_output
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clka1_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clka1_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clka1_output);
 
 static ssize_t store_enable_clkb0_output(struct device *d,
@@ -456,7 +456,7 @@ static ssize_t store_enable_clkb0_output
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clkb0_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clkb0_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clkb0_output);
 
 static ssize_t store_enable_clka0_output(struct device *d,
@@ -477,7 +477,7 @@ static ssize_t store_enable_clka0_output
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(enable_clka0_output, S_IWUGO, NULL,
+static DEVICE_ATTR(enable_clka0_output, (S_IWUSR|S_IWGRP), NULL,
 		store_enable_clka0_output);
 
 static ssize_t store_select_amcb2_transmit_clock(struct device *d,
@@ -519,7 +519,7 @@ static ssize_t store_select_amcb2_transm
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_amcb2_transmit_clock, S_IWUGO, NULL,
+static DEVICE_ATTR(select_amcb2_transmit_clock, (S_IWUSR|S_IWGRP), NULL,
 	store_select_amcb2_transmit_clock);
 
 static ssize_t store_select_amcb1_transmit_clock(struct device *d,
@@ -560,7 +560,7 @@ static ssize_t store_select_amcb1_transm
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_amcb1_transmit_clock, S_IWUGO, NULL,
+static DEVICE_ATTR(select_amcb1_transmit_clock, (S_IWUSR|S_IWGRP), NULL,
 		store_select_amcb1_transmit_clock);
 
 static ssize_t store_select_redundant_clock(struct device *d,
@@ -581,7 +581,7 @@ static ssize_t store_select_redundant_cl
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_redundant_clock, S_IWUGO, NULL,
+static DEVICE_ATTR(select_redundant_clock, (S_IWUSR|S_IWGRP), NULL,
 		store_select_redundant_clock);
 
 static ssize_t store_select_ref_frequency(struct device *d,
@@ -602,7 +602,7 @@ static ssize_t store_select_ref_frequenc
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(select_ref_frequency, S_IWUGO, NULL,
+static DEVICE_ATTR(select_ref_frequency, (S_IWUSR|S_IWGRP), NULL,
 		store_select_ref_frequency);
 
 static ssize_t store_filter_select(struct device *d,
@@ -623,7 +623,7 @@ static ssize_t store_filter_select(struc
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(filter_select, S_IWUGO, NULL, store_filter_select);
+static DEVICE_ATTR(filter_select, (S_IWUSR|S_IWGRP), NULL, store_filter_select);
 
 static ssize_t store_hardware_switching_mode(struct device *d,
 		 struct device_attribute *attr, const char *buf, size_t count)
@@ -643,7 +643,7 @@ static ssize_t store_hardware_switching_
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(hardware_switching_mode, S_IWUGO, NULL,
+static DEVICE_ATTR(hardware_switching_mode, (S_IWUSR|S_IWGRP), NULL,
 		store_hardware_switching_mode);
 
 static ssize_t store_hardware_switching(struct device *d,
@@ -664,7 +664,7 @@ static ssize_t store_hardware_switching(
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(hardware_switching, S_IWUGO, NULL,
+static DEVICE_ATTR(hardware_switching, (S_IWUSR|S_IWGRP), NULL,
 		store_hardware_switching);
 
 static ssize_t store_refalign (struct device *d,
@@ -684,7 +684,7 @@ static ssize_t store_refalign (struct de
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(refalign, S_IWUGO, NULL, store_refalign);
+static DEVICE_ATTR(refalign, (S_IWUSR|S_IWGRP), NULL, store_refalign);
 
 static ssize_t store_mode_select (struct device *d,
 		 struct device_attribute *attr, const char *buf, size_t count)
@@ -704,7 +704,7 @@ static ssize_t store_mode_select (struct
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(mode_select, S_IWUGO, NULL, store_mode_select);
+static DEVICE_ATTR(mode_select, (S_IWUSR|S_IWGRP), NULL, store_mode_select);
 
 static ssize_t store_reset (struct device *d,
 		 struct device_attribute *attr, const char *buf, size_t count)
@@ -724,7 +724,7 @@ static ssize_t store_reset (struct devic
 	return strnlen(buf, count);
 }
 
-static DEVICE_ATTR(reset, S_IWUGO, NULL, store_reset);
+static DEVICE_ATTR(reset, (S_IWUSR|S_IWGRP), NULL, store_reset);
 
 static struct attribute *tlclk_sysfs_entries[] = {
 	&dev_attr_current_ref.attr,

--
