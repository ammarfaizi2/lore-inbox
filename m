Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSHGMoQ>; Wed, 7 Aug 2002 08:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSHGMoQ>; Wed, 7 Aug 2002 08:44:16 -0400
Received: from angband.namesys.com ([212.16.7.85]:29338 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317329AbSHGMoO>; Wed, 7 Aug 2002 08:44:14 -0400
Date: Wed, 7 Aug 2002 16:47:48 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: compile error : reiserfs - 2.4.19
Message-ID: <20020807164748.A18722@namesys.com>
References: <20020807044225.17552f07.stephane.wirtel@belgacom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020807044225.17552f07.stephane.wirtel@belgacom.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Are you sure this is vanilla 2.4.19 and you have not applied any
   patches on top of it? (e.g. 2.4.19-ac[234])
   Here locally I can compile 2.4.19 with reiserfs and CONFIG_REISERFS_CHECK
   both on and off.
   If you have vanilla 2.4.19, please send me your full .config.

   Thank you.

Bye,
    Oleg
On Wed, Aug 07, 2002 at 04:42:25AM +0200, Stephane Wirtel wrote:
> my .config
> 
> CONFIG_REISERFS_FS=y
> CONFIG_REISERFS_CHECK=y
> CONFIG_REISERFS_PROC_INFO=y
> 
> my error is as follows :
> 
> make -C reiserfs
> make[2]: Entering directory `/root/linux-2.4.19/fs/reiserfs'
> make all_targets
> make[3]: Entering directory `/root/linux-2.4.19/fs/reiserfs'
> gcc -D__KERNEL__ -I/root/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=bitmap  -c -o bitmap.o bitmap.c
> bitmap.c: In function `reiserfs_free_block':
> bitmap.c:132: parse error before `)'
> bitmap.c:133: parse error before `)'
> bitmap.c: In function `reiserfs_free_prealloc_block':
> bitmap.c:142: parse error before `)'
> bitmap.c:143: parse error before `)'
> bitmap.c: In function `do_reiserfs_new_blocknrs':
> bitmap.c:326: parse error before `)'
> bitmap.c:341: parse error before `)'
> bitmap.c:417: parse error before `)'
> make[3]: *** [bitmap.o] Error 1
> make[3]: Leaving directory `/root/linux-2.4.19/fs/reiserfs'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/root/linux-2.4.19/fs/reiserfs'
> make[1]: *** [_subdir_reiserfs] Error 2
> make[1]: Leaving directory `/root/linux-2.4.19/fs'
> make: *** [_dir_fs] Error 2
> bash-2.05a# 
> 
> bitmap.c 
> In function `reiserfs_free_block':
> 132 :    RFALSE(!s, "vs-4061: trying to free block on nonexistent device");
> 133 :    RFALSE(is_reusable (s, block, 1) == 0, "vs-4071: can not free such block");
> 
> In function `reiserfs_free_prealloc_block':
> 142 :    RFALSE(!th->t_super, "vs-4060: trying to free block on nonexistent device");
> 143 :    RFALSE(is_reusable (th->t_super, block, 1) == 0, "vs-4070: can not free such block");
> 
> In function `do_reiserfs_new_blocknrs':
> 326 :    RFALSE( !s, "vs-4090: trying to get new block from nonexistent device");
> 340 :    RFALSE( is_reusable (s, *free_blocknrs, 1) == 0, 
> 341 :         "vs-4120: bad blocknr on free_blocknrs list");
> 
> 
> 415 :    RFALSE( buffer_locked (SB_AP_BITMAP (s)[i]) ||
> 416 :        is_reusable (s, search_start, 0) == 0,
> 417 :        "vs-4140: bitmap block is locked or bad block number found");
> 
> 
> there are the RFALSE's define :
> 
> #if defined( CONFIG_REISERFS_CHECK )
> #define RFALSE( cond, format, args... ) RASSERT( !( cond ), format, ##args )
> #else
> #define RFALSE( cond, format, args... ) do {;} while( 0 )
> #endif
> 
> 
> now i'm compiling my kernel without CONFIG_REISERFS_CHECK
> 
> St?phane Wirtel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
