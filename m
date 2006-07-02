Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWGBXYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWGBXYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWGBXYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:24:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36055 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750712AbWGBXYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:24:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:23:56 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 15/19] ieee1394: nodemgr: make module parameter ignore_drivers
 writable
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.b95f0afc24a01a08@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.016) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nodemgr's ignore_drivers variable is exposed as a module load parameter
(therefore also as a sysfs attribute below /sys/module) and additionally
as an attribute below /sys/bus/ieee1394.  Since the latter is writable,
make the former writable too.

Note, the bus's attribute ignore_drivers is only relevant to newly added
units, not to present or suspended or resuming units.  Those have their
own attribute ignore_driver.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-07-01 21:17:37.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-07-01 21:21:23.000000000 +0200
@@ -28,7 +28,7 @@
 #include "nodemgr.h"
 
 static int ignore_drivers;
-module_param(ignore_drivers, int, 0444);
+module_param(ignore_drivers, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_drivers, "Disable automatic probing for drivers.");
 
 struct nodemgr_csr_info {


