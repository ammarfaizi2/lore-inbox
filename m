Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUKNUyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUKNUyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUKNUxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:53:12 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:12548
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261368AbUKNUvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:51:02 -0500
Message-Id: <200411142304.iAEN4MbV013366@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org, cw@f00f.org
Subject: [PATCH] - UML - add initramfs to Kconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Nov 2004 18:04:22 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch (copy and yank) so UML builds don't generate a warning
from linux/usr/Makefile:gen_cmd_list when CONFIG_INITRAMFS_SOURCE
isn't defined (maybe the Makefile shouldn't require
CONFIG_INITRAMFS_SOURCE to be set?).

Signed-off-by: cw@f00f.org
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/Kconfig_block
===================================================================
--- 2.6.9.orig/arch/um/Kconfig_block	2004-11-14 15:31:25.000000000 -0500
+++ 2.6.9/arch/um/Kconfig_block	2004-11-14 15:31:37.000000000 -0500
@@ -79,6 +79,34 @@
 
 	  If you are not sure, leave it blank.
 
+# copied directly from drivers/block/Kconfig
+
+config INITRAMFS_SOURCE
+	string "Source directory of cpio_list"
+	default ""
+	help
+	  This can be set to either a directory containing files, etc to be
+	  included in the initramfs archive, or a file containing newline
+	  separated entries.
+
+	  If it is a file, it should be in the following format:
+	    # a comment
+	    file <name> <location> <mode> <uid> <gid>
+	    dir <name> <mode> <uid> <gid>
+	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
+
+	  Where:
+	    <name>      name of the file/dir/nod in the archive
+	    <location>  location of the file in the current filesystem
+	    <mode>      mode/permissions of the file
+	    <uid>       user id (0=root)
+	    <gid>       group id (0=root)
+	    <dev_type>  device type (b=block, c=character)
+	    <maj>       major number of nod
+	    <min>       minor number of nod
+
+	  If you are not sure, leave it blank.
+
 config MMAPPER
 	tristate "Example IO memory driver"
 	depends on BROKEN

