Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbSI0XQB>; Fri, 27 Sep 2002 19:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262640AbSI0XQB>; Fri, 27 Sep 2002 19:16:01 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:53985 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262639AbSI0XQA>; Fri, 27 Sep 2002 19:16:00 -0400
X-Face: >Q)4Pn.JVfRz{G(G_eIkykbZGG\)2mk8:5a"{^Mk07iC#F.t2L7h<Sa|7Zr1_L8[nbiq:8F
 %o\(7>|]{*cFg$GEPDdun~+UTjG(^4z<_Ksw%L-\w0xDmUR~<zsnGH]&sK=M\Y=;U4XZ"z)[CX6I6d
 _p
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] 2.4.18/2.5.39 include/asm-alpha/mmu_context.h compile fix
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 28 Sep 2002 01:21:29 +0200
Message-ID: <87smzv3tom.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

CVS gcc doesn't allow mentioning __asm__("...") registers in the
clobber list any more (see also
http://gcc.gnu.org/ml/gcc/2002-09/msg00741.html).  This patch applies
to both 2.4.18 and 2.5.39.

-- 
	Falk


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=reload_thread.patch

--- linux-2.5.39/include/asm-alpha/mmu_context.h~	2002-09-27 23:49:55.000000000 +0200
+++ linux-2.5.39/include/asm-alpha/mmu_context.h	2002-09-28 00:47:28.000000000 +0200
@@ -25,23 +25,23 @@
 extern inline unsigned long
 __reload_thread(struct pcb_struct *pcb)
 {
 	register unsigned long a0 __asm__("$16");
 	register unsigned long v0 __asm__("$0");
 
 	a0 = virt_to_phys(pcb);
 	__asm__ __volatile__(
 		"call_pal %2 #__reload_thread"
 		: "=r"(v0), "=r"(a0)
 		: "i"(PAL_swpctx), "r"(a0)
-		: "$1", "$16", "$22", "$23", "$24", "$25");
+		: "$1", "$22", "$23", "$24", "$25");
 
 	return v0;
 }
 
 
 /*
  * The maximum ASN's the processor supports.  On the EV4 this is 63
  * but the PAL-code doesn't actually use this information.  On the
  * EV5 this is 127, and EV6 has 255.
  *
  * On the EV4, the ASNs are more-or-less useless anyway, as they are

--=-=-=--
