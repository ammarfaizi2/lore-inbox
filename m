Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161427AbWJKVXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161427AbWJKVXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161398AbWJKVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:46751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161404AbWJKVGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:10 -0400
Date: Wed, 11 Oct 2006 14:05:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 28/67] Fix exported headers for SPARC, SPARC64
Message-ID: <20061011210546.GC16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0006-Fix-exported-headers-for-SPARC-SPARC64.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

Mostly removing files which have no business being used in userspace.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-sparc/Kbuild       |    7 -------
 include/asm-sparc/page.h       |    8 ++++----
 include/asm-sparc64/Kbuild     |    5 +----
 include/asm-sparc64/page.h     |    9 ++++-----
 include/asm-sparc64/shmparam.h |    2 ++
 5 files changed, 11 insertions(+), 20 deletions(-)

--- linux-2.6.18.orig/include/asm-sparc/Kbuild
+++ linux-2.6.18/include/asm-sparc/Kbuild
@@ -2,20 +2,13 @@ include include/asm-generic/Kbuild.asm
 
 header-y += apc.h
 header-y += asi.h
-header-y += auxio.h
 header-y += bpp.h
-header-y += head.h
-header-y += ipc.h
 header-y += jsflash.h
 header-y += openpromio.h
-header-y += pbm.h
 header-y += pconf.h
-header-y += pgtsun4.h
 header-y += reg.h
 header-y += traps.h
-header-y += turbosparc.h
 header-y += vfc_ioctls.h
-header-y += winmacro.h
 
 unifdef-y += fbio.h
 unifdef-y += perfctr.h
--- linux-2.6.18.orig/include/asm-sparc/page.h
+++ linux-2.6.18/include/asm-sparc/page.h
@@ -8,6 +8,8 @@
 #ifndef _SPARC_PAGE_H
 #define _SPARC_PAGE_H
 
+#ifdef __KERNEL__
+
 #ifdef CONFIG_SUN4
 #define PAGE_SHIFT   13
 #else
@@ -21,8 +23,6 @@
 #endif
 #define PAGE_MASK    (~(PAGE_SIZE-1))
 
-#ifdef __KERNEL__
-
 #include <asm/btfixup.h>
 
 #ifndef __ASSEMBLY__
@@ -160,9 +160,9 @@ extern unsigned long pfn_base;
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
+
 #endif /* _SPARC_PAGE_H */
--- linux-2.6.18.orig/include/asm-sparc64/Kbuild
+++ linux-2.6.18/include/asm-sparc64/Kbuild
@@ -8,15 +8,12 @@ header-y += apb.h
 header-y += asi.h
 header-y += bbc.h
 header-y += bpp.h
+header-y += const.h
 header-y += display7seg.h
 header-y += envctrl.h
-header-y += floppy.h
 header-y += ipc.h
-header-y += kdebug.h
-header-y += mostek.h
 header-y += openprom.h
 header-y += openpromio.h
-header-y += parport.h
 header-y += pconf.h
 header-y += psrcompat.h
 header-y += pstate.h
--- linux-2.6.18.orig/include/asm-sparc64/page.h
+++ linux-2.6.18/include/asm-sparc64/page.h
@@ -3,6 +3,8 @@
 #ifndef _SPARC64_PAGE_H
 #define _SPARC64_PAGE_H
 
+#ifdef __KERNEL__
+
 #include <asm/const.h>
 
 #if defined(CONFIG_SPARC64_PAGE_SIZE_8KB)
@@ -27,8 +29,6 @@
 #define DCACHE_ALIASING_POSSIBLE
 #endif
 
-#ifdef __KERNEL__
-
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_4MB)
 #define HPAGE_SHIFT		22
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_512K)
@@ -141,8 +141,7 @@ typedef unsigned long pgprot_t;
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* !(__KERNEL__) */
-
 #include <asm-generic/page.h>
 
-#endif /* !(_SPARC64_PAGE_H) */
+#endif /* __KERNEL__ */
+#endif /* _SPARC64_PAGE_H */
--- linux-2.6.18.orig/include/asm-sparc64/shmparam.h
+++ linux-2.6.18/include/asm-sparc64/shmparam.h
@@ -1,6 +1,7 @@
 /* $Id: shmparam.h,v 1.5 2001/09/24 21:17:57 kanoj Exp $ */
 #ifndef _ASMSPARC64_SHMPARAM_H
 #define _ASMSPARC64_SHMPARAM_H
+#ifdef __KERNEL__
 
 #include <asm/spitfire.h>
 
@@ -8,4 +9,5 @@
 /* attach addr a multiple of this */
 #define	SHMLBA	((PAGE_SIZE > L1DCACHE_SIZE) ? PAGE_SIZE : L1DCACHE_SIZE)
 
+#endif /* __KERNEL__ */
 #endif /* _ASMSPARC64_SHMPARAM_H */

--
