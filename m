Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318749AbSG0NKF>; Sat, 27 Jul 2002 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318750AbSG0NKF>; Sat, 27 Jul 2002 09:10:05 -0400
Received: from holomorphy.com ([66.224.33.161]:55970 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318749AbSG0NKE>;
	Sat, 27 Jul 2002 09:10:04 -0400
Date: Sat, 27 Jul 2002 06:13:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.29 PAE compilefix
Message-ID: <20020727131312.GL25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't tried booting it yet, but here's the compilefix:

Cheers,
Bill

===== arch/i386/mm/init.c 1.22 vs edited =====
--- 1.22/arch/i386/mm/init.c	Fri Jul 26 12:07:32 2002
+++ edited/arch/i386/mm/init.c	Sat Jul 27 05:35:05 2002
@@ -54,7 +54,7 @@
 		
 #if CONFIG_X86_PAE
 	pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-	set_pgd(pgd, __pgd(__pa(md_table) | _PAGE_PRESENT));
+	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 	if (pmd_table != pmd_offset(pgd, 0)) 
 		BUG();
 #else
