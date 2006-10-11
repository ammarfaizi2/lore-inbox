Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161407AbWJKVHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407AbWJKVHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWJKVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:43679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161407AbWJKVGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:08 -0400
Date: Wed, 11 Oct 2006 14:05:36 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Paul Mundt <lethal@linux-sh.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 25/67] Fix make headers_check on sh
Message-ID: <20061011210536.GZ16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0003-Fix-make-headers_check-on-sh.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Paul Mundt <lethal@linux-sh.org>

Cleanup for user headers, as noted:

asm-sh/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-sh/ptrace.h requires asm/ubc.h, which does not exist in exported headers

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/sh/kernel/process.c |    1 +
 include/asm-sh/page.h    |    3 +--
 include/asm-sh/ptrace.h  |    2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.18.orig/arch/sh/kernel/process.c
+++ linux-2.6.18/arch/sh/kernel/process.c
@@ -26,6 +26,7 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/elf.h>
+#include <asm/ubc.h>
 
 static int hlt_counter=0;
 
--- linux-2.6.18.orig/include/asm-sh/page.h
+++ linux-2.6.18/include/asm-sh/page.h
@@ -112,9 +112,8 @@ typedef struct { unsigned long pgprot; }
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
 #endif /* __ASM_SH_PAGE_H */
--- linux-2.6.18.orig/include/asm-sh/ptrace.h
+++ linux-2.6.18/include/asm-sh/ptrace.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_SH_PTRACE_H
 #define __ASM_SH_PTRACE_H
 
-#include <asm/ubc.h>
-
 /*
  * Copyright (C) 1999, 2000  Niibe Yutaka
  *

--
