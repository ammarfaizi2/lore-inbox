Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281643AbRLAMrg>; Sat, 1 Dec 2001 07:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281645AbRLAMr0>; Sat, 1 Dec 2001 07:47:26 -0500
Received: from maila.telia.com ([194.22.194.231]:61150 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S281643AbRLAMrT>;
	Sat, 1 Dec 2001 07:47:19 -0500
To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@math.psu.edu>
Subject: modular nfs broken in 2.5.1-pre5
From: Peter Osterlund <petero2@telia.com>
Date: 01 Dec 2001 13:47:14 +0100
Message-ID: <m2bshj9kfh.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling nfs as a module doesn't work because of missing symbols.
The patch below works for me.

--- linux/fs/Makefile.old	Sat Dec  1 13:26:58 2001
+++ linux/fs/Makefile	Sat Dec  1 13:15:42 2001
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o seq_file.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
--- linux/fs/seq_file.c.old	Sat Dec  1 13:26:49 2001
+++ linux/fs/seq_file.c	Sat Dec  1 12:57:17 2001
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 
@@ -275,6 +276,7 @@
 	m->count = p - m->buf;
         return 0;
 }
+EXPORT_SYMBOL(seq_escape);
 
 int seq_printf(struct seq_file *m, const char *f, ...)
 {
@@ -293,3 +295,4 @@
 	m->count = m->size;
 	return -1;
 }
+EXPORT_SYMBOL(seq_printf);

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden
