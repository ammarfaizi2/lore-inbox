Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264960AbRFUNa0>; Thu, 21 Jun 2001 09:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbRFUNaQ>; Thu, 21 Jun 2001 09:30:16 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:58886 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S264958AbRFUNaH>; Thu, 21 Jun 2001 09:30:07 -0400
Date: Thu, 21 Jun 2001 21:31:01 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: needed this to run 2.4.6-pre4
Message-ID: <Pine.LNX.4.33.0106212128241.272-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


still not in 2.4.6-pre4. Without this, you'll get a lot of undefined
symbols referencing do_softirq

Jeff
[ jchua@fedex.com ]

--- include/asm-i386/softirq.h	Thu Jun 14 17:10:34 2001
+++ include/asm-i386/softirq.h.new	Thu Jun 14 17:17:15 2001
@@ -36,13 +36,13 @@
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


