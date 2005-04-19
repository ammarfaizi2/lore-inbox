Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVDSGc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVDSGc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 02:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDSGc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 02:32:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:40709 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261346AbVDSGc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 02:32:26 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: use 64bit rotations
Date: Tue, 19 Apr 2005 09:31:17 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> <200504190926.53565.vda@port.imtp.ilyichevsk.odessa.ua> <200504190928.40353.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200504190928.40353.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1WKZCNjNEbL6G7/"
Message-Id: <200504190931.17456.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_1WKZCNjNEbL6G7/
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Remove local 64bit rotation function, use generic one.

Patch is untested.

I believe there is no more 64bit rotations in the kernel.
--
vda

--Boundary-00=_1WKZCNjNEbL6G7/
Content-Type: text/x-diff;
  charset="koi8-r";
  name="4.ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="4.ia64.patch"

diff -urpN 2.6.12-rc2.3.ws/arch/ia64/kernel/ptrace.c 2.6.12-rc2.4.ia64/arch/ia64/kernel/ptrace.c
--- 2.6.12-rc2.3.ws/arch/ia64/kernel/ptrace.c	Mon Apr 18 22:54:38 2005
+++ 2.6.12-rc2.4.ia64/arch/ia64/kernel/ptrace.c	Tue Apr 19 00:44:30 2005
@@ -80,7 +80,7 @@ ia64_get_scratch_nat_bits (struct pt_reg
 			dist = 64 + bit - first;			\
 		else							\
 			dist = bit - first;				\
-		ia64_rotr(unat, dist) & mask;				\
+		ror64(unat, dist) & mask;				\
 	})
 	unsigned long val;
 
@@ -119,7 +119,7 @@ ia64_put_scratch_nat_bits (struct pt_reg
 			dist = 64 + bit - first;			\
 		else							\
 			dist = bit - first;				\
-		ia64_rotl(nat & mask, dist);				\
+		rol64(nat & mask, dist);				\
 	})
 	unsigned long scratch_unat;
 
diff -urpN 2.6.12-rc2.3.ws/include/asm-ia64/processor.h 2.6.12-rc2.4.ia64/include/asm-ia64/processor.h
--- 2.6.12-rc2.3.ws/include/asm-ia64/processor.h	Thu Feb  3 11:40:06 2005
+++ 2.6.12-rc2.4.ia64/include/asm-ia64/processor.h	Tue Apr 19 00:43:30 2005
@@ -652,14 +652,6 @@ ia64_get_dbr (__u64 regnum)
 	return retval;
 }
 
-static inline __u64
-ia64_rotr (__u64 w, __u64 n)
-{
-	return (w >> n) | (w << (64 - n));
-}
-
-#define ia64_rotl(w,n)	ia64_rotr((w), (64) - (n))
-
 /*
  * Take a mapped kernel address and return the equivalent address
  * in the region 7 identity mapped virtual area.

--Boundary-00=_1WKZCNjNEbL6G7/--

