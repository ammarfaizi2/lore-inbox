Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSK2LYI>; Fri, 29 Nov 2002 06:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSK2LYI>; Fri, 29 Nov 2002 06:24:08 -0500
Received: from cibs9.sns.it ([192.167.206.29]:46609 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267016AbSK2LYH>;
	Fri, 29 Nov 2002 06:24:07 -0500
Date: Fri, 29 Nov 2002 12:31:27 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: error in hugetlbpage.c 
Message-ID: <Pine.LNX.4.43.0211291212100.986-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




--- linux-2.5.50/arch/i386/mm/hugetlbpage.orig  2002-11-29
12:27:33.000000000 +0100
+++ linux-2.5.50/arch/i386/mm/hugetlbpage.c     2002-11-29
12:26:34.000000000 +0100
@@ -607,7 +607,7 @@
        return (int) htlbzone_pages;
 }

-int hugetlb_sysctl_handler(ctl_table *table, int write, struct file *file, void *buffer, size_t *length)
+int hugetlb_sysctl_handler(struct ctl_table *table, int write, struct file *file, void *buffer, size_t *length)
 {
        proc_dointvec(table, write, file, buffer, length);
        htlbpage_max = set_hugetlb_mem_size(htlbpage_max);


this is needed to avoid a compile error.


rch/i386/mm/hugetlbpage.c:610: parse error before '*' token
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




