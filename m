Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbQKPUux>; Thu, 16 Nov 2000 15:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbQKPUud>; Thu, 16 Nov 2000 15:50:33 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:18790
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131227AbQKPUuc>; Thu, 16 Nov 2000 15:50:32 -0500
Date: Thu, 16 Nov 2000 21:12:40 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: sailer@ife.ee.ethz.ch
Cc: linux-kernel@vger.kernel.org
Subject: [uPATCH] Compile error in drivers/net/hamradio/baycom_epp.c (240-t11p5)
Message-ID: <20001116211240.B716@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Recent changes in the kernel has made the patch below necessary:


--- linux-240-t11-pre5-clean/drivers/net/hamradio/baycom_epp.c	Sat Nov  4 23:27:07 2000
+++ linux/drivers/net/hamradio/baycom_epp.c	Thu Nov 16 20:27:22 2000
@@ -812,10 +812,10 @@
 /* --------------------------------------------------------------------- */
 
 #ifdef __i386__
-#define GETTICK(x)                                                \
-({                                                                \
-	if (current_cpu_data.x86_capability & X86_FEATURE_TSC)    \
-		__asm__ __volatile__("rdtsc" : "=a" (x) : : "dx");\
+#define GETTICK(x)                                                      \
+({                                                                      \
+	if (test_bit(X86_FEATURE_TSC, &current_cpu_data.x86_capability))\
+		__asm__ __volatile__("rdtsc" : "=a" (x) : : "dx");      \
 })
 #else /* __i386__ */
 #define GETTICK(x)

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

There are two major products that come out of Berkeley: LSD and UNIX. We 
don't believe this to be a coincidence. -- Jeremy S. Anderson 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
