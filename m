Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268626AbTCCWAx>; Mon, 3 Mar 2003 17:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268627AbTCCWAv>; Mon, 3 Mar 2003 17:00:51 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33796 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S268626AbTCCWAt>; Mon, 3 Mar 2003 17:00:49 -0500
Date: Mon, 3 Mar 2003 17:11:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.63] aha152x, module issues
Message-ID: <Pine.LNX.4.44.0303031710370.22041-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aha152x alternates between not compiling and not working. The kernel has it not compiling.

  gcc -Wp,-MD,drivers/scsi/.aha152x.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE  -DAHA152X_STAT -DAUTOCONF -DKBUILD_BASENAME=aha152x -DKBUILD_MODNAME=aha152x -c -o drivers/scsi/aha152x.o drivers/scsi/aha152x.c
drivers/scsi/aha152x.c: In function `aha152x_detect':
drivers/scsi/aha152x.c:1134: too many arguments to function `pnp_activate_dev'
make[2]: *** [drivers/scsi/aha152x.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


Hogwash. I unpacked the source, copied the (working) 2.5.59 .config,
and made oldconfig, bzImage, modules and modules_install in that order.
I never even thought of playing with SUBDIRS... And the
/lib/modules/2.5.63 directory did not even exist when I started, so the
whine about stale module entries clearly doesn't mean what I would
assume.

++ make modules_install
make -rR -f scripts/Makefile.modinst
scripts/Makefile.modinst:16: *** Uh-oh, you have stale module entries. You messed with SUBDIRS, do not complain if something goes wrong.
  mkdir -p /lib/modules/2.5.63/kernel/fs; cp fs/binfmt_aout.ko /lib/modules/2.5.63/kernel/fs
cp: cannot stat `fs/binfmt_aout.ko': No such file or directory
make[1]: *** [fs/binfmt_aout.ko] Error 1
make: *** [_modinst_] Error 2



