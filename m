Return-Path: <linux-kernel-owner+w=401wt.eu-S1422827AbWLUIfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422827AbWLUIfT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWLUIfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:35:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:65192 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422827AbWLUIfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:35:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:from;
        b=t9NEZ21dwwWZ1ryC6gnlC894U+Ml1zk3VpakOA1MrNmb4l592UxMGxrTgcVGOmq6r71+VEUvfrFKqUds13cgKgdkrrAXGgCGG4F7uHZFZTpIbPFsY8Gxhg1h4ixfH4qjc00BSsN9czjA8n0yWSQrQt1IGVLTLtKBeS6yYUSkfI4=
Message-ID: <458A4742.3060204@gmail.com>
Date: Thu, 21 Dec 2006 09:35:14 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH -rt 1/4] ARM: Include compilation and warning fixes
Content-Type: multipart/mixed;
 boundary="------------010702050500080503060601"
From: Dirk Behme <dirk.behme@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702050500080503060601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: Fix compilation issues and warnings for CONFIG PREEMPT
RT for ARM in include/asm-arm/system.h.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------010702050500080503060601
Content-Type: text/plain;
 name="arm_include_fixes_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm_include_fixes_patch.txt"

Index: linux-2.6.20-rc1/include/asm-arm/system.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-arm/system.h
+++ linux-2.6.20-rc1/include/asm-arm/system.h
@@ -173,23 +173,25 @@ static inline void set_copro_access(unsi
 extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
+#include <linux/irqflags.h>
+
 #ifndef CONFIG_SMP
 static inline void adjust_cr(unsigned long mask, unsigned long set)
 {
-	unsigned long flags, cr;
+	unsigned long flags;
 
 	mask &= ~CR_A;
 
 	set &= mask;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	cr_no_alignment = (cr_no_alignment & ~mask) | set;
 	cr_alignment = (cr_alignment & ~mask) | set;
 
 	set_cr((get_cr() & ~mask) | set);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 #endif
 
@@ -248,8 +250,6 @@ static inline void sched_cacheflush(void
 {
 }
 
-#include <linux/irqflags.h>
-
 #ifdef CONFIG_SMP
 
 #define smp_mb()		mb()


--------------010702050500080503060601--
