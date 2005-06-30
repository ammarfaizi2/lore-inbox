Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbVF3UlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbVF3UlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbVF3UlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:41:10 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:33041 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S263149AbVF3UjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:39:03 -0400
Message-ID: <42C4585E.7090204@stud.feec.vutbr.cz>
Date: Thu, 30 Jun 2005 22:38:54 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Weston <weston@sysex.net>
CC: Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-38
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050629193804.GA6256@elte.hu> <200506300136.01061.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <Pine.LNX.4.58.0506301238450.20655@echo.lysdexia.org>
In-Reply-To: <Pine.LNX.4.58.0506301238450.20655@echo.lysdexia.org>
Content-Type: multipart/mixed;
 boundary="------------010809080401050200020307"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010809080401050200020307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here are some more fixes for -RT-2.6.12-final-V0.7.50-38 needed to 
compile it on x86_64.

Michal

--------------010809080401050200020307
Content-Type: text/plain;
 name="rt-amd64-PER_CPU_LOCKED.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-amd64-PER_CPU_LOCKED.diff"

diff -Nurp -X dontdiff.new linux-RT/arch/x86_64/mm/init.c linux-RT.mich/arch/x86_64/mm/init.c
--- linux-RT/arch/x86_64/mm/init.c	2005-06-30 21:22:33.000000000 +0200
+++ linux-RT.mich/arch/x86_64/mm/init.c	2005-06-30 22:28:16.000000000 +0200
@@ -47,7 +47,7 @@ extern int swiotlb;
 
 extern char _stext[];
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 
 /*
  * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
diff -Nurp -X dontdiff.new linux-RT/include/asm-x86_64/percpu.h linux-RT.mich/include/asm-x86_64/percpu.h
--- linux-RT/include/asm-x86_64/percpu.h	2005-06-30 21:44:37.000000000 +0200
+++ linux-RT.mich/include/asm-x86_64/percpu.h	2005-06-30 22:26:10.000000000 +0200
@@ -63,6 +63,9 @@ extern void setup_per_cpu_areas(void);
 #endif	/* SMP */
 
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+#define DECLARE_PER_CPU_LOCKED(type, name) \
+	extern spinlock_t per_cpu_lock__##name##_locked; \
+	extern __typeof__(type) per_cpu__##name##_locked
 
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)

--------------010809080401050200020307--
