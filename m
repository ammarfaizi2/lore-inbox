Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTDYV0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTDYV0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:26:23 -0400
Received: from [62.37.236.142] ([62.37.236.142]:11424 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S264476AbTDYV0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:26:21 -0400
Message-ID: <3EA9AAD4.4020804@wanadoo.es>
Date: Fri, 25 Apr 2003 23:38:28 +0200
From: =?ISO-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [ Compile Regression on i386 ]-2.4.21-rc1-ac2 _critical_ compile
 errors
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel compilation output summary:

--fs/devpts--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c
ommon -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=inode
-c -o inode.o inode.c
inode.c: In function `init_devpts_fs':
inode.c:233: `devpts_upcall_new' undeclared (first use in this function)
inode.c:233: (Each undeclared identifier is reported only once
inode.c:233: for each function it appears in.)
inode.c:234: `devpts_upcall_kill' undeclared (first use in this function)
inode.c: In function `exit_devpts_fs':
inode.c:244: `devpts_upcall_new' undeclared (first use in this function)
inode.c:245: `devpts_upcall_kill' undeclared (first use in this function)
make[1]: [inode.o] Error 1 (ignored)
--end--

--drivers/char/drm-4.0--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_dma  -c -o i810_dma.o i810_dma.c
i810_dma.c: In function `i810_unmap_buffer':
i810_dma.c:231: too few arguments to function `do_munmap'
make[2]: [i810_dma.o] Error 1 (ignored)
--end--

--vmlinux-fs/fs.o--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=dec_and_lock  -c -o dec_and_lock.o dec_and_lock.c
rm -f lib.a
ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o dec_and_lock.o
make[2]: Leaving directory `/datos/kernel/linux/arch/i386/lib'
make[1]: Leaving directory `/datos/kernel/linux/arch/i386/lib'
ld -m elf_i386 -T /datos/kernel/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/media/media.o \
        net/network.o \
        /datos/kernel/linux/arch/i386/lib/lib.a /datos/kernel/linux/lib/lib.a /datos/kernel/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `do_quotactl':
fs/fs.o(.text+0x1b913): undefined reference to `sync_dquots_dev'
make: [vmlinux] Error 1 (ignored)
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
nm: vmlinux: No such file or directory
make[1]: Entering directory `/datos/kernel/linux/arch/i386/boot'
gcc -E -D__KERNEL__ -I/datos/kernel/linux/include -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:256: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
gcc -E -D__KERNEL__ -I/datos/kernel/linux/include -D__BIG_KERNEL__ -D__ASSEMBLY__ -traditional -DSVGA_MODE=NORMAL_VGA  setup.S -o bsetup.s
as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1587: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary -e begtext -o bsetup bsetup.o
make[1]: *** No rule to make target `/datos/kernel/linux/vmlinux', needed by `compressed/bvmlinux'.
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o tools/build tools/build.c -I/datos/kernel/linux/include
make[1]: Target `bzImage' not remade because of errors.
make[1]: Leaving directory `/datos/kernel/linux/arch/i386/boot'
make: [bzImage] Error 2 (ignored)
--end--

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!


