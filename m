Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWBGCXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWBGCXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWBGCWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:22:52 -0500
Received: from [198.99.130.12] ([198.99.130.12]:18155 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964940AbWBGCWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:22:48 -0500
Message-Id: <200602070223.k172Nr2L009659@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: [PATCH 3/8] UML - Add debug switch for skas mode
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Feb 2006 21:23:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't do anything but emit a warning, but there's a user population
that's used to adding 'debug' to the UML command line in order to gdb it.
With skas0 mode, that's not necessary, but these users need some indication
that 'debug' doesn't do what they want.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/um_arch.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/um_arch.c	2006-02-06 17:35:35.000000000 -0500
@@ -193,6 +193,24 @@ __uml_setup("root=", uml_root_setup,
 "        root=/dev/ubd5\n\n"
 );
 
+#ifndef CONFIG_MODE_TT
+
+static int __init no_skas_debug_setup(char *line, int *add)
+{
+	printf("'debug' is not necessary to gdb UML in skas mode - run \n");
+	printf("'gdb linux' and disable CONFIG_CMDLINE_ON_HOST if gdb \n");
+	printf("doesn't work as expected\n");
+
+	return 0;
+}
+
+__uml_setup("debug", no_skas_debug_setup,
+"debug\n"
+"    this flag is not needed to run gdb on UML in skas mode\n\n"
+);
+
+#endif
+
 #ifdef CONFIG_SMP
 static int __init uml_ncpus_setup(char *line, int *add)
 {

