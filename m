Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSBCKZ2>; Sun, 3 Feb 2002 05:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSBCKZR>; Sun, 3 Feb 2002 05:25:17 -0500
Received: (root@vger.kernel.org) by vger.kernel.org id <S286692AbSBCKZE>;
	Sun, 3 Feb 2002 05:25:04 -0500
Received: from mx3.fuse.net ([216.68.1.123]:65197 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S286311AbSBCGek>;
	Sun, 3 Feb 2002 01:34:40 -0500
Message-ID: <3C5CD9F3.8090404@fuse.net>
Date: Sun, 03 Feb 2002 01:34:27 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: ACPI help needed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a curious problem on my hands (I think. Maybe somebody can fix 
it in an instant):

the latest ACPI patch refuses to build with my box.

Under gcc 2.95.4 I get:
ld -m elf_i386 -T 
/home/expsoft/src/linux-kernel/linux-2.5/linux/arch/i386/vmlinux.lds -e 
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
       --start-group \
       arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
       
/home/expsoft/src/linux-kernel/linux-2.5/linux/arch/i386/lib/lib.a 
/home/expsoft/src/linux-kernel/linux-2.5/linux/lib/lib.a 
/home/expsoft/src/linux-kernel/linux-2.5/linux/arch/i386/lib/lib.a \
        drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o 
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o 
drivers/input/serio/seriodrv.o \
       net/network.o \
       --end-group \
       -o vmlinux
drivers/acpi/acpi.o: In function `acpi_battery_read_info':
drivers/acpi/acpi.o(.text+0x2864e): undefined reference to `__ucmpdi2'
drivers/acpi/acpi.o(.text+0x28667): undefined reference to `__ucmpdi2'
drivers/acpi/acpi.o(__ksymtab+0x208): undefined reference to `acpi_exit'


And under 3.0 (debian unstable latest, 3.0.4-pre020127), the errors 
about __ucmpdi2 disappear, but the acpi_exit one remains.  acpi_init, 
which is a very very similarly defined, constructed, etc function is 
fine.  Somebody please help me (my system depends on ACPI PCI IRQ routing).

--Nathan


