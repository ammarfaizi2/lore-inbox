Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTETQZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTETQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:25:51 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:36269 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S263455AbTETQZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:25:49 -0400
Date: Tue, 20 May 2003 11:38:45 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Brian Gerst <bgerst@didntduck.org>, Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
In-Reply-To: <Pine.LNX.4.44.0305201726200.12110-100000@serv>
Message-ID: <Pine.LNX.4.44.0305201126450.24017-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Roman Zippel wrote:

> Has the new syntax any advantage, e.g. does it make sense to have adfs-m? 
> Otherwise the -obj syntax looks IMO more readable and it directly says 
> that this is a composite object.

Let me quote from Brian's patch:

diff -urN linux-2.5.69-bk/fs/ext3/Makefile linux/fs/ext3/Makefile
--- linux-2.5.69-bk/fs/ext3/Makefile    2003-05-17 23:55:01.000000000 
-0400
+++ linux/fs/ext3/Makefile      2003-05-18 15:59:09.000000000 -0400
@@ -4,17 +4,9 @@

 obj-$(CONFIG_EXT3_FS) += ext3.o

-ext3-objs    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o 
inode.o \
+ext3-y       := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o 
inode.o \
                ioctl.o namei.o super.o symlink.o hash.o

-ifeq ($(CONFIG_EXT3_FS_XATTR),y)
-ext3-objs += xattr.o xattr_user.o xattr_trusted.o
-endif
-
-ifeq ($(CONFIG_EXT3_FS_POSIX_ACL),y)
-ext3-objs += acl.o
-endif
-
-ifeq ($(CONFIG_EXT3_FS_SECURITY),y)
-ext3-objs += xattr_security.o
-endif
+ext3-$(CONFIG_EXT3_FS_XATTR) += xattr.o xattr_user.o xattr_trusted.o
+ext3-$(CONFIG_EXT3_FS_POSIX_ACL) += acl.o
+ext3-$(CONFIG_EXT3_FS_SECURITY) += xattr_security.o

which I think clearly shows the benefits. I agree that "-objs" is more 
intuitive than "-y", otoh it also has potential for confusion with 
"obj-$(CONFIG_...)" (as kinda proven by your "-obj" quote above ;).

Basically, I think having "-y" is essential for uses like the one above, 
the only question is whether to switch everything to "-y" or use "-y" for 
multipart modules with optional parts and "-objs" for multipart modules 
with a static list of components. For my opinion on that, see earlier this 
thread...

--Kai



