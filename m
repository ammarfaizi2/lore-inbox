Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSEUWGx>; Tue, 21 May 2002 18:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316692AbSEUWGw>; Tue, 21 May 2002 18:06:52 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17818 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316664AbSEUWGv>;
	Tue, 21 May 2002 18:06:51 -0400
Date: Tue, 21 May 2002 23:51:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.17: compilation ignores errors?!
Message-ID: <20020521215148.GA14121@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems compilation now ignores errors...

I introduced parse error into init/main.c, and:

pavel@amd:/usr/src/linux$ time make bzImage
make[1]: Entering directory `/usr/src/linux/init'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i386
-DKBUILD_BASENAME=main -c -o main.o main.c
main.c:529: parse error before `bar'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Generating ../include/linux/compile.h
../include/linux/compile.h is unchanged
ld -m elf_i386 -r -o init.o main.o version.o do_mounts.o
ld: cannot open main.o: No such file or directory
make[1]: Leaving directory `/usr/src/linux/init'
make[1]: Entering directory `/usr/src/linux/kernel'
make[1]: Nothing to be done for `first_rule'.
make[1]: Leaving directory `/usr/src/linux/kernel'
make[1]: Entering directory `/usr/src/linux/lib'
make[2]: Entering directory `/usr/src/linux/lib/zlib_inflate'
...
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
         drivers/acpi/acpi.o drivers/pci/driver.o drivers/base/base.o
drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pcmcia/pcmcia.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o
drivers/input/serio/seriodrv.o drivers/i2c/i2c.o arch/i386/pci/pci.o \
        net/network.o \
        --end-group \
        -o vmlinux
ld: cannot open init/init.o: No such file or directory
make: *** [vmlinux] Error 1
7.18user 5.22system 44.64 (0m44.649s) elapsed 27.77%CPU

That's not too helpfull :(.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
