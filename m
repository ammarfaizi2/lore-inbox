Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286212AbRLJKK1>; Mon, 10 Dec 2001 05:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286214AbRLJKKU>; Mon, 10 Dec 2001 05:10:20 -0500
Received: from [195.66.192.167] ([195.66.192.167]:19461 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286212AbRLJKJ6>; Mon, 10 Dec 2001 05:09:58 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] printk(*KERN_INFO* "Freeing unused kernel/initrd mem")
Date: Mon, 10 Dec 2001 12:03:40 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01121012034001.01165@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes loglevel of "Freeing unused kernel/initrd mem" printks
to KERN_INFO in several archs.

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Since wholesale patch wasn't accepted, I'll send most obvious
parts split in small pieces now.

If something wrong with the patch or with the way I'm trying to
push it into mainstream kernel, let me know.

vda@port.imtp.ilyichevsk.odessa.ua

diff -u --recursive linux-2.4.16-pre1.orig/arch/alpha/mm/init.c 
linux-2.4.16-pre1/arch/alpha/mm/init.c
--- linux-2.4.16-pre1.orig/arch/alpha/mm/init.c	Fri Sep 21 01:02:03 2001
+++ linux-2.4.16-pre1/arch/alpha/mm/init.c	Tue Nov 27 17:19:07 2001
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
+	printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - __start) >> 
10);
 }
 #endif
 
diff -u --recursive linux-2.4.16-pre1.orig/arch/cris/mm/init.c 
linux-2.4.16-pre1/arch/cris/mm/init.c
--- linux-2.4.16-pre1.orig/arch/cris/mm/init.c	Thu Jul 26 20:10:06 2001
+++ linux-2.4.16-pre1/arch/cris/mm/init.c	Tue Nov 27 17:19:08 2001
@@ -459,7 +459,7 @@
                 free_page(addr);
                 totalram_pages++;
         }
-        printk ("Freeing unused kernel memory: %dk freed\n", 
+        printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", 
 		(&__init_end - &__init_begin) >> 10);
 }
 
diff -u --recursive linux-2.4.16-pre1.orig/arch/i386/mm/init.c 
linux-2.4.16-pre1/arch/i386/mm/init.c
--- linux-2.4.16-pre1.orig/arch/i386/mm/init.c	Sun Nov 11 16:09:32 2001
+++ linux-2.4.16-pre1/arch/i386/mm/init.c	Tue Nov 27 17:19:08 2001
@@ -504,7 +504,7 @@
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
 
-	printk("Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk 
data, %dk init, %ldk highmem)\n",
+	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk 
reserved, %dk data, %dk init, %ldk highmem)\n",
 		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
 		max_mapnr << (PAGE_SHIFT-10),
 		codesize >> 10,
@@ -568,14 +568,14 @@
 		free_page(addr);
 		totalram_pages++;
 	}
-	printk ("Freeing unused kernel memory: %dk freed\n", (&__init_end - 
&__init_begin) >> 10);
+	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end 
- &__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start < end)
-		printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 
10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
diff -u --recursive linux-2.4.16-pre1.orig/arch/ia64/mm/init.c 
linux-2.4.16-pre1/arch/ia64/mm/init.c
--- linux-2.4.16-pre1.orig/arch/ia64/mm/init.c	Fri Nov  9 20:26:17 2001
+++ linux-2.4.16-pre1/arch/ia64/mm/init.c	Tue Nov 27 17:19:08 2001
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
+		printk (KERN_INFO "Freeing initrd memory: %ldkB freed\n", (end - start) >> 
10);
 
 	for (; start < end; start += PAGE_SIZE) {
 		if (!VALID_PAGE(virt_to_page(start)))
diff -u --recursive linux-2.4.16-pre1.orig/arch/mips/mm/init.c 
linux-2.4.16-pre1/arch/mips/mm/init.c
--- linux-2.4.16-pre1.orig/arch/mips/mm/init.c	Wed Jul  4 16:50:39 2001
+++ linux-2.4.16-pre1/arch/mips/mm/init.c	Tue Nov 27 17:19:08 2001
@@ -262,7 +262,7 @@
 		totalram_pages++;
 		addr += PAGE_SIZE;
 	}
-	printk("Freeing unused kernel memory: %dk freed\n",
+	printk(KERN_INFO "Freeing unused kernel memory: %dk freed\n",
 	       (&__init_end - &__init_begin) >> 10);
 }
 
diff -u --recursive linux-2.4.16-pre1.orig/arch/mips64/mm/init.c 
linux-2.4.16-pre1/arch/mips64/mm/init.c
--- linux-2.4.16-pre1.orig/arch/mips64/mm/init.c	Wed Jul  4 16:50:39 2001
+++ linux-2.4.16-pre1/arch/mips64/mm/init.c	Tue Nov 27 17:19:08 2001
@@ -455,7 +455,7 @@
 		totalram_pages++;
 		addr += PAGE_SIZE;
 	}
-	printk("Freeing unused kernel memory: %ldk freed\n",
+	printk(KERN_INFO "Freeing unused kernel memory: %ldk freed\n",
 	       (&__init_end - &__init_begin) >> 10);
 }
 
diff -u --recursive linux-2.4.16-pre1.orig/arch/ppc/mm/init.c 
linux-2.4.16-pre1/arch/ppc/mm/init.c
--- linux-2.4.16-pre1.orig/arch/ppc/mm/init.c	Tue Oct  2 14:12:44 2001
+++ linux-2.4.16-pre1/arch/ppc/mm/init.c	Tue Nov 27 17:19:08 2001
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
+	printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 
10);
 
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
@@ -518,7 +518,7 @@
 	}
 #endif /* CONFIG_HIGHMEM */
 
-        printk("Memory: %luk available (%dk kernel code, %dk data, %dk init, 
%ldk highmem)\n",
+        printk(KERN_INFO "Memory: %luk available (%dk kernel code, %dk data, 
%dk init, %ldk highmem)\n",
 	       (unsigned long)nr_free_pages()<< (PAGE_SHIFT-10),
 	       codepages<< (PAGE_SHIFT-10), datapages<< (PAGE_SHIFT-10),
 	       initpages<< (PAGE_SHIFT-10),
diff -u --recursive linux-2.4.16-pre1.orig/arch/s390/mm/init.c 
linux-2.4.16-pre1/arch/s390/mm/init.c
--- linux-2.4.16-pre1.orig/arch/s390/mm/init.c	Thu Oct 11 14:04:57 2001
+++ linux-2.4.16-pre1/arch/s390/mm/init.c	Tue Nov 27 17:19:08 2001
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
-                printk ("Freeing initrd memory: %ldk freed\n", (end - start) 
>> 10);
+                printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", 
(end - start) >> 10);
         for (; start < end; start += PAGE_SIZE) {
                 ClearPageReserved(virt_to_page(start));
                 set_page_count(virt_to_page(start), 1);
diff -u --recursive linux-2.4.16-pre1.orig/arch/s390x/mm/init.c 
linux-2.4.16-pre1/arch/s390x/mm/init.c
--- linux-2.4.16-pre1.orig/arch/s390x/mm/init.c	Fri Nov  9 19:58:02 2001
+++ linux-2.4.16-pre1/arch/s390x/mm/init.c	Tue Nov 27 17:19:08 2001
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
-                printk ("Freeing initrd memory: %ldk freed\n", (end - start) 
>> 10);
+                printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", 
(end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
                 ClearPageReserved(virt_to_page(start));
                 set_page_count(virt_to_page(start), 1);
diff -u --recursive linux-2.4.16-pre1.orig/arch/sh/mm/init.c 
linux-2.4.16-pre1/arch/sh/mm/init.c
--- linux-2.4.16-pre1.orig/arch/sh/mm/init.c	Mon Oct 15 18:36:48 2001
+++ linux-2.4.16-pre1/arch/sh/mm/init.c	Tue Nov 27 17:19:08 2001
@@ -187,7 +187,7 @@
 		free_page(addr);
 		totalram_pages++;
 	}
-	printk ("Freeing unused kernel memory: %dk freed\n", (&__init_end - 
&__init_begin) >> 10);
+	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end 
- &__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -200,7 +200,7 @@
 		free_page(p);
 		totalram_pages++;
 	}
-	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+	printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 
10);
 }
 #endif
 
diff -u --recursive linux-2.4.16-pre1.orig/arch/sparc/mm/init.c 
linux-2.4.16-pre1/arch/sparc/mm/init.c
--- linux-2.4.16-pre1.orig/arch/sparc/mm/init.c	Mon Oct  1 14:19:56 2001
+++ linux-2.4.16-pre1/arch/sparc/mm/init.c	Tue Nov 27 17:19:08 2001
@@ -462,7 +462,7 @@
 	initpages = (((unsigned long) &__init_end) - ((unsigned long) 
&__init_begin));
 	initpages = PAGE_ALIGN(initpages) >> PAGE_SHIFT;
 
-	printk("Memory: %dk available (%dk kernel code, %dk data, %dk init, %ldk 
highmem) [%08lx,%08lx]\n",
+	printk(KERN_INFO "Memory: %dk available (%dk kernel code, %dk data, %dk 
init, %ldk highmem) [%08lx,%08lx]\n",
 	       nr_free_pages() << (PAGE_SHIFT-10),
 	       codepages << (PAGE_SHIFT-10),
 	       datapages << (PAGE_SHIFT-10), 
@@ -489,14 +489,14 @@
 		totalram_pages++;
 		num_physpages++;
 	}
-	printk ("Freeing unused kernel memory: %dk freed\n", (&__init_end - 
&__init_begin) >> 10);
+	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end 
- &__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start < end)
-		printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 
10);
 	for (; start < end; start += PAGE_SIZE) {
 		struct page *p = virt_to_page(start);
 
