Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268527AbTANDXW>; Mon, 13 Jan 2003 22:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268544AbTANDXW>; Mon, 13 Jan 2003 22:23:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:18082 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268527AbTANDXV>; Mon, 13 Jan 2003 22:23:21 -0500
Subject: [PATCH][TRIVIAL] linux-2.5.57_x86-tsc-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1042514802.1514.30.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Jan 2003 19:26:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, All,
	Since no one complained about this over the weekend, here it is. This
patch simply removes one more of the remaining CONFIG_X86_TSC #ifdefs
(this one from get_cycles()). Instead of a compile time switch, it
switches on cpu_has_tsc. 

Please apply.

thanks
-john


diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Mon Jan 13 17:29:06 2003
+++ b/include/asm-i386/timex.h	Mon Jan 13 17:29:06 2003
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



