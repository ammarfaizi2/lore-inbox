Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161408AbWJKVGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161408AbWJKVGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161415AbWJKVGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:56223 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161412AbWJKVGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:17 -0400
Date: Wed, 11 Oct 2006 14:05:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 24/67] Fix ARM make headers_check
Message-ID: <20061011210531.GY16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0002-HEADERS-Fix-ARM-make-headers_check.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

Sanitise the ARM headers exported to userspace.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-arm/elf.h  |   18 ++++++++----------
 include/asm-arm/page.h |    4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

--- linux-2.6.18.orig/include/asm-arm/elf.h
+++ linux-2.6.18/include/asm-arm/elf.h
@@ -8,9 +8,6 @@
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
-#ifdef __KERNEL
-#include <asm/procinfo.h>
-#endif
 
 typedef unsigned long elf_greg_t;
 typedef unsigned long elf_freg_t[3];
@@ -32,11 +29,6 @@ typedef elf_greg_t elf_gregset_t[ELF_NGR
 typedef struct user_fp elf_fpregset_t;
 
 /*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) ( ((x)->e_machine == EM_ARM) && (ELF_PROC_OK((x))) )
-
-/*
  * These are used to set parameters in the core dumps.
  */
 #define ELF_CLASS	ELFCLASS32
@@ -47,6 +39,14 @@ typedef struct user_fp elf_fpregset_t;
 #endif
 #define ELF_ARCH	EM_ARM
 
+#ifdef __KERNEL__
+#include <asm/procinfo.h>
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) ( ((x)->e_machine == EM_ARM) && (ELF_PROC_OK((x))) )
+
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
 
@@ -83,8 +83,6 @@ typedef struct user_fp elf_fpregset_t;
 extern char elf_platform[];
 #define ELF_PLATFORM	(elf_platform)
 
-#ifdef __KERNEL__
-
 /*
  * 32-bit code is always OK.  Some cpus can do 26-bit, some can't.
  */
--- linux-2.6.18.orig/include/asm-arm/page.h
+++ linux-2.6.18/include/asm-arm/page.h
@@ -11,13 +11,13 @@
 #define _ASMARM_PAGE_H
 
 
+#ifdef __KERNEL__
+
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT		12
 #define PAGE_SIZE		(1UL << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
-#ifdef __KERNEL__
-
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 

--
