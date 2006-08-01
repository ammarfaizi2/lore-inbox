Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWHASUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWHASUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWHASUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:20:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21931 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751760AbWHASUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:20:07 -0400
Date: Tue, 1 Aug 2006 14:20:00 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: don't print migration cost when only 1 CPU
Message-ID: <20060801182000.GI22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If only a single CPU is present, printing this doesn't make much sense.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/kernel/sched.c~	2006-04-24 19:30:13.000000000 -0400
+++ linux-2.6/kernel/sched.c	2006-04-24 19:32:49.000000000 -0400
@@ -5518,13 +5518,15 @@ static void calibrate_migration_costs(co
 #endif
 		);
 	if (system_state == SYSTEM_BOOTING) {
-		printk("migration_cost=");
-		for (distance = 0; distance <= max_distance; distance++) {
-			if (distance)
-				printk(",");
-			printk("%ld", (long)migration_cost[distance] / 1000);
+		if (num_online_cpus() > 1) {
+			printk("migration_cost=");
+			for (distance = 0; distance <= max_distance; distance++) {
+				if (distance)
+					printk(",");
+				printk("%ld", (long)migration_cost[distance] / 1000);
+			}
+			printk("\n");
 		}
-		printk("\n");
 	}
 	j1 = jiffies;
 	if (migration_debug)

-- 
http://www.codemonkey.org.uk
