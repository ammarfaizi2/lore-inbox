Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbTJYPvO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJYPvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 11:51:14 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:31507 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S262677AbTJYPvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 11:51:13 -0400
From: "Art Haas" <ahaas@airmail.net>
Date: Sat, 25 Oct 2003 10:51:07 -0500
To: parisc-linux@parisc-linux.org, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 cleanup in kernel/sysctl.c
Message-ID: <20031025155107.GA2718@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Looking at the file kernel/sysctl.c I saw this HP-PA specfic block of
code. Here's an untested patch to format the code with C99 named
initializers.

Art Haas

===== kernel/sysctl.c 1.55 vs edited =====
--- 1.55/kernel/sysctl.c	Thu Oct  2 02:12:07 2003
+++ edited/kernel/sysctl.c	Sat Oct 25 10:45:03 2003
@@ -336,10 +336,22 @@
 	},
 #endif
 #ifdef __hppa__
-	{KERN_HPPA_PWRSW, "soft-power", &pwrsw_enabled, sizeof (int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_HPPA_UNALIGNED, "unaligned-trap", &unaligned_enabled, sizeof (int),
-	 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= KERN_HPPA_PWRSW,
+		.procname	= "soft-power",
+		.data		= &pwrsw_enabled,
+		.maxlen		= sizeof (int),
+	 	.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_HPPA_UNALIGNED,
+		.procname	= "unaligned-trap",
+		.data		= &unaligned_enabled,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
 	{
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
