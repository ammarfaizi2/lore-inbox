Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWBCSn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWBCSn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWBCSn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:43:59 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:28850 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030198AbWBCSn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:43:58 -0500
Date: Fri, 3 Feb 2006 13:39:53 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch -mm4 take 2] sched: only print migration_cost once per
  boot
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602031342_MC3-1-B787-2DE1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

migration_cost prints after every CPU hotplug event.  Make it
print only once at boot.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm4-386.orig/kernel/sched.c
+++ 2.6.16-rc1-mm4-386/kernel/sched.c
@@ -5699,13 +5699,15 @@ static void calibrate_migration_costs(co
 			-1
 #endif
 		);
-	printk("migration_cost=");
-	for (distance = 0; distance <= max_distance; distance++) {
-		if (distance)
-			printk(",");
-		printk("%ld", (long)migration_cost[distance] / 1000);
+	if (system_state == SYSTEM_BOOTING) {
+		printk("migration_cost=");
+		for (distance = 0; distance <= max_distance; distance++) {
+			if (distance)
+				printk(",");
+			printk("%ld", (long)migration_cost[distance] / 1000);
+		}
+		printk("\n");
 	}
-	printk("\n");
 	j1 = jiffies;
 	if (migration_debug)
 		printk("migration: %ld seconds\n", (j1-j0)/HZ);
-- 
Chuck
