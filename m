Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbULKPkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbULKPkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbULKPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:40:43 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:65154 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261950AbULKPkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:40:35 -0500
Date: Sat, 11 Dec 2004 16:40:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp bugfixes: do not oops when not enough memory during resume
Message-ID: <20041211154022.GA1860@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This prevents oops when not enough memory is available during
resume. Please apply,
							Pavel

--- clean/kernel/power/swsusp.c	28 Oct 2004 15:21:34 -0000	1.29
+++ linux/kernel/power/swsusp.c	10 Dec 2004 21:35:59 -0000
@@ -985,6 +969,8 @@
 		c = *c;
 		free_pages((unsigned long)f, pagedir_order);
 	}
+	if (ret)
+		return ret;
 	printk("|\n");
 	return check_pagedir();
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
