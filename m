Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTEJNLF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 09:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTEJNLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 09:11:05 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:17628 "EHLO fep1.cogeco.net")
	by vger.kernel.org with ESMTP id S264095AbTEJNLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 09:11:03 -0400
Date: Sat, 10 May 2003 09:30:29 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linking error in sounddrivers.o (2.4.20)
Message-ID: <20030510133029.GA10023@dragon.homelinux.org>
References: <20030510012805.GA1037@dragon.homelinux.org> <20030510075220.GC31003@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510075220.GC31003@actcom.co.il>
User-Agent: Mutt/1.5.4i
From: Olivier Dragon <dragon@shadnet.shad.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 10:52:20AM +0300, Muli Ben-Yehuda wrote:
> Does it still happen with 2.4.21-rc2? Also, could you please send me
> in private the .config? I get a 504 gateway error when trying to wget
> it. 
> That's a fairly experimental kernel for compiling kernels. You might
> want to stick with 2.95 for the time being. 

Ok, I've compiled 2.4.21-rc2 (make dep; make bzImage) with 2.95 and I
got rid of the compilation error (most likely gcc bug) but I still get
the same linking error as previously mentioned. See below:

-Olivier

Linux trinity 2.4.20-ck6 #4 Fri Apr 25 15:20:53 EDT 2003 i686 unknown unknown GNU/Linux
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.33
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         radeon



gcc -D__KERNEL__ -I/home/oli/src/linux2.4/linux-laptop/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -iwithprefix include -DKBUILD_BASENAME=mmx  -c -o mmx.o mmx.c
rm -f lib.a
ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o mmx.o
make[2]: Leaving directory `/home/oli/src/linux2.4/linux-laptop/arch/i386/lib'
make[1]: Leaving directory `/home/oli/src/linux2.4/linux-laptop/arch/i386/lib'
ld -m elf_i386 -T /home/oli/src/linux2.4/linux-laptop/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/media/media.o drivers/input/inputdrv.o \
        net/network.o \
        /home/oli/src/linux2.4/linux-laptop/arch/i386/lib/lib.a /home/oli/src/linux2.4/linux-laptop/lib/lib.a /home/oli/src/linux2.4/linux-laptop/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/sound/sounddrivers.o(.text.init+0x823): In function `trident_probe':
: undefined reference to `pcigame_attach'
make: *** [vmlinux] Error 1


-- 
          __-/|    ? ?     |\-__
     __--/  /  \   (^^)   /  \  \--__
  _-/   /   /   \ / ( )  /   \   \   \-_
 /  /   /  /     (   ^^ ~     \  \   \  \
 / Oli Dragon    dragon@shadnet.shad.ca \
/  Sfwr Eng IV   (  McMaster University  \
/  /  /     __--_ (   ) __--__     \  \  \
|  /  /  _/        \_ \_       \_  \  \  |
 \/  / _/            \_ \_       \_ \  \/
  \_/ /                -\_\        \ \_/
    \/                   -)         \/
                       *~
       ___--<****************>--___
      [http://dragon.homelinux.org/]
       ~~~--<****************>--~~~
