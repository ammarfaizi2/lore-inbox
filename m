Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSJHXN2>; Tue, 8 Oct 2002 19:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJHXN2>; Tue, 8 Oct 2002 19:13:28 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:28920 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261427AbSJHXKt>; Tue, 8 Oct 2002 19:10:49 -0400
Date: Tue, 8 Oct 2002 19:16:30 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch/bk] export do_sync_{read,write}
Message-ID: <20021008191630.G15858@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew Morton noticed that do_sync_{read,write} need to be exported for 
modules, so I've added the patch below to the bk tree at
master.kernel.org:/home/bcrl/aio-2.5 .  Please apply,

		-ben
-- 
"Do you seek knowledge in time travel?"

===== fs/Makefile 1.36 vs edited =====
--- 1.36/fs/Makefile	Wed Sep 18 21:54:43 2002
+++ edited/fs/Makefile	Tue Oct  8 19:11:56 2002
@@ -6,7 +6,7 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o
+                fcntl.o read_write.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
===== fs/read_write.c 1.16 vs edited =====
--- 1.16/fs/read_write.c	Tue Sep 24 21:29:19 2002
+++ edited/fs/read_write.c	Tue Oct  8 19:12:25 2002
@@ -614,3 +614,6 @@
 
 	return do_sendfile(out_fd, in_fd, NULL, count, 0);
 }
+
+EXPORT_SYMBOL(do_sync_read);
+EXPORT_SYMBOL(do_sync_write);
