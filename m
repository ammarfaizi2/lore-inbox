Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVARPap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVARPap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVARPao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:30:44 -0500
Received: from [193.120.144.98] ([193.120.144.98]:53209 "EHLO europlex.ie")
	by vger.kernel.org with ESMTP id S261316AbVARPa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:30:26 -0500
Message-ID: <41ED2DAC.5030209@eircom.net>
Date: Tue, 18 Jan 2005 15:39:24 +0000
From: "Bryan O'Donoghue" <typedef@eircom.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppc32 2.6.x builds for ppc m8xx arch.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2005 15:34:28.0890 (UTC) FILETIME=[32D1E7A0:01C4FD73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings list.

I'm curious about something which looks like an error in the mpc8xx 
build of the latest 2.6.11-rc1 kernel.

Firstly, I have a 2.4.28-rc1 which builds just fine for this arch, 
however from an almost totally similar kernel config as was used in the 
2.4, and with the same compiler, the 2.6 build gives a (bad insturction 
?) error when attempting to execute the resulting zImage.elf from a 2.6 
build.



Looking at the difference between the 2.4 and the 2.6 build arguments.

powerpc-linux-gcc -D__KERNEL__ 
-I/home/kernels/2.4.28-pre/vanilla/linux-2.4.28-rc3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer 
-I/home/kernels/2.4.28-pre/vanilla/linux-2.4.28-rc3/arch/ppc 
-fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
-mmultiple -mstring -mcpu=860 -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=uart -c -o uart.o uart.c


powerpc-linux-gcc -m32 -Wp,-MD,scripts/mod/.empty.o.d -nostdinc -isystem 
/usr/local/powerpc/lib/gcc/powerpc-linux/3.4.2/include -D__KERNEL__ 
-Iinclude -Iarch/ppc -Wall -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-aliasing -fno-common -ffreestanding -O2 -fomit-frame-pointer 
-Iarch/ppc -msoft-float -pipe -ffixed-r2 -mmultiple -mstring 
-Wdeclaration-after-statement -DKBUILD_BASENAME=empty 
-DKBUILD_MODNAME=empty -c -o scripts/mod/.tmp_empty.o scripts/mod/empty.c
scripts/mod/mk_elfconfig ppc < scripts/mod/empty.o > scripts/mod/elfconfig.h

I notice that for a start -m32 has appeared out of nowhere and 
furthermore -mcpu=860 has gone away.

Is this actually correct ? I have specified that the arch should be 8xx 
in menuconfig.

My build command is make ARCH=ppc CROSS_COMPILE=powerpc-linux- V=1
yet still shouldn't mcpu=860, be present in the 2.6 compile arguments?

It _is_ the case that the 2.4.x in question had some modification 
initially by the PCB vendor to make Linux talk to specific settings for 
their hardware, but, I've found these differences between the vanilla 
2.4.27 and the vendor modified 2.4.27.. and can reliably get 2.4.x 
booting on this PCB, however 2.6.x won't work.

After applying a 2.6 version of the patches that should be applied to a 
2.4.x, I get a boot error... what I'd like to be able to do is verify 
that the above 2.6 compile arguments are _not_ the source of the boot 
error, so that I can focus on finding the difference between the 2.4 
build and 2.6 build in terms of necessary patching to make things boot.

So essentially, I'd like to ask the list if the specified compile 
arguments above are correct for the targetted architecture "mpc860", so 
that I can rule it out of my boot error, or perhaps fix said compile 
arguments and send a patch ?

root@bimbette:~# powerpc-linux-gcc -v 

Reading specs from /usr/local/powerpc/lib/gcc/powerpc-linux/3.4.2/specs
Configured with: ../configure --target=powerpc-linux 
--prefix=/usr/local/powerpc 
--with-as=/usr/local/powerpc/bin/powerpc-linux-as 
--with-ld=/usr/local/powerpc/bin/powerpc-linux-ld 
--enable-languages=c,c++,java --enable-long-long --with-newlib 
--with-headers=/root/crossbuild/gcc-3.4.x/toolchain_powerpc/powerpc-linux-uclibc/sys-include 
--with-libs=/root/crossbuild/gcc-3.4.x/toolchain_powerpc/powerpc-linux-uclibc/lib 
--with-ecos --disable-werror --enable-threads=posix : (reconfigured) 
../configure --target=powerpc-linux --prefix=/usr/local/powerpc 
--with-as=/usr/local/powerpc/bin/powerpc-linux-as 
--with-ld=/usr/local/powerpc/bin/powerpc-linux-ld --enable-languages=c 
--enable-long-long --with-newlib 
--with-headers=/root/crossbuild/gcc-3.4.x/toolchain_powerpc/powerpc-linux-uclibc/sys-include 
--with-libs=/root/crossbuild/gcc-3.4.x/toolchain_powerpc/powerpc-linux-uclibc/lib 
--with-ecos --disable-werror --enable-threads=posix
Thread model: posix
gcc version 3.4.2

Best
Bryan


