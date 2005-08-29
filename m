Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbVH2UPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbVH2UPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbVH2UOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:14:06 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:36110 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751596AbVH2UOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:14:02 -0400
Message-Id: <200508292007.j7TK7Ags029938@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/9] UML - UML/i386 is i386 when running on x86_64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:07:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Paolo Giarrusso - Make a UML/i386 instance running on x86_64 pretend
to be i386 rather than x86_64.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc6/arch/um/kernel/user_util.c
===================================================================
--- linux-2.6.12-rc6.orig/arch/um/kernel/user_util.c	2005-08-08 12:32:06.000000000 -0400
+++ linux-2.6.12-rc6/arch/um/kernel/user_util.c	2005-08-12 14:00:34.000000000 -0400
@@ -132,7 +132,12 @@
 	struct utsname host;
 
 	uname(&host);
-	strcpy(machine_out, host.machine);
+	/* XXX: crude detection of 32-bit binary. */
+	if (sizeof(long) == 4 && !strcmp(host.machine, "x86_64")) {
+		strcpy(machine_out, "i686");
+	} else {
+		strcpy(machine_out, host.machine);
+	}
 }
 
 char host_info[(_UTSNAME_LENGTH + 1) * 4 + _UTSNAME_NODENAME_LENGTH + 1];

