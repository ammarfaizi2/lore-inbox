Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263495AbTDGPmz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTDGPmy (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:42:54 -0400
Received: from mario.gams.at ([194.42.96.10]:44852 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id S263495AbTDGPmx convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:42:53 -0400
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: bboett@adlp.org
cc: linux-kernel@vger.kernel.org, Sean Neakums <sneakums@zork.net>
Subject: Re: 2.5.66 not compiling 
References: <20030407153006.GC1088@adlp.org> 
In-reply-to: Your message of "Mon, 07 Apr 2003 17:30:06 +0200."
             <20030407153006.GC1088@adlp.org> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 07 Apr 2003 17:54:07 +0200
Message-ID: <7216.1049730847@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bboett@bboett.dyndns.org (Bruno Boettcher) wrote:
>make -f scripts/Makefile.build obj=fs/cramfs
>  gcc -Wp,-MD,fs/cramfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-proto
>types -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-st
>ack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -fomit-frame-poin
>ter -nostdinc -iwithprefix include    -DKBUILD_BASENAME=inode -DKBUILD_MODNAME
>=cramfs -c -o fs/cramfs/.tmp_inode.o fs/cramfs/inode.c
>fs/cramfs/inode.c: In function `get_cramfs_inode':
>fs/cramfs/inode.c:54: incompatible types in assignment
>make[2]: *** [fs/cramfs/inode.o] Fehler 1
>
>not the faintest idea on what did get wrong... so if someone has an
>idea... i will take it :D 

--- fs/cramfs/inode.c-orig	Thu Mar 27 14:17:22 2003
+++ fs/cramfs/inode.c	Thu Mar 27 13:47:56 2003
@@ -51,7 +51,9 @@
 		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
-		inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
+		inode->i_mtime.tv_sec = inode->i_mtime.tv_nsec = 
+			inode->i_atime.tv_sec = inode->i_atime.tv_nsec = 
+			inode->i_ctime.tv_sec = inode->i_ctime.tv_nsec = 0;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


