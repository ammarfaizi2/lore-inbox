Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265077AbUEKXzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265077AbUEKXzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUEKXwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:52:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:52392 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263467AbUEKXuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:50:02 -0400
Date: Tue, 11 May 2004 16:50:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] minor cleanups in capability.c
Message-ID: <20040511165000.P21045@build.pdx.osdl.net>
References: <20040511164640.O21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511164640.O21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 04:46:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove confusing error message when loading as secondary module, and
ditch conditional MY_NAME macro.

--- linus-2.5/security/capability.c~verbose	2004-05-11 15:44:11.651038464 -0700
+++ linus-2.5/security/capability.c	2004-05-11 16:02:25.144802144 -0700
@@ -47,11 +47,7 @@
 	.vm_enough_memory =             cap_vm_enough_memory,
 };
 
-#if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
-#define MY_NAME THIS_MODULE->name
-#else
-#define MY_NAME "capability"
-#endif
+#define MY_NAME __stringify(KBUILD_MODNAME)
 
 /* flag to keep track of how we were registered */
 static int secondary;
@@ -61,8 +57,6 @@
 {
 	/* register ourselves with the security framework */
 	if (register_security (&capability_ops)) {
-		printk (KERN_INFO
-			"Failure registering capabilities with the kernel\n");
 		/* try registering with primary module */
 		if (mod_reg_security (MY_NAME, &capability_ops)) {
 			printk (KERN_INFO "Failure registering capabilities "
@@ -71,7 +65,8 @@
 		}
 		secondary = 1;
 	}
-	printk (KERN_INFO "Capability LSM initialized\n");
+	printk (KERN_INFO "Capability LSM initialized%s\n",
+		secondary ? " as secondary" : "");
 	return 0;
 }
 
