Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264762AbSJPLYo>; Wed, 16 Oct 2002 07:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264772AbSJPLYo>; Wed, 16 Oct 2002 07:24:44 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32772 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264762AbSJPLYn>;
	Wed, 16 Oct 2002 07:24:43 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: XFS build error on m68k in 2.5.43 
In-reply-to: Your message of "Wed, 16 Oct 2002 13:21:39 +0200."
             <Pine.GSO.4.21.0210161319210.9988-100000@vervain.sonytel.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 Oct 2002 21:30:27 +1000
Message-ID: <31054.1034767827@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002 13:21:39 +0200 (MEST), 
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>When compiling a kernel for m68k (with CONFIG_XFS_FS=m), I get this error:
>
>| make -f fs/xfs/Makefile 
>|    rm -f fs/xfs/built-in.o; m68k-linux-ar rcs fs/xfs/built-in.o
>|   m68k-linux-gcc -Wp,-MD,fs/xfs/linux/.xfs_stats.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -fno-strength-reduce -ffixed-a2 -nostdinc -iwithprefix include -DMODULE -Ifs/xfs -funsigned-char  -DKBUILD_BASENAME=xfs_stats   -c -o fs/xfs/linux/xfs_stats.o fs/xfs/linux/xfs_stats.c
>| In file included from fs/xfs/xfs.h:70,
>|                  from fs/xfs/linux/xfs_stats.c:33:
>| fs/xfs/xfs_bmap_btree.h:662: badly punctuated parameter list in `#define'
>| fs/xfs/xfs_log.h:62: warning: `_lsn_cmp' defined but not used
>| make[2]: *** [fs/xfs/linux/xfs_stats.o] Error 1
>| make[1]: *** [fs/xfs] Error 2
>| make: *** [fs] Error 2
>
>Since it's not obvious to me what's wrong with that define, I'm asking here.

Spot the typo :(

--- fs/xfs/xfs_bmap_btree.h.orig	Wed Oct 16 21:28:36 2002
+++ fs/xfs/xfs_bmap_btree.h	Wed Oct 16 21:28:49 2002
@@ -658,8 +658,8 @@
 #else
 #define xfs_bmbt_disk_set_all(r, s) \
 	xfs_bmbt_set_all(r, s)
-#define xfs_bmbt_disk_set_allf(r, 0, b, c, v) \
-	xfs_bmbt_set_allf(r, 0, b, c, v)
+#define xfs_bmbt_disk_set_allf(r, o, b, c, v) \
+	xfs_bmbt_set_allf(r, o, b, c, v)
 #endif
 
 void

