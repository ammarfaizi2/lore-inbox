Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317289AbSFCGMw>; Mon, 3 Jun 2002 02:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317290AbSFCGMv>; Mon, 3 Jun 2002 02:12:51 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:48889 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317289AbSFCGMu>; Mon, 3 Jun 2002 02:12:50 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] TRIVIAL: must be __KERNEL__ for byteorder/generic.h
Date: Mon, 03 Jun 2002 16:10:34 +1000
Message-Id: <E17El34-0007hR-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This seems correct for 2.5: noone outside the kernel should be using
  these, and it breaks glibc building in some cases  -- RR ]

dank@kegel.com: byteorder.h, ntohl, and compiling userspace programs:
  Here's that patch again (MIME this time, so tabs don't get
  lost by my silly gui mailer); applies cleanly against against 2.4.19-pre8.
  Nobody commented on it last time I posted it, and it does
  make compiling gcc easier, so I guess that makes it trivial patch
  monkey fodder.  Or am I making a silly mistake?
  - Dan

--- trivial-2.5.20/include/linux/byteorder/generic.h.orig	Mon Jun  3 15:25:10 2002
+++ trivial-2.5.20/include/linux/byteorder/generic.h	Mon Jun  3 15:25:10 2002
@@ -123,6 +123,7 @@
 #endif
 
 
+#if defined(__KERNEL__)
 /*
  * Handle ntohl and suches. These have various compatibility
  * issues - like we want to give the prototype even though we
@@ -146,17 +147,11 @@
  * Do the prototypes. Somebody might want to take the
  * address or some such sick thing..
  */
-#if defined(__KERNEL__) || (defined (__GLIBC__) && __GLIBC__ >= 2)
 extern __u32			ntohl(__u32);
 extern __u32			htonl(__u32);
-#else
-extern unsigned long int	ntohl(unsigned long int);
-extern unsigned long int	htonl(unsigned long int);
-#endif
 extern unsigned short int	ntohs(unsigned short int);
 extern unsigned short int	htons(unsigned short int);
 
-
 #if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__)
 
 #define ___htonl(x) __cpu_to_be32(x)
@@ -164,17 +159,14 @@
 #define ___ntohl(x) __be32_to_cpu(x)
 #define ___ntohs(x) __be16_to_cpu(x)
 
-#if defined(__KERNEL__) || (defined (__GLIBC__) && __GLIBC__ >= 2)
 #define htonl(x) ___htonl(x)
 #define ntohl(x) ___ntohl(x)
-#else
-#define htonl(x) ((unsigned long)___htonl(x))
-#define ntohl(x) ((unsigned long)___ntohl(x))
-#endif
 #define htons(x) ___htons(x)
 #define ntohs(x) ___ntohs(x)
 
 #endif /* OPTIMIZE */
+
+#endif /* KERNEL */
 
 
 #endif /* _LINUX_BYTEORDER_GENERIC_H */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
