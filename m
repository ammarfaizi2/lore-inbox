Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274321AbRIYW05>; Tue, 25 Sep 2001 18:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274215AbRIYW0s>; Tue, 25 Sep 2001 18:26:48 -0400
Received: from zeke.inet.com ([199.171.211.198]:9724 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S274195AbRIYW0g>;
	Tue, 25 Sep 2001 18:26:36 -0400
Message-ID: <3BB104A9.3AD512A5@inet.com>
Date: Tue, 25 Sep 2001 17:26:49 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] core file naming option
Content-Type: multipart/mixed;
 boundary="------------D77FB6F2EA145041FE6C3CA3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D77FB6F2EA145041FE6C3CA3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan et. all,

The attached patch adds an option to the build to have core files named
core.processname, but defaulting to the current behaviour of course. 
For most people the single 'core' file is sufficient, but when the sky
is falling, it's nice to have more places for it to land.  :)
So, is this something that might go into the kernel, or are their
philisophical reasons against it?  (The patch is against 2.2.19.  I
haven't looked at 2.4.x yet.  Let me know if you want a 2.4 or if I
should send it to Linus, or...)

Questions, comments, etc. welcome,

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
--------------D77FB6F2EA145041FE6C3CA3
Content-Type: text/plain; charset=us-ascii;
 name="corefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="corefile.patch"

diff -urN linux.orig/Documentation/Configure.help linux/Documentation/Configure.help
--- linux.orig/Documentation/Configure.help	Tue Sep 25 17:02:27 2001
+++ linux/Documentation/Configure.help	Tue Sep 25 16:54:23 2001
@@ -8765,6 +8765,12 @@
   from within Linux if you have also said Y to "UFS filesystem
   support", above.
 
+Long corefile names
+CONFIG_COREFILE_LONGNAME
+  If you say Y here, core files will be named 'core.[process]' where
+  '[process]' is the name of the process which dumped core.
+  Otherwise, they will be named 'core' by default.
+
 ADFS filesystem support (read only) (EXPERIMENTAL)
 CONFIG_ADFS_FS
   The Acorn Disc Filing System is the standard filesystem of the
diff -urN linux.orig/fs/Config.in linux/fs/Config.in
--- linux.orig/fs/Config.in	Tue Sep 25 17:02:34 2001
+++ linux/fs/Config.in	Tue Sep 25 16:53:08 2001
@@ -6,6 +6,7 @@
 
 bool	 'Quota support' CONFIG_QUOTA
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
+bool     'Long corefile names' CONFIG_COREFILE_LONGNAME
 
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -urN linux.orig/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux.orig/fs/binfmt_elf.c	Tue Sep 25 17:02:34 2001
+++ linux/fs/binfmt_elf.c	Tue Sep 25 16:53:08 2001
@@ -1140,7 +1140,7 @@
 	set_fs(KERNEL_DS);
 
 	memcpy(corefile,"core.",5);
-#if 0
+#ifdef CONFIG_COREFILE_LONGNAME
 	memcpy(corefile+5,current->comm,sizeof(current->comm));
 #else
 	corefile[4] = '\0';

--------------D77FB6F2EA145041FE6C3CA3--

