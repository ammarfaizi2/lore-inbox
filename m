Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbTC1BGl>; Thu, 27 Mar 2003 20:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261883AbTC1BGl>; Thu, 27 Mar 2003 20:06:41 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:4776 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261863AbTC1BGj>;
	Thu, 27 Mar 2003 20:06:39 -0500
Message-Id: <200303280117.h2S1Hib05921@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: akpm@zip.com.au
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix to support discontigmem for 16way x440
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_11789499400"
Date: Thu, 27 Mar 2003 17:17:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_11789499400
Content-Type: text/plain; charset=us-ascii


This patch fixes a bug that kept the 16way x440 from booting with numa memory 
allocation support.  Please apply this patch to your tree.


Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


--==_Exmh_11789499400
Content-Type: application/x-patch ; name="linux-2.5.66-16wayfix_A0.patch"
Content-Description: linux-2.5.66-16wayfix_A0.patch
Content-Disposition: attachment; filename="linux-2.5.66-16wayfix_A0.patch"

diff -Nru a/arch/i386/mm/boot_ioremap.c b/arch/i386/mm/boot_ioremap.c
--- a/arch/i386/mm/boot_ioremap.c	Thu Mar 27 16:58:16 2003
+++ b/arch/i386/mm/boot_ioremap.c	Thu Mar 27 16:58:16 2003
@@ -19,6 +19,7 @@
 #undef CONFIG_X86_PAE
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/tlbflush.h>
 #include <linux/init.h>
 #include <linux/stddef.h>
 
@@ -48,10 +49,12 @@
 {
 	boot_pte_t* pte;
 	int i;
+	char *vaddr = virtual_source;
 
 	pte = boot_vaddr_to_pte(virtual_source);
 	for (i=0; i < nrpages; i++, phys_addr += PAGE_SIZE, pte++) {
 		set_pte(pte, pfn_pte(phys_addr>>PAGE_SHIFT, PAGE_KERNEL));
+		__flush_tlb_one(&vaddr[i*PAGE_SIZE]);
 	}
 }
 

--==_Exmh_11789499400--


