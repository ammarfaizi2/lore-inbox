Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVJPGZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVJPGZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 02:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJPGZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 02:25:49 -0400
Received: from xenotime.net ([66.160.160.81]:45713 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751295AbVJPGZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 02:25:48 -0400
Date: Sat, 15 Oct 2005 23:25:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: fix some kernel-api warnings
Message-Id: <20051015232543.117db444.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix various warnings in kernel-doc:

Warning(linux-2614-rc4//include/linux/net.h:89): Enum value 'SOCK_DCCP' not described in enum 'sock_type'

usercopy.c: should use !E instead of !I for exported symbols:
Warning(linux-2614-rc4//arch/i386/lib/usercopy.c): no structured comments found

fs.h does not need to use !E since it has no exported symbols:
Warning(linux-2614-rc4//include/linux/fs.h:1182): No description found for parameter 'find_exported_dentry'
Warning(linux-2614-rc4//include/linux/fs.h): no structured comments found

irq/manage.c should use !E for its exported symbols:
Warning(linux-2614-rc4//kernel/irq/manage.c): no structured comments found

macmodes.c should use !E for its exported symbols:
Warning(linux-2614-rc4//drivers/video/macmodes.c): no structured comments found

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/DocBook/kernel-api.tmpl |    7 +++----
 include/linux/fs.h                    |    2 ++
 include/linux/net.h                   |    1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff -Naurp linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl~doc_kernel_api linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl
--- linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl~doc_kernel_api	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl	2005-10-15 23:06:11.000000000 -0700
@@ -118,7 +118,7 @@ X!Ilib/string.c
      </sect1>
      <sect1><title>User Space Memory Access</title>
 !Iinclude/asm-i386/uaccess.h
-!Iarch/i386/lib/usercopy.c
+!Earch/i386/lib/usercopy.c
      </sect1>
      <sect1><title>More Memory Management Functions</title>
 !Iinclude/linux/rmap.h
@@ -174,7 +174,6 @@ X!Ilib/string.c
      <title>The Linux VFS</title>
      <sect1><title>The Filesystem types</title>
 !Iinclude/linux/fs.h
-!Einclude/linux/fs.h
      </sect1>
      <sect1><title>The Directory Cache</title>
 !Efs/dcache.c
@@ -266,7 +265,7 @@ X!Ekernel/module.c
   <chapter id="hardware">
      <title>Hardware Interfaces</title>
      <sect1><title>Interrupt Handling</title>
-!Ikernel/irq/manage.c
+!Ekernel/irq/manage.c
      </sect1>
 
      <sect1><title>Resources Management</title>
@@ -499,7 +498,7 @@ KAO -->
 !Edrivers/video/modedb.c
      </sect1>
      <sect1><title>Frame Buffer Macintosh Video Mode Database</title>
-!Idrivers/video/macmodes.c
+!Edrivers/video/macmodes.c
      </sect1>
      <sect1><title>Frame Buffer Fonts</title>
         <para>
diff -Naurp linux-2614-rc4/include/linux/fs.h~doc_kernel_api linux-2614-rc4/include/linux/fs.h
--- linux-2614-rc4/include/linux/fs.h~doc_kernel_api	2005-10-14 17:31:29.000000000 -0700
+++ linux-2614-rc4/include/linux/fs.h	2005-10-15 22:44:15.000000000 -0700
@@ -1082,6 +1082,8 @@ int sync_inode(struct inode *inode, stru
  * @get_name:       find the name for a given inode in a given directory
  * @get_parent:     find the parent of a given directory
  * @get_dentry:     find a dentry for the inode given a file handle sub-fragment
+ * @find_exported_dentry:
+ *	set by the exporting module to a standard helper function.
  *
  * Description:
  *    The export_operations structure provides a means for nfsd to communicate
diff -Naurp linux-2614-rc4/include/linux/net.h~doc_kernel_api linux-2614-rc4/include/linux/net.h
--- linux-2614-rc4/include/linux/net.h~doc_kernel_api	2005-10-14 17:31:29.000000000 -0700
+++ linux-2614-rc4/include/linux/net.h	2005-10-15 23:16:08.000000000 -0700
@@ -71,6 +71,7 @@ typedef enum {
  * @SOCK_RAW: raw socket
  * @SOCK_RDM: reliably-delivered message
  * @SOCK_SEQPACKET: sequential packet socket
+ * @SOCK_DCCP: Datagram Congestion Control Protocol socket
  * @SOCK_PACKET: linux specific way of getting packets at the dev level.
  *		  For writing rarp and other similar things on the user level.
  *


---
