Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUIMMWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUIMMWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUIMMWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:22:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:35824 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266308AbUIMMWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:22:19 -0400
Date: Mon, 13 Sep 2004 08:26:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] Allow multiple inputs in alternative_input
Message-ID: <Pine.LNX.4.53.0409130823170.2297@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,
	I had to use the following patch to allow multiple arguments to be 
passed down to the asm stub for alternative_input whilst writing 
alternatives for mwait code, it seems like a simple enough fix.

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.9-rc1-bk18-stage/include/asm-i386/system.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-i386/system.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 system.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-i386/system.h	11 Sep 2004 14:17:54 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-i386/system.h	12 Sep 2004 04:18:35 -0000
@@ -321,7 +321,7 @@ struct alt_instr { 
  * If you use variable sized constraints like "m" or "g" in the 
  * replacement maake sure to pad to the worst case length.
  */
-#define alternative_input(oldinstr, newinstr, feature, input)			\
+#define alternative_input(oldinstr, newinstr, feature, input...)		\
 	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
 		      ".section .altinstructions,\"a\"\n"			\
 		      "  .align 4\n"						\
@@ -333,7 +333,7 @@ struct alt_instr { 
 		      ".previous\n"						\
 		      ".section .altinstr_replacement,\"ax\"\n"			\
 		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ 	\
-		      ".previous" :: "i" (feature), input)  
+		      ".previous" :: "i" (feature), ##input)  
 
 /*
  * Force strict CPU ordering.
Index: linux-2.6.9-rc1-bk18-stage/include/asm-x86_64/system.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-x86_64/system.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 system.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-x86_64/system.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-x86_64/system.h	13 Sep 2004 12:22:39 -0000
@@ -123,7 +123,7 @@ struct alt_instr { 
  * If you use variable sized constraints like "m" or "g" in the 
  * replacement maake sure to pad to the worst case length.
  */
-#define alternative_input(oldinstr, newinstr, feature, input)		\
+#define alternative_input(oldinstr, newinstr, feature, input...)	\
 	asm volatile ("661:\n\t" oldinstr "\n662:\n"			\
 		      ".section .altinstructions,\"a\"\n"		\
 		      "  .align 8\n"					\
@@ -135,7 +135,7 @@ struct alt_instr { 
 		      ".previous\n"					\
 		      ".section .altinstr_replacement,\"ax\"\n"		\
 		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ \
-		      ".previous" :: "i" (feature), input)
+		      ".previous" :: "i" (feature), ##input)
 
 /*
  * Clear and set 'TS' bit respectively
