Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSKYMil>; Mon, 25 Nov 2002 07:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSKYMil>; Mon, 25 Nov 2002 07:38:41 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:53005 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263135AbSKYMik>; Mon, 25 Nov 2002 07:38:40 -0500
Message-ID: <3DE21B96.8BA15D27@aitel.hist.no>
Date: Mon, 25 Nov 2002 13:46:14 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.49 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, viro@math.psu.edu, rgooch@ras.ucalgary.ca
Subject: [PATCH] make 2.5.49 mount root again for devfs users
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init/do_mounts.c changed in 2.5.48, and booting with devfs
(and without initial ramdisk) has been impossible since then.  
I experimented with do_mounts undoing the early devfs mount.  
Devfs is mounted later anyway.

Feel free to test, but be warned that I am not an expert
on this part of the kernel.  This made 2.5.49 work for
me though.  I hope someone can comment on this.
If it isn't "the right way" please tell what is.

Helge Hafting


--- do_mounts.c.original        2002-11-25 12:41:48.000000000 +0100
+++ do_mounts.c 2002-11-25 13:34:58.000000000 +0100
@@ -846,10 +846,7 @@
 {
        int is_floppy;
 
-#ifdef CONFIG_DEVFS_FS
-       sys_mount("devfs", "/dev", "devfs", 0, NULL);
-       do_devfs = 1;
-#endif
+
 
        md_run_setup();
