Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRGRWyy>; Wed, 18 Jul 2001 18:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRGRWyo>; Wed, 18 Jul 2001 18:54:44 -0400
Received: from t2.redhat.com ([199.183.24.243]:32765 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263918AbRGRWyg>; Wed, 18 Jul 2001 18:54:36 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: bitops.h ifdef __KERNEL__ cleanup.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Jul 2001 23:54:36 +0100
Message-ID: <27472.995496876@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not all architectures put clear_bit et al in asm/bitops.h in a form which 
is usable from userspace. Yet because it happens to work on a PeeCee, 
people do it anyway. 

There's a simple way to fix that :)

Index: include/asm-i386/bitops.h
===================================================================
RCS file: /inst/cvs/linux/include/asm-i386/bitops.h,v
retrieving revision 1.2.2.7
diff -u -r1.2.2.7 bitops.h
--- include/asm-i386/bitops.h	2001/06/02 16:27:54	1.2.2.7
+++ include/asm-i386/bitops.h	2001/07/18 22:52:11
@@ -7,6 +7,8 @@
 
 #include <linux/config.h>
 
+#ifdef __KERNEL__
+
 /*
  * These have to be done with inline assembly: that way the bit-setting
  * is guaranteed to be atomic. All bit operations return 0 if the bit
@@ -329,8 +331,6 @@
 		:"r" (~word));
 	return word;
 }
-
-#ifdef __KERNEL__
 
 /**
  * ffs - find first bit set

--
dwmw2


