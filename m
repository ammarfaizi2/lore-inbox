Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992637AbWKAQeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992637AbWKAQeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946938AbWKAQet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:34:49 -0500
Received: from [198.99.130.12] ([198.99.130.12]:16050 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1946932AbWKAQet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:34:49 -0500
Message-Id: <200611011732.kA1HWfMd005504@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/2] UML - Include tidying
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2006 12:32:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the __NR_* constants, we need sys/syscall.h.
linux/unistd.h works as well since it includes syscall.h, however
syscall.h is more parsimonious.  We were inconsistent in this, and
this patch adds syscall.h includes where necessary and removes
linux/unistd.h includes where they are not needed.  

asm/unistd.h also includes the __NR_* constants, but these are not the
glibc-sanctioned ones, so this also removes one such inclusion.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/process.c	2006-10-30 12:57:27.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/process.c	2006-10-30 15:25:20.000000000 -0500
@@ -7,7 +7,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
-#include <linux/unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
Index: linux-2.6.18-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/skas/process.c	2006-10-30 13:11:24.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/skas/process.c	2006-10-30 15:26:38.000000000 -0500
@@ -14,7 +14,7 @@
 #include <sys/mman.h>
 #include <sys/user.h>
 #include <sys/time.h>
-#include <asm/unistd.h>
+#include <sys/syscall.h>
 #include <asm/types.h>
 #include "user.h"
 #include "sysdep/ptrace.h"
Index: linux-2.6.18-mm/arch/um/os-Linux/tls.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/tls.c	2006-10-30 12:57:27.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/tls.c	2006-10-30 15:25:55.000000000 -0500
@@ -1,7 +1,7 @@
 #include <errno.h>
+#include <unistd.h>
 #include <sys/ptrace.h>
 #include <sys/syscall.h>
-#include <unistd.h>
 #include <asm/ldt.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"

