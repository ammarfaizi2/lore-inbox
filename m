Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJARf4>; Tue, 1 Oct 2002 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261680AbSJARep>; Tue, 1 Oct 2002 13:34:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:13829 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262170AbSJARdo>; Tue, 1 Oct 2002 13:33:44 -0400
Date: Tue, 1 Oct 2002 19:39:08 +0200
From: Miroslav Rudisin <miero@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] default file permission for vfat
Message-ID: <20021001173908.GA15838@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The attached patch change default permission of files on [v]fatfs.
Default RWX have no utilization. This patch remove exec flag.

2.4.19 & 2.5.30

Thanks

--
Miroslav Rudisin


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- inode.c.orig	Mon Aug  5 21:56:01 2002
+++ inode.c	Mon Aug  5 21:58:32 2002
@@ -932,8 +932,8 @@
 		inode->i_generation |= 1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,
 		    ((sbi->options.showexec &&
-		       !is_exec(de->ext))
-		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
+		       is_exec(de->ext))
+		    	? S_IRWXUGO : S_IRUGO|S_IWUGO)
 		    & ~sbi->options.fs_umask) | S_IFREG;
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
 		if (sbi->fat_bits == 32) {

--/9DWx/yDrRhgMJTb--
