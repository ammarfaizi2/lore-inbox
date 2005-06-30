Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVF3Arr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVF3Arr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVF3Arr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:47:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43026 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262762AbVF3Ark (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:47:40 -0400
Date: Thu, 30 Jun 2005 02:47:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] CONFIGFS_FS: "If unsure, say N."
Message-ID: <20050630004738.GA27478@stusta.de>
References: <20050624080315.GC26545@stusta.de> <20050629213038.GA23823@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629213038.GA23823@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 02:30:38PM -0700, Joel Becker wrote:
> On Fri, Jun 24, 2005 at 10:03:15AM +0200, Adrian Bunk wrote:
> > I haven't found any reason why CONFIGFS_FS is user-visible.
> > Other parts of the kernel using configfs should simply select it.
> 
> 	Doesn't work for external modules that might want to use it.
> Imagine that configfs gets merged before OCFS2, which depends on it.

I was surprised if configfs was merged with zero users in the kernel.

But I get your point, what about the patch below?

> Joel

cu
Adrian


<--  snip  -->


Make it clear that users usually shouldn't manually enable CONFIGFS_FS.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/fs/Kconfig.old	2005-06-30 01:51:51.000000000 +0200
+++ linux-2.6.12-mm2-full/fs/Kconfig	2005-06-30 01:54:01.000000000 +0200
@@ -934,13 +934,11 @@
 	tristate "Userspace-driven configuration filesystem (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
-	  configfs is a ram-based filesystem that provides the converse
-	  of sysfs's functionality. Where sysfs is a filesystem-based
-	  view of kernel objects, configfs is a filesystem-based manager
-	  of kernel objects, or config_items.
+	  This option is provided for the case where no in-kernel-tree
+	  modules require configfs, but a module built outside the kernel
+	  tree does. Such modules require Y or M here.
 
-	  Both sysfs and configfs can and should exist together on the
-	  same system. One is not a replacement for the other.
+	  If unsure, say N.
 
 config RELAYFS_FS
 	tristate "Relayfs file system support"

