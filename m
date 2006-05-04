Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWEDD1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWEDD1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWEDD1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:27:45 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:31993 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750926AbWEDD1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:27:44 -0400
Date: Wed, 3 May 2006 21:27:47 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 1/13: eCryptfs] fs/Makefile and fs/Kconfig
Message-ID: <20060504032747.GA28319@hellewell.homeip.net>
References: <20060504031755.GA28257@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504031755.GA28257@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 1st patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

This patch modifies the fs/Kconfig and fs/Makefile files to
incorporate eCryptfs into the kernel build.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 Kconfig  |   18 ++++++++++++++++++
 Makefile |    1 +
 2 files changed, 19 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/Kconfig
===================================================================
--- linux-2.6.17-rc3-mm1-ecryptfs.orig/fs/Kconfig	2006-05-02 18:05:37.000000000 -0600
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/Kconfig	2006-05-02 19:35:57.000000000 -0600
@@ -935,6 +935,24 @@
 	  To compile this file system support as a module, choose M here: the
 	  module will be called affs.  If unsure, say N.
 
+config ECRYPT_FS
+	tristate "eCrypt filesystem layer support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && KEYS && CRYPTO
+	help
+	  Encrypted filesystem that operates on the VFS layer.  See
+	  Documentation/ecryptfs.txt to learn more about eCryptfs.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called ecryptfs.
+
+config ECRYPT_DEBUG
+	bool "Enable eCryptfs debug mode"
+	depends on ECRYPT_FS
+	help
+	  Turn on debugging code in eCryptfs.
+
+	  If unsure, say N.
+
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/Makefile
===================================================================
--- linux-2.6.17-rc3-mm1-ecryptfs.orig/fs/Makefile	2006-05-02 18:05:37.000000000 -0600
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/Makefile	2006-05-02 19:35:57.000000000 -0600
@@ -68,6 +68,7 @@
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
 obj-$(CONFIG_HFS_FS)		+= hfs/
+obj-$(CONFIG_ECRYPT_FS)		+= ecryptfs/
 obj-$(CONFIG_VXFS_FS)		+= freevxfs/
 obj-$(CONFIG_NFS_FS)		+= nfs/
 obj-$(CONFIG_EXPORTFS)		+= exportfs/
