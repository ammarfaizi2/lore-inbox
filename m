Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSJQDHJ>; Wed, 16 Oct 2002 23:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbSJQDHJ>; Wed, 16 Oct 2002 23:07:09 -0400
Received: from zok.SGI.COM ([204.94.215.101]:1669 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261664AbSJQDHH>;
	Wed, 16 Oct 2002 23:07:07 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.43 export _end
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Oct 2002 13:12:37 +1000
Message-ID: <8402.1034824357@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some programs such as ps, lkcd and others need to validate that
System.map matches the kernel.  Comparing all symbol names from ksyms
against map breaks badly when faced with function descriptors (ia64 has
hundreds of mismatches because of function descriptors).  lkcd attempts
to solve this problem by adding kernel_magic which contains the value
of _end, but that requires /dev/kmem access to read kernel_magic.

Trivial fix - export _end.  Every arch *lds* file defines _end.
No special access is required to match ksyms _end against System.map
_end.

Index: 43.1/kernel/ksyms.c
--- 43.1/kernel/ksyms.c Wed, 16 Oct 2002 14:25:21 +1000 kaos (linux-2.5/w/d/18_ksyms.c 1.22.1.31 444)
+++ 43.1(w)/kernel/ksyms.c Thu, 17 Oct 2002 12:16:14 +1000 kaos (linux-2.5/w/d/18_ksyms.c 1.22.1.31 444)
@@ -602,3 +602,7 @@ EXPORT_SYMBOL(__per_cpu_offset);
 
 /* debug */
 EXPORT_SYMBOL(dump_stack);
+
+/* To match ksyms with System.map */
+extern const char _end[];
+EXPORT_SYMBOL(_end);

