Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267606AbSKQU6T>; Sun, 17 Nov 2002 15:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbSKQU6T>; Sun, 17 Nov 2002 15:58:19 -0500
Received: from guru.webcon.net ([66.11.168.140]:57749 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S267606AbSKQU6O>;
	Sun, 17 Nov 2002 15:58:14 -0500
Date: Sun, 17 Nov 2002 16:04:05 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.20-rc1-ac4, devlist.h & io_apic.c
Message-ID: <Pine.LNX.4.44.0211171540410.12883-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: Entering directory
`/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/drivers/pci'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
-march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=pci
-DEXPORT_SYMTAB -c pci.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
-march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=quirks  -c -o
quirks.o quirks.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
-march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=compat  -c -o
compat.o compat.c
make[3]: *** No rule to make target
`/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/drivers/pci/devlist.h',
needed by 'names.o'.  Stop.


Building gen-devlist by hand, then 'make devlist.h classlist.h', then back
to 'make bzImage' got the compile past that point.

Next, however, at the very end:

ld -m elf_i386 -T
/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/arch/i386/vmlinux.lds -e
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o
drivers/video/video.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/arch/i386/lib/lib.a
/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/lib/lib.a
/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o: In function 	`io_apic_set_pci_routing':
arch/i386/kernel/kernel.o(.text+0x12b7b): undefined reference to
`target_cpus'
make: *** [vmlinux] Error 1


This one-liner fixes it:

--- arch/i386/kernel/io_apic.c~	Sun Nov 17 16:02:29 2002
+++ arch/i386/kernel/io_apic.c	Sun Nov 17 16:02:29 2002
@@ -1894,7 +1894,7 @@
 
 	entry.delivery_mode = dest_LowestPrio;
 	entry.dest_mode = INT_DELIVERY_MODE;
-	entry.dest.logical.logical_dest = target_cpus();
+	entry.dest.logical.logical_dest = TARGET_CPUS;
 	entry.mask = 1;					 /* Disabled (masked) */
 	entry.trigger = 1;				   /* Level sensitive */
 	entry.polarity = 1;					/* Low active */



Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------

