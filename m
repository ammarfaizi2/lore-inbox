Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbRLVQ5Y>; Sat, 22 Dec 2001 11:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286826AbRLVQ5P>; Sat, 22 Dec 2001 11:57:15 -0500
Received: from ldap.elis.rug.ac.be ([157.193.67.1]:62891 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S286825AbRLVQ5B>; Sat, 22 Dec 2001 11:57:01 -0500
Date: Sat, 22 Dec 2001 17:56:55 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: <linux-kernel@vger.kernel.org>
Subject: earlyclobber
Message-ID: <Pine.LNX.4.33.0112221752150.6586-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think that in the file include/asm-i386/uaccess.h in some macro's the 
ecx register should be marked as an "earlyclobber" operand since it is 
one. Patch follows.

Frank.

--- linux-2.4.17/include/asm-i386/uaccess.h	Sat Dec 22 09:35:17 2001
+++ linux/include/asm-i386/uaccess.h	Sat Dec 22 17:32:14 2001
@@ -151,7 +151,7 @@
 ({							\
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) *__pu_addr = (ptr);		\
-	if (access_ok(VERIFY_WRITE,__pu_addr,size))	\
+	if (access_ok(VERIFY_WRITE,__pu_addr,(size)))	\
 		__put_user_size((x),__pu_addr,(size),__pu_err);	\
 	__pu_err;					\
 })							
@@ -337,7 +337,7 @@
 			"	.align 4\n"			\
 			"	.long 0b,2b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\
@@ -356,7 +356,7 @@
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\
@@ -375,7 +375,7 @@
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\
@@ -397,7 +397,7 @@
 			"	.long 1b,5b\n"			\
 			"	.long 2b,6b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\
@@ -427,7 +427,7 @@
 			"	.align 4\n"			\
 			"	.long 0b,2b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\
@@ -459,7 +459,7 @@
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\
@@ -491,7 +491,7 @@
 			"	.long 0b,3b\n"			\
 			"	.long 1b,4b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\
@@ -533,7 +533,7 @@
 			"	.long 1b,5b\n"			\
 			"	.long 2b,6b\n"			\
 			".previous"				\
-			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
+			: "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
 		break;						\

