Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSLIRXN>; Mon, 9 Dec 2002 12:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbSLIRXM>; Mon, 9 Dec 2002 12:23:12 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:22680 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id <S265806AbSLIRXL>; Mon, 9 Dec 2002 12:23:11 -0500
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.54084.694635.159603@ronispc.chem.mcgill.ca>
Date: Mon, 9 Dec 2002 12:30:44 -0500
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, ronis@onsager.chem.mcgill.ca,
       David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: build failure in 2.4.20
In-Reply-To: <200212091809.57622.m.c.p@wolk-project.de>
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
	<200212091809.57622.m.c.p@wolk-project.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: ronis@onsager.chem.mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc-Christian,

Thanks for the reply.  I made the change and that problem went away.  Now however, I die at the next step; i.e.,

make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: cannot open binary: No such file or directory
make[1]: *** [bbootsect] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
make: *** [bzImage] Error 2

I'm using GNU ld version 2.13 and objdump -i shows that binary is
allowed.  I tried changing the instances of -oformat binary to
--oformat=binary in arch/i386/Makefile, but the changes seem to be
ignored, which is strange.

David





Marc-Christian Petersen writes:
 > On Monday 09 December 2002 16:22, David Ronis wrote:
 > 
 > Hi David,
 > 
 > > drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in
 > > discarded section .text.exit' make: *** [vmlinux] Error 1
 > > It sounds like this is a problem with ld or as, but I'm not sure.  Any
 > > suggestions?
 > $editor arch/i386/vmlinux.lds
 > 
 > you'll see starting at line 67 this:
 > 
 >   /* Sections to be discarded */
 >   /DISCARD/ : {
 >         *(.text.exit)
 >         *(.data.exit)
 >         *(.exitcall.exit)
 >         }
 > 
 > remove this:
 > 
 >         *(.text.exit)
 > 
 > try again.
 > 
 > ciao, Marc
 > 
