Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFFJoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 05:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTFFJoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 05:44:18 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:57238 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S261153AbTFFJoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 05:44:17 -0400
Date: Fri, 6 Jun 2003 11:57:49 +0200
From: Jasper Spaans <jasper@vs19.net>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] fix location of zap_low_mappings
Message-ID: <20030606095749.GA13037@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
Keywords: supercomputer genetic Serbian smuggle Ft. Knox CIA North Korea Qaddafi 
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

When compiling current BK 2.5, I get a warning about zap_low_mappings not
being declared. Moving it from smp.h to pgtable.h fixes this (and doesn't
break my setup). 

Does anyone object to this fix?

[not Cc:-ed to the trivial patch monkey, as I'm not sure whether pgtable.h
 is the right place to put this]

Bye,
Jasper

Index: linux-2.5/include/asm-i386/pgtable.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/pgtable.h,v
retrieving revision 1.33
diff -u -r1.33 pgtable.h
--- l/include/asm-i386/pgtable.h	4 May 2003 01:50:19 -0000	1.33
+++ l/include/asm-i386/pgtable.h	6 Jun 2003 08:40:18 -0000
@@ -23,6 +23,7 @@
 
 extern pgd_t swapper_pg_dir[1024];
 extern void paging_init(void);
+extern void zap_low_mappings (void);
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
Index: l/include/asm-i386//smp.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/smp.h,v
retrieving revision 1.24
diff -u -r1.24 smp.h
--- l/include/asm-i386/smp.h	4 Jun 2003 00:16:47 -0000	1.24
+++ l/include/asm-i386/smp.h	6 Jun 2003 08:40:18 -0000
@@ -43,7 +43,6 @@
 extern void smp_send_reschedule(int cpu);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
-extern void zap_low_mappings (void);
 
 #define MAX_APICID 256
 

-- 
Jasper Spaans
http://jsp.vs19.net/contact/

``Got no clue? Too bad for you.''
