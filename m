Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264664AbSJOTwr>; Tue, 15 Oct 2002 15:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264671AbSJOTwn>; Tue, 15 Oct 2002 15:52:43 -0400
Received: from ip008.siteplanet.com.br ([200.245.54.8]:7689 "EHLO
	plutao.siteplanet.com.br") by vger.kernel.org with ESMTP
	id <S264664AbSJOTw2>; Tue, 15 Oct 2002 15:52:28 -0400
Subject: [PATCH 2.0] Fixed kernel stuff
From: Fernando Alencar =?ISO-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
To: David Weinehall <tao@acc.umu.se>
Cc: fadel@ferasoft.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20021014220527.GU26715@khan.acc.umu.se>
References: <1034548634.543.1.camel@nitrogenium> 
	<20021014220527.GU26715@khan.acc.umu.se>
Content-Type: multipart/mixed; boundary="=-BtlZSwMnPdmHMpBsdk2N"
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Oct 2002 17:02:37 -0200
Message-Id: <1034708558.427.0.camel@nitrogenium>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BtlZSwMnPdmHMpBsdk2N
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all, specially David=20

I think this patch is trivial enough to be accepted, but...

This patch fixed some stuff:
	* Fixed warning in script/lxdialog/menubox.c
	* Fixed warning in script/lxdialog/textbox.c
	* Small VM updates ...

Please apply.


best regards,

--=20
Fernando Alencar Mar=F3stica
Graduate Student, Computer Science
Linux Register User Id #281457

University Methodist of Piracicaba
Departament of Computer Science
home: http://www.unimep.br/~famarost


--=-BtlZSwMnPdmHMpBsdk2N
Content-Disposition: attachment; filename=linux-2.0.40-rc6.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.0.40-rc6.patch; charset=ISO-8859-1

diff -urN linux-2.0.39/CREDITS linux-2.0.39-patch/CREDITS
--- linux-2.0.39/CREDITS	Tue Jan  9 19:29:20 2001
+++ linux-2.0.39-patch/CREDITS	Tue Oct 15 13:22:10 2002
@@ -1409,6 +1409,16 @@
 S: Santa Clara, California 95051
 S: USA
=20
+N: Fernando Alencar Mar=F3stica
+E: famarost@unimep.br
+W: http://www.unimep.br/~famarost
+D: Miscellaneous kernel hacker
+S: UNIMEP University Methodist of Piracicaba
+S: Departament of Computer Science
+S: Rodovia do A=E7ucar, Km 156
+S: 13400-911 - Piracicaba - S=E3o Paulo
+S: Brazil
+
 N: Jeff Tranter
 E: Jeff_Tranter@Mitel.COM
 D: Enhancements to Joystick driver
diff -urN linux-2.0.39/include/asm-i386/page.h linux-2.0.39-patch/include/a=
sm-i386/page.h
--- linux-2.0.39/include/asm-i386/page.h	Sun Jun 13 14:21:03 1999
+++ linux-2.0.39-patch/include/asm-i386/page.h	Sun Oct 13 12:42:04 2002
@@ -11,6 +11,9 @@
=20
 #define STRICT_MM_TYPECHECKS
=20
+#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
+
 #ifdef STRICT_MM_TYPECHECKS
 /*
  * These are used to make use of C type-checking..
diff -urN linux-2.0.39/include/asm-i386/pgtable.h linux-2.0.39-patch/includ=
e/asm-i386/pgtable.h
--- linux-2.0.39/include/asm-i386/pgtable.h	Wed Aug 25 19:08:27 1999
+++ linux-2.0.39-patch/include/asm-i386/pgtable.h	Sun Oct 13 13:08:24 2002
@@ -229,7 +229,7 @@
  * area for the same reason. ;)
  */
 #define VMALLOC_OFFSET	(8*1024*1024)
-#define VMALLOC_START ((high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1=
))
+#define VMALLOC_START (((unsigned long)high_memory + VMALLOC_OFFSET) & ~(V=
MALLOC_OFFSET-1))
 #define VMALLOC_VMADDR(x) (TASK_SIZE + (unsigned long)(x))
=20
 /*
@@ -302,7 +302,7 @@
=20
 #define BAD_PAGETABLE __bad_pagetable()
 #define BAD_PAGE __bad_page()
-#define ZERO_PAGE ((unsigned long) empty_zero_page)
+#define ZERO_PAGE(vaddr) ((unsigned long) empty_zero_page)
=20
 /* number of bits that fit into a memory pointer */
 #define BITS_PER_PTR			(8*sizeof(unsigned long))
diff -urN linux-2.0.39/mm/filemap.c linux-2.0.39-patch/mm/filemap.c
--- linux-2.0.39/mm/filemap.c	Wed Jun  3 19:17:50 1998
+++ linux-2.0.39-patch/mm/filemap.c	Sun Oct 13 12:56:38 2002
@@ -817,7 +817,7 @@
 	/*
 	 * No sharing ... copy to the new page.
 	 */
-	memcpy((void *) new_page, (void *) old_page, PAGE_SIZE);
+	copy_page(new_page, old_page);
 	flush_page_to_ram(new_page);
 	release_page(page);
 	return new_page;
diff -urN linux-2.0.39/mm/memory.c linux-2.0.39-patch/mm/memory.c
--- linux-2.0.39/mm/memory.c	Wed Sep 11 11:57:19 1996
+++ linux-2.0.39-patch/mm/memory.c	Sun Oct 13 13:19:20 2002
@@ -57,18 +57,18 @@
  * a common occurrence (no need to read the page to know
  * that it's zero - better for the cache and memory subsystem).
  */
-static inline void copy_page(unsigned long from, unsigned long to)
+static inline void copy_cow_page(unsigned long from, unsigned long to)
 {
-	if (from =3D=3D ZERO_PAGE) {
-		memset((void *) to, 0, PAGE_SIZE);
+	if (from =3D=3D ZERO_PAGE(to)) {
+		clear_page(to);
 		return;
 	}
-	memcpy((void *) to, (void *) from, PAGE_SIZE);
+	copy_page(to,from);
 }
=20
 #define USER_PTRS_PER_PGD (TASK_SIZE / PGDIR_SIZE)
=20
-mem_map_t * mem_map =3D NULL;
+mem_map_t *mem_map =3D NULL;
=20
 /*
  * oom() prints a message (so that the user knows why the process died),
@@ -88,7 +88,7 @@
  */
 static inline void free_one_pmd(pmd_t * dir)
 {
-	pte_t * pte;
+	pte_t *pte;
=20
 	if (pmd_none(*dir))
 		return;
@@ -632,7 +632,7 @@
 		if (new_page) {
 			if (PageReserved(mem_map + MAP_NR(old_page)))
 				++vma->vm_mm->rss;
-			copy_page(old_page,new_page);
+			copy_cow_page(old_page, new_page);
 			flush_page_to_ram(old_page);
 			flush_page_to_ram(new_page);
 			flush_cache_page(vma, address);
@@ -930,7 +930,7 @@
 		unsigned long page =3D __get_free_page(GFP_KERNEL);
 		if (!page)
 			goto sigbus;
-		memset((void *) page, 0, PAGE_SIZE);
+		clear_page(page);
 		entry =3D pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		vma->vm_mm->rss++;
 		tsk->min_flt++;
diff -urN linux-2.0.39/mm/page_alloc.c linux-2.0.39-patch/mm/page_alloc.c
--- linux-2.0.39/mm/page_alloc.c	Mon Jul 13 17:47:40 1998
+++ linux-2.0.39-patch/mm/page_alloc.c	Tue Oct 15 12:34:58 2002
@@ -42,7 +42,7 @@
 struct free_area_struct {
 	struct page *next;
 	struct page *prev;
-	unsigned int * map;
+	unsigned int *map;
 };
=20
 #define memory_head(x) ((struct page *)(x))
diff -urN linux-2.0.39/mm/vmalloc.c linux-2.0.39-patch/mm/vmalloc.c
--- linux-2.0.39/mm/vmalloc.c	Wed Jun  3 19:17:50 1998
+++ linux-2.0.39-patch/mm/vmalloc.c	Tue Oct 15 12:52:09 2002
@@ -97,11 +97,12 @@
 static void free_area_pages(unsigned long address, unsigned long size)
 {
 	pgd_t * dir;
+	unsigned long start =3D address;
 	unsigned long end =3D address + size;
=20
 	dir =3D pgd_offset(&init_mm, address);
 	flush_cache_all();
-	while (address < end) {
+	while (address >=3D start && address < end) {
 		free_area_pmd(dir, address, end - address);
 		address =3D (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
@@ -154,11 +155,12 @@
 static int alloc_area_pages(unsigned long address, unsigned long size)
 {
 	pgd_t * dir;
+	unsigned long start =3D address;
 	unsigned long end =3D address + size;
=20
 	dir =3D pgd_offset(&init_mm, address);
 	flush_cache_all();
-	while (address < end) {
+	while (address >=3D start && address < end) {
 		pmd_t *pmd =3D pmd_alloc_kernel(dir, address);
 		if (!pmd)
 			return -ENOMEM;
@@ -250,7 +252,7 @@
 			break;
 		addr =3D (void *) (tmp->size + (unsigned long) tmp->addr);
 	}
-	area->addr =3D addr;
+	area->addr =3D (void *)addr;
 	area->next =3D *p;
 	*p =3D area;
 	return area;
diff -urN linux-2.0.39/mm/vmscan.c linux-2.0.39-patch/mm/vmscan.c
--- linux-2.0.39/mm/vmscan.c	Sun Nov 15 16:33:20 1998
+++ linux-2.0.39-patch/mm/vmscan.c	Tue Oct 15 12:21:40 2002
@@ -461,7 +461,7 @@
 =09
 	current->session =3D 1;
 	current->pgrp =3D 1;
-	sprintf(current->comm, "kswapd");
+	strcpy(current->comm, "kswapd");
 	current->blocked =3D ~0UL;
 =09
 	/*
diff -urN linux-2.0.39/scripts/lxdialog/menubox.c linux-2.0.39-patch/script=
s/lxdialog/menubox.c
--- linux-2.0.39/scripts/lxdialog/menubox.c	Sun Nov 15 16:33:24 1998
+++ linux-2.0.39-patch/scripts/lxdialog/menubox.c	Sun Oct 13 13:30:54 2002
@@ -29,7 +29,7 @@
 static void
 print_item (WINDOW * win, const char *item, int choice, int selected, int =
hotkey)
 {
-    int i, j;
+    int j;
     char menu_item[menu_width+1];
=20
     strncpy(menu_item, item, menu_width);
@@ -40,8 +40,11 @@
     wattrset (win, menubox_attr);
     wmove (win, choice, 0);
 #if OLD_NCURSES
-    for (i =3D 0; i < menu_width; i++)
-	waddch (win, ' ');
+    {
+    	int i;
+	for (i =3D 0; i < menu_width; i++)
+		waddch (win, ' ');
+    }
 #else
     wclrtoeol(win);
 #endif
diff -urN linux-2.0.39/scripts/lxdialog/textbox.c linux-2.0.39-patch/script=
s/lxdialog/textbox.c
--- linux-2.0.39/scripts/lxdialog/textbox.c	Sun Nov 15 16:33:24 1998
+++ linux-2.0.39-patch/scripts/lxdialog/textbox.c	Sun Oct 13 13:31:23 2002
@@ -451,7 +451,7 @@
 static void
 print_line (WINDOW * win, int row, int width)
 {
-    int i, y, x;
+    int y, x;
     char *line;
=20
     line =3D get_line ();
@@ -463,8 +463,11 @@
     getyx (win, y, x);
     /* Clear 'residue' of previous line */
 #if OLD_NCURSES
-    for (i =3D 0; i < width - x; i++)
-	waddch (win, ' ');
+    {
+	int i;	   =20
+    	for (i =3D 0; i < width - x; i++)
+		waddch (win, ' ');
+    }
 #else
     wclrtoeol(win);
 #endif

--=-BtlZSwMnPdmHMpBsdk2N--

