Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSHGCiv>; Tue, 6 Aug 2002 22:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSHGCiv>; Tue, 6 Aug 2002 22:38:51 -0400
Received: from mirapoint3.brutele.be ([212.68.203.242]:22893 "EHLO
	mirapoint3.brutele.be") by vger.kernel.org with ESMTP
	id <S316623AbSHGCit>; Tue, 6 Aug 2002 22:38:49 -0400
Date: Wed, 7 Aug 2002 04:42:25 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: compile error : reiserfs - 2.4.19
Message-Id: <20020807044225.17552f07.stephane.wirtel@belgacom.net>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my .config

CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y

my error is as follows :

make -C reiserfs
make[2]: Entering directory `/root/linux-2.4.19/fs/reiserfs'
make all_targets
make[3]: Entering directory `/root/linux-2.4.19/fs/reiserfs'
gcc -D__KERNEL__ -I/root/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=bitmap  -c -o bitmap.o bitmap.c
bitmap.c: In function `reiserfs_free_block':
bitmap.c:132: parse error before `)'
bitmap.c:133: parse error before `)'
bitmap.c: In function `reiserfs_free_prealloc_block':
bitmap.c:142: parse error before `)'
bitmap.c:143: parse error before `)'
bitmap.c: In function `do_reiserfs_new_blocknrs':
bitmap.c:326: parse error before `)'
bitmap.c:341: parse error before `)'
bitmap.c:417: parse error before `)'
make[3]: *** [bitmap.o] Error 1
make[3]: Leaving directory `/root/linux-2.4.19/fs/reiserfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/root/linux-2.4.19/fs/reiserfs'
make[1]: *** [_subdir_reiserfs] Error 2
make[1]: Leaving directory `/root/linux-2.4.19/fs'
make: *** [_dir_fs] Error 2
bash-2.05a# 

bitmap.c 
In function `reiserfs_free_block':
132 :    RFALSE(!s, "vs-4061: trying to free block on nonexistent device");
133 :    RFALSE(is_reusable (s, block, 1) == 0, "vs-4071: can not free such block");

In function `reiserfs_free_prealloc_block':
142 :    RFALSE(!th->t_super, "vs-4060: trying to free block on nonexistent device");
143 :    RFALSE(is_reusable (th->t_super, block, 1) == 0, "vs-4070: can not free such block");

In function `do_reiserfs_new_blocknrs':
326 :    RFALSE( !s, "vs-4090: trying to get new block from nonexistent device");
340 :    RFALSE( is_reusable (s, *free_blocknrs, 1) == 0, 
341 :         "vs-4120: bad blocknr on free_blocknrs list");


415 :    RFALSE( buffer_locked (SB_AP_BITMAP (s)[i]) ||
416 :        is_reusable (s, search_start, 0) == 0,
417 :        "vs-4140: bitmap block is locked or bad block number found");


there are the RFALSE's define :

#if defined( CONFIG_REISERFS_CHECK )
#define RFALSE( cond, format, args... ) RASSERT( !( cond ), format, ##args )
#else
#define RFALSE( cond, format, args... ) do {;} while( 0 )
#endif


now i'm compiling my kernel without CONFIG_REISERFS_CHECK

Stéphane Wirtel
