Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161392AbWJKVFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161392AbWJKVFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWJKVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:04:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:10910 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161383AbWJKVEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:35 -0400
Date: Wed, 11 Oct 2006 14:03:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/67] uml: allow using again x86/x86_64 crypto code
Message-ID: <20061011210335.GC16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="uml-allow-using-again-x86-x86_64-crypto-code.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Enable compilation of x86_64 crypto code;, and add the needed constant
to make the code compile again (that macro was added to i386 asm-offsets
between 2.6.17 and 2.6.18, in 6c2bb98bc33ae33c7a33a133a4cd5a06395fece5).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/Makefile-x86_64                        |    2 +-
 arch/um/include/common-offsets.h               |    1 +
 arch/um/include/sysdep-i386/kernel-offsets.h   |    1 +
 arch/um/include/sysdep-x86_64/kernel-offsets.h |    1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.18.orig/arch/um/Makefile-x86_64
+++ linux-2.6.18/arch/um/Makefile-x86_64
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-core-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/ arch/x86_64/crypto/
 START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
--- linux-2.6.18.orig/arch/um/include/common-offsets.h
+++ linux-2.6.18/arch/um/include/common-offsets.h
@@ -15,3 +15,4 @@ DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
--- linux-2.6.18.orig/arch/um/include/sysdep-i386/kernel-offsets.h
+++ linux-2.6.18/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -1,6 +1,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/mman.h>
 
 #define DEFINE(sym, val) \
--- linux-2.6.18.orig/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ linux-2.6.18/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -2,6 +2,7 @@
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/page.h>
 #include <asm/mman.h>
 

--
