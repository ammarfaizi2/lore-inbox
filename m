Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268105AbTAJCNy>; Thu, 9 Jan 2003 21:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268106AbTAJCNy>; Thu, 9 Jan 2003 21:13:54 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13779 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268105AbTAJCNx>;
	Thu, 9 Jan 2003 21:13:53 -0500
Subject: [RFC][PATCH] linux-2.5.55_x86-tsc-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042165079.1052.296.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 18:18:00 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch simply removes one more of the remaining CONFIG_X86_TSC
#ifdefs from get_cycles(). It is replaced w/ a if(cpu_has_tsc) switch,
so if you think this will cause a major performance impact, let me know
and I'll leave it alone. 

Otherwise I'll send it in for real on monday. 

thanks
-john

diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Thu Jan  9 17:17:17 2003
+++ b/include/asm-i386/timex.h	Thu Jan  9 17:17:17 2003
@@ -40,14 +40,10 @@
 
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
-
-	rdtscll(ret);
+	unsigned long long ret = 0;
+	if(cpu_has_tsc)
+		rdtscll(ret);
 	return ret;
-#endif
 }
 
 extern unsigned long cpu_khz;



