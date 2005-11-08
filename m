Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVKHE2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVKHE2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVKHE2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:28:14 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:59666 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030264AbVKHE2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:28:13 -0500
Date: Mon, 7 Nov 2005 20:28:12 -0800
Message-Id: <200511080428.jA84SCwt009890@zach-dev.vmware.com>
Subject: [PATCH 9/21] i386 Deprecate obsolete ldt accessors
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:28:12.0587 (UTC) FILETIME=[D488A7B0:01C5E41C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Old accessors to fetch LDT descriptors are unused and outdated and in
the wrong header file.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/system.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/system.h	2005-11-04 17:45:04.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/system.h	2005-11-05 00:28:08.000000000 -0800
@@ -56,22 +56,6 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
 #define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , (limit) )
 
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
