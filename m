Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVBZSFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVBZSFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBZSFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 13:05:48 -0500
Received: from pop.gmx.de ([213.165.64.20]:19658 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261247AbVBZSFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:05:39 -0500
X-Authenticated: #264456
Date: Sat, 26 Feb 2005 19:05:56 +0100
From: Matthias Kunze <Matthias.Kunze@gmx-topmail.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] config option for default loglevel
Message-Id: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de>
Reply-To: Matthias.Kunze@gmx-topmail.de
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've created a little patch to make the default loglevel a configurable
option. Is there a chance that this patch will be included in a future
release?

diff -Naur linux-2.6.10/drivers/video/console/Kconfig linux-2.6.10-new/drivers/video/console/Kconfig
--- linux-2.6.10/drivers/video/console/Kconfig  2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10-new/drivers/video/console/Kconfig      2005-02-26 17:11:03.000000000 +0100
@@ -186,5 +186,25 @@
          big letters (like the letters used in the SPARC PROM). If the
          standard font is unreadable for you, say Y, otherwise say N.
 
+config DEFAULT_CONSOLE_LOGLEVEL
+        int "Default Console Loglevel"
+        range 1 8
+        default 7
+        help
+          All Kernel Messages with a loglevel smaller than the console loglevel
+          will be printed to the console. This value can later be changed with
+          klogd or other programs. The loglevels are defined as follows:
+
+          0 (KERN_EMERG)        system is unusable
+          1 (KERN_ALERT)        action must be taken immediately
+          2 (KERN_CRIT)         critical conditions
+          3 (KERN_ERR)          error conditions
+          4 (KERN_WARNING)      warning conditions
+          5 (KERN_NOTICE)       normal but significant condition
+          6 (KERN_INFO)         informational
+          7 (KERN_DEBUG)        debug-level messages
+
+          The console loglevel can be set to a value in the range from 1 to 8.
+
 endmenu
 
diff -Naur linux-2.6.10/kernel/printk.c linux-2.6.10-new/kernel/printk.c
--- linux-2.6.10/kernel/printk.c        2005-02-26 16:49:03.000000000 +0100
+++ linux-2.6.10-new/kernel/printk.c    2005-02-26 17:32:09.000000000 +0100
@@ -41,7 +41,7 @@
 
 /* We show everything that is MORE important than this.. */
 #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */
-#define DEFAULT_CONSOLE_LOGLEVEL 7 /* anything MORE serious than KERN_DEBUG */
+#define DEFAULT_CONSOLE_LOGLEVEL CONFIG_DEFAULT_CONSOLE_LOGLEVEL
 
 DECLARE_WAIT_QUEUE_HEAD(log_wait);


---
Matthias Kunze
http://elpp.foofighter.de
