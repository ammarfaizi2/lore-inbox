Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUHNO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUHNO2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHNO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:28:46 -0400
Received: from verein.lst.de ([213.95.11.210]:19627 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263024AbUHNO07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:26:59 -0400
Date: Sat, 14 Aug 2004 16:26:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] avoid via-pmu warnings for non-powerbook configs
Message-ID: <20040814142656.GB25939@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.35/drivers/macintosh/via-pmu.c	2004-07-27 00:05:13 +02:00
+++ edited/drivers/macintosh/via-pmu.c	2004-08-14 16:04:04 +02:00
@@ -138,7 +138,6 @@
 static volatile int adb_int_pending;
 static volatile int disable_poll;
 static struct adb_request bright_req_1, bright_req_2;
-static unsigned long async_req_locks;
 static struct device_node *vias;
 static int pmu_kind = PMU_UNKNOWN;
 static int pmu_fully_inited = 0;
@@ -155,6 +154,7 @@
 static int option_lid_wakeup = 1;
 static int sleep_in_progress;
 static int can_sleep;
+static unsigned long async_req_locks;
 #endif /* CONFIG_PMAC_PBOOK */
 static unsigned int pmu_irq_stats[11];
 
@@ -494,12 +494,9 @@
 	/* Create /proc/pmu */
 	proc_pmu_root = proc_mkdir("pmu", NULL);
 	if (proc_pmu_root) {
-		int i;
-		proc_pmu_info = create_proc_read_entry("info", 0, proc_pmu_root,
-					proc_get_info, NULL);
-		proc_pmu_irqstats = create_proc_read_entry("interrupts", 0, proc_pmu_root,
-					proc_get_irqstats, NULL);
 #ifdef CONFIG_PMAC_PBOOK
+		int i;
+
 		for (i=0; i<pmu_battery_count; i++) {
 			char title[16];
 			sprintf(title, "battery_%d", i);
@@ -507,6 +504,11 @@
 						proc_get_batt, (void *)i);
 		}
 #endif /* CONFIG_PMAC_PBOOK */
+
+		proc_pmu_info = create_proc_read_entry("info", 0, proc_pmu_root,
+					proc_get_info, NULL);
+		proc_pmu_irqstats = create_proc_read_entry("interrupts", 0, proc_pmu_root,
+					proc_get_irqstats, NULL);
 		proc_pmu_options = create_proc_entry("options", 0600, proc_pmu_root);
 		if (proc_pmu_options) {
 			proc_pmu_options->nlink = 1;
===== drivers/scsi/sd.c 1.155 vs edited =====
