Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSLHQ57>; Sun, 8 Dec 2002 11:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSLHQ57>; Sun, 8 Dec 2002 11:57:59 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:9907 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S261364AbSLHQ55>; Sun, 8 Dec 2002 11:57:57 -0500
Date: Sun, 8 Dec 2002 11:58:49 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.50-ac1 : arch/i386/mm/hugetlbpage.c 
Message-ID: <Pine.LNX.4.44.0212081156130.2895-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   While 'make bzImage', I received the following error...

arch/i386/mm/hugetlbpage.c:610: parse error before `*'
arch/i386/mm/hugetlbpage.c: In function `hugetlb_sysctl_handler':
arch/i386/mm/hugetlbpage.c:611: number of arguments doesn't match prototype
include/linux/hugetlb.h:14: prototype declaration
arch/i386/mm/hugetlbpage.c:612: warning: implicit declaration of function `proc_dointvec'
arch/i386/mm/hugetlbpage.c:612: `table' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: (Each undeclared identifier is reported only once
arch/i386/mm/hugetlbpage.c:612: for each function it appears in.)
arch/i386/mm/hugetlbpage.c:612: `write' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: `file' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: `buffer' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: `length' undeclared (first use in this function)
make[1]: *** [arch/i386/mm/hugetlbpage.o] Error 1
make: *** [arch/i386/mm] Error 2

I've attached a possible patch for the issue, since noticed these same 
error in a previous kernel. There have also been other patches that seem 
to do the same then...fix the error.

--- linux/arch/i386/mm/hugetlbpage.c.old	Wed Nov 27 18:31:44 2002
+++ linux/arch/i386/mm/hugetlbpage.c	Wed Nov 27 18:31:38 2002
@@ -607,7 +607,7 @@
 	return (int) htlbzone_pages;
 }
 
-int hugetlb_sysctl_handler(ctl_table *table, int write, struct file *file, void *buffer, size_t *length)
+int hugetlb_sysctl_handler(struct ctl_table *table, int write, struct file *file, void *buffer, size_t *length)
 {
 	proc_dointvec(table, write, file, buffer, length);
 	htlbpage_max = set_hugetlb_mem_size(htlbpage_max);

