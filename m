Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSGALbN>; Mon, 1 Jul 2002 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSGALbN>; Mon, 1 Jul 2002 07:31:13 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:55952 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S315480AbSGALbL>; Mon, 1 Jul 2002 07:31:11 -0400
Message-ID: <3D203DE2.592BEF5A@cisco.com>
Date: Mon, 01 Jul 2002 17:02:50 +0530
From: Manik Raina <manik@cisco.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@redhat.com, davej@suse.de
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH]: { 2.5 } Correcting comment in include/asm-i386/tlbflush.h
Content-Type: multipart/mixed;
 boundary="------------9BEEC8E7222BA1EF87736D92"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9BEEC8E7222BA1EF87736D92
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



    TLB flush happens when the CR3 register is written to. Comment is
misleading ....



--------------9BEEC8E7222BA1EF87736D92
Content-Type: text/plain; charset=us-ascii;
 name="tlb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tlb.diff"

diff -u -U 6 -r linux-2.5.24/include/asm-i386/tlbflush.h nice/include/asm-i386/tlbflush.h
--- linux-2.5.24/include/asm-i386/tlbflush.h	Fri Jun 21 04:23:51 2002
+++ nice/include/asm-i386/tlbflush.h	Mon Jul  1 16:54:31 2002
@@ -7,14 +7,14 @@
 
 #define __flush_tlb()							\
 	do {								\
 		unsigned int tmpreg;					\
 									\
 		__asm__ __volatile__(					\
-			"movl %%cr3, %0;  # flush TLB \n"		\
-			"movl %0, %%cr3;              \n"		\
+			"movl %%cr3, %0;              \n"		\
+			"movl %0, %%cr3;  # flush TLB \n"		\
 			: "=r" (tmpreg)					\
 			:: "memory");					\
 	} while (0)
 
 /*
  * Global pages have to be flushed a bit differently. Not a real
@@ -23,14 +23,14 @@
 #define __flush_tlb_global()						\
 	do {								\
 		unsigned int tmpreg;					\
 									\
 		__asm__ __volatile__(					\
 			"movl %1, %%cr4;  # turn off PGE     \n"	\
-			"movl %%cr3, %0;  # flush TLB        \n"	\
-			"movl %0, %%cr3;                     \n"	\
+			"movl %%cr3, %0;                     \n"	\
+			"movl %0, %%cr3;  # flush TLB        \n"	\
 			"movl %2, %%cr4;  # turn PGE back on \n"	\
 			: "=&r" (tmpreg)				\
 			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
 			  "r" (mmu_cr4_features)			\
 			: "memory");					\
 	} while (0)


--------------9BEEC8E7222BA1EF87736D92--

