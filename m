Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbTCaCKo>; Sun, 30 Mar 2003 21:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbTCaCKo>; Sun, 30 Mar 2003 21:10:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32164 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261362AbTCaCKn>; Sun, 30 Mar 2003 21:10:43 -0500
Date: Sun, 30 Mar 2003 21:22:01 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: akpm@digeo.com, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Wrong comment due to pte_file()
Message-ID: <20030330212201.A4155@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above other bit tests says "if pte_present is true",
but the pte_file is backwards. A classic case of code changing
from under comments. How about abolishing all comments? :-)

diff -urN -X dontdiff linux-2.5.66/include/asm-i386/pgtable.h linux-2.5.66-sparc/include/asm-i386/pgtable.h
--- linux-2.5.66/include/asm-i386/pgtable.h	2003-03-24 14:01:14.000000000 -0800
+++ linux-2.5.66-sparc/include/asm-i386/pgtable.h	2003-03-30 16:35:04.000000000 -0800
@@ -188,6 +188,10 @@
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
+
+/*
+ * The following only works if pte_present() is not true.
+ */
 static inline int pte_file(pte_t pte)		{ return (pte).pte_low & _PAGE_FILE; }
 
 static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
