Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266669AbRGJQwZ>; Tue, 10 Jul 2001 12:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266684AbRGJQwP>; Tue, 10 Jul 2001 12:52:15 -0400
Received: from gw-nl5.philips.com ([212.153.235.99]:60434 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP
	id <S266669AbRGJQwD>; Tue, 10 Jul 2001 12:52:03 -0400
From: fabrizio.gennari@philips.com
Subject: Kernel 2.4.6 does not compile on Sparc
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Jul 2001 18:51:14 +0200
Message-ID: <OF41725CBA.1CC3C47B-ONC1256A85.005BAE76@diamond.philips.com>
X-MIMETrack: Serialize by Router on EMAUO01/H/SERVER/PHILIPS(Release 5.0.5 |September 22, 2000) at
 10/07/2001 19:05:45
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a problem with kernel 2.4.6 on a Sparc. It seems that pgalloc.h defines as macros some identifiers which are defined elsewhere as functions, with a different number of args. Those are pte_alloc (defined in memory.c) and pmd_alloc (defined in
mm.h). It is the same problem as Alex Buell has, as he wrote on May 9th:

Has anyone got a patch to fix the following error when compiling
2.4.4 on SparcStation 4?


make[2]: Entering directory `/usr/src/linux-2.4.4/mm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -mno-fpu
-fcall-used-g5 -fcall-used-g7 -c -o memory.o memory.c
memory.c:183: macro `pmd_alloc' used with too many (3) args
memory.c:204: macro `pte_alloc' used with too many (3) args
memory.c:725: macro `pte_alloc' used with too many (3) args
memory.c:750: macro `pmd_alloc' used with too many (3) args
memory.c:805: macro `pte_alloc' used with too many (3) args
memory.c:832: macro `pmd_alloc' used with too many (3) args
memory.c:1339: macro `pmd_alloc' used with too many (3) args
memory.c:1342: macro `pte_alloc' used with too many (3) args
memory.c:1392: macro `pte_alloc' used with too many (3) args
memory.c: In function `copy_page_range':
memory.c:183: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:183: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c:204: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:204: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `zeromap_pmd_range':
memory.c:725: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:725: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `zeromap_page_range':
memory.c:750: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:750: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c: In function `remap_pmd_range':
memory.c:805: warning: passing arg 1 of `___f_pte_alloc' from incompatible
pointer type
memory.c:805: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `remap_page_range':
memory.c:832: warning: passing arg 1 of `___f_pmd_alloc' from incompatible
pointer type
memory.c:832: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c: In function `handle_mm_fault':
memory.c:1339: warning: passing arg 1 of `___f_pmd_alloc' from
incompatible pointer type
memory.c:1339: warning: passing arg 2 of `___f_pmd_alloc' makes integer
from pointer without a cast
memory.c:1342: warning: passing arg 1 of `___f_pte_alloc' from
incompatible pointer type
memory.c:1342: warning: passing arg 2 of `___f_pte_alloc' makes integer
from pointer without a cast
memory.c: In function `__pmd_alloc':
memory.c:1364: warning: implicit declaration of function
`pmd_alloc_one_fast'
memory.c:1364: warning: assignment makes pointer from integer without a
cast
memory.c:1367: warning: implicit declaration of function `pmd_alloc_one'
memory.c:1367: warning: assignment makes pointer from integer without a
cast
memory.c:1381: warning: implicit declaration of function `pgd_populate'
memory.c: At top level:
memory.c:1393: conflicting types for `___f_pte_alloc'
/usr/src/linux-2.4.4/include/asm/pgalloc.h:125: previous declaration of
`___f_pte_alloc'
memory.c: In function `___f_pte_alloc':
memory.c:1398: warning: implicit declaration of function
`pte_alloc_one_fast'
memory.c:1398: `address' undeclared (first use in this function)
memory.c:1398: (Each undeclared identifier is reported only once
memory.c:1398: for each function it appears in.)
memory.c:1398: warning: assignment makes pointer from integer without a
cast
memory.c:1401: warning: implicit declaration of function `pte_alloc_one'
memory.c:1401: warning: assignment makes pointer from integer without a
cast
memory.c:1415: warning: implicit declaration of function `pmd_populate'
make[2]: *** [memory.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.4/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.4/mm'
make: *** [_dir_mm] Error 2

---------------------------------------------------------
Fabrizio Gennari          tel. +39 039 203 7816
Philips Research Monza    fax. +39 039 203 7800
via G. Casati 23          fabrizio.gennari@philips.com
20052 Monza (MI) Italy    http://www.research.philips.com


