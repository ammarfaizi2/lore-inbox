Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVAJFNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVAJFNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVAJFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:13:50 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:13316
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262067AbVAJFNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:13:48 -0500
Message-Id: <200501100735.j0A7Z9PW005740@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH 2/28] UML - Use va_end wherever va_args are used
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finish using va_list correctly, by calling va_end.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/signal_user.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/signal_user.c	2004-12-14 12:10:30.000000000 -0500
+++ 2.6.10/arch/um/kernel/signal_user.c	2004-12-14 15:51:35.000000000 -0500
@@ -41,6 +41,7 @@
 	while((mask = va_arg(ap, int)) != -1){
 		sigaddset(&action.sa_mask, mask);
 	}
+	va_end(ap);
 	action.sa_flags = flags;
 	action.sa_restorer = NULL;
 	if(sigaction(sig, &action, NULL) < 0)
Index: 2.6.10/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/tracer.c	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/tracer.c	2004-12-14 15:51:35.000000000 -0500
@@ -84,6 +84,7 @@
 
 	va_start(ap, format);
 	vprintf(format, ap);
+	va_end(ap);
 	printf("\n");
 	while(1) pause();
 }

