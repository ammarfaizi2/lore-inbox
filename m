Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUJDJ6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUJDJ6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 05:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUJDJ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 05:58:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:44477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267903AbUJDJ6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 05:58:36 -0400
Date: Mon, 4 Oct 2004 02:55:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: yoshfuji@linux-ipv6.org, jmorris@redhat.com, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add rotate left/right ops to bitops.h
Message-Id: <20041004025510.69fafbc5.akpm@osdl.org>
In-Reply-To: <200410031359.45549.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410031344.54182.vda@port.imtp.ilyichevsk.odessa.ua>
	<20041003.195645.08061913.yoshfuji@linux-ipv6.org>
	<200410031359.45549.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> 269r3rot.diff  text/x-diff (4685 bytes)



- bitops.h needs types.h for u64

- Fix ghastly coding style innovations.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-i386/bitops.h |   55 ++++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 25 deletions(-)

diff -puN include/asm-i386/bitops.h~add-rotate-left-right-ops-to-bitopsh-build-fix include/asm-i386/bitops.h
--- 25/include/asm-i386/bitops.h~add-rotate-left-right-ops-to-bitopsh-build-fix	2004-10-03 21:18:30.801267776 -0700
+++ 25-akpm/include/asm-i386/bitops.h	2004-10-03 21:28:53.625584088 -0700
@@ -7,6 +7,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /*
  * These have to be done with inline assembly: that way the bit-setting
@@ -446,25 +447,25 @@ static inline int ffs(int x)
  * Have to stick to edx,eax pair only because
  * gcc has limited support for 64bit asm parameters
  */
-#define constant_rol64(v,c) \
+#define constant_rol64(v, c)				\
 	({						\
 	u64 vv = (v);					\
-	if(!(c&63)) {					\
-	} else if((c&63)==1) {				\
+	if (!(c & 63)) {				\
+	} else if ((c & 63) == 1) {			\
 		asm (					\
 		"	shldl	$1,%%edx,%%eax	\n"	\
 		"	rcll	$1,%%edx	\n"	\
 		: "=&A" (vv)				\
 		: "0" (vv)				\
 		);					\
-	} else if((c&63)==63) {				\
+	} else if ((c & 63) == 63) {			\
 		asm (					\
 		"	shrdl	$1,%%edx,%%eax	\n"	\
 		"	rcrl	$1,%%edx	\n"	\
 		: "=&A" (vv)				\
 		: "0" (vv)				\
 		);					\
-	} else if((c&63)<32) {				\
+	} else if ((c & 63) < 32) {			\
 		asm (					\
 		"	shldl	%3,%%edx,%%eax	\n"	\
 		"	shldl	%3,%2,%%edx	\n"	\
@@ -473,16 +474,16 @@ static inline int ffs(int x)
 		  "r" (vv),				\
 		  "Ic" (c&63)				\
 		);					\
-	} else if((c&63)>32) {				\
+	} else if ((c & 63) > 32) {			\
 		asm (					\
 		"	shrdl	%3,%%edx,%%eax	\n"	\
 		"	shrdl	%3,%2,%%edx	\n"	\
 		: "=&A" (vv)				\
 		: "0" (vv),				\
 		  "r" (vv),				\
-		  "Ic" (64-(c&63))			\
+		  "Ic" (64 - (c & 63))			\
 		);					\
-	} else /* (c&63)==32 */ {			\
+	} else /* (c & 63) == 32 */ {			\
 		asm (					\
 		"	xchgl	%%edx,%%eax	\n"	\
 		: "=&A" (vv)				\
@@ -491,43 +492,43 @@ static inline int ffs(int x)
 	}						\
 	vv;						\
 	})
-#define constant_ror64(v,c) \
+#define constant_ror64(v, c)				\
 	({						\
 	u64 vv = (v);					\
-	if(!(c&63)) {					\
-	} else if((c&63)==1) {				\
+	if (!(c & 63)) {				\
+	} else if ((c & 63) == 1) {			\
 		asm (					\
 		"	shrdl	$1,%%edx,%%eax	\n"	\
 		"	rcrl	$1,%%edx	\n"	\
 		: "=&A" (vv)				\
 		: "0" (vv)				\
 		);					\
-	} else if((c&63)==63) {				\
+	} else if ((c & 63) == 63) {			\
 		asm (					\
 		"	shldl	$1,%%edx,%%eax	\n"	\
 		"	rcll	$1,%%edx	\n"	\
 		: "=&A" (vv)				\
 		: "0" (vv)				\
 		);					\
-	} else if((c&63)<32) {				\
+	} else if ((c & 63) < 32) {			\
 		asm (					\
 		"	shrdl	%3,%%edx,%%eax	\n"	\
 		"	shrdl	%3,%2,%%edx	\n"	\
 		: "=&A" (vv)				\
 		: "0" (vv),				\
 		  "r" (vv),				\
-		  "Ic" (c&63)				\
+		  "Ic" (c & 63)				\
 		);					\
-	} else if((c&63)>32) {				\
+	} else if ((c & 63) > 32) {			\
 		asm (					\
 		"	shldl	%3,%%edx,%%eax	\n"	\
 		"	shldl	%3,%2,%%edx	\n"	\
 		: "=&A" (vv)				\
 		: "0" (vv),				\
 		  "r" (vv),				\
-		  "Ic" (64-(c&63))			\
+		  "Ic" (64 - (c & 63))			\
 		);					\
-	} else /* (c&63)==32 */ {			\
+	} else /* (c & 63) == 32 */ {			\
 		asm (					\
 		"	xchgl	%%edx,%%eax	\n"	\
 		: "=&A" (vv)				\
@@ -536,20 +537,24 @@ static inline int ffs(int x)
 	}						\
 	vv;						\
 	})
+
 /*
  * Unfortunately 64bit rotations with non-constant count
  * have issues with cnt>=32. Using C code instead
  */
-static inline u64 rol64(u64 x,int num) {
-	if(__builtin_constant_p(num))
-		return constant_rol64(x,num);
+static inline u64 rol64(u64 x,int num)
+{
+	if (__builtin_constant_p(num))
+		return constant_rol64(x, num);
 	/* Hmmm... shall we do cnt&=63 here? */
-	return ((x<<num) | (x>>(64-num)));
+	return ((x << num) | (x >> (64 - num)));
 }
-static inline u64 ror64(u64 x,int num) {
-	if(__builtin_constant_p(num))
-		return constant_ror64(x,num);
-	return ((x>>num) | (x<<(64-num)));
+
+static inline u64 ror64(u64 x, int num)
+{
+	if (__builtin_constant_p(num))
+		return constant_ror64(x, num);
+	return ((x >> num) | (x << (64 - num)));
 }
 
 #define ARCH_HAS_ROL64
_

