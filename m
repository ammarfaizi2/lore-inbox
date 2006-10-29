Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWJ2UHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWJ2UHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWJ2UHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:07:04 -0500
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:2672 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751847AbWJ2UHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:07:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=DqcIDJwC81552W8NNDmIvG95/H9C5V6I6LovzDUGjcWhLAPFAdbBkEMJK+tvl711uwHtArlLl8t8Z/be3YZAgFhipR+YQMxj+TbNFdtENda6SJuHaqYvePfzQk+2Y4+9bJirB6Dnf/ozxh5s2r2fUhWCDF8G/+2+ioefreGp+yw=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] i386, x86_64: comment magic constants in delay.h
Date: Sun, 29 Oct 2006 21:07:05 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Message-Id: <20061029200705.26757.51162.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029200702.26757.12496.stgit@americanbeauty.home.lan>
References: <20061029200702.26757.12496.stgit@americanbeauty.home.lan>
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
@@ -7,6 +7,7 @@ #define _I386_DELAY_H
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
@@ -7,18 +7,21 @@ #define _X8664_DELAY_H
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
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
