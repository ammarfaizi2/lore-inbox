Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315130AbSECShI>; Fri, 3 May 2002 14:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315133AbSECShH>; Fri, 3 May 2002 14:37:07 -0400
Received: from msp-65-29-16-52.mn.rr.com ([65.29.16.52]:55936 "HELO
	local.enodev.com") by vger.kernel.org with SMTP id <S315130AbSECShF>;
	Fri, 3 May 2002 14:37:05 -0400
Date: Fri, 3 May 2002 13:36:57 -0500
From: Shawn <core@enodev.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [LINK FAILURE] 2.5.12-dj1 (mark_buffer_uptodate)
Message-ID: <20020503183657.GA23553@local.enodev.com>
In-Reply-To: <20020503181719.GA20588@local.enodev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the right thing to do?

--- rd.c	Fri May  3 12:48:35 2002
+++ rd.c.new	Fri May  3 13:35:43 2002
@@ -122,7 +122,7 @@
 		do {
 			if (!buffer_uptodate(tmp)) {
 				memset(address, 0, tmp->b_size);
-				mark_buffer_uptodate(tmp, 1);
+				set_buffer_uptodate(tmp);
 			}
 			address += tmp->b_size;
 			tmp = tmp->b_this_page;

On 05/03, Shawn said something like:
> Searched the archives, and didn't find anything.

...

> make CFLAGS="-D__KERNEL__ -I/usr/src/2.5/linux-2.5.12/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon  " -C  arch/i386/lib
> make[1]: Entering directory `/usr/src/2.5/linux-2.5.12/arch/i386/lib'
> make all_targets
> make[2]: Entering directory `/usr/src/2.5/linux-2.5.12/arch/i386/lib'
> make[2]: Nothing to be done for `all_targets'.
> make[2]: Leaving directory `/usr/src/2.5/linux-2.5.12/arch/i386/lib'
> make[1]: Leaving directory `/usr/src/2.5/linux-2.5.12/arch/i386/lib'
> ld -m elf_i386 -T /usr/src/2.5/linux-2.5.12/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
> 	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
> 	/usr/src/2.5/linux-2.5.12/arch/i386/lib/lib.a /usr/src/2.5/linux-2.5.12/lib/lib.o /usr/src/2.5/linux-2.5.12/arch/i386/lib/lib.a \
> 	 drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/atm/atm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/md/mddev.o \
> 	net/network.o \
> 	--end-group \
> 	-o vmlinux
> drivers/block/block.o: In function `ramdisk_updatepage':
> drivers/block/block.o(.text+0xc514): undefined reference to `mark_buffer_uptodate'
> make: *** [vmlinux] Error 1

--
Shawn Leas
core@enodev.com

In school, every period ends with a bell.  Every sentence ends
with a period.  Every crime ends with a sentence.
						-- Stephen Wright
