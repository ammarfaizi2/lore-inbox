Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266339AbRGGOl5>; Sat, 7 Jul 2001 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266345AbRGGOlr>; Sat, 7 Jul 2001 10:41:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:32712 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266339AbRGGOla>;
	Sat, 7 Jul 2001 10:41:30 -0400
Message-ID: <3B471F98.42875269@mandrakesoft.com>
Date: Sat, 07 Jul 2001 10:41:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.4.6 PCMCIA NET modular build breakage
In-Reply-To: <200107071423.f67ENv707049@linuxhacker.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> arm-linux-ld -p -X -T arch/arm/vmlinux.lds arch/arm/kernel/head-armv.o arch/arm/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/arm/kernel/kernel.o arch/arm/mm/mm.o arch/arm/mach-sa1100/sa1100.o
> kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/cdrom/driver.o drivers/mtd/mtdlink.o drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o drivers/video/video.o \
>         net/network.o \
>         arch/arm/fastfpe/fast-math-emu.o arch/arm/nwfpe/math-emu.o arch/arm/lib/lib.a /home/green/arm/cvs/linux/kernel/lib/lib.a /skiff/local/lib/gcc-lib/arm-linux/2.95.2/soft-float/libgcc.a \
>         --end-group \
>         -o vmlinux
> arm-linux-ld: cannot open drivers/net/pcmcia/pcmcia_net.o: No such file or directory
> make: *** [vmlinux] Error 1
> 
> And Rules.make is almost identical to that in vanilla kernel (if someone is
> interested). (almost means that it have rule on how to make .o files from .S)

It is clear that,
(1) your config has CONFIG_NET_PCMCIA, and appears to be ok
(2) your linux/Makefile is correct, as the link statement includes
pcmcia_net.o

So that leaves us with drivers/net/Makefile and
drivers/net/pcmcia/Makefile.

drivers/net/Makefile is a potential problem source, perhaps the
following change is not in your arch tree:
	subdir-$(CONFIG_NET_PCMCIA) += pcmcia

If that statement exists in drivers/net/Makefile, you need to run a
kernel build, and start staring at make output to see exactly why it is
not building.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
