Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWCYQ0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWCYQ0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWCYQ0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:26:01 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:7562 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750719AbWCYQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:25:59 -0500
Subject: [patch 1 of 4] Rename e820_map to e820_any_map to reflect its
	behavior better
From: Arjan van de Ven <arjan@linux.intel.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Mar 2006 17:23:16 +0100
Message-Id: <1143303796.2898.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename e820_mapped to e820_any_mapped since it tests if any part
of the range is mapped according to the type. Later steps will introduce
e820_all_mapped which will check if the entire range is mapped with the type.
Both have their merit.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/kernel/aperture.c |    2 +-
 arch/x86_64/kernel/e820.c     |    2 +-
 arch/x86_64/mm/init.c         |    2 +-
 include/asm-x86_64/e820.h     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.16-mmconfig/arch/x86_64/kernel/aperture.c
===================================================================
--- linux-2.6.16-mmconfig.orig/arch/x86_64/kernel/aperture.c
+++ linux-2.6.16-mmconfig/arch/x86_64/kernel/aperture.c
@@ -80,7 +80,7 @@ static int __init aperture_valid(char *n
 		printk("Aperture from %s beyond 4GB. Ignoring.\n",name);
 		return 0; 
 	}
-	if (e820_mapped(aper_base, aper_base + aper_size, E820_RAM)) {  
+	if (e820_any_mapped(aper_base, aper_base + aper_size, E820_RAM)) {
 		printk("Aperture from %s pointing to e820 RAM. Ignoring.\n",name);
 		return 0; 
 	} 
Index: linux-2.6.16-mmconfig/arch/x86_64/kernel/e820.c
===================================================================
--- linux-2.6.16-mmconfig.orig/arch/x86_64/kernel/e820.c
+++ linux-2.6.16-mmconfig/arch/x86_64/kernel/e820.c
@@ -80,7 +80,7 @@ static inline int bad_addr(unsigned long
 	return 0;
 } 
 
-int __init e820_mapped(unsigned long start, unsigned long end, unsigned type) 
+int __init e820_any_mapped(unsigned long start, unsigned long end, unsigned type)
 { 
 	int i;
 	for (i = 0; i < e820.nr_map; i++) { 
Index: linux-2.6.16-mmconfig/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.16-mmconfig.orig/arch/x86_64/mm/init.c
+++ linux-2.6.16-mmconfig/arch/x86_64/mm/init.c
@@ -277,7 +277,7 @@ static void __meminit phys_pud_init(pud_
 		if (paddr >= end)
 			break;
 
-		if (!after_bootmem && !e820_mapped(paddr, paddr+PUD_SIZE, 0)) {
+		if (!after_bootmem && !e820_any_mapped(paddr, paddr+PUD_SIZE, 0)) {
 			set_pud(pud, __pud(0)); 
 			continue;
 		} 
Index: linux-2.6.16-mmconfig/include/asm-x86_64/e820.h
===================================================================
--- linux-2.6.16-mmconfig.orig/include/asm-x86_64/e820.h
+++ linux-2.6.16-mmconfig/include/asm-x86_64/e820.h
@@ -47,7 +47,7 @@ extern void contig_e820_setup(void); 
 extern unsigned long e820_end_of_ram(void);
 extern void e820_reserve_resources(void);
 extern void e820_print_map(char *who);
-extern int e820_mapped(unsigned long start, unsigned long end, unsigned type);
+extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
 
 extern void e820_bootmem_free(pg_data_t *pgdat, unsigned long start,unsigned long end);
 extern void e820_setup_gap(void);

