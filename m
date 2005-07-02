Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVGBK7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVGBK7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 06:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGBK7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 06:59:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261162AbVGBK6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 06:58:55 -0400
Date: Sat, 2 Jul 2005 12:58:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] CONFIGFS_FS: "If unsure, say N."
Message-ID: <20050702105848.GI3592@stusta.de>
References: <20050624080315.GC26545@stusta.de> <20050629213038.GA23823@ca-server1.us.oracle.com> <20050630004738.GA27478@stusta.de> <20050630005723.GE23823@ca-server1.us.oracle.com> <20050630011015.GC27478@stusta.de> <20050630013011.GF23823@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630013011.GF23823@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 06:30:11PM -0700, Joel Becker wrote:
> On Thu, Jun 30, 2005 at 03:10:15AM +0200, Adrian Bunk wrote:
> > The question is:
> > Assume a user doesn't use external modules, will enabling this option 
> > have any effect for him except that it wastes some bytes of his RAM?
> > 
> > sysfs is useful in this case.
> > How is configfs useful in this case?
> 
> 	I'm not saying it is.  I'm saying that "Hey, if you are unsure
> you want 'N'" is a good thing to say, but removing the description of
> "what configfs is" is unhelpful and unneeded.

OK, what about the patch below?

> Joel

cu
Adrian



<--  snip  -->


Make it clear that users usually shouldn't manually enable CONFIGFS_FS.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1-full/fs/Kconfig.old	2005-07-02 12:50:23.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/fs/Kconfig	2005-07-02 12:51:05.000000000 +0200
@@ -936,24 +936,30 @@
 config CONFIGFS_FS
 	tristate "Userspace-driven configuration filesystem (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
 	  configfs is a ram-based filesystem that provides the converse
 	  of sysfs's functionality. Where sysfs is a filesystem-based
 	  view of kernel objects, configfs is a filesystem-based manager
 	  of kernel objects, or config_items.
 
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
 
+	  This option is provided for the case where no in-kernel-tree
+	  modules require configfs, but a module built outside the kernel
+	  tree does. Such modules require Y or M here.
+
+	  If unsure, say N.
+
 config RELAYFS_FS
 	tristate "Relayfs file system support"
 	---help---
 	  Relayfs is a high-speed data relay filesystem designed to provide
 	  an efficient mechanism for tools and facilities to relay large
 	  amounts of data from kernel space to user space.
 
 	  To compile this code as a module, choose M here: the module will be
 	  called relayfs.
 
 	  If unsure, say N.
 

