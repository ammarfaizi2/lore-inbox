Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312852AbSDFWKr>; Sat, 6 Apr 2002 17:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312853AbSDFWKq>; Sat, 6 Apr 2002 17:10:46 -0500
Received: from ucsu.Colorado.EDU ([128.138.129.83]:54988 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S312852AbSDFWKp>; Sat, 6 Apr 2002 17:10:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.8-pre2: Linker Failure
Date: Sat, 6 Apr 2002 15:05:25 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <02040608575201.10881@cobra.linux>
MIME-Version: 1.0
Message-Id: <02040615052502.00758@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.8-pre2
Patch causes a linker failure for fs/dquot.c.

 diff -Nru a/fs/dquot.c b/fs/dquot.c
 --- a/fs/dquot.c        Fri Apr  5 16:56:33 2002
 +++ b/fs/dquot.c        Fri Apr  5 16:56:33 2002

 ...

 -       kmem_cache_shrink(dquot_cachep);
 -       return 0;
 +       return kmem_cache_shrink_nr(dquot_cachep);

 ...

 gcc -D__KERNEL__ -I/usr/src/linux-2.5.8-pre2/include -Wall
 -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-
 pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
 -march=athlon    -DKBUILD_BASENAME=
 dec_and_lock  -c -o dec_and_lock.o dec_and_lock.c
 rm -f lib.a
 ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o
 memcpy.o strstr.o mmx.o dec_and_lock.o
 make[2]: Leaving directory `/usr/src/linux-2.5.8-pre2/arch/i386/lib'
 make[1]: Leaving directory `/usr/src/linux-2.5.8-pre2/arch/i386/lib'
 ld -m elf_i386 -T /usr/src/linux-2.5.8-pre2/arch/i386/vmlinux.lds -e stext
 arch/i386/kernel/head.o arch/i386/ke
 rnel/init_task.o init/main.o init/version.o init/do_mounts.o \
         --start-group \
         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
 fs/fs.o ipc/ipc.o \
         /usr/src/linux-2.5.8-pre2/arch/i386/lib/lib.a
 /usr/src/linux-2.5.8-pre2/lib/lib.a /usr/src/linux-2.5.8-
 pre2/arch/i386/lib/lib.a \
          drivers/acpi/acpi.o drivers/parport/driver.o drivers/base/base.o
 drivers/char/char.o drivers/block/blo
 ck.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
 drivers/ide/idedriver.o drivers/cdrom/driver.o
  sound/sound.o drivers/pci/driver.o drivers/video/video.o \
         net/network.o \
         --end-group \
         -o vmlinux
 fs/fs.o: In function `shrink_dqcache_memory':
 fs/fs.o(.text+0x1da31): undefined reference to `kmem_cache_shrink_nr'
 make: *** [vmlinux] Error 1
