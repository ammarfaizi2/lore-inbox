Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315966AbSEGUnQ>; Tue, 7 May 2002 16:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315967AbSEGUnP>; Tue, 7 May 2002 16:43:15 -0400
Received: from pD9E23EE2.dip.t-dialin.net ([217.226.62.226]:30879 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315966AbSEGUnP>; Tue, 7 May 2002 16:43:15 -0400
Date: Tue, 7 May 2002 14:43:08 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Roman Zippel <zippel@linux-m68k.org>
cc: Thunder from the hill <thunder@ngforever.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pfn-Functionset out of order for sparc64 in current Bk tree?
In-Reply-To: <Pine.LNX.4.21.0205072115360.32715-100000@serv>
Message-ID: <Pine.LNX.4.44.0205071441140.4189-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Roman Zippel wrote advises on pfn.

So this compiles for me.

							       Regards,
								Thunder

diff -Nur linus-2.5/include/asm-sparc64/page.h thunder-2.5/include/asm-sparc64/page.h
--- linus-2.5/include/asm-sparc64/page.h	Tue May  7 14:30:00 2002
+++ thunder-2.5/include/asm-sparc64/page.h	Tue May  7 14:08:48 2002
@@ -114,6 +114,8 @@
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 #define virt_to_page(kaddr)	(mem_map + ((__pa(kaddr)-phys_base) >> PAGE_SHIFT))
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 
 #define virt_to_phys __pa
diff -Nur linus-2.5/include/asm-sparc64/pgtable.h thunder-2.5/include/asm-sparc64/pgtable.h
--- linus-2.5/include/asm-sparc64/pgtable.h	Tue May  7 14:30:00 2002
+++ thunder-2.5/include/asm-sparc64/pgtable.h	Tue May  7 14:10:46 2002
@@ -201,6 +201,7 @@
 #define page_pte(page)			page_pte_prot(page, __pgprot(0))
 
 #define mk_pte_phys(physpage, pgprot)	(__pte((physpage) | pgprot_val(pgprot) | _PAGE_SZBITS))
+#define pfn_pte(pfn,prot)		mk_pte_phys(pfn << PAGE_SHIFT, prot)
 
 extern inline pte_t pte_modify(pte_t orig_pte, pgprot_t new_prot)
 {
@@ -272,6 +273,8 @@
 #define pte_offset_map_nested		__pte_offset
 #define pte_unmap(pte)			do { } while (0)
 #define pte_unmap_nested(pte)		do { } while (0)
+#define pfn_to_page(pfn)		(mem_map + (pfn))
+#define pte_pfn(x)			(pte_val(x) >> PAGE_SHIFT)
 
 extern pgd_t swapper_pg_dir[1];
 
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

