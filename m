Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290056AbSBKSgJ>; Mon, 11 Feb 2002 13:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290059AbSBKSf7>; Mon, 11 Feb 2002 13:35:59 -0500
Received: from gwyn.tux.org ([207.96.122.8]:14549 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S290056AbSBKSfs>;
	Mon, 11 Feb 2002 13:35:48 -0500
Date: Mon, 11 Feb 2002 13:35:47 -0500
From: Timothy Ball <timball@tux.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: chaffee@cs.berkeley.edu, dwmw2@redhat.com, paulus@samba.org,
        marcelo@conectiva.com.br
Subject: [Patch] #define foo(a) do { ... } while(0); typo fix
Message-ID: <20020211183547.GA1630@gwyn.tux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Statements like the one in the subject shouldn't have the trailing
semicolon, it's a minor typo and I only saw it four times in my
egrep'ing so this following patch fixes it every where I saw it. 

Please apply.

--timball

--snip--snip--snip--
diff -ruN linux-2.4.18-pre1-mjc2.orig/drivers/video/chipsfb.c linux-2.4.18-pre1-mjc2/drivers/video/chipsfb.c
--- linux-2.4.18-pre1-mjc2.orig/drivers/video/chipsfb.c	Mon Feb 11 02:03:12 2002
+++ linux-2.4.18-pre1-mjc2/drivers/video/chipsfb.c	Mon Feb 11 01:38:09 2002
@@ -79,7 +79,7 @@
 } while (0)
 #define read_ind(num, var, ap, dp)	do { \
 	outb((num), (ap)); var = inb((dp)); \
-} while (0);
+} while (0)
 
 /* extension registers */
 #define write_xr(num, val)	write_ind(num, val, 0x3d6, 0x3d7)
diff -ruN linux-2.4.18-pre1-mjc2.orig/fs/vfat/namei.c linux-2.4.18-pre1-mjc2/fs/vfat/namei.c
--- linux-2.4.18-pre1-mjc2.orig/fs/vfat/namei.c	Mon Feb 11 01:59:39 2002
+++ linux-2.4.18-pre1-mjc2/fs/vfat/namei.c	Mon Feb 11 02:06:52 2002
@@ -446,7 +446,7 @@
 	(x)->lower = 1;				\
 	(x)->upper = 1;				\
 	(x)->valid = 1;				\
-} while (0);
+} while (0)
 
 static inline unsigned char
 shortname_info_to_lcase(struct shortname_info *base,
diff -ruN linux-2.4.18-pre1-mjc2.orig/include/linux/mtd/compatmac.h linux-2.4.18-pre1-mjc2/include/linux/mtd/compatmac.h
--- linux-2.4.18-pre1-mjc2.orig/include/linux/mtd/compatmac.h	Mon Feb 11 01:59:57 2002
+++ linux-2.4.18-pre1-mjc2/include/linux/mtd/compatmac.h	Mon Feb 11 02:13:37 2002
@@ -190,8 +190,8 @@
 
 #if LINUX_VERSION_CODE < 0x20300
 #include <linux/interrupt.h>
-#define spin_lock_bh(lock) do {start_bh_atomic();spin_lock(lock);}while(0);
-#define spin_unlock_bh(lock) do {spin_unlock(lock);end_bh_atomic();}while(0);
+#define spin_lock_bh(lock) do {start_bh_atomic();spin_lock(lock);}while(0)
+#define spin_unlock_bh(lock) do {spin_unlock(lock);end_bh_atomic();}while(0)
 #else
 #include <asm/softirq.h>
 #include <linux/spinlock.h>
diff -ruN linux-2.4.18-pre1-mjc2.orig/include/linux/rtnetlink.h linux-2.4.18-pre1-mjc2/include/linux/rtnetlink.h
--- linux-2.4.18-pre1-mjc2.orig/include/linux/rtnetlink.h	Mon Feb 11 01:59:57 2002
+++ linux-2.4.18-pre1-mjc2/include/linux/rtnetlink.h	Mon Feb 11 02:14:37 2002
@@ -587,7 +587,7 @@
 
 #define ASSERT_RTNL() do { if (down_trylock(&rtnl_sem) == 0)  { up(&rtnl_sem); \
 printk("RTNL: assertion failed at " __FILE__ "(%d):" __FUNCTION__ "\n", __LINE__); } \
-		   } while(0);
+		   } while(0)
 #define BUG_TRAP(x) if (!(x)) { printk("KERNEL: assertion (" #x ") failed at " __FILE__ "(%d):" __FUNCTION__ "\n", __LINE__); }
 
-- 
	GPG key available on pgpkeys.mit.edu
pub  1024D/511FBD54 2001-07-23 Timothy Lu Hu Ball <timball@tux.org>
Key fingerprint = B579 29B0 F6C8 C7AA 3840  E053 FE02 BB97 511F BD54
