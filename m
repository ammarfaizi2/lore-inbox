Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275202AbTHRWGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275211AbTHRWGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:06:15 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:14518
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id S275202AbTHRWGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:06:07 -0400
Date: Mon, 18 Aug 2003 15:06:05 -0700
From: Phil Oester <kernel@theoesters.com>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
Subject: [PATCH] Ratelimit SO_BSDCOMPAT warnings
Message-ID: <20030818150605.A23957@ns1.theoesters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in March, there was some discussion about ratelimiting the
BSDCOMPAT errors, and James Morris provided a patch to achieve
this.

http://www.ussg.iu.edu/hypermail/linux/kernel/0303.3/1078.html

To which David Miller stated the patch had been applied.

http://www.ussg.iu.edu/hypermail/linux/kernel/0303.3/1081.html

Unfortunately, it seems to have fallen through the cracks.  Below
is the patch again, updated for 2.6.0-test3 - please apply.

Phil Oester

--- linux-2.6.0-test3-orig/net/core/sock.c      Sat Aug  9 00:38:59 2003
+++ linux-2.6.0-test3/net/core/sock.c   Mon Aug 18 18:01:15 2003
@@ -153,8 +153,13 @@
 
 static void sock_warn_obsolete_bsdism(const char *name)
 {
-       printk(KERN_WARNING "process `%s' is using obsolete "
-              "%s SO_BSDCOMPAT\n", current->comm, name);
+       static int warned;
+
+       if (!warned) {
+               warned = 1;
+               printk(KERN_WARNING "process `%s' is using obsolete "
+                      "%s SO_BSDCOMPAT\n", current->comm, name);
+       }
 }
 
 /*

