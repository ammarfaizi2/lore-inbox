Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTLIFEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 00:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTLIFEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 00:04:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:57873 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S262859AbTLIFEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 00:04:48 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS merged in 2.4 
In-reply-to: Your message of "Mon, 08 Dec 2003 12:48:20 CDT."
             <20031208174820.GA18504@rdlg.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Dec 2003 16:04:37 +1100
Message-ID: <18424.1070946277@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 12:48:20 -0500, 
"Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:
>While I think this is a good idea in general:
>make bzImage gives this:
>make[4]: Leaving directory `/exp/src1/kernels/2.4.23/Desktop/linux-2.4.23/f=
>s/vfat'
>make -C xfs fastdep
>make: *** xfs: No such file or directory.  Stop.

The XFS infrastructure has been merged, but not the fs/xfs directory
(wrong order).  Apply this temporary patch until fs/xfs is in Marcelo's
BK tree.

--- fs/Makefile.orig	2003-12-09 16:01:55.000000000 +1100
+++ fs/Makefile	2003-12-09 16:02:09.000000000 +1100
@@ -8,7 +8,7 @@
 O_TARGET := fs.o
 
 export-objs :=	filesystems.o open.o dcache.o buffer.o dquot.o
-mod-subdirs :=	nls xfs
+mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
@@ -66,7 +66,6 @@
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
 subdir-$(CONFIG_BEFS_FS)	+= befs
 subdir-$(CONFIG_JFS_FS)		+= jfs
-subdir-$(CONFIG_XFS_FS)		+= xfs
 
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o

