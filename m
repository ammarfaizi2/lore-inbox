Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967754AbWLDXRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967754AbWLDXRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759830AbWLDXQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:16:26 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:47872 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759835AbWLDXQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:16:22 -0500
Message-Id: <200612042312.kB4NCJ2Q024556@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/4] UML - include stddef.h correctly
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Dec 2006 18:12:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were not including stddef.h in files that used offsetof.

One file was also including linux/stddef.h for no perciptible reason.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/ldt.c	2006-12-04 14:25:45.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/ldt.c	2006-12-04 14:26:12.000000000 -0500
@@ -3,7 +3,6 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
 #include "linux/sched.h"
 #include "linux/slab.h"
 #include "linux/types.h"
Index: linux-2.6.18-mm/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/ptrace_user.c	2006-12-04 14:25:45.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/ptrace_user.c	2006-12-04 14:26:12.000000000 -0500
@@ -4,9 +4,9 @@
  */
 
 #include <stdio.h>
+#include <stddef.h>
 #include <errno.h>
 #include <unistd.h>
-#include <linux/stddef.h>
 #include "ptrace_user.h"
 /* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
 #include <asm/user.h>
Index: linux-2.6.18-mm/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/user-offsets.c	2006-12-04 14:25:45.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/user-offsets.c	2006-12-04 14:26:12.000000000 -0500
@@ -2,7 +2,7 @@
 #include <signal.h>
 #include <asm/ptrace.h>
 #include <asm/user.h>
-#include <linux/stddef.h>
+#include <stddef.h>
 #include <sys/poll.h>
 
 #define DEFINE(sym, val) \

