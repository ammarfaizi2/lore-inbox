Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSJMDWJ>; Sat, 12 Oct 2002 23:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJMDWJ>; Sat, 12 Oct 2002 23:22:09 -0400
Received: from [218.245.208.194] ([218.245.208.194]:9856 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261411AbSJMDWE>;
	Sat, 12 Oct 2002 23:22:04 -0400
Date: Sun, 13 Oct 2002 11:20:36 +0800
From: Hu Gang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: patch for 2.5.42. 1/2
Message-Id: <20021013112036.4c14a156.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.5JPRKPueM,sNBi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.5JPRKPueM,sNBi
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__13_Oct_2002_11:20:36_+0800_0b9bc098"


--Multipart_Sun__13_Oct_2002_11:20:36_+0800_0b9bc098
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Pavel Machek:

This patch can fix, That if run suspend without swaping device/file will Oops.

--- linux-2.5.42/kernel/suspend.c	Sat Oct 12 21:25:06 2002
+++ linux-2.5.42-suspend/kernel/suspend.c	Sat Oct 12 21:28:03 2002
@@ -309,6 +309,9 @@
 	union diskpage *cur;
 	struct page *page;
 
+	if (root_swap == 0xFFFF)  /* ignored */
+		return;
+
 	page = alloc_page(GFP_ATOMIC);
 	if (!page)
 		panic("Out of memory in mark_swapfiles");
@@ -686,6 +689,7 @@
 	if(nr_free_pages() < nr_needed_pages) {
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
+		root_swap = 0xFFFF;
 		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
@@ -843,8 +847,10 @@
 		PRINTK("Syncing disks before copy\n");
 		do_suspend_sync();
 
+		PRINTK("Doing drivers_suspend\n");
 		/* Save state of all device drivers, and stop them. */		   
 		if(drivers_suspend()==0)
+			PRINTK("Doing do_magic(0)\n");
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *


-- 
		- Hu Gang




--Multipart_Sun__13_Oct_2002_11:20:36_+0800_0b9bc098
Content-Type: text/plain;
 name="00000006.mimetmp"
Content-Disposition: attachment;
 filename="00000006.mimetmp"
Content-Transfer-Encoding: 7bit

Hello Pavel Machek:

This patch can fix, That if run suspend without swaping device/file will Oops.

--- linux-2.5.42/kernel/suspend.c	Sat Oct 12 21:25:06 2002
+++ linux-2.5.42-suspend/kernel/suspend.c	Sat Oct 12 21:28:03 2002
@@ -309,6 +309,9 @@
 	union diskpage *cur;
 	struct page *page;
 
+	if (root_swap == 0xFFFF)  /* ignored */
+		return;
+
 	page = alloc_page(GFP_ATOMIC);
 	if (!page)
 		panic("Out of memory in mark_swapfiles");
@@ -686,6 +689,7 @@
 	if(nr_free_pages() < nr_needed_pages) {
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
+		root_swap = 0xFFFF;
 		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
@@ -843,8 +847,10 @@
 		PRINTK("Syncing disks before copy\n");
 		do_suspend_sync();
 
+		PRINTK("Doing drivers_suspend\n");
 		/* Save state of all device drivers, and stop them. */		   
 		if(drivers_suspend()==0)
+			PRINTK("Doing do_magic(0)\n");
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *


-- 
		- Hu Gang




--Multipart_Sun__13_Oct_2002_11:20:36_+0800_0b9bc098
Content-Type: text/plain;
 name="00000001.mimetmp"
Content-Disposition: attachment;
 filename="00000001.mimetmp"
Content-Transfer-Encoding: 7bit

Hello Pavel Machek:

This patch can fix, That if run suspend without swaping device/file will Oops.

--- linux-2.5.42/kernel/suspend.c	Sat Oct 12 21:25:06 2002
+++ linux-2.5.42-suspend/kernel/suspend.c	Sat Oct 12 21:28:03 2002
@@ -309,6 +309,9 @@
 	union diskpage *cur;
 	struct page *page;
 
+	if (root_swap == 0xFFFF)  /* ignored */
+		return;
+
 	page = alloc_page(GFP_ATOMIC);
 	if (!page)
 		panic("Out of memory in mark_swapfiles");
@@ -686,6 +689,7 @@
 	if(nr_free_pages() < nr_needed_pages) {
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
+		root_swap = 0xFFFF;
 		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
@@ -843,8 +847,10 @@
 		PRINTK("Syncing disks before copy\n");
 		do_suspend_sync();
 
+		PRINTK("Doing drivers_suspend\n");
 		/* Save state of all device drivers, and stop them. */		   
 		if(drivers_suspend()==0)
+			PRINTK("Doing do_magic(0)\n");
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *


-- 
		- Hu Gang




--Multipart_Sun__13_Oct_2002_11:20:36_+0800_0b9bc098
Content-Type: application/pgp-signature;
 name="00000000.mimetmp"
Content-Disposition: attachment;
 filename="00000000.mimetmp"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi4wIChHTlUv
TGludXgpCgppRDhEQlFFOXFDVGxQTTR1Q3k3YkFKZ1JBdkliQUp3THN1VlQrRGNtdVBCZlhudGV2
NHp0bU5DYTRBQ2VQT1Q3CkVQZ01lVDNLQ1NQNTU4SVl1MkFsOEdVPQo9bUs2MAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KDQo=

--Multipart_Sun__13_Oct_2002_11:20:36_+0800_0b9bc098--

--=.5JPRKPueM,sNBi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qOaEPM4uCy7bAJgRApzjAJ9SJN/GO2n1zwBXShCNiT8is7WupACff+Zg
s2TYjdS0Glvq01zVZRFKTu4=
=F8n8
-----END PGP SIGNATURE-----

--=.5JPRKPueM,sNBi--
