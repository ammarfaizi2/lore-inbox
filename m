Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVKJAjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVKJAjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVKJAjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:39:13 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:41481 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751133AbVKJAjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:39:12 -0500
Date: Wed, 9 Nov 2005 16:39:11 -0800
Message-Id: <200511100039.jAA0dB1S027774@zach-dev.vmware.com>
Subject: [PATCH 5/10] Deprecate obsolete ldt accessors
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:39:12.0118 (UTC) FILETIME=[2B66F960:01C5E58F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Old accessors to fetch LDT descriptors are unused and outdated and in
the wrong header file.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/include/asm-i386/system.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/system.h	2005-11-08 03:26:03.000000000 -0800
+++ linux-2.6.14/include/asm-i386/system.h	2005-11-09 01:36:06.000000000 -0800
@@ -56,22 +56,6 @@
 #define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
 #define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1)>>12 )
 
-static inline unsigned long _get_base(char * addr)
-{
-	unsigned long __base;
-	__asm__("movb %3,%%dh\n\t"
-		"movb %2,%%dl\n\t"
-		"shll $16,%%edx\n\t"
-		"movw %1,%%dx"
-		:"=&d" (__base)
-		:"m" (*((addr)+2)),
-		 "m" (*((addr)+4)),
-		 "m" (*((addr)+7)));
-	return __base;
-}
-
-#define get_base(ldt) _get_base( ((char *)&(ldt)) )
-
 /*
  * Load a segment. Fall back on loading the zero
  * segment if something goes wrong..
