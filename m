Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270503AbUJUC77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270503AbUJUC77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270527AbUJUC7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:59:25 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:24018 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270605AbUJUClU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:41:20 -0400
Date: Wed, 20 Oct 2004 19:40:54 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] UML: INITRAMFS_SOURCE noise/build fix
Message-ID: <20041021024054.GA17968@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch (copy & yank) so UML builds don't generate a warning
from linux/usr/Makefile:gen_cmd_list when CONFIG_INITRAMFS_SOURCE
isn't defined (maybe the Makefile shouldn't require
CONFIG_INITRAMFS_SOURCE to be set?).

Signed-off-by: cw@f00f.org

diff -Nru a/arch/um/Kconfig_block b/arch/um/Kconfig_block
--- a/arch/um/Kconfig_block	2004-10-20 19:36:35 -07:00
+++ b/arch/um/Kconfig_block	2004-10-20 19:36:35 -07:00
@@ -52,6 +52,34 @@
 	bool "Initial RAM disk (initrd) support"
 	depends on BLK_DEV_RAM=y
 
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
