Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292220AbSBBEQk>; Fri, 1 Feb 2002 23:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292221AbSBBEQb>; Fri, 1 Feb 2002 23:16:31 -0500
Received: from mx3.fuse.net ([216.68.1.123]:32690 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S292220AbSBBEQP>;
	Fri, 1 Feb 2002 23:16:15 -0500
Message-ID: <3C5B6803.1030101@fuse.net>
Date: Fri, 01 Feb 2002 23:16:03 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: New ACPI source release (20010201)
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7C0A@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

>Hello all,
>
>I'm pleased to announce that the big changes that we have been working on
>are now stable enough to distribute to other developers. Since our web
>liaison person doesn't work on the weekend, the developer.intel.com site
>will not be updated until the Monday evening push. However, there will be
>early access to the Linux patch via the acpi project on SourceForge.net.
>
Just got the patch and applied it to 2.5.3-dj1.  It fails to build thus:
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

$ find . -type f | xargs grep -e __ucmpdi2
Binary file ./drivers/acpi/acpi.o matches
Binary file ./drivers/acpi/acpi_battery.o matches
./arch/arm/kernel/armksyms.c:extern void __ucmpdi2(void);
./arch/arm/kernel/armksyms.c:EXPORT_SYMBOL_NOVERS(__ucmpdi2);
./arch/arm/lib/ucmpdi2.c:__ucmpdi2 (DItype a, DItype b)

$ find . -type f | xargs grep -e acpi_exit
./include/linux/modules/acpi_ksyms.ver:#define __ver_acpi_exit  smp_240a2b61
./include/linux/modules/acpi_ksyms.ver:#define acpi_exit        
_set_ver(acpi_exit)
./drivers/acpi/acpi_ksyms.c:EXPORT_SYMBOL(acpi_exit);
./drivers/acpi/acpi_bus.c:acpi_exit (void)
./drivers/acpi/acpi_bus.c:      FUNCTION_TRACE("acpi_exit");
./drivers/acpi/acpi_bus.h:void acpi_exit (void);
Binary file ./drivers/acpi/acpi_ksyms.o matches
Binary file ./drivers/acpi/acpi_bus.o matches
Binary file ./drivers/acpi/acpi.o matches

All ACPI stuff is Y.

I will do some digging myself but I thought it would be good to throw 
this out for your viewing (dis)pleasure.

--Nathan.



