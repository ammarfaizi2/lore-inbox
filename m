Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290276AbSAXGfX>; Thu, 24 Jan 2002 01:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSAXGfK>; Thu, 24 Jan 2002 01:35:10 -0500
Received: from [216.70.178.182] ([216.70.178.182]:6272 "EHLO mail.xinetd.com")
	by vger.kernel.org with ESMTP id <S290276AbSAXGe6>;
	Thu, 24 Jan 2002 01:34:58 -0500
Date: Wed, 23 Jan 2002 22:34:18 -0800 (PST)
From: Glendon Gross <gross@xinetd.com>
To: Robert Love <rml@tech9.net>
cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Subject: Re: Low latency for recent kernels
In-Reply-To: <1011846537.855.71.camel@phantasy>
Message-ID: <Pine.LNX.4.21.0201232228080.384-100000@mail.xinetd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was able to build kernel 2.5.2 after applying the patch, but only
after editing out a line from /usr/src/linux/arch/i386/kernel/i387.c.
After applying the patch, the system does seem a little faster. (This
is a P-II/233 with 512k cache.)

Prior to the edit, I got this:

Script started on Wed Jan 23 21:58:40 2002
gross@mail:/usr/src/2.5.2/linux > make bzImage
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/2.5.2/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/2.5.2/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 " -C  kernel
make[1]: Entering directory `/usr/src/2.5.2/linux/kernel'
make all_targets

(snip)

make[2]: Entering directory `/usr/src/2.5.2/linux/kernel'
make[1]: Leaving directory `/usr/src/2.5.2/linux/arch/i386/math-emu'
ld -m elf_i386 -T /usr/src/2.5.2/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	/usr/src/2.5.2/linux/arch/i386/lib/lib.a /usr/src/2.5.2/linux/lib/lib.a /usr/src/2.5.2/linux/arch/i386/lib/lib.a \
	 drivers/acpi/acpi.o drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/atm/atm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o drivers/pnp/pnp.o drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/telephony/telephony.o arch/i386/math-emu/math.o \
	net/network.o \
	--end-group \
	-o vmlinux
arch/i386/kernel/kernel.o: In function `kernel_fpu_begin':
arch/i386/kernel/kernel.o(.text+0x7ccd): undefined reference to `preempt_disable'
make: *** [vmlinux] Error 1
gross@mail:/usr/src/2.5.2/linux > exit

Script done on Wed Jan 23 22:01:56 2002


So I looked at i387.c and commented out this line:

Script started on Wed Jan 23 22:31:34 2002
gross@mail:/usr/src/linux/arch/i386/kernel > pwd
/usr/src/linux/arch/i386/kernel
gross@mail:/usr/src/linux/arch/i386/kernel > grep preempt i387.c
/*	preempt_disable();    */
gross@mail:/usr/src/linux/arch/i386/kernel > exit

Script done on Wed Jan 23 22:31:51 2002


On 23 Jan 2002, Robert Love wrote:

> On Wed, 2002-01-23 at 23:20, Glendon Gross wrote:
>  
> > Is this patch available for 2.5.2 ? or is it already part of the tree?
> 
> No, its not in 2.5 at the moment.  2.5.2 patch is available at:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.5
> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

