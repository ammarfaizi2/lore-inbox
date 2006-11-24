Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934524AbWKXJrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934524AbWKXJrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934525AbWKXJrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:47:53 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:46826 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S934524AbWKXJrw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:47:52 -0500
To: jdike@addtoit.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: UML compile problems on -mm
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <E1GnXeZ-00052H-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 24 Nov 2006 10:47:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having problems compiling UML on 2.6.19-rc6-mm1:

  CC      arch/um/os-Linux/skas/process.o
arch/um/os-Linux/skas/process.c:538:2: warning: #warning need cpu pid in switch_mm_skas
arch/um/os-Linux/skas/process.c: In function ‘copy_context_skas0’:
arch/um/os-Linux/skas/process.c:342: error: ‘PAGE_SHIFT’ undeclared (first use in this function)
arch/um/os-Linux/skas/process.c:342: error: (Each undeclared identifier is reported only once
arch/um/os-Linux/skas/process.c:342: error: for each function it appears in.)
make[2]: *** [arch/um/os-Linux/skas/process.o] Error 1

After applying this patch:

Index: linux/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux.orig/arch/um/include/sysdep-i386/stub.h	2006-11-23 13:51:54.000000000 +0100
+++ linux/arch/um/include/sysdep-i386/stub.h	2006-11-23 13:52:10.000000000 +0100
@@ -9,6 +9,7 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
+#include <asm/page.h>
 #include "stub-data.h"
 #include "kern_constants.h"
 #include "uml-config.h"

it still fails on linking:

  LD      .tmp_vmlinux1
lib/lib.a(bug.o): In function `find_bug':
lib/bug.c:108: undefined reference to `__start___bug_table'
lib/bug.c:108: undefined reference to `__stop___bug_table'
lib/bug.c:109: undefined reference to `__start___bug_table'
lib/bug.c:109: undefined reference to `__start___bug_table'
lib/bug.c:108: undefined reference to `__stop___bug_table'
collect2: ld returned 1 exit status

Miklos
