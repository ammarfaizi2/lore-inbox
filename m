Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292248AbSBTUAW>; Wed, 20 Feb 2002 15:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292255AbSBTT7a>; Wed, 20 Feb 2002 14:59:30 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:28194 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S292248AbSBTT6Z>; Wed, 20 Feb 2002 14:58:25 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F7B@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'thunder7@xs4all.nl'" <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: RE: 2.5.5 compile on alpha bombs
Date: Wed, 20 Feb 2002 14:58:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw the same error on Sparc, and Ingo pointed out that a quick work around
was to revert switch_to () from two args back to three in sched.c

It looks like this now switch_to (prev, next);
I was able to change it like this switch_to (prev, next, prev); and was able
to get it working again, this is not the correct fix, but a quick work
around, and I don't know if Alpha is the same, but it may be worth a shot.

Bruce H.

-----Original Message-----
From: Jurriaan on Alpha [mailto:thunder7@xs4all.nl]
Sent: Wednesday, February 20, 2002 2:36 PM
To: linux-kernel@vger.kernel.org
Subject: 2.5.5 compile on alpha bombs


I'm not sure if it is meant to work, it being a development kernel and
all, but if anybody is interested:

ALPHA :make boot
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6
-DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /usr/src/linux-2.5.5/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.5.5/include/linux/blkdev.h:9,
                 from /usr/src/linux-2.5.5/include/linux/blk.h:4,
                 from init/main.c:25:
/usr/src/linux-2.5.5/include/linux/highmem.h: In function
`memclear_highpage_flush':
/usr/src/linux-2.5.5/include/linux/highmem.h:112: warning: implicit
declaration of function `flush_dcache_page'
/usr/src/linux-2.5.5/include/linux/highmem.h:113: warning: implicit
declaration of function `flush_page_to_ram'
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6
-DUTS_MACHINE='"alpha"' -DKBUILD_BASENAME=version -c -o init/version
.o init/version.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -c -o
init/do_mounts.o init/do_mounts.c
In file included from /usr/src/linux-2.5.5/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.5.5/include/linux/blkdev.h:9,
                 from /usr/src/linux-2.5.5/include/linux/blk.h:4,
                 from init/do_mounts.c:9:
/usr/src/linux-2.5.5/include/linux/highmem.h: In function
`memclear_highpage_flush':
/usr/src/linux-2.5.5/include/linux/highmem.h:112: warning: implicit
declaration of function `flush_dcache_page'
/usr/src/linux-2.5.5/include/linux/highmem.h:113: warning: implicit
declaration of function `flush_page_to_ram'
init/do_mounts.c: At top level:
init/do_mounts.c:958: warning: `crd_load' defined but not used
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-stric
t-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 "
-C  kernel
make[1]: Entering directory `/usr/src/linux-2.5.5/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.5.5/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6
-DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sche
d.c
In file included from sched.c:22:
/usr/src/linux-2.5.5/include/asm/mmu_context.h:32: #error update this
function.
sched.c:440: macro `switch_to' used with only 2 args
In file included from sched.c:24:
/usr/src/linux-2.5.5/include/linux/highmem.h: In function
`memclear_highpage_flush':
/usr/src/linux-2.5.5/include/linux/highmem.h:112: warning: implicit
declaration of function `flush_dcache_page'
/usr/src/linux-2.5.5/include/linux/highmem.h:113: warning: implicit
declaration of function `flush_page_to_ram'
sched.c: In function `context_switch':
sched.c:440: parse error before `)'
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.5/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5/kernel'
make: *** [_dir_kernel] Error 2
ALPHA :

Jurriaan
-- 
Lack of skill dictates economy of style.
	Joey Ramone
GNU/Linux 2.4.18-rc1 on Debian/Alpha 988 bogomips 5 users load:0.00 0.09
0.21
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
