Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267053AbRGSIWn>; Thu, 19 Jul 2001 04:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267055AbRGSIWd>; Thu, 19 Jul 2001 04:22:33 -0400
Received: from unamed.infotel.bg ([212.39.68.18]:16645 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S267053AbRGSIWT>;
	Thu, 19 Jul 2001 04:22:19 -0400
Date: Thu, 19 Jul 2001 11:23:06 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Linus Torvalds <torvalds@transmeta.com>
cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <200107182204.f6IM4K001282@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10107191113080.2341-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Wed, 18 Jul 2001, Linus Torvalds wrote:

> Can you verify with this alternate patch instead? Yours works ok on
> older gcc's, but the gcc team feels that clobbers must never cover
> inputs or outputs, so your patch really generates invalid asms.  Here's
> a alternate, can you verify that it works for you guys, and perhaps
> people can at the same time eye-ball it for any other issues they can
> think of?

	This patch works for me too (I checked all cpuid_XXX calls).
After some thinking I produced another patch. The interesting part is
that __volatile__ solves the problem. Patch appended. I see in other
kernel files that volatile solves gcc bugs. The question is whether
the volatile is needed only as a work-around or it is needed in this
case particulary, i.e. where the output registers are not used and are
optimized.

> 		Linus

Regards

--
Julian Anastasov <ja@ssi.bg>


--- include/asm-i386/processor.h.orig1	Wed Jul 18 12:03:26 2001
+++ include/asm-i386/processor.h	Thu Jul 19 10:58:06 2001
@@ -136,7 +136,7 @@
 {
 	unsigned int eax, ebx, ecx, edx;

-	__asm__("cpuid"
+	__asm__ __volatile__ ("cpuid"
 		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
 		: "a" (op));
 	return eax;
@@ -145,7 +145,7 @@
 {
 	unsigned int eax, ebx, ecx, edx;

-	__asm__("cpuid"
+	__asm__ __volatile__ ("cpuid"
 		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
 		: "a" (op));
 	return ebx;
@@ -154,7 +154,7 @@
 {
 	unsigned int eax, ebx, ecx, edx;

-	__asm__("cpuid"
+	__asm__ __volatile__ ("cpuid"
 		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
 		: "a" (op));
 	return ecx;
@@ -163,7 +163,7 @@
 {
 	unsigned int eax, ebx, ecx, edx;

-	__asm__("cpuid"
+	__asm__ __volatile__ ("cpuid"
 		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
 		: "a" (op));
 	return edx;

