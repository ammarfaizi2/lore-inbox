Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314994AbSDWA5t>; Mon, 22 Apr 2002 20:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314995AbSDWA5s>; Mon, 22 Apr 2002 20:57:48 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:2312 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S314994AbSDWA5r>; Mon, 22 Apr 2002 20:57:47 -0400
Message-ID: <3CC4B170.542524E3@zip.com.au>
Date: Mon, 22 Apr 2002 17:57:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] expfs.c compile fix for crufty old compilers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-2.91.66 doesn't like the macro-varargs construct
which expfs.c is using.

Does anyone know which version of gcc gained the
alternative syntax?

--- linux-2.5.9/fs/exportfs/expfs.c	Mon Apr 22 16:41:03 2002
+++ 25/fs/exportfs/expfs.c	Mon Apr 22 17:51:53 2002
@@ -34,7 +34,7 @@ struct export_operations export_op_defau
 
 #define	CALL(ops,fun) ((ops->fun)?(ops->fun):export_op_default.fun)
 
-#define dprintk(x, ...) do{}while(0)
+#define dprintk(fmt, args...) do{}while(0)
 
 struct dentry *
 find_exported_dentry(struct super_block *sb, void *obj, void *parent,

-
