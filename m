Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSE2OnZ>; Wed, 29 May 2002 10:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSE2OnY>; Wed, 29 May 2002 10:43:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46349 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315417AbSE2OnX>; Wed, 29 May 2002 10:43:23 -0400
Date: Wed, 29 May 2002 16:43:25 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 1/3 Ported quota changes
Message-ID: <20020529144323.GA9503@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  so I ported quota changes to 2.5.18.  The first one is just a minor
change to Makefile and Config.in to not build quota.c when not needed.
I don't see the patch in 2.5.18 so I resend it...

							Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18/fs/Config.in linux-2.5.18-1-makefix/fs/Config.in
--- linux-2.5.18/fs/Config.in	Sat May 25 14:25:31 2002
+++ linux-2.5.18-1-makefix/fs/Config.in	Tue May 28 23:46:57 2002
@@ -8,10 +8,13 @@
 dep_tristate '  Old quota format support' CONFIG_QFMT_V1 $CONFIG_QUOTA
 dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
 dep_mbool '  Compatible quota interfaces' CONFIG_QIFACE_COMPAT $CONFIG_QUOTA
-if [ "$CONFIG_QUOTA" = "y" -a "$CONFIG_QIFACE_COMPAT" = "y" ]; then
-   choice '    Compatible quota interfaces' \
-	"Original	CONFIG_QIFACE_V1 \
-	 VFSv0		CONFIG_QIFACE_V2" Original
+if [ "$CONFIG_QUOTA" = "y" ]; then
+   define_bool CONFIG_QUOTACTL y
+   if [ "$CONFIG_QIFACE_COMPAT" = "y" ]; then
+       choice '    Compatible quota interfaces' \
+		"Original	CONFIG_QIFACE_V1 \
+		 VFSv0		CONFIG_QIFACE_V2" Original
+   fi
 fi
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.18/fs/Makefile linux-2.5.18-1-makefix/fs/Makefile
--- linux-2.5.18/fs/Makefile	Tue May 28 23:41:29 2002
+++ linux-2.5.18-1-makefix/fs/Makefile	Tue May 28 23:47:19 2002
@@ -15,7 +15,7 @@
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o quota.o
+		fs-writeback.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
@@ -35,6 +35,7 @@
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
 obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
+obj-$(CONFIG_QUOTACTL)		+= quota.o
 
 obj-$(CONFIG_PROC_FS)		+= proc/
 obj-y				+= partitions/
