Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSJPSgm>; Wed, 16 Oct 2002 14:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262831AbSJPSgm>; Wed, 16 Oct 2002 14:36:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19984 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262813AbSJPSgl>;
	Wed, 16 Oct 2002 14:36:41 -0400
Date: Wed, 16 Oct 2002 19:42:38 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] default VM flags for upwards-growing stacks
Message-ID: <20021016194238.O15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urpNX build-tools/dontdiff linus-2.5/include/linux/mm.h parisc-2.5/include/linux/mm.h
--- linus-2.5/include/linux/mm.h	Tue Oct  8 10:54:13 2002
+++ parisc-2.5/include/linux/mm.h	Tue Oct  8 16:49:15 2002
@@ -106,7 +106,11 @@ struct vm_area_struct {
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 
-#define VM_STACK_FLAGS	(0x00000100 | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
+#ifdef ARCH_STACK_GROWSUP
+#define VM_STACK_FLAGS	(VM_GROWSUP | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
+#else
+#define VM_STACK_FLAGS	(VM_GROWSDOWN | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
+#endif
 
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
 #define VM_ClearReadHint(v)		(v)->vm_flags &= ~VM_READHINTMASK

-- 
Revolutions do not require corporate support.
