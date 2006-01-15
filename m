Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWAOUsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWAOUsH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWAOUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:47:56 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:30371 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750773AbWAOUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:52 -0500
Message-Id: <200601152139.k0FLdrwi027752@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 10/11] UML - Use setjmp/longjmp instead of sigsetjmp/siglongjmp
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are doing soft interrupts, there's no point in using
sigsetjmp and siglongjmp.  Using setjmp and longjmp saves a
sigprocmask on every jump.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/include/longjmp.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/longjmp.h	2006-01-09 11:44:53.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/longjmp.h	2006-01-09 11:48:47.000000000 -0500
@@ -5,13 +5,13 @@
 #include "os.h"
 
 #define UML_SIGLONGJMP(buf, val) do { \
-	siglongjmp(*buf, val);		\
+	longjmp(*buf, val);	\
 } while(0)
 
 #define UML_SIGSETJMP(buf, enable) ({ \
 	int n; \
 	enable = get_signals(); \
-	n = sigsetjmp(*buf, 1); \
+	n = setjmp(*buf); \
 	if(n != 0) \
 		set_signals(enable); \
 	n; })

