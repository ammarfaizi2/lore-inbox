Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWGCQun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWGCQun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 12:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWGCQun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 12:50:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:24157 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750935AbWGCQum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 12:50:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer;
        b=S0FCI+ydLudrrzgnZciUXrFIuXtH9MCSkTf82QTqeOjBxY0e25AZPAZ1yfuMQg9ZjERtOWXv7vrJqJWR+/Y922KvKe3YX988DynnnmD5ZNUq0Wb+GcWethj08gjb8XdXjVHN1alDMwHEN/iMjfvzJActHyHXNa70M+3ka8jco5c=
Subject: Documentation/initrd.txt update
From: Guilherme Destefani <guilhermedestefani@gmail.com>
Reply-To: linux-kernel@vger.kernel.org, guilhermedestefani@gmail.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-NPi+2mzSfYCxYmCUEYaN"
Date: Mon, 03 Jul 2006 13:50:37 -0300
Message-Id: <1151945437.5699.13.camel@homemfera.perkons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NPi+2mzSfYCxYmCUEYaN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The cpio initrd isn't documented in
linux-2.6.17/Documentation/initrd.txt.
(but it is in
linux-2.6.17/Documentation/filesystems/ramfs-rootfs-initramfs.txt)
initrd.txt shouldn't be updated?

Two possible updates follow, use patch -p1 inside the kernel tree.

--=-NPi+2mzSfYCxYmCUEYaN
Content-Description: 
Content-Disposition: inline; filename=Documentation_initrd.txt.use_patch_p1_option1.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.17.old/Documentation/initrd.txt	2006-06-17 22:49:35.000000000 -0300
+++ linux-2.6.17/Documentation/initrd.txt	2006-07-03 13:29:00.000000000 -0300
@@ -104,11 +104,13 @@
 Third, you have to create the RAM disk image. This is done by creating a
 file system on a block device, copying files to it as needed, and then
 copying the content of the block device to the initrd file. With recent
-kernels, at least three types of devices are suitable for that:
+kernels, at least four types of devices are suitable for that:
 
  - a floppy disk (works everywhere but it's painfully slow)
  - a RAM disk (fast, but allocates physical memory)
  - a loopback device (the most elegant solution)
+ - a cpio containing the initrd files, described in
+   Documentation/filesystems/ramfs-rootfs-initramfs.txt
 
 We'll describe the loopback device method:
 

--=-NPi+2mzSfYCxYmCUEYaN
Content-Description: 
Content-Disposition: inline; filename=Documentation_initrd.txt.use_patch_p1_option2.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.17.old/Documentation/initrd.txt	2006-07-03 13:25:35.000000000 -0300
+++ linux-2.6.17/Documentation/initrd.txt	2006-07-03 13:39:54.000000000 -0300
@@ -140,6 +140,25 @@
     compressed
     # gzip -9 initrd
 
+It is also possible to use a cpio archive (instead of a file system), 
+and pack all the files inside it.
+The kernel will create a ramdisk, unpack the contents of the initrd
+ and execute /init.
+
+To create such a file:
+
+ 1) Enter the directory containig the unpacked initrd files:
+    # cd /path/to/initrd
+ 2) Create the cpio file (whithout any leading path).
+ 3) Create a cpio file.
+ 4) Compress it with gzip to save space.
+    steps 2,3 and 4 can be archieved with:
+    find -printf "%P\n" |cpio -oc | gzip -9 > /full_path_to/initrd.img
+    |-------step 2------|-step 3--|------------step 4-----------------|
+
+Or use usr/gen_init_cpio
+(see Documentation/filesystems/ramfs-rootfs-initramfs.txt)
+
 For experimenting with initrd, you may want to take a rescue floppy and
 only add a symbolic link from /linuxrc to /bin/sh. Alternatively, you
 can try the experimental newlib environment [2] to create a small

--=-NPi+2mzSfYCxYmCUEYaN--

