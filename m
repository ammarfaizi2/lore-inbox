Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293742AbSCKNsd>; Mon, 11 Mar 2002 08:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293737AbSCKNsS>; Mon, 11 Mar 2002 08:48:18 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50695 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293739AbSCKNr5>; Mon, 11 Mar 2002 08:47:57 -0500
Message-Id: <200203111345.g2BDjcq05339@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] KERN_INFO 2.4.19-pre2 "freeing unused mem"
Date: Mon, 11 Mar 2002 15:44:52 -0200
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

diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/alpha/mm/init.c linux-new/arch/alpha/mm/init.c
--- linux-2.4.19-pre2/arch/alpha/mm/init.c	Fri Sep 21 01:02:03 2001
+++ linux-new/arch/alpha/mm/init.c	Mon Mar 11 10:31:26 2002
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
 
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/cris/mm/init.c linux-new/arch/cris/mm/init.c
--- linux-2.4.19-pre2/arch/cris/mm/init.c	Mon Feb 25 17:37:52 2002
+++ linux-new/arch/cris/mm/init.c	Mon Mar 11 10:42:33 2002
@@ -465,7 +465,7 @@
                 free_page(addr);
                 totalram_pages++;
         }
-        printk ("Freeing unused kernel memory: %luk freed\n", 
+        printk (KERN_INFO "Freeing unused kernel memory: %luk freed\n", 
 		(&__init_end - &__init_begin) >> 10);
 }
 
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/i386/mm/init.c linux-new/arch/i386/mm/init.c
--- linux-2.4.19-pre2/arch/i386/mm/init.c	Fri Dec 21 15:41:53 2001
+++ linux-new/arch/i386/mm/init.c	Mon Mar 11 10:31:26 2002
@@ -505,7 +505,7 @@
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
 
-	printk("Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
+	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
 		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
 		max_mapnr << (PAGE_SHIFT-10),
 		codesize >> 10,
@@ -569,14 +569,14 @@
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
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/ia64/mm/init.c linux-new/arch/ia64/mm/init.c
--- linux-2.4.19-pre2/arch/ia64/mm/init.c	Fri Nov  9 20:26:17 2001
+++ linux-new/arch/ia64/mm/init.c	Mon Mar 11 10:31:26 2002
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
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/mips/mm/init.c linux-new/arch/mips/mm/init.c
--- linux-2.4.19-pre2/arch/mips/mm/init.c	Tue Mar  5 12:41:54 2002
+++ linux-new/arch/mips/mm/init.c	Mon Mar 11 10:31:26 2002
@@ -368,7 +368,7 @@
 		totalram_pages++;
 		addr += PAGE_SIZE;
 	}
-	printk("Freeing unused kernel memory: %dk freed\n",
+	printk(KERN_INFO "Freeing unused kernel memory: %dk freed\n",
 	       (&__init_end - &__init_begin) >> 10);
 }
 
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/mips64/mm/init.c linux-new/arch/mips64/mm/init.c
--- linux-2.4.19-pre2/arch/mips64/mm/init.c	Tue Mar  5 12:42:03 2002
+++ linux-new/arch/mips64/mm/init.c	Mon Mar 11 10:31:26 2002
@@ -325,7 +325,7 @@
 		totalram_pages++;
 		addr += PAGE_SIZE;
 	}
-	printk("Freeing unused kernel memory: %ldk freed\n",
+	printk(KERN_INFO "Freeing unused kernel memory: %ldk freed\n",
 	       (&__init_end - &__init_begin) >> 10);
 }
 
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/ppc/mm/init.c linux-new/arch/ppc/mm/init.c
--- linux-2.4.19-pre2/arch/ppc/mm/init.c	Mon Feb 25 17:37:55 2002
+++ linux-new/arch/ppc/mm/init.c	Mon Mar 11 10:31:26 2002
@@ -230,7 +230,7 @@
 		 (unsigned long)(&__ ## TYPE ## _end), \
 		 #TYPE);
 
-	printk ("Freeing unused kernel memory:");
+	printk (KERN_INFO "Freeing unused kernel memory:");
 	FREESEC(init);
 	if (_machine != _MACH_Pmac)
 		FREESEC(pmac);
@@ -247,7 +247,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+	printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
@@ -515,7 +515,7 @@
 	}
 #endif /* CONFIG_HIGHMEM */
 
-        printk("Memory: %luk available (%dk kernel code, %dk data, %dk init, %ldk highmem)\n",
+        printk(KERN_INFO "Memory: %luk available (%dk kernel code, %dk data, %dk init, %ldk highmem)\n",
 	       (unsigned long)nr_free_pages()<< (PAGE_SHIFT-10),
 	       codepages<< (PAGE_SHIFT-10), datapages<< (PAGE_SHIFT-10),
 	       initpages<< (PAGE_SHIFT-10),
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/s390/mm/init.c linux-new/arch/s390/mm/init.c
--- linux-2.4.19-pre2/arch/s390/mm/init.c	Thu Oct 11 14:04:57 2001
+++ linux-new/arch/s390/mm/init.c	Mon Mar 11 10:31:26 2002
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
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/s390x/mm/init.c linux-new/arch/s390x/mm/init.c
--- linux-2.4.19-pre2/arch/s390x/mm/init.c	Fri Nov  9 19:58:02 2001
+++ linux-new/arch/s390x/mm/init.c	Mon Mar 11 10:31:26 2002
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
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/sh/mm/init.c linux-new/arch/sh/mm/init.c
--- linux-2.4.19-pre2/arch/sh/mm/init.c	Mon Oct 15 18:36:48 2001
+++ linux-new/arch/sh/mm/init.c	Mon Mar 11 10:31:26 2002
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
 
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/arch/sparc/mm/init.c linux-new/arch/sparc/mm/init.c
--- linux-2.4.19-pre2/arch/sparc/mm/init.c	Fri Dec 21 15:41:53 2001
+++ linux-new/arch/sparc/mm/init.c	Mon Mar 11 10:31:26 2002
@@ -459,7 +459,7 @@
 	initpages = (((unsigned long) &__init_end) - ((unsigned long) &__init_begin));
 	initpages = PAGE_ALIGN(initpages) >> PAGE_SHIFT;
 
-	printk("Memory: %dk available (%dk kernel code, %dk data, %dk init, %ldk highmem) [%08lx,%08lx]\n",
+	printk(KERN_INFO "Memory: %dk available (%dk kernel code, %dk data, %dk init, %ldk highmem) [%08lx,%08lx]\n",
 	       nr_free_pages() << (PAGE_SHIFT-10),
 	       codepages << (PAGE_SHIFT-10),
 	       datapages << (PAGE_SHIFT-10), 
@@ -486,14 +486,14 @@
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
 
