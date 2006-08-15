Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbWHOQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbWHOQCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965376AbWHOQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:02:53 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:61153 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S965256AbWHOQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:02:52 -0400
Message-Id: <44E20C5C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 15 Aug 2006 18:03:08 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Cc: <patches@x86-64.org>
Subject: [PATCH] fix x86 cpuid keys used in alternative_smp()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By hard-coding the cpuid keys for alternative_smp() rather than using
the symbolic constant it turned out that incorrect values were used on
both i386 (0x68 instead of 0x69) and x86-64 (0x66 instead of 0x68).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.18-rc4/include/asm-i386/alternative.h	2006-08-15 11:29:59.000000000 +0200
+++ 2.6.18-rc4-x86-alternatives-key/include/asm-i386/alternative.h	2006-08-15 15:21:15.000000000 +0200
@@ -116,7 +116,7 @@ static inline void alternatives_smp_swit
 		      "  .align 4\n"					\
 		      "  .long 661b\n"            /* label */		\
 		      "  .long 663f\n"		  /* new instruction */	\
-		      "  .byte 0x68\n"            /* X86_FEATURE_UP */	\
+		      "  .byte " __stringify(X86_FEATURE_UP) "\n"	\
 		      "  .byte 662b-661b\n"       /* sourcelen */	\
 		      "  .byte 664f-663f\n"       /* replacementlen */	\
 		      ".previous\n"					\
--- linux-2.6.18-rc4/include/asm-x86_64/alternative.h	2006-08-15 11:30:02.000000000 +0200
+++ 2.6.18-rc4-x86-alternatives-key/include/asm-x86_64/alternative.h	2006-08-15 15:22:41.000000000 +0200
@@ -130,7 +130,7 @@ static inline void alternatives_smp_swit
 		      "  .align 8\n"					\
 		      "  .quad 661b\n"            /* label */		\
 		      "  .quad 663f\n"		  /* new instruction */	\
-		      "  .byte 0x66\n"            /* X86_FEATURE_UP */	\
+		      "  .byte " __stringify(X86_FEATURE_UP) "\n"	\
 		      "  .byte 662b-661b\n"       /* sourcelen */	\
 		      "  .byte 664f-663f\n"       /* replacementlen */	\
 		      ".previous\n"					\


