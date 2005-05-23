Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVEWW1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVEWW1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 18:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVEWW1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 18:27:16 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:48071 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261155AbVEWW0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 18:26:20 -0400
Message-Id: <200505232225.j4NMPQgJ023237@ms-smtp-04.texas.rr.com>
From: ericvh@gmail.com
Date: Mon, 23 May 2005 17:25:07 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 1/7] v9fs: Documentaion, Makefiles, Configuration (2.0-rc6)
Cc: v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [1/7] of the v9fs-2.0-rc6 patch against Linux v2.6.12-rc4.

This part of the patch contains Documentation, Makefiles, 
and configuration file changes.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

 Documentation/filesystems/v9fs.txt |   83 ++++++++++
 fs/9p/Makefile                     |   16 +
 MAINTAINERS                        |   11 +
 fs/Kconfig                         |   11 +
 fs/Makefile                        |    1 
 5 files changed, 122 insertions(+)
-------------

Index: Documentation/filesystems/v9fs.txt
===================================================================
--- /dev/null  (tree:0bf32353105286a5624aeea862d35a4bbae09851)
+++ 178666ee376655ef8ec19a2ffc0490241b428110/Documentation/filesystems/v9fs.txt  (mode:100644)
@@ -0,0 +1,83 @@
+			V9FS: 9P2000 for Linux
+			======================
+
+ABOUT
+=====
+
+v9fs is a Unix implementation of the Plan 9 9p remote filesystem protocol. 
+
+This software was originally developed by Ron Minnich <rminnich@lanl.gov>
+and Maya Gokhale <maya@lanl.gov>.  Additional development by Greg Watson 
+<gwatson@lanl.gov> and most recently Eric Van Hensbergen 
+<ericvh@gmail.com> and Latchesar Ionkov <lucho@ionkov.net>.
+
+USAGE
+=====
+
+For remote file server:
+
+	mount -t 9P 10.10.1.2 /mnt/9
+
+For Plan 9 From User Space applications (http://swtch.com/plan9)
+
+	mount -t 9P /tmp/ns.root.:0/acme/acme /mnt/9 proto=unix,name=$USER
+
+OPTIONS
+=======
+
+  proto=name	select an alternative transport.  Valid options are 
+  		currently either unix (specifying a named pipe mount
+		point) or tcp (specifying a normal TCP/IP connection)
+  
+  name=name	user name to attempt mount as on the remote server.  The
+  		server may override or ignore this value.  Certain user
+		names may require authentication.
+
+  debug=n	specifies debug level.  The debug level is a bitmask.
+  			0x01 = display verbose error messages
+			0x02 = developer debug (DEBUG_CURRENT)
+			0x04 = display 9P trace
+			0x08 = display VFS trace
+			0x10 = display Marshalling debug
+			0x20 = display RPC debug
+			0x40 = display transport debug
+			0x80 = display allocation debug
+
+  maxdata=n	the number of bytes to use for 9P packet payload (msize)
+
+  port=n	port to connect to on the remote server
+
+  noextend	force legacy mode (no 9P2000.u semantics)
+
+  uid		attempt to mount as a particular uid
+
+  gid		attempt to mount with a particular gid
+
+  afid		security channel - used by Plan 9 authentication protocols
+
+  nodevmap	do not map special files - represent them as normal files.
+  		This can be used to share devices/named pipes/sockets between
+		hosts.  This functionality will be expanded in later versions.
+
+RESOURCES
+=========
+
+The Linux version of the 9P server, along with some client-side utilities 
+can be found at http://v9fs.sf.net (along with a CVS repository of the 
+development branch of this module).  There are user and developer mailing
+lists here, as well as a bug-tracker.
+
+For more information on the Plan 9 Operating System check out
+http://plan9.bell-labs.com/plan9
+
+For information on Plan 9 from User Space (Plan 9 applications and libraries
+ported to Linux/BSD/OSX/etc) check out http://swtch.com/plan9
+
+
+STATUS
+======
+
+The 2.6 kernel support is working on PPC and x86.  
+
+PLEASE USE THE SOURCEFORGE BUG-TRACKER TO REPORT PROBLEMS.
+
Index: MAINTAINERS
===================================================================
--- 0bf32353105286a5624aeea862d35a4bbae09851/MAINTAINERS  (mode:100644)
+++ 178666ee376655ef8ec19a2ffc0490241b428110/MAINTAINERS  (mode:100644)
@@ -2589,6 +2589,17 @@
 W:	http://rio500.sourceforge.net
 S:	Maintained
 
+V9FS FILE SYSTEM
+P:      Eric Van Hensbergen
+M:      ericvh@gmail.com
+P:      Ron Minnich
+M:      rminnich@lanl.gov
+P:      Latchesar Ionkov
+M:      lucho@ionkov.net 
+L:      v9fs-developer@lists.sourceforge.net
+W:      http://v9fs.sf.net
+S:      Maintained
+
 VIDEO FOR LINUX
 P:	Gerd Knorr
 M:	kraxel@bytesex.org

Index: fs/9p/Makefile
===================================================================
--- /dev/null  (tree:0bf32353105286a5624aeea862d35a4bbae09851)
+++ 178666ee376655ef8ec19a2ffc0490241b428110/fs/9p/Makefile  (mode:100644)
@@ -0,0 +1,16 @@
+obj-$(CONFIG_9P_FS) := 9p2000.o
+
+9p2000-objs := \
+	vfs_super.o \
+	vfs_inode.o \
+	vfs_file.o \
+	vfs_dir.o \
+	idpool.o \
+	error.o \
+	mux.o \
+	trans_sock.o \
+	9p.o \
+	conv.o \
+	v9fs.o \
+	fid.o
+

Index: fs/Kconfig
===================================================================
--- 0bf32353105286a5624aeea862d35a4bbae09851/fs/Kconfig  (mode:100644)
+++ 178666ee376655ef8ec19a2ffc0490241b428110/fs/Kconfig  (mode:100644)
@@ -1715,6 +1715,17 @@
 config RXRPC
 	tristate
 
+config 9P_FS 
+	tristate "Plan 9 Resource Sharing support (9P2000) (Experimental)"
+	depends on INET && EXPERIMENTAL
+	help 
+	  If you say Y here, you will get a experimental support for
+	  Plan 9 resource sharing via the 9P2000 protocol.
+
+	  See <http://v9fs.sf.net> for more intormation.
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Partition Types"
Index: fs/Makefile
===================================================================
--- 0bf32353105286a5624aeea862d35a4bbae09851/fs/Makefile  (mode:100644)
+++ 178666ee376655ef8ec19a2ffc0490241b428110/fs/Makefile  (mode:100644)
@@ -95,3 +95,4 @@
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
+obj-$(CONFIG_9P_FS)		+= 9p/

