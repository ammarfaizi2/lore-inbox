Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264220AbUKBHU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbUKBHU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S446885AbUKBHUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:20:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:60879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S446704AbUKBHTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:19:51 -0500
Date: Tue, 2 Nov 2004 00:17:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 10/14] FRV: Make calibrate_delay() optional
Message-Id: <20041102001743.0dfecb7c.akpm@osdl.org>
In-Reply-To: <200411011930.iA1JULKN023227@warthog.cambridge.redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	<200411011930.iA1JULKN023227@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



init/main.c: In function `start_kernel':
init/main.c:494: warning: implicit declaration of function `calibrate_delay'

Move the calibrate_delay() prototype into linux/delay.h

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-frv/delay.h    |    1 -
 25-akpm/include/asm-m32r/smp.h     |    1 -
 25-akpm/include/asm-x86_64/proto.h |    1 -
 25-akpm/include/linux/delay.h      |    1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

diff -puN include/linux/delay.h~frv-make-calibrate_delay-optional-warning-fix include/linux/delay.h
--- 25/include/linux/delay.h~frv-make-calibrate_delay-optional-warning-fix	2004-11-01 23:20:40.736445936 -0800
+++ 25-akpm/include/linux/delay.h	2004-11-01 23:21:09.070138560 -0800
@@ -38,6 +38,7 @@ extern unsigned long loops_per_jiffy;
 #define ndelay(x)	udelay(((x)+999)/1000)
 #endif
 
+void calibrate_delay(void);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
 
diff -puN include/asm-m32r/smp.h~frv-make-calibrate_delay-optional-warning-fix include/asm-m32r/smp.h
--- 25/include/asm-m32r/smp.h~frv-make-calibrate_delay-optional-warning-fix	2004-11-01 23:20:40.752443504 -0800
+++ 25-akpm/include/asm-m32r/smp.h	2004-11-01 23:20:54.544346816 -0800
@@ -92,7 +92,6 @@ static __inline__ unsigned int num_booti
 }
 
 extern void smp_send_timer(void);
-extern void calibrate_delay(void);
 extern unsigned long send_IPI_mask_phys(cpumask_t, int, int);
 
 #endif	/* not __ASSEMBLY__ */
diff -puN include/asm-x86_64/proto.h~frv-make-calibrate_delay-optional-warning-fix include/asm-x86_64/proto.h
--- 25/include/asm-x86_64/proto.h~frv-make-calibrate_delay-optional-warning-fix	2004-11-01 23:20:40.769440920 -0800
+++ 25-akpm/include/asm-x86_64/proto.h	2004-11-01 23:21:13.197511104 -0800
@@ -25,7 +25,6 @@ extern void ia32_syscall(void);
 extern void ia32_cstar_target(void); 
 extern void ia32_sysenter_target(void); 
 
-extern void calibrate_delay(void);
 extern void cpu_idle(void);
 extern void config_acpi_tables(void);
 extern void ia32_syscall(void);
diff -puN include/asm-frv/delay.h~frv-make-calibrate_delay-optional-warning-fix include/asm-frv/delay.h
--- 25/include/asm-frv/delay.h~frv-make-calibrate_delay-optional-warning-fix	2004-11-01 23:20:40.785438488 -0800
+++ 25-akpm/include/asm-frv/delay.h	2004-11-01 23:21:19.580540736 -0800
@@ -18,7 +18,6 @@
  * delay loop - runs at __core_clock_speed_HZ / 2 [there are 2 insns in the loop]
  */
 extern unsigned long __delay_loops_MHz;
-extern void calibrate_delay(void);
 
 static inline void __delay(unsigned long loops)
 {
_

