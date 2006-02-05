Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWBELpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWBELpj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWBELpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:45:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35046 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751717AbWBELpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:45:39 -0500
Date: Sun, 5 Feb 2006 12:45:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] suspend: make progress printing prettier
Message-ID: <20060205114526.GA3126@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Combination of printk/pr_debug led to <7> in the middle of the line,
and we printed way too many dots.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 41f6636..c9c293f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -80,7 +80,7 @@ static int save_highmem_zone(struct zone
 		void *kaddr;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
 
-		if (!(pfn%1000))
+		if (!(pfn%10000))
 			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
@@ -121,13 +121,14 @@ int save_highmem(void)
 	struct zone *zone;
 	int res = 0;
 
-	pr_debug("swsusp: Saving Highmem\n");
+	pr_debug("swsusp: Saving Highmem");
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			res = save_highmem_zone(zone);
 		if (res)
 			return res;
 	}
+	printk("\n");
 	return 0;
 }
 

-- 
Thanks, Sharp!
