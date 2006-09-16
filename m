Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWIQFKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWIQFKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 01:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWIQFKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 01:10:10 -0400
Received: from xenotime.net ([66.160.160.81]:38846 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932184AbWIQFKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 01:10:09 -0400
Date: Sat, 16 Sep 2006 15:11:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Cc: adobriyan@gmail.com, rossb@google.com
Subject: [PATCH] config.gz doesn't need module_exit
Message-Id: <20060916151122.7d57eeb8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

This is an alternative patch to the current /proc/config.gz
'module' patch from Ross.  Pointed out by Alexey.

/proc/config.gz handler doesn't need module_exit() since it
isn't built as a module and the exit function won't be used
when the code is built into the kernel.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 kernel/configs.c |    9 ---------
 1 files changed, 9 deletions(-)

--- linux-2618-rc7work.orig/kernel/configs.c
+++ linux-2618-rc7work/kernel/configs.c
@@ -99,16 +99,7 @@ static int __init ikconfig_init(void)
 	return 0;
 }
 
-/***************************************************/
-/* ikconfig_cleanup: clean up our mess           */
-
-static void __exit ikconfig_cleanup(void)
-{
-	remove_proc_entry("config.gz", &proc_root);
-}
-
 module_init(ikconfig_init);
-module_exit(ikconfig_cleanup);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Randy Dunlap");


---
