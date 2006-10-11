Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161516AbWJKVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161516AbWJKVXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161410AbWJKVGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:48543 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161398AbWJKVGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:11 -0400
Date: Wed, 11 Oct 2006 14:05:39 -0700
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
Subject: [patch 26/67] Fix make headers_check on sh64
Message-ID: <20061011210539.GA16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0004-Fix-make-headers_check-on-sh64.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Paul Mundt <lethal@linux-sh.org>

Cleanup for user headers, as noted:

asm-sh64/page.h requires asm-generic/memory_model.h, which does not exist in exported headers
asm-sh64/shmparam.h requires asm/cache.h, which does not exist in exported headers
asm-sh64/signal.h requires asm/processor.h, which does not exist in exported headers
asm-sh64/user.h requires asm/processor.h, which does not exist in exported headers

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-sh64/page.h     |    3 +--
 include/asm-sh64/shmparam.h |   16 ++++------------
 include/asm-sh64/signal.h   |    1 -
 include/asm-sh64/user.h     |    1 -
 4 files changed, 5 insertions(+), 16 deletions(-)

--- linux-2.6.18.orig/include/asm-sh64/page.h
+++ linux-2.6.18/include/asm-sh64/page.h
@@ -112,9 +112,8 @@ typedef struct { unsigned long pgprot; }
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
 #endif /* __ASM_SH64_PAGE_H */
--- linux-2.6.18.orig/include/asm-sh64/shmparam.h
+++ linux-2.6.18/include/asm-sh64/shmparam.h
@@ -2,19 +2,11 @@
 #define __ASM_SH64_SHMPARAM_H
 
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * include/asm-sh64/shmparam.h
- *
- * Copyright (C) 2000, 2001  Paolo Alberelli
- *
+ * Set this to a sensible safe default, we'll work out the specifics for the
+ * align mask from the cache descriptor at run-time.
  */
+#define	SHMLBA	0x4000
 
-#include <asm/cache.h>
-
-/* attach addr a multiple of this */
-#define	SHMLBA	(cpu_data->dcache.sets * L1_CACHE_BYTES)
+#define __ARCH_FORCE_SHMLBA
 
 #endif /* __ASM_SH64_SHMPARAM_H */
--- linux-2.6.18.orig/include/asm-sh64/signal.h
+++ linux-2.6.18/include/asm-sh64/signal.h
@@ -13,7 +13,6 @@
  */
 
 #include <linux/types.h>
-#include <asm/processor.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
--- linux-2.6.18.orig/include/asm-sh64/user.h
+++ linux-2.6.18/include/asm-sh64/user.h
@@ -13,7 +13,6 @@
  */
 
 #include <linux/types.h>
-#include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
 

--
