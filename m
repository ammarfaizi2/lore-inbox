Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbULYRjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbULYRjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbULYRjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:39:54 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:54912 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261542AbULYRjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:39:36 -0500
Date: Sat, 25 Dec 2004 18:38:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: Small cleanups
Message-ID: <20041225173819.GA10167@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds statics at few places and fixes stale references to
pmdisk. Please apply,
                                                                Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-cvs/kernel/power/swsusp.c	2004-12-14 20:43:42.000000000 +0100
+++ linux-cvs/kernel/power/swsusp.c	2004-12-14 20:48:31.000000000 +0100
@@ -104,14 +102,14 @@
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
-struct swsusp_header {
+static struct swsusp_header {
 	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
 	swp_entry_t swsusp_info;
 	char	orig_sig[10];
 	char	sig[10];
 } __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
 
-struct swsusp_info swsusp_info;
+static struct swsusp_info swsusp_info;
 
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
@@ -174,7 +172,7 @@
 		resume_device == MKDEV(imajor(inode), iminor(inode));
 }
 
-int swsusp_swap_check(void) /* This is called before saving image */
+static int swsusp_swap_check(void) /* This is called before saving image */
 {
 	int i, len;
 	
@@ -1216,7 +1189,7 @@
 }
 
 /**
- *	pmdisk_read - Read saved image from swap.
+ *	swsusp_read - Read saved image from swap.
  */
 
 int __init swsusp_read(void)
@@ -1240,6 +1213,6 @@
 	if (!error)
 		pr_debug("Reading resume file was successful\n");
 	else
-		pr_debug("pmdisk: Error %d resuming\n", error);
+		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
