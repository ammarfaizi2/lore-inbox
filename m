Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWB1D4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWB1D4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWB1D4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:56:36 -0500
Received: from mail.suse.de ([195.135.220.2]:48557 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932368AbWB1D4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:56:36 -0500
From: Neil Brown <neilb@suse.de>
To: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Date: Tue, 28 Feb 2006 14:55:50 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17411.51654.9256.327930@cse.unsw.edu.au>
Subject: Re: Bug in fs/reiserfs/file.c
In-Reply-To: message from Neil Brown on Tuesday February 28
References: <17411.42877.14972.748051@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 28, neilb@suse.de wrote:
> 
> 
> As an aside, 
>   info gcc
> tells me that '-W' will cause a warning when
> 
>         * An unsigned value is compared against zero with `<' or `<='.
> 
> It doesn't :-(

Actually, it does.  However Linux isn't compiled with "-W".
I'm experimenting with

diff ./Makefile~current~ ./Makefile
--- ./Makefile~current~	2006-02-28 14:44:21.000000000 +1100
+++ ./Makefile	2006-02-28 14:44:51.000000000 +1100
@@ -306,7 +306,7 @@ LINUXINCLUDE    := -Iinclude \
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
-CFLAGS 		:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+CFLAGS 		:= -W -Wall -Wno-unused -Wno-sign-compare -Wundef -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common \
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__



and it reports the following.

I think all of these are harmless except the file.c:1472 one (I
think), but it probably wouldn't hurt to tidy them up.

NeilBrown


  GEN    /home/src/mm-i386/Makefile
scripts/kconfig/conf -s arch/i386/Kconfig
#
# using defaults found in .config
#
  SPLIT   include/linux/autoconf.h -> include/config/*
  Using /home/src/mm as source for kernel
  GEN    /home/src/mm-i386/Makefile
  CHK     include/linux/version.h
  CC      fs/reiserfs/bitmap.o
  CC      fs/reiserfs/do_balan.o
  CC      fs/reiserfs/namei.o
/home/src/mm/fs/reiserfs/namei.c: In function `reiserfs_lookup':
/home/src/mm/fs/reiserfs/namei.c:370: warning: empty body in an if-statement
/home/src/mm/fs/reiserfs/namei.c: In function `reiserfs_create':
/home/src/mm/fs/reiserfs/namei.c:629: warning: empty body in an if-statement
/home/src/mm/fs/reiserfs/namei.c:673: warning: empty body in an if-statement
/home/src/mm/fs/reiserfs/namei.c: In function `reiserfs_mknod':
/home/src/mm/fs/reiserfs/namei.c:704: warning: empty body in an if-statement
/home/src/mm/fs/reiserfs/namei.c:752: warning: empty body in an if-statement
/home/src/mm/fs/reiserfs/namei.c: In function `reiserfs_mkdir':
/home/src/mm/fs/reiserfs/namei.c:783: warning: empty body in an if-statement
/home/src/mm/fs/reiserfs/namei.c:838: warning: empty body in an if-statement
  CC      fs/reiserfs/inode.o
/home/src/mm/fs/reiserfs/inode.c: In function `reiserfs_get_block':
/home/src/mm/fs/reiserfs/inode.c:630: warning: comparison of unsigned expression < 0 is always false
/home/src/mm/fs/reiserfs/inode.c:942: warning: comparison of unsigned expression < 0 is always false
  CC      fs/reiserfs/file.o
/home/src/mm/fs/reiserfs/file.c: In function `reiserfs_file_write':
/home/src/mm/fs/reiserfs/file.c:1472: warning: comparison of unsigned expression < 0 is always false
  CC      fs/reiserfs/dir.o
  CC      fs/reiserfs/fix_node.o
/home/src/mm/fs/reiserfs/fix_node.c: In function `create_virtual_node':
/home/src/mm/fs/reiserfs/fix_node.c:196: warning: empty body in an else-statement
  CC      fs/reiserfs/super.o
/home/src/mm/fs/reiserfs/super.c:687: warning: missing initializer
/home/src/mm/fs/reiserfs/super.c:687: warning: (near initialization for `logging_mode[3].clrmask')
/home/src/mm/fs/reiserfs/super.c:694: warning: missing initializer
/home/src/mm/fs/reiserfs/super.c:694: warning: (near initialization for `barrier_mode[2].clrmask')
/home/src/mm/fs/reiserfs/super.c: In function `reiserfs_parse_options':
/home/src/mm/fs/reiserfs/super.c:892: warning: missing initializer
/home/src/mm/fs/reiserfs/super.c:892: warning: (near initialization for `opts[9].arg_required')
/home/src/mm/fs/reiserfs/super.c:910: warning: missing initializer
/home/src/mm/fs/reiserfs/super.c:910: warning: (near initialization for `opts[25].arg_required')
  CC      fs/reiserfs/prints.o
  CC      fs/reiserfs/objectid.o
  CC      fs/reiserfs/lbalance.o
  CC      fs/reiserfs/ibalance.o
  CC      fs/reiserfs/stree.o
  CC      fs/reiserfs/hashes.o
  CC      fs/reiserfs/tail_conversion.o
  CC      fs/reiserfs/journal.o
/home/src/mm/fs/reiserfs/journal.c: In function `journal_read':
/home/src/mm/fs/reiserfs/journal.c:2322: warning: comparison of unsigned expression >= 0 is always true
  CC      fs/reiserfs/resize.o
  CC      fs/reiserfs/item_ops.o
  CC      fs/reiserfs/ioctl.o
  CC      fs/reiserfs/procfs.o
  LD      fs/reiserfs/reiserfs.o
  LD      fs/reiserfs/built-in.o
