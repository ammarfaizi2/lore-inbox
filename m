Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbTBFFsL>; Thu, 6 Feb 2003 00:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTBFFsL>; Thu, 6 Feb 2003 00:48:11 -0500
Received: from dp.samba.org ([66.70.73.150]:17872 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265643AbTBFFsJ>;
	Thu, 6 Feb 2003 00:48:09 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] linux-2.5.57_x86-tsc-cleanup_A0
Date: Thu, 06 Feb 2003 16:56:51 +1100
Message-Id: <20030206055746.B29912C0EF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  john stultz <johnstul@us.ibm.com>

  Linus, All,
  	Since no one complained about this over the weekend, here it is. This
  patch simply removes one more of the remaining CONFIG_X86_TSC #ifdefs
  (this one from get_cycles()). Instead of a compile time switch, it
  switches on cpu_has_tsc. 
  
  Please apply.
  
  thanks
  -john
  
  

--- trivial-2.5-bk/include/asm-i386/timex.h.orig	2003-02-06 16:30:27.000000000 +1100
+++ trivial-2.5-bk/include/asm-i386/timex.h	2003-02-06 16:30:27.000000000 +1100
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
-- 
  Don't blame me: the Monkey is driving
  File: john stultz <johnstul@us.ibm.com>: [PATCH][TRIVIAL] linux-2.5.57_x86-tsc-cleanup_A0
