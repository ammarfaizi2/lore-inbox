Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWJ2D5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWJ2D5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 23:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWJ2D5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 23:57:55 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:50215 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964986AbWJ2D5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 23:57:54 -0400
Date: Sat, 28 Oct 2006 20:53:24 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] docbook: make a filesystems book
Message-Id: <20061028205324.6ce9a5c1.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Make a filesystems DocBook book/file by moving all filesystems
info from kernel-api.tmpl.  Will also merge journal-api.tmpl
into it soon (with permission from Roger Gammans).
Localizes filesystem info and reduces size of the huge (produced)
kernel-api output files.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/DocBook/Makefile         |    2 
 Documentation/DocBook/filesystems.tmpl |  101 +++++++++++++++++++++++++++++++++
 Documentation/DocBook/kernel-api.tmpl  |   60 -------------------
 3 files changed, 102 insertions(+), 61 deletions(-)

--- /dev/null
+++ linux-2619-rc3g5/Documentation/DocBook/filesystems.tmpl
@@ -0,0 +1,101 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+
+<book id="Linux-filesystems-API">
+ <bookinfo>
+  <title>Linux Filesystems API</title>
+
+  <legalnotice>
+   <para>
+     This documentation is free software; you can redistribute
+     it and/or modify it under the terms of the GNU General Public
+     License as published by the Free Software Foundation; either
+     version 2 of the License, or (at your option) any later
+     version.
+   </para>
+
+   <para>
+     This program is distributed in the hope that it will be
+     useful, but WITHOUT ANY WARRANTY; without even the implied
+     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+     See the GNU General Public License for more details.
+   </para>
+
+   <para>
+     You should have received a copy of the GNU General Public
+     License along with this program; if not, write to the Free
+     Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+     MA 02111-1307 USA
+   </para>
+
+   <para>
+     For more details see the file COPYING in the source
+     distribution of Linux.
+   </para>
+  </legalnotice>
+ </bookinfo>
+
+<toc></toc>
+
+  <chapter id="vfs">
+     <title>The Linux VFS</title>
+     <sect1><title>The Filesystem types</title>
+!Iinclude/linux/fs.h
+     </sect1>
+     <sect1><title>The Directory Cache</title>
+!Efs/dcache.c
+!Iinclude/linux/dcache.h
+     </sect1>
+     <sect1><title>Inode Handling</title>
+!Efs/inode.c
+!Efs/bad_inode.c
+     </sect1>
+     <sect1><title>Registration and Superblocks</title>
+!Efs/super.c
+     </sect1>
+     <sect1><title>File Locks</title>
+!Efs/locks.c
+!Ifs/locks.c
+     </sect1>
+     <sect1><title>Other Functions</title>
+!Efs/mpage.c
+!Efs/namei.c
+!Efs/buffer.c
+!Efs/bio.c
+!Efs/seq_file.c
+!Efs/filesystems.c
+!Efs/fs-writeback.c
+!Efs/block_dev.c
+     </sect1>
+  </chapter>
+
+  <chapter id="proc">
+     <title>The proc filesystem</title>
+
+     <sect1><title>sysctl interface</title>
+!Ekernel/sysctl.c
+     </sect1>
+
+     <sect1><title>proc filesystem interface</title>
+!Ifs/proc/base.c
+     </sect1>
+  </chapter>
+
+  <chapter id="sysfs">
+     <title>The Filesystem for Exporting Kernel Objects</title>
+!Efs/sysfs/file.c
+!Efs/sysfs/symlink.c
+!Efs/sysfs/bin.c
+  </chapter>
+
+  <chapter id="debugfs">
+     <title>The debugfs filesystem</title>
+
+     <sect1><title>debugfs interface</title>
+!Efs/debugfs/inode.c
+!Efs/debugfs/file.c
+     </sect1>
+  </chapter>
+
+</book>
--- linux-2619-rc3g5.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2619-rc3g5/Documentation/DocBook/kernel-api.tmpl
@@ -182,66 +182,6 @@ X!Ilib/string.c
      </sect1>
   </chapter>
 
-  <chapter id="vfs">
-     <title>The Linux VFS</title>
-     <sect1><title>The Filesystem types</title>
-!Iinclude/linux/fs.h
-     </sect1>
-     <sect1><title>The Directory Cache</title>
-!Efs/dcache.c
-!Iinclude/linux/dcache.h
-     </sect1>
-     <sect1><title>Inode Handling</title>
-!Efs/inode.c
-!Efs/bad_inode.c
-     </sect1>
-     <sect1><title>Registration and Superblocks</title>
-!Efs/super.c
-     </sect1>
-     <sect1><title>File Locks</title>
-!Efs/locks.c
-!Ifs/locks.c
-     </sect1>
-     <sect1><title>Other Functions</title>
-!Efs/mpage.c
-!Efs/namei.c
-!Efs/buffer.c
-!Efs/bio.c
-!Efs/seq_file.c
-!Efs/filesystems.c
-!Efs/fs-writeback.c
-!Efs/block_dev.c
-     </sect1>
-  </chapter>
-
-  <chapter id="proc">
-     <title>The proc filesystem</title>
- 
-     <sect1><title>sysctl interface</title>
-!Ekernel/sysctl.c
-     </sect1>
-
-     <sect1><title>proc filesystem interface</title>
-!Ifs/proc/base.c
-     </sect1>
-  </chapter>
-
-  <chapter id="sysfs">
-     <title>The Filesystem for Exporting Kernel Objects</title>
-!Efs/sysfs/file.c
-!Efs/sysfs/symlink.c
-!Efs/sysfs/bin.c
-  </chapter>
-
-  <chapter id="debugfs">
-     <title>The debugfs filesystem</title>
- 
-     <sect1><title>debugfs interface</title>
-!Efs/debugfs/inode.c
-!Efs/debugfs/file.c
-     </sect1>
-  </chapter>
-
   <chapter id="relayfs">
      <title>relay interface support</title>
 
--- linux-2619-rc3g5.orig/Documentation/DocBook/Makefile
+++ linux-2619-rc3g5/Documentation/DocBook/Makefile
@@ -9,7 +9,7 @@
 DOCBOOKS := wanbook.xml z8530book.xml mcabook.xml videobook.xml \
 	    kernel-hacking.xml kernel-locking.xml deviceiobook.xml \
 	    procfs-guide.xml writing_usb_driver.xml \
-	    kernel-api.xml journal-api.xml lsm.xml usb.xml \
+	    kernel-api.xml filesystems.xml journal-api.xml lsm.xml usb.xml \
 	    gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml \
 	    genericirq.xml
 


---
