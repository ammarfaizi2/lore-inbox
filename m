Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264595AbRFUBzs>; Wed, 20 Jun 2001 21:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbRFUBzi>; Wed, 20 Jun 2001 21:55:38 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:4160 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S264595AbRFUBzX>; Wed, 20 Jun 2001 21:55:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.6-pre4 unresolved symbol do_softirq
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Jun 2001 11:55:15 +1000
Message-ID: <5362.993088515@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_softirq is called from asm code which does not get preprocessed.
The label needs to be exposed so cpp can see it.

Against 2.4.6-pre4.

Index: 6-pre4.1/include/asm-i386/softirq.h
--- 6-pre4.1/include/asm-i386/softirq.h Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/T/51_softirq.h 1.3 644)
+++ 6-pre4.1(w)/include/asm-i386/softirq.h Thu, 21 Jun 2001 11:52:34 +1000 kaos (linux-2.4/T/51_softirq.h 1.3 644)
@@ -36,13 +36,13 @@ do {									\
 									\
 			".section .text.lock,\"ax\";"			\
 			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
-			"call do_softirq;"				\
+			"call %c1;"					\
 			"popl %%edx; popl %%ecx; popl %%eax;"		\
 			"jmp 1b;"					\
 			".previous;"					\
 									\
 		: /* no output */					\
-		: "r" (ptr)						\
+		: "r" (ptr), "i" (do_softirq)				\
 		/* no registers clobbered */ );				\
 } while (0)
 

