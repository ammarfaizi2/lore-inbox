Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSDXL7k>; Wed, 24 Apr 2002 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSDXL7j>; Wed, 24 Apr 2002 07:59:39 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:57765 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S311871AbSDXL7c>; Wed, 24 Apr 2002 07:59:32 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "Andrew Morton" <akpm@zip.com.au>, "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] remove show_buffers()
Date: Wed, 24 Apr 2002 17:23:03 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBMEANCGAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-76333d7b-5776-11d6-a942-00b0d0d06be8"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3CC67339.A800A462@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-76333d7b-5776-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

show_buffers() can still be kept, with it being made inline and calling
printk("%ld buffermem pages\n", nr_buffermem_pages()); that should simply
things - I presume

so you could have

inline void
show_buffers(void)
{
	printk("%ld buffermem pages\n", nr_buffermem_pages());
}

which with a good compiler would do the same as you intend to do
right now.

Frankly, I do not know much about the buffer cache layer in Linux,
so I might have missed something obvious.

Let me know,
Balbir Singh.

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org
|[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Andrew Morton
|Sent: Wednesday, April 24, 2002 2:26 PM
|To: lkml
|Subject: [patch] remove show_buffers()
|
|
|
|
|Remove show_buffers().  It really has nothing to show any more.  just
|buffermem_pages() - move that out into the callers.
|
|There's a lot of duplication in this code.  better approach would be to
|remove all the duplicated code out in the architectures and implement
|generic show_memory_state().  Later.
|
|
|=====================================
|
|--- 2.5.9/fs/buffer.c~cleanup-060-show_buffers	Wed Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/fs/buffer.c	Wed Apr 24 01:44:52 2002
|@@ -2172,14 +2172,6 @@ int try_to_free_buffers(struct page *pag
| }
| EXPORT_SYMBOL(try_to_free_buffers);
| 
|-/* ================== Debugging =================== */
|-
|-void show_buffers(void)
|-{
|-	printk("Buffer memory:   %6dkB\n",
|-			atomic_read(&buffermem_pages) << (PAGE_SHIFT-10));
|-}
|-
| int block_sync_page(struct page *page)
| {
| 	run_task_queue(&tq_disk);
|--- 2.5.9/arch/alpha/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/alpha/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -139,7 +139,7 @@ show_mem(void)
| 	printk("%ld reserved pages\n",reserved);
| 	printk("%ld pages shared\n",shared);
| 	printk("%ld pages swap cached\n",cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| #endif
| 
|--- 2.5.9/arch/alpha/mm/numa.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/alpha/mm/numa.c	Wed Apr 24 01:06:14 2002
|@@ -426,5 +426,5 @@ show_mem(void)
| 	printk("%ld pages shared\n",shared);
| 	printk("%ld pages swap cached\n",cached);
| 	printk("%ld pages in page table cache\n",pgtable_cache_size);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
|--- 2.5.9/arch/arm/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/arm/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -101,7 +101,7 @@ void show_mem(void)
| 	printk("%d slab pages\n", slab);
| 	printk("%d pages shared\n", shared);
| 	printk("%d pages swap cached\n", cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| struct node_info {
|--- 2.5.9/arch/cris/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/cris/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -183,7 +183,7 @@ show_mem(void)
| 	printk("%d pages shared\n",shared);
| 	printk("%d pages swap cached\n",cached);
| 	printk("%ld pages in page table cache\n",pgtable_cache_size);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| /*
|--- 2.5.9/arch/i386/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/i386/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -95,7 +95,7 @@ void show_mem(void)
| 	printk("%d reserved pages\n",reserved);
| 	printk("%d pages shared\n",shared);
| 	printk("%d pages swap cached\n",cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| /* References to section boundaries */
|--- 2.5.9/arch/ia64/hp/sim/simserial.c~cleanup-060-show_buffers	
|Wed Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/ia64/hp/sim/simserial.c	Wed Apr 24 01:06:14 2002
|@@ -156,7 +156,6 @@ static  void receive_chars(struct tty_st
| 				continue;
| 			} else if ( seen_esc == 2 ) {
| 				if ( ch == 'P' ) show_state();		
|/* F1 key */
|-				if ( ch == 'Q' ) show_buffers();	
|/* F2 key */
| #ifdef CONFIG_KDB
| 				if ( ch == 'S' )
| 					kdb(KDB_REASON_KEYBOARD, 0, 
|(kdb_eframe_t) regs);
|--- 2.5.9/arch/ia64/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/ia64/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -200,7 +200,7 @@ show_mem(void)
| 			pgdat = pgdat->node_next;
| 		} while (pgdat);
| 		printk("Total of %ld pages in page table cache\n", 
|pgtable_cache_size);
|-		show_buffers();
|+		printk("%ld buffermem pages\n", nr_buffermem_pages());
| 		printk("%d free buffer pages\n", nr_free_buffer_pages());
| 	}
| #else /* !CONFIG_DISCONTIGMEM */
|@@ -220,7 +220,7 @@ show_mem(void)
| 	printk("%d pages shared\n", shared);
| 	printk("%d pages swap cached\n", cached);
| 	printk("%ld pages in page table cache\n", pgtable_cache_size);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| #endif /* !CONFIG_DISCONTIGMEM */
| }
| 
|--- 2.5.9/arch/m68k/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/m68k/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -109,7 +109,7 @@ void show_mem(void)
|     printk("%d pages shared\n",shared);
|     printk("%d pages swap cached\n",cached);
|     printk("%ld pages in page table cache\n",pgtable_cache_size);
|-    show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| extern void init_pointer_table(unsigned long ptable);
|--- 2.5.9/arch/mips/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/mips/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -137,7 +137,7 @@ void show_mem(void)
| 	printk("%d pages swap cached\n",cached);
| 	printk("%ld pages in page table cache\n",pgtable_cache_size);
| 	printk("%d free pages\n", free);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| /* References to section boundaries */
|--- 2.5.9/arch/mips64/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/mips64/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -341,7 +341,7 @@ void show_mem(void)
| 	printk("%d pages swap cached\n",cached);
| 	printk("%ld pages in page table cache\n", pgtable_cache_size);
| 	printk("%d free pages\n", free);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| #ifndef CONFIG_DISCONTIGMEM
|--- 2.5.9/arch/parisc/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/parisc/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -155,7 +155,7 @@ void show_mem(void)
| 	printk("%d reserved pages\n",reserved);
| 	printk("%d pages shared\n",shared);
| 	printk("%d pages swap cached\n",cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| void set_pte_phys (unsigned long vaddr, unsigned long phys)
|--- 2.5.9/arch/ppc/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/ppc/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -142,7 +142,7 @@ void show_mem(void)
| 	printk("%d reserved pages\n",reserved);
| 	printk("%d pages shared\n",shared);
| 	printk("%d pages swap cached\n",cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| void si_meminfo(struct sysinfo *val)
|--- 2.5.9/arch/ppc64/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/ppc64/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -138,7 +138,7 @@ void show_mem(void)
| 	printk("%d reserved pages\n",reserved);
| 	printk("%d pages shared\n",shared);
| 	printk("%d pages swap cached\n",cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| void si_meminfo(struct sysinfo *val)
|--- 2.5.9/arch/s390/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/s390/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -89,7 +89,7 @@ void show_mem(void)
|         printk("%d pages shared\n",shared);
|         printk("%d pages swap cached\n",cached);
|         printk("%ld pages in page table cache\n",pgtable_cache_size);
|-        show_buffers();
|+        printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| /* References to section boundaries */
|--- 2.5.9/arch/s390x/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/s390x/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -89,7 +89,7 @@ void show_mem(void)
|         printk("%d pages shared\n",shared);
|         printk("%d pages swap cached\n",cached);
|         printk("%ld pages in page table cache\n",pgtable_cache_size);
|-        show_buffers();
|+        printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| /* References to section boundaries */
|--- 2.5.9/arch/sh/mm/init.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/arch/sh/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -73,7 +73,7 @@ void show_mem(void)
| 	printk("%d reserved pages\n",reserved);
| 	printk("%d pages shared\n",shared);
| 	printk("%d pages swap cached\n",cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| /* References to section boundaries */
|--- 2.5.9/arch/sparc/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/sparc/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -84,7 +84,7 @@ void show_mem(void)
| 	if (sparc_cpu_model == sun4m || sparc_cpu_model == sun4d)
| 		printk("%ld entries in page dir cache\n",pgd_cache_size);
| #endif	
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| extern pgprot_t protection_map[16];
|--- 2.5.9/arch/sparc64/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/sparc64/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -334,7 +334,7 @@ void show_mem(void)
| #ifndef CONFIG_SMP
| 	printk("%d entries in page dir cache\n",pgd_cache_size);
| #endif	
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| void mmu_info(struct seq_file *m)
|--- 2.5.9/arch/x86_64/mm/init.c~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/arch/x86_64/mm/init.c	Wed Apr 24 01:06:14 2002
|@@ -69,7 +69,7 @@ void show_mem(void)
| 	printk("%d reserved pages\n",reserved);
| 	printk("%d pages shared\n",shared);
| 	printk("%d pages swap cached\n",cached);
|-	show_buffers();
|+	printk("%ld buffermem pages\n", nr_buffermem_pages());
| }
| 
| /* References to section boundaries */
|--- 2.5.9/drivers/sgi/char/sgiserial.c~cleanup-060-show_buffers	
|Wed Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/drivers/sgi/char/sgiserial.c	Wed Apr 24 01:06:14 2002
|@@ -423,7 +423,8 @@ static _INLINE_ void receive_chars(struc
| 			show_state();
| 			return;
| 		} else if (ch == 2) {
|-			show_buffers();
|+			printk("%ld buffermem pages\n",
|+					nr_buffermem_pages());
| 			return;
| 		}
| 	}
|--- 2.5.9/include/linux/fs.h~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/include/linux/fs.h	Wed Apr 24 01:44:52 2002
|@@ -1585,8 +1585,6 @@ extern ssize_t generic_read_dir(struct f
| extern struct file_operations simple_dir_operations;
| extern struct inode_operations simple_dir_inode_operations;
| 
|-extern void show_buffers(void);
|-
| #ifdef CONFIG_BLK_DEV_INITRD
| extern unsigned int real_root_dev;
| #endif
|--- 2.5.9/mm/page_alloc.c~cleanup-060-show_buffers	Wed Apr 24 
|01:06:14 2002
|+++ 2.5.9-akpm/mm/page_alloc.c	Wed Apr 24 01:06:14 2002
|@@ -619,6 +619,11 @@ unsigned int nr_free_highpages (void)
| }
| #endif
| 
|+unsigned long nr_buffermem_pages(void)
|+{
|+	return atomic_read(&buffermem_pages);
|+}
|+
| /*
|  * Accumulate the page_state information across all CPUs.
|  * The result is unavoidably approximate - it can change
|--- 2.5.9/include/linux/swap.h~cleanup-060-show_buffers	Wed 
|Apr 24 01:06:14 2002
|+++ 2.5.9-akpm/include/linux/swap.h	Wed Apr 24 01:06:14 2002
|@@ -98,6 +98,7 @@ extern int nr_swap_pages;
| extern unsigned int nr_free_pages(void);
| extern unsigned int nr_free_buffer_pages(void);
| extern unsigned int nr_free_pagecache_pages(void);
|+extern unsigned long nr_buffermem_pages(void);
| extern int nr_active_pages;
| extern int nr_inactive_pages;
| extern atomic_t nr_async_pages;
|
|-
|-
|To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPartTM-000-76333d7b-5776-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************
      


Information contained in this E-MAIL being proprietary to Wipro Limited
is 'privileged' and 'confidential' and intended for use only by the
individual or entity to which it is addressed. You are notified that any
use, copying or dissemination of the information contained in the E-MAIL
in any manner whatsoever is strictly prohibited.



 ********************************************************************

------=_NextPartTM-000-76333d7b-5776-11d6-a942-00b0d0d06be8--
