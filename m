Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135223AbRDZJLM>; Thu, 26 Apr 2001 05:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135226AbRDZJLA>; Thu, 26 Apr 2001 05:11:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:1540 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S135223AbRDZJKu>;
	Thu, 26 Apr 2001 05:10:50 -0400
Message-ID: <3AE7E346.731E19FA@evision-ventures.com>
Date: Thu, 26 Apr 2001 10:58:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH: 2.4.3 tinny module interface cleanum
Content-Type: multipart/mixed;
 boundary="------------43925C8050D15D7AD91312A5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------43925C8050D15D7AD91312A5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello!

The following patch is making the get_empty_super() function
just local to the place where it's only use is and where it's only
use should be: fs/super.c

The removal of this symbol from ksyms.c should:

1. Help making the module interface cleaner by a tinny margin :-).

2. shouldn't hurt anything sane.

Please apply... line sloops in the patch are due to bla bla, and
don't hurt...

Thank's

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
--------------43925C8050D15D7AD91312A5
Content-Type: text/plain; charset=us-ascii;
 name="get_emty_super.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="get_emty_super.diff"

diff -ur linux/fs/super.c new/fs/super.c
--- linux/fs/super.c	Wed Apr 18 20:41:17 2001
+++ new/fs/super.c	Thu Apr 26 01:08:48 2001
@@ -691,7 +691,7 @@
  *	the request.
  */
  
-struct super_block *get_empty_super(void)
+static struct super_block *get_empty_super(void)
 {
 	struct super_block *s;
 
diff -ur linux/include/linux/fs.h new/include/linux/fs.h
--- linux/include/linux/fs.h	Wed Apr 18 20:41:18 2001
+++ new/include/linux/fs.h	Thu Apr 26 01:03:03 2001
@@ -1291,7 +1285,6 @@
 
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(kdev_t);
-struct super_block *get_empty_super(void);
 extern void put_super(kdev_t);
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
diff -ur linux/kernel/ksyms.c new/kernel/ksyms.c
--- linux/kernel/ksyms.c	Wed Apr 18 20:41:19 2001
+++ new/kernel/ksyms.c	Thu Apr 26 00:40:48 2001
@@ -129,7 +129,6 @@
 EXPORT_SYMBOL(update_atime);
 EXPORT_SYMBOL(get_fs_type);
 EXPORT_SYMBOL(get_super);
-EXPORT_SYMBOL(get_empty_super);
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(names_cachep);
 EXPORT_SYMBOL(fput);

--------------43925C8050D15D7AD91312A5--

