Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKPB5Z>; Wed, 15 Nov 2000 20:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKPB5P>; Wed, 15 Nov 2000 20:57:15 -0500
Received: from [209.249.10.20] ([209.249.10.20]:36006 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129045AbQKPB5B>; Wed, 15 Nov 2000 20:57:01 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 15 Nov 2000 17:26:57 -0800
Message-Id: <200011160126.RAA32351@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, sailer@ife.ee.ethz.ch
Subject: Patch: linux-2.4.0-test11-pre5/drivers/net/hamradio compile problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	linux-2.4.0-test11-pre5/drivers/net/hamradio/baycomm_epp.c and
linux-2.4.0-test11-pre5/drivers/net/hamradio/soundmodem.h refer to
current_cpu.x86_capability, which has changed from an integer to
an array, causing compile errors in these files.  Here is a proposed
patch.  Thomas, will you handle feeding these patches to Linus if
they look good, or do you want me to?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.4.0-test11-pre5/drivers/net/hamradio/baycom_epp.c	Fri Oct 27 10:55:01 2000
+++ linux/drivers/net/hamradio/baycom_epp.c	Wed Nov 15 17:20:16 2000
@@ -814,7 +814,7 @@
 #ifdef __i386__
 #define GETTICK(x)                                                \
 ({                                                                \
-	if (current_cpu_data.x86_capability & X86_FEATURE_TSC)    \
+	if (test_bit(X86_FEATURE_TSC, &current_cpu_data.x86_capability))    \
 		__asm__ __volatile__("rdtsc" : "=a" (x) : : "dx");\
 })
 #else /* __i386__ */
--- linux-2.4.0-test11-pre5/drivers/net/hamradio/soundmodem/sm.h	Wed Aug 18 11:38:50 1999
+++ linux/drivers/net/hamradio/soundmodem/sm.h	Wed Nov 15 16:46:57 2000
@@ -299,7 +299,7 @@
 
 #ifdef __i386__
 
-#define HAS_RDTSC (current_cpu_data.x86_capability & X86_FEATURE_TSC)
+#define HAS_RDTSC (test_bit(X86_FEATURE_TSC, &current_cpu_data.x86_capability))
 
 /*
  * only do 32bit cycle counter arithmetic; we hope we won't overflow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
