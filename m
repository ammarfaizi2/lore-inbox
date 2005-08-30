Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVH3Rji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVH3Rji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVH3Rji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:39:38 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:6091 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932172AbVH3Rjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:39:37 -0400
Subject: [PATCH] fix hpet drift and url
From: Alex Williamson <alex.williamson@hp.com>
To: akpm@osdl.org
Cc: "Robert W. Picco" <bob.picco@hp.com>, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Tue, 30 Aug 2005 11:40:01 -0600
Message-Id: <1125423601.6792.16.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The HPET driver is using a parts per second drift factor instead of
the standard parts per million drift the time interpolator code expects.
This patch fixes that problem and updates the URL for the HPET spec.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>

diff -r 38ae29531c91 drivers/char/hpet.c
--- a/drivers/char/hpet.c	Tue Aug 30 05:51:28 2005
+++ b/drivers/char/hpet.c	Tue Aug 30 11:21:46 2005
@@ -44,7 +44,7 @@
 /*
  * The High Precision Event Timer driver.
  * This driver is closely modelled after the rtc.c driver.
- * http://www.intel.com/labs/platcomp/hpet/hpetspec.htm
+ * http://www.intel.com/hardwaredesign/hpetspec.htm
  */
 #define	HPET_USER_FREQ	(64)
 #define	HPET_DRIFT	(500)
@@ -712,7 +712,7 @@
 	ti->shift = 10;
 	ti->addr = &hpetp->hp_hpet->hpet_mc;
 	ti->frequency = hpet_time_div(hpets->hp_period);
-	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
+	ti->drift = HPET_DRIFT;
 	ti->mask = -1;
 
 	hpetp->hp_interpolator = ti;


