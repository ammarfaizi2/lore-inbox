Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUIIPxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUIIPxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUIIPqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:46:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45790 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265900AbUIIPmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:42:23 -0400
Date: Thu, 9 Sep 2004 17:42:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: kill crash when too much memory is free
Message-ID: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If too much memory is free, swsusp dies in quite a ugly way. Even when
it is not neccessary to relocate pagedir, it is proably still
neccessary to relocate individual pages. Thanks to Kurt Garloff and
Stefan Seyfried...
								Pavel
PS: And could I have one brown paper bag, please?

--- clean-mm/kernel/power/swsusp.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-09-09 08:56:20.000000000 +0200
@@ -950,9 +934,9 @@
 
 	printk("Relocating pagedir ");
 
-	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
+	if (!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
 		printk("not necessary\n");
-		return 0;
+		return check_pagedir();
 	}
 
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {



