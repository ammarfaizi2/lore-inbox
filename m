Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319356AbSIMKaN>; Fri, 13 Sep 2002 06:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319466AbSIMKaN>; Fri, 13 Sep 2002 06:30:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:41744 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319356AbSIMKaM>; Fri, 13 Sep 2002 06:30:12 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15745.48975.172938.121684@laputa.namesys.com>
Date: Fri, 13 Sep 2002 14:34:55 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: UML 2.5.34
In-Reply-To: <200209121812.NAA02610@ccure.karaya.com>
References: <200209121812.NAA02610@ccure.karaya.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Zippy-Says: Inside, I'm already SOBBING!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike writes:
 > UML has been updated to 2.5.34 and UML 2.4.19-3.
 > 
 > There have been only a few minor changes since UML 2.5.33.  This is mostly an
 > update to 2.5.34.
 > 
 > The patch is available at
 > 	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.34-1.bz2
 > 
 > For the other UML mirrors and other downloads, see 
 > 	http://user-mode-linux.sourceforge.net/dl-sf.html
 > 
 > Other links of interest:
 > 
 > 	The UML project home page : http://user-mode-linux.sourceforge.net
 > 	The UML Community site : http://usermodelinux.org

And this is a patch to make it compilable (not sure about
CLOCK_TICK_RATE and pte_addr_t parts though):

It even boots, great!
----------------------------------------------------------------------
===== include/asm-um/percpu.h 1.1 vs edited =====
--- 1.1/include/asm-um/percpu.h	Fri Sep  6 21:29:29 2002
+++ edited/include/asm-um/percpu.h	Fri Sep 13 14:27:59 2002
@@ -1,5 +1,5 @@
-#ifndef __UM_CACHEFLUSH_H
-#define __UM_CACHEFLUSH_H
+#ifndef __UM_PERCPU_H
+#define __UM_PERCPU_H
 
 #include "asm/arch/percpu.h"
 
===== include/asm-um/pgtable.h 1.1 vs edited =====
--- 1.1/include/asm-um/pgtable.h	Fri Sep  6 21:29:29 2002
+++ edited/include/asm-um/pgtable.h	Fri Sep 13 14:04:54 2002
@@ -372,6 +372,10 @@
 
 #define kern_addr_valid(addr) (1)
 
+#if !defined(CONFIG_HIGHPTE)
+typedef pte_t *pte_addr_t;
+#endif
+
 #include <asm-generic/pgtable.h>
 
 #endif
===== include/asm-um/timex.h 1.1 vs edited =====
--- 1.1/include/asm-um/timex.h	Fri Sep  6 21:29:29 2002
+++ edited/include/asm-um/timex.h	Fri Sep 13 14:09:28 2002
@@ -7,6 +7,8 @@
 
 #define cacheflush_time (0)
 
+#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+
 static inline cycles_t get_cycles (void)
 {
 	return 0;
----------------------------------------------------------------------
 > 
 > 				Jeff
 > 

Nikita.
