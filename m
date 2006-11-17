Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752809AbWKQTcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWKQTcD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825AbWKQTcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:32:03 -0500
Received: from [151.97.230.35] ([151.97.230.35]:4580 "EHLO memento.home.lan")
	by vger.kernel.org with ESMTP id S1752809AbWKQTcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:32:00 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] i386, x86_64: comment magic constants in delay.h
Date: Fri, 17 Nov 2006 20:30:48 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Message-Id: <20061117193048.13096.47786.stgit@americanbeauty.home.lan>
In-Reply-To: <20061101163043.GA2602@elf.ucw.cz>
References: <20061101163043.GA2602@elf.ucw.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

For both i386 and x86_64, copy from arch/$ARCH/lib/delay.c comments about the
used magic constants, plus a few other niceties.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-i386/delay.h   |    5 ++++-
 include/asm-x86_64/delay.h |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-i386/delay.h b/include/asm-i386/delay.h
index b1c7650..9ae5e37 100644
--- a/include/asm-i386/delay.h
+++ b/include/asm-i386/delay.h
@@ -7,6 +7,7 @@
  * Delay routines calling functions in arch/i386/lib/delay.c
  */
  
+/* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
 
@@ -15,10 +16,12 @@ extern void __ndelay(unsigned long nsecs
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
+/* 0x10c7 is 2**32 / 1000000 (rounded up) */
 #define udelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
-	
+
+/* 0x5 is 2**32 / 1000000000 (rounded up) */
 #define ndelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
 	__ndelay(n))
diff --git a/include/asm-x86_64/delay.h b/include/asm-x86_64/delay.h
index 40146f6..c2669f1 100644
--- a/include/asm-x86_64/delay.h
+++ b/include/asm-x86_64/delay.h
@@ -7,18 +7,21 @@
  * Delay routines calling functions in arch/x86_64/lib/delay.c
  */
  
+/* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
-extern void __ndelay(unsigned long usecs);
+extern void __ndelay(unsigned long nsecs);
 extern void __const_udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
+/* 0x10c7 is 2**32 / 1000000 (rounded up) */
 #define udelay(n) (__builtin_constant_p(n) ? \
 	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
 
+/* 0x5 is 2**32 / 1000000000 (rounded up) */
 #define ndelay(n) (__builtin_constant_p(n) ? \
        ((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
        __ndelay(n))
