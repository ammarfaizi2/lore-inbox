Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbSKSXTO>; Tue, 19 Nov 2002 18:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbSKSXSJ>; Tue, 19 Nov 2002 18:18:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267600AbSKSXPe>;
	Tue, 19 Nov 2002 18:15:34 -0500
Date: Tue, 19 Nov 2002 15:21:20 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <james.bottomley@hansenpartnership.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] voyager sysrq usage
Message-ID: <Pine.LNX.4.33L2.0211191516120.27979-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

This patch (to 2.5.48 plain) moves the Voyager sysrq dump key
from 'C' to 'V' and makes the 'V' a capital V in the help_msg.
The latter is the way that the other sysrq help messages indicate
which character key to use to invoke them, and it would be good
if the Voyager sysrq dump did the same.

It also documents this key in Documentation/sysrq.txt .

Is there any particular reason that Voyager sysrq dump is using
'C' to dump processor info?

BTW, how does someone enable CONFIG_VOYAGER to build a
Voyager kernel?

Please apply.
-- 
~Randy



--- ./drivers/char/sysrq.c%voy	Sun Nov 17 20:29:53 2002
+++ ./drivers/char/sysrq.c	Tue Nov 19 15:01:01 2002
@@ -326,7 +326,7 @@
 #ifdef CONFIG_VOYAGER
 static struct sysrq_key_op sysrq_voyager_dump_op = {
 	.handler	= voyager_dump,
-	.help_msg	= "voyager",
+	.help_msg	= "Voyager",
 	.action_msg	= "Dump Voyager Status\n",
 };
 #endif
@@ -364,11 +364,7 @@
 		 it is handled specially on the sparc
 		 and will never arrive */
 /* b */	&sysrq_reboot_op,
-#ifdef CONFIG_VOYAGER
-/* c */ &sysrq_voyager_dump_op,
-#else
 /* c */	NULL,
-#endif
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
@@ -396,7 +392,11 @@
 /* s */	&sysrq_sync_op,
 /* t */	&sysrq_showstate_op,
 /* u */	&sysrq_mountro_op,
+#ifdef CONFIG_VOYAGER
+/* v */ &sysrq_voyager_dump_op,
+#else
 /* v */	NULL,
+#endif
 /* w */	NULL,
 /* x */	NULL,
 /* y */	NULL,
--- ./Documentation/sysrq.txt%voy	Sun Nov 17 20:29:45 2002
+++ ./Documentation/sysrq.txt	Tue Nov 19 15:04:25 2002
@@ -59,6 +59,8 @@

 'm'     - Will dump current memory info to your console.

+'v'	- Dumps Voyager SMP processor info to your console.
+
 '0'-'9' - Sets the console log level, controlling which kernel messages
           will be printed to your console. ('0', for example would make
           it so that only emergency messages like PANICs or OOPSes would

