Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314641AbSEFULe>; Mon, 6 May 2002 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314694AbSEFULd>; Mon, 6 May 2002 16:11:33 -0400
Received: from jane.hollins.EDU ([192.160.94.78]:18697 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S314641AbSEFULc>;
	Mon, 6 May 2002 16:11:32 -0400
Message-ID: <3CD6E36C.2020902@hollins.edu>
Date: Mon, 06 May 2002 16:11:24 -0400
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020122
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.14-dj1
In-Reply-To: <20020506184320.GA16392@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an error compiling for the aic7xxx (compiling firmware) and this 
also happened in 2.5.13-dj1 but this does not occur in the vanilla 
2.5.13 or 2.5.14.  And, of course, removing aic7xxx_seq.h and 
aic7xxx_reg.h is bad and causes me to have to pull it from another copy 
of the source tree.  This is compiling the aic7xxx (not the old one) 
into the kernel (not a module) and compiling the firmware:

make[5]: Entering directory 
`/other/work/lx/linux-2.5.14-dj1/drivers/scsi/aic7xxx/aicasm'
yacc -d -b aicasm_gram aicasm_gram.y
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
lex  -oaicasm_scan.c aicasm_scan.l
lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
gcc -I/usr/include -I. -ldb aicasm.c aicasm_symbol.c aicasm_gram.c 
aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasmmake[5]: 
Leaving directory 
`/other/work/lx/linux-2.5.14-dj1/drivers/scsi/aic7xxx/aicasm'
aicasm/aicasm -I. -r aic7xxx_reg.h -o aic7xxx_seq.h aic7xxx.seq
aicasm/aicasm: Stopped at file aic7xxx.reg, line 1013 - syntax error
aicasm/aicasm: Removing aic7xxx_seq.h due to error
aicasm/aicasm: Removing aic7xxx_reg.h due to error
make[4]: *** [aic7xxx_reg.h] Error 65
make[4]: Leaving directory 
`/other/work/lx/linux-2.5.14-dj1/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory 
`/other/work/lx/linux-2.5.14-dj1/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/other/work/lx/linux-2.5.14-dj1/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/other/work/lx/linux-2.5.14-dj1/drivers'
make: *** [_dir_drivers] Error 2


Dave Jones wrote:

>Just clearing out the pending folder, and dropping some more
>bits found whilst patch splitting.
>
>As usual,..
>Patch against 2.5.13 vanilla is available from:
>ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/
>
>Merged patch archive: http://www.codemonkey.org.uk/patches/merged/
>
>Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
>known bugs that are also in mainline.
>
> -- Davej.
>
>2.5.14-dj1
>o   Don't prefetch memcpy's to/from io addresses.	(Me)
>o   Fix MMX prefetching for x86-64			(Me)
>o   Other small MMX copying tweaks for x86-64.		(Me)
>o   Drop more silly bits found whilst patch splitting.
>o   Fix tcq brown paper bag bug.			(Jens Axboe)
>o   OSS API emulation config.in thinko.			(Jaroslav Kysela)
>o   Update to IDE-55					(Martin Dalecki)
>o   Disallow compilation with gcc 2.91.66		(Andrew Morton)
>o   Missed blksize cleanup in rd.c			(Al Viro)
>o   NTFS compile fix.					(Andrew Morton)
>o   More futex updates.					(Rusty Russell)
>o   DE600 region checking cleanup.			(William Stinson)
>o   Update VIA quirk URL.				(Erich Schubert)
>o   Fix up a few _llseek prototypes.			(Frank Davis)
>o   Move busmouse BKL usage to correct place.		(Frank Davis)
>o   __d_lookup() microoptimisation.			(Paul Menage)	
>o   Fix CAP_SYS_RAWIO thinko for cpqfcTSinit		(Christoph Hellwig)
>o   malloc.h -> slab.h for pc300_tty			(Adrian Bunk)
>o   Add CONFIG_BROKEN_SCSI_ERROR_HANDLING		(Me)
>    | Those who don't care about their data can now
>    | choose the same behaviour as mainline.
>
>


