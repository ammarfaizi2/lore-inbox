Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRJZJjL>; Fri, 26 Oct 2001 05:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278078AbRJZJjC>; Fri, 26 Oct 2001 05:39:02 -0400
Received: from mail311.mail.bellsouth.net ([205.152.58.171]:4019 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278081AbRJZJix>; Fri, 26 Oct 2001 05:38:53 -0400
Message-ID: <3BD92F59.BAD76B6F@mandrakesoft.com>
Date: Fri, 26 Oct 2001 05:39:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.14.2: more inflate_fs build fixes
Content-Type: multipart/mixed;
 boundary="------------1D646421290B7064987BA594"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1D646421290B7064987BA594
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

oops.  I forgot to send this part, which is missing also.

This is required also, in order to build cramfs or zisofs in
2.4.14-pre2.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------1D646421290B7064987BA594
Content-Type: text/plain; charset=us-ascii;
 name="inflate-fs-2.4.14.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inflate-fs-2.4.14.2.patch"

--- /home/jgarzik/tmp/linux-2.4.14-pre2/fs/Config.in	Thu Oct  4 18:13:18 2001
+++ linux_2_4/fs/Config.in	Fri Oct 26 05:41:53 2001
@@ -128,6 +128,24 @@
    define_bool CONFIG_SMB_FS n
 fi
 
+#
+# Do we need the compression support?
+#
+if [ "$CONFIG_ZISOFS" = "y" ]; then
+   define_tristate CONFIG_ZISOFS_FS $CONFIG_ISO9660_FS
+else
+   define_tristate CONFIG_ZISOFS_FS n
+fi
+if [ "$CONFIG_CRAMFS" = "y" -o "$CONFIG_ZISOFS_FS" = "y" ]; then
+   define_tristate CONFIG_ZLIB_FS_INFLATE y
+else
+  if [ "$CONFIG_CRAMFS" = "m" -o "$CONFIG_ZISOFS_FS" = "m" ]; then
+     define_tristate CONFIG_ZLIB_FS_INFLATE m
+  else
+     define_tristate CONFIG_ZLIB_FS_INFLATE n
+  fi
+fi
+
 mainmenu_option next_comment
 comment 'Partition Types'
 source fs/partitions/Config.in
--- /home/jgarzik/tmp/linux-2.4.14-pre2/fs/Makefile	Thu Oct  4 18:13:18 2001
+++ linux_2_4/fs/Makefile	Fri Oct 26 05:41:53 2001
@@ -27,6 +27,7 @@
 
 # Do not add any filesystems before this line
 subdir-$(CONFIG_EXT2_FS)	+= ext2
+subdir-$(CONFIG_ZLIB_FS_INFLATE) += inflate_fs
 subdir-$(CONFIG_CRAMFS)		+= cramfs
 subdir-$(CONFIG_RAMFS)		+= ramfs
 subdir-$(CONFIG_CODA_FS)	+= coda

--------------1D646421290B7064987BA594--


