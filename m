Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbULCUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbULCUAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbULCTxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:53:01 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:19204
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262479AbULCT3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:29:12 -0500
Message-Id: <200412032145.iB3LjCZW004705@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - Allow vsyscall code to build on 2.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:45:12 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch fixes compilation on 2.4 hosts by not relying on macros from 2.6
host kernel headers in one userspace file. It's about AT_SYSINFO_* macros.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN /dev/null arch/um/include/elf_user.h
--- /dev/null	2004-06-30 21:04:37.000000000 +0200
+++ linux-2.6.10-rc2-root/arch/um/include/elf_user.h	2004-11-25 17:33:23.559706592 +0100
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
+ * Licensed under the GPL
+ */
+
+#ifndef __ELF_USER_H__
+#define __ELF_USER_H__
+
+/* For compilation on a host that doesn't support AT_SYSINFO (Linux 2.4)  */
+
+#ifndef AT_SYSINFO
+#define AT_SYSINFO 32
+#endif
+#ifndef AT_SYSINFO_EHDR
+#define AT_SYSINFO_EHDR 33
+#endif
+
+#endif
diff -puN arch/um/os-Linux/elf_aux.c~compile-elf_aux arch/um/os-Linux/elf_aux.c
--- linux-2.6.10-rc2/arch/um/os-Linux/elf_aux.c~compile-elf_aux	2004-11-25 17:33:23.555707903 +0100
+++ linux-2.6.10-rc2-root/arch/um/os-Linux/elf_aux.c	2004-11-25 17:33:23.559706592 +0100
@@ -10,6 +10,7 @@
 #include <elf.h>
 #include <stddef.h>
 #include "init.h"
+#include "elf_user.h"
 
 #if ELF_CLASS == ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
_

