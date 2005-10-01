Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVJAHDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJAHDD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVJAHDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:03:03 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:53893 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750757AbVJAHDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:03:01 -0400
Date: Sat, 1 Oct 2005 00:03:04 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [drivers/eisa] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001070304.GG25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -281,13 +281,11 @@ static int __init eisa_probe (struct eis
 	/* First try to get hold of slot 0. If there is no device
 	 * here, simply fail, unless root->force_probe is set. */
 	
-	if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL))) {
+	if (!(edev = kzalloc (sizeof (*edev), GFP_KERNEL))) {
 		printk (KERN_ERR "EISA: Couldn't allocate mainboard slot\n");
 		return -ENOMEM;
 	}
 		
-	memset (edev, 0, sizeof (*edev));
-
 	if (eisa_request_resources (root, edev, 0)) {
 		printk (KERN_WARNING \
 			"EISA: Cannot allocate resource for mainboard\n");
@@ -317,13 +315,11 @@ static int __init eisa_probe (struct eis
  force_probe:
 	
         for (c = 0, i = 1; i <= root->slots; i++) {
-		if (!(edev = kmalloc (sizeof (*edev), GFP_KERNEL))) {
+		if (!(edev = kzalloc (sizeof (*edev), GFP_KERNEL))) {
 			printk (KERN_ERR "EISA: Out of memory for slot %d\n",
 				i);
 			continue;
 		}
-		
-		memset (edev, 0, sizeof (*edev));
 
 		if (eisa_request_resources (root, edev, i)) {
 			printk (KERN_WARNING \
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
