Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSK0XhO>; Wed, 27 Nov 2002 18:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSK0XhO>; Wed, 27 Nov 2002 18:37:14 -0500
Received: from shells.hardanger.net ([209.113.172.35]:12036 "EHLO
	server.bohemians.org") by vger.kernel.org with ESMTP
	id <S264943AbSK0XhJ>; Wed, 27 Nov 2002 18:37:09 -0500
Date: Wed, 27 Nov 2002 23:44:26 +0000
From: Martin Dahl <dahlm@izno.net>
To: linux-kernel@vger.kernel.org
Cc: Frank Davis <fdavis@si.rr.com>
Subject: [PATCH] Re: 2.5.50 : arch/i386/mm/hugetblpage.c error
Message-ID: <20021127234426.GA15475@izno.net>
References: <Pine.LNX.4.44.0211271826270.2465-100000@linux-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211271826270.2465-100000@linux-dev>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello all,
>   While 'make bzImage', I received the following error.
> 
> Regards,
> Frank
> 
> arch/i386/mm/hugetlbpage.c:610: parse error before `*'
> arch/i386/mm/hugetlbpage.c: In function `hugetlb_sysctl_handler':
> arch/i386/mm/hugetlbpage.c:611: number of arguments doesn't match prototype
> include/linux/hugetlb.h:14: prototype declaration
> arch/i386/mm/hugetlbpage.c:612: warning: implicit declaration of function `proc_dointvec'
> arch/i386/mm/hugetlbpage.c:612: `table' undeclared (first use in this function)
> arch/i386/mm/hugetlbpage.c:612: (Each undeclared identifier is reported only once
> arch/i386/mm/hugetlbpage.c:612: for each function it appears in.)
> arch/i386/mm/hugetlbpage.c:612: `write' undeclared (first use in this function)
> arch/i386/mm/hugetlbpage.c:612: `file' undeclared (first use in this function)
> arch/i386/mm/hugetlbpage.c:612: `buffer' undeclared (first use in this function)
> arch/i386/mm/hugetlbpage.c:612: `length' undeclared (first use in this function)
> make[1]: *** [arch/i386/mm/hugetlbpage.o] Error 1
> make: *** [arch/i386/mm] Error 2
> 
Looks like there's a missing include, the following patch should fix it

--- arch/i386/mm/hugetlbpage.c.orig     2002-11-27 23:37:47.000000000 +0000
+++ arch/i386/mm/hugetlbpage.c  2002-11-27 23:36:20.000000000 +0000
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/sysctl.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>



hth, martin

-- 
Martin Dahl
dahlm@izno.net
