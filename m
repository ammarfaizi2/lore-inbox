Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268231AbTBNILX>; Fri, 14 Feb 2003 03:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268232AbTBNILX>; Fri, 14 Feb 2003 03:11:23 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:594
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268231AbTBNILX>; Fri, 14 Feb 2003 03:11:23 -0500
Date: Fri, 14 Feb 2003 03:19:49 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] small PPC32 smp_message_pass buglet
Message-ID: <Pine.LNX.4.50.0302140316140.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this define is missing a brace, otherwise we might just hit a 
NULL dereference.

Index: linux-2.5.60-uml/arch/ppc/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/ppc/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60-uml/arch/ppc/kernel/smp.c	10 Feb 2003 22:14:40 -0000	1.1.1.1
+++ linux-2.5.60-uml/arch/ppc/kernel/smp.c	14 Feb 2003 06:46:37 -0000
@@ -78,9 +78,10 @@
 #define PPC_MSG_XMON_BREAK	3
 
 #define smp_message_pass(t,m,d,w) \
-    do { if (smp_ops) \
+    do { if (smp_ops) {\
 	     atomic_inc(&ipi_sent); \
 	     smp_ops->message_pass((t),(m),(d),(w)); \
+	 } \
        } while(0)
 
 /* 

-- 
function.linuxpower.ca
