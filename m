Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264287AbUDVQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264287AbUDVQZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUDVQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:25:51 -0400
Received: from mail.ccur.com ([208.248.32.212]:44813 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264287AbUDVQZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:25:48 -0400
Date: Thu, 22 Apr 2004 12:25:44 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0 of 17] cpumask v4 - bitmap and cpumask cleanup
Message-ID: <20040422162544.GA17611@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040421232247.22ffe1f2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
 This patch gets the new bitmap stuff to compile and pass a boot-test
on Opteron.

I especially like the cleaned-up, orthogonal API and your addition of
the missing bitmap_andnot() function.  Good work!

Regards,
Joe
"Money can buy bandwidth, but latency is forever" -- John Mashey


diff -ura 2.6.5-pj/arch/x86_64/kernel/smpboot.c 2.6.5-pj2/arch/x86_64/kernel/smpboot.c
--- 2.6.5-pj/arch/x86_64/kernel/smpboot.c	2004-04-03 22:38:26.000000000 -0500
+++ 2.6.5-pj2/arch/x86_64/kernel/smpboot.c	2004-04-22 12:06:02.209264270 -0400
@@ -827,7 +827,7 @@
 		if (apicid == boot_cpu_id)
 			continue;
 
-		if (!cpu_isset(apicid, phys_cpu_present_map))
+		if (!physid_isset(apicid, phys_cpu_present_map))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
diff -ura 2.6.5-pj/include/asm-x86_64/smp.h 2.6.5-pj2/include/asm-x86_64/smp.h
--- 2.6.5-pj/include/asm-x86_64/smp.h	2004-04-22 12:19:58.665010667 -0400
+++ 2.6.5-pj2/include/asm-x86_64/smp.h	2004-04-22 11:43:49.190316603 -0400
@@ -60,7 +60,6 @@
 
 extern cpumask_t cpu_callout_map;
 #define cpu_possible_map cpu_callout_map
-#define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 
 static inline int num_booting_cpus(void)
 {
@@ -85,7 +84,6 @@
 
 #define safe_smp_processor_id() (disable_apic ? 0 : x86_apicid_to_cpu[hard_smp_processor_id()])
 
-#define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 #endif /* !ASSEMBLY */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
