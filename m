Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSA1Hzu>; Mon, 28 Jan 2002 02:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288668AbSA1Hzc>; Mon, 28 Jan 2002 02:55:32 -0500
Received: from [195.66.192.167] ([195.66.192.167]:33287 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S285516AbSA1Hz3>; Mon, 28 Jan 2002 02:55:29 -0500
Message-Id: <200201280751.g0S7pqE21752@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] KERN_INFO for "Freeing unused kernel mem"
Date: Mon, 28 Jan 2002 09:51:54 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

This diff is for _INFO'izing "Freeing unused kernel mem"
for multiple archs.
--
vda

diff --recursive -u linux-2.4.13-orig/arch/alpha/mm/init.c linux-2.4.13-new/arch/alpha/mm/init.c
--- linux-2.4.13-orig/arch/alpha/mm/init.c	Fri Sep 21 01:02:03 2001
+++ linux-2.4.13-new/arch/alpha/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -380,7 +380,7 @@
 		free_page(addr);
 		totalram_pages++;
 	}
-	printk ("Freeing unused kernel memory: %ldk freed\n",
+	printk (KERN_INFO "Freeing unused kernel memory: %ldk freed\n",
 		(&__init_end - &__init_begin) >> 10);
 }
 
@@ -395,7 +395,7 @@
 		free_page(start);
 		totalram_pages++;
 	}
-	printk ("Freeing initrd memory: %ldk freed\n", (end - __start) >> 10);
+	printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - __start) >> 10);
 }
 #endif
 
diff --recursive -u linux-2.4.13-orig/arch/cris/mm/init.c linux-2.4.13-new/arch/cris/mm/init.c
--- linux-2.4.13-orig/arch/cris/mm/init.c	Thu Jul 26 20:10:06 2001
+++ linux-2.4.13-new/arch/cris/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -459,7 +459,7 @@
                 free_page(addr);
                 totalram_pages++;
         }
-        printk ("Freeing unused kernel memory: %dk freed\n", 
+        printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", 
 		(&__init_end - &__init_begin) >> 10);
 }
 
diff --recursive -u linux-2.4.13-orig/arch/i386/mm/init.c linux-2.4.13-new/arch/i386/mm/init.c
--- linux-2.4.13-orig/arch/i386/mm/init.c	Fri Sep 21 00:59:20 2001
+++ linux-2.4.13-new/arch/i386/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -488,7 +488,7 @@
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
 
-	printk("Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
+	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
 		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
 		max_mapnr << (PAGE_SHIFT-10),
 		codesize >> 10,
@@ -552,14 +552,14 @@
 		free_page(addr);
 		totalram_pages++;
 	}
-	printk ("Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
+	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start < end)
-		printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
diff --recursive -u linux-2.4.13-orig/arch/ia64/mm/init.c linux-2.4.13-new/arch/ia64/mm/init.c
--- linux-2.4.13-orig/arch/ia64/mm/init.c	Fri Sep 21 01:02:03 2001
+++ linux-2.4.13-new/arch/ia64/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -99,7 +99,7 @@
 		free_page(addr);
 		++totalram_pages;
 	}
-	printk ("Freeing unused kernel memory: %ldkB freed\n",
+	printk (KERN_INFO "Freeing unused kernel memory: %ldkB freed\n",
 		(&__init_end - &__init_begin) >> 10);
 }
 
@@ -141,7 +141,7 @@
 	end = end & PAGE_MASK;
 
 	if (start < end)
-		printk ("Freeing initrd memory: %ldkB freed\n", (end - start) >> 10);
+		printk (KERN_INFO "Freeing initrd memory: %ldkB freed\n", (end - start) >> 10);
 
 	for (; start < end; start += PAGE_SIZE) {
 		if (!VALID_PAGE(virt_to_page(start)))
diff --recursive -u linux-2.4.13-orig/arch/mips/mm/init.c linux-2.4.13-new/arch/mips/mm/init.c
--- linux-2.4.13-orig/arch/mips/mm/init.c	Wed Jul  4 16:50:39 2001
+++ linux-2.4.13-new/arch/mips/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -262,7 +262,7 @@
 		totalram_pages++;
 		addr += PAGE_SIZE;
 	}
-	printk("Freeing unused kernel memory: %dk freed\n",
+	printk(KERN_INFO "Freeing unused kernel memory: %dk freed\n",
 	       (&__init_end - &__init_begin) >> 10);
 }
 
diff --recursive -u linux-2.4.13-orig/arch/mips64/mm/init.c linux-2.4.13-new/arch/mips64/mm/init.c
--- linux-2.4.13-orig/arch/mips64/mm/init.c	Wed Jul  4 16:50:39 2001
+++ linux-2.4.13-new/arch/mips64/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -455,7 +455,7 @@
 		totalram_pages++;
 		addr += PAGE_SIZE;
 	}
-	printk("Freeing unused kernel memory: %ldk freed\n",
+	printk(KERN_INFO "Freeing unused kernel memory: %ldk freed\n",
 	       (&__init_end - &__init_begin) >> 10);
 }
 
diff --recursive -u linux-2.4.13-orig/arch/ppc/mm/init.c linux-2.4.13-new/arch/ppc/mm/init.c
--- linux-2.4.13-orig/arch/ppc/mm/init.c	Tue Oct  2 14:12:44 2001
+++ linux-2.4.13-new/arch/ppc/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -231,7 +231,7 @@
 		 (unsigned long)(&__ ## TYPE ## _end), \
 		 #TYPE);
 
-	printk ("Freeing unused kernel memory:");
+	printk (KERN_INFO "Freeing unused kernel memory:");
 	FREESEC(init);
 	if (_machine != _MACH_Pmac)
 		FREESEC(pmac);
@@ -248,7 +248,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+	printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
@@ -518,7 +518,7 @@
 	}
 #endif /* CONFIG_HIGHMEM */
 
-        printk("Memory: %luk available (%dk kernel code, %dk data, %dk init, %ldk highmem)\n",
+        printk(KERN_INFO "Memory: %luk available (%dk kernel code, %dk data, %dk init, %ldk highmem)\n",
 	       (unsigned long)nr_free_pages()<< (PAGE_SHIFT-10),
 	       codepages<< (PAGE_SHIFT-10), datapages<< (PAGE_SHIFT-10),
 	       initpages<< (PAGE_SHIFT-10),
diff --recursive -u linux-2.4.13-orig/arch/s390/mm/init.c linux-2.4.13-new/arch/s390/mm/init.c
--- linux-2.4.13-orig/arch/s390/mm/init.c	Thu Oct 11 14:04:57 2001
+++ linux-2.4.13-new/arch/s390/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -214,7 +214,7 @@
 		free_page(addr);
 		totalram_pages++;
         }
-        printk ("Freeing unused kernel memory: %dk freed\n",
+        printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n",
 		(&__init_end - &__init_begin) >> 10);
 }
 
@@ -222,7 +222,7 @@
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
         if (start < end)
-                printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+                printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
         for (; start < end; start += PAGE_SIZE) {
                 ClearPageReserved(virt_to_page(start));
                 set_page_count(virt_to_page(start), 1);
diff --recursive -u linux-2.4.13-orig/arch/s390x/mm/init.c linux-2.4.13-new/arch/s390x/mm/init.c
--- linux-2.4.13-orig/arch/s390x/mm/init.c	Thu Oct 11 14:04:57 2001
+++ linux-2.4.13-new/arch/s390x/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -226,7 +226,7 @@
 		free_page(addr);
 		totalram_pages++;
         }
-        printk ("Freeing unused kernel memory: %ldk freed\n",
+        printk (KERN_INFO "Freeing unused kernel memory: %ldk freed\n",
 		(&__init_end - &__init_begin) >> 10);
 }
 
@@ -234,7 +234,7 @@
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
         if (start < end)
-                printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+                printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
                 ClearPageReserved(virt_to_page(start));
                 set_page_count(virt_to_page(start), 1);
diff --recursive -u linux-2.4.13-orig/arch/sh/mm/init.c linux-2.4.13-new/arch/sh/mm/init.c
--- linux-2.4.13-orig/arch/sh/mm/init.c	Mon Oct 15 18:36:48 2001
+++ linux-2.4.13-new/arch/sh/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -187,7 +187,7 @@
 		free_page(addr);
 		totalram_pages++;
 	}
-	printk ("Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
+	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -200,7 +200,7 @@
 		free_page(p);
 		totalram_pages++;
 	}
-	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+	printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 }
 #endif
 
diff --recursive -u linux-2.4.13-orig/arch/sparc/mm/init.c linux-2.4.13-new/arch/sparc/mm/init.c
--- linux-2.4.13-orig/arch/sparc/mm/init.c	Mon Oct  1 14:19:56 2001
+++ linux-2.4.13-new/arch/sparc/mm/init.c	Thu Nov  8 23:42:11 2001
@@ -462,7 +462,7 @@
 	initpages = (((unsigned long) &__init_end) - ((unsigned long) &__init_begin));
 	initpages = PAGE_ALIGN(initpages) >> PAGE_SHIFT;
 
-	printk("Memory: %dk available (%dk kernel code, %dk data, %dk init, %ldk highmem) [%08lx,%08lx]\n",
+	printk(KERN_INFO "Memory: %dk available (%dk kernel code, %dk data, %dk init, %ldk highmem) [%08lx,%08lx]\n",
 	       nr_free_pages() << (PAGE_SHIFT-10),
 	       codepages << (PAGE_SHIFT-10),
 	       datapages << (PAGE_SHIFT-10), 
@@ -489,14 +489,14 @@
 		totalram_pages++;
 		num_physpages++;
 	}
-	printk ("Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
+	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start < end)
-		printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		struct page *p = virt_to_page(start);
 
