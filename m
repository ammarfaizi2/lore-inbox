Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279509AbRKFOZy>; Tue, 6 Nov 2001 09:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279519AbRKFOZp>; Tue, 6 Nov 2001 09:25:45 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:55038 "EHLO
	c0mailgw03.prontomail.com") by vger.kernel.org with ESMTP
	id <S279509AbRKFOZa>; Tue, 6 Nov 2001 09:25:30 -0500
Message-ID: <3BE7F2CE.F56B19FC@starband.net>
Date: Tue, 06 Nov 2001 09:25:18 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux Kernel 2.4.14 Fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Either disable the loop device.

or

2) I've picked this up on #linux on EFNet, not sure if it the correct
function, however...

Edit /usr/src/linux/drivers/block/loop.c

Change all instances (2) of deactivate_page to lru_cache_del.

Before and after makes below.

BEFORE:

make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/mm'
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 " -C  arch/i386/lib
make[1]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o

drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a
/usr/src/linux-2.4.14/lib/lib.a
/usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x855f): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0x85c4): undefined reference to
`deactivate_page'
make: *** [vmlinux] Error 1
[root@war linux]#

AFTER:
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 " -C  arch/i386/lib
make[1]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \

        /usr/src/linux-2.4.14/arch/i386/lib/lib.a
/usr/src/linux-2.4.14/lib/lib.a
/usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux-2.4.14/arch/i386/boot'
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.14/include -D__BIG_KERNEL__
-traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:257: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.14/include -D__BIG_KERNEL__
-D__ASSEMBLY__ -traditional -DSVGA_MODE=NORMAL_VGA  setup.S -o bsetup.s
as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1559: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary -e begtext -o bsetup
bsetup.o
make[2]: Entering directory
`/usr/src/linux-2.4.14/arch/i386/boot/compressed'
tmppiggy=_tmp_$$piggy; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \
objcopy -O binary -R .note -R .comment -S /usr/src/linux-2.4.14/vmlinux
$tmppiggy; \
gzip -f -9 < $tmppiggy > $tmppiggy.gz; \
echo "SECTIONS { .data : { input_len = .; LONG(input_data_end -
input_data) input_data = .; *(.data) input_data_end = .; }}" >
$tmppiggy.lnk; \
ld -m elf_i386 -r -o piggy.o -b binary $tmppiggy.gz -b elf32-i386 -T
$tmppiggy.lnk; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.4.14/include
-traditional -c head.S
gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -c misc.c
ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
piggy.o
make[2]: Leaving directory
`/usr/src/linux-2.4.14/arch/i386/boot/compressed'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o tools/build
tools/build.c -I/usr/src/linux-2.4.14/include
objcopy -O binary -R .note -R .comment -S compressed/bvmlinux
compressed/bvmlinux.out
tools/build -b bbootsect bsetup compressed/bvmlinux.out CURRENT >
bzImage
Root device is (3, 2)
Boot sector 512 bytes.
Setup is 2496 bytes.
System is 958 kB
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/boot'
[root@war linux]#


