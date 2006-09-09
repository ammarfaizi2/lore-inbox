Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWIIL3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWIIL3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWIIL3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:29:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19605 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932073AbWIIL3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:29:53 -0400
Subject: [PATCH] [4/6] Move kernel-only #includes within <asm-i386/elf.h>
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157800733.2977.40.camel@pmac.infradead.org>
References: <1157800733.2977.40.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:29:31 +0100
Message-Id: <1157801371.2977.57.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some files which don't exist in userspace were being included
unconditionally in asm-i386/elf.h. Move the offending #includes down a
few lines so that they're protected by #ifdef __KERNEL__

In fact, we probably want to kill off all userspace use of asm/elf.h --
but we aren't there yet, so we should at least make it possible to
include it for now.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-i386/elf.h b/include/asm-i386/elf.h
index 1eac92c..db4344d 100644
--- a/include/asm-i386/elf.h
+++ b/include/asm-i386/elf.h
@@ -7,10 +7,7 @@ #define __ASMi386_ELF_H
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
-#include <asm/processor.h>
-#include <asm/system.h>		/* for savesegment */
 #include <asm/auxvec.h>
-#include <asm/desc.h>
 
 #include <linux/utsname.h>
 
@@ -48,6 +45,12 @@ #define ELF_CLASS	ELFCLASS32
 #define ELF_DATA	ELFDATA2LSB
 #define ELF_ARCH	EM_386
 
+#ifdef __KERNEL__
+
+#include <asm/processor.h>
+#include <asm/system.h>		/* for savesegment */
+#include <asm/desc.h>
+
 /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program starts %edx
    contains a pointer to a function which might be registered using `atexit'.
    This provides a mean for the dynamic linker to call DT_FINI functions for
@@ -111,7 +114,6 @@ #define ELF_HWCAP	(boot_cpu_data.x86_cap
 
 #define ELF_PLATFORM  (system_utsname.machine)
 
-#ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 /*

-- 
dwmw2

