Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTK2Bre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 20:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTK2Bre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 20:47:34 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:12528 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S263595AbTK2BrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 20:47:17 -0500
Message-ID: <046b01c3b61a$b47ea730$02c8a8c0@steinman>
Reply-To: "Adam Kropelin" <akropel1@rochester.rr.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Cc: "Burton Windle" <bwindle@fint.org>
References: <02d801c3b474$e09e42a0$02c8a8c0@steinman> <200311282126.59634.sam@ravnborg.org>
Subject: Re: Parallel build not working since -test6?
Date: Fri, 28 Nov 2003 20:47:10 -0500
Organization: Kroptech
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0468_01C3B5F0.CB873480"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0468_01C3B5F0.CB873480
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Sam Ravnborg <sam@ravnborg.org> wrote:
> On Thursday 27 November 2003 00:27, Adam Kropelin wrote:
>> Lately I've noticed my kernel compilations taking longer than usual.
>> Tonight I finally realized the cause... Parallel building (i.e. make
>> -jN) is no longer working for me. I traced it back and the last
>> kernel it worked in was -test5. It ceased working in -test6.
> It works for me, and for sure it works for most others. Otherwise I
> would have seen lot of complaints like yours.
> I recall one similar post, and the person in question used a homegrown
> script that caused the problems.
>
> Could you try to post:
> a) Exact command used when building the kernel.

make oldconfig
make -j2 install

(Also tried 'make -j2 bzImage' with no change in behavior observed.)

I always do this directly from the command line, no special scripts.

> b) Output of kernel compile [first 100 lines] after a make clean

Attached since I'm sure this mail client will wrap it horribly otherwise. I
enabled verbose mode for the capture since I figured you probably wanted all
the details you could get. This particular compile is for -test6, the first
non-working version.

An additional item I just noticed...I do see 2 parallel builds for the very
first part of the  session (when various items in the scripts/ directory are
being compiled).  As soon as the scripts/ directory is finished, I only see
one process and my idle cpu usage jumps to about 40% (from 0%).

I'm happy to try anything else you wish...

--Adam

------=_NextPart_000_0468_01C3B5F0.CB873480
Content-Type: application/octet-stream;
	name="compile.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="compile.out"

make -f scripts/Makefile.build obj=3Dscripts=0A=
  gcc -Wp,-MD,scripts/.fixdep.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/fixdep scripts/fixdep.c=0A=
  gcc -Wp,-MD,scripts/.split-include.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/split-include =
scripts/split-include.c=0A=
  gcc -Wp,-MD,scripts/.conmakehash.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/conmakehash scripts/conmakehash.c=0A=
  gcc -Wp,-MD,scripts/.docproc.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/docproc scripts/docproc.c=0A=
  gcc -Wp,-MD,scripts/.kallsyms.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/kallsyms scripts/kallsyms.c=0A=
  gcc -Wp,-MD,scripts/.empty.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dempty -DKBUILD_MODNAME=3Dempty -c -o scripts/empty.o =
scripts/empty.c=0A=
  gcc -Wp,-MD,scripts/.mk_elfconfig.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/mk_elfconfig =
scripts/mk_elfconfig.c=0A=
  gcc -Wp,-MD,scripts/.pnmtologo.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/pnmtologo scripts/pnmtologo.c=0A=
  gcc -Wp,-MD,scripts/.bin2c.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o scripts/bin2c scripts/bin2c.c=0A=
  scripts/mk_elfconfig i386 < scripts/empty.o > scripts/elfconfig.h=0A=
  gcc -Wp,-MD,scripts/.file2alias.o.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer       -c -o scripts/file2alias.o =
scripts/file2alias.c=0A=
  gcc -Wp,-MD,scripts/.modpost.o.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer       -c -o scripts/modpost.o scripts/modpost.c=0A=
  gcc  -o scripts/modpost scripts/modpost.o scripts/file2alias.o  =0A=
  SPLIT   include/linux/autoconf.h -> include/config/*=0A=
mkdir -p .tmp_versions=0A=
make -f scripts/Makefile.build obj=3Darch/i386/kernel =
arch/i386/kernel/asm-offsets.s=0A=
  gcc -Wp,-MD,arch/i386/kernel/.asm-offsets.s.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dasm_offsets -DKBUILD_MODNAME=3Dasm_offsets -S -o =
arch/i386/kernel/asm-offsets.s arch/i386/kernel/asm-offsets.c =0A=
  CHK     include/asm-i386/asm_offsets.h=0A=
  UPD     include/asm-i386/asm_offsets.h=0A=
make -f scripts/Makefile.build obj=3Dinit=0A=
  gcc -Wp,-MD,init/.main.o.d -nostdinc -iwithprefix include -D__KERNEL__ =
-Iinclude  -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes =
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe =
-mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dmain -DKBUILD_MODNAME=3Dmain -c -o init/main.o =
init/main.c=0A=
  CHK     include/linux/compile.h=0A=
  UPD     include/linux/compile.h=0A=
  gcc -Wp,-MD,init/.do_mounts.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Ddo_mounts -DKBUILD_MODNAME=3Dmounts -c -o =
init/do_mounts.o init/do_mounts.c=0A=
  gcc -Wp,-MD,init/.do_mounts_md.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Ddo_mounts_md -DKBUILD_MODNAME=3Dmounts -c -o =
init/do_mounts_md.o init/do_mounts_md.c=0A=
  gcc -Wp,-MD,init/.initramfs.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dinitramfs -DKBUILD_MODNAME=3Dinitramfs -c -o =
init/initramfs.o init/initramfs.c=0A=
  gcc -Wp,-MD,init/.version.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dversion -DKBUILD_MODNAME=3Dversion -c -o =
init/version.o init/version.c=0A=
  ld -m elf_i386  -r -o init/mounts.o init/do_mounts.o =
init/do_mounts_md.o=0A=
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o =
init/mounts.o init/initramfs.o=0A=
make -f scripts/Makefile.build obj=3Dusr=0A=
  gcc -Wp,-MD,usr/.gen_init_cpio.d -Wall -Wstrict-prototypes -O2 =
-fomit-frame-pointer        -o usr/gen_init_cpio usr/gen_init_cpio.c=0A=
  ./usr/gen_init_cpio > usr/initramfs_data.cpio=0A=
  gzip -f -9 < usr/initramfs_data.cpio > usr/initramfs_data.cpio.gz=0A=
  gcc -Wp,-MD,usr/.initramfs_data.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ =
-Iinclude/asm-i386/mach-default    -c -o usr/initramfs_data.o =
usr/initramfs_data.S=0A=
   ld -m elf_i386  -r -o usr/built-in.o usr/initramfs_data.o=0A=
make -f scripts/Makefile.build obj=3Darch/i386/kernel=0A=
  gcc -Wp,-MD,arch/i386/kernel/.process.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dprocess -DKBUILD_MODNAME=3Dprocess -c -o =
arch/i386/kernel/process.o arch/i386/kernel/process.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.semaphore.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dsemaphore -DKBUILD_MODNAME=3Dsemaphore -c -o =
arch/i386/kernel/semaphore.o arch/i386/kernel/semaphore.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.signal.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dsignal -DKBUILD_MODNAME=3Dsignal -c -o =
arch/i386/kernel/signal.o arch/i386/kernel/signal.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.entry.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ =
-Iinclude/asm-i386/mach-default -traditional   -c -o =
arch/i386/kernel/entry.o arch/i386/kernel/entry.S=0A=
  gcc -Wp,-MD,arch/i386/kernel/.traps.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dtraps -DKBUILD_MODNAME=3Dtraps -c -o =
arch/i386/kernel/traps.o arch/i386/kernel/traps.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.irq.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dirq -DKBUILD_MODNAME=3Dirq -c -o =
arch/i386/kernel/irq.o arch/i386/kernel/irq.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.vm86.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dvm86 -DKBUILD_MODNAME=3Dvm86 -c -o =
arch/i386/kernel/vm86.o arch/i386/kernel/vm86.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.ptrace.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dptrace -DKBUILD_MODNAME=3Dptrace -c -o =
arch/i386/kernel/ptrace.o arch/i386/kernel/ptrace.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.i8259.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Di8259 -DKBUILD_MODNAME=3Di8259 -c -o =
arch/i386/kernel/i8259.o arch/i386/kernel/i8259.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.ioport.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dioport -DKBUILD_MODNAME=3Dioport -c -o =
arch/i386/kernel/ioport.o arch/i386/kernel/ioport.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.ldt.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dldt -DKBUILD_MODNAME=3Dldt -c -o =
arch/i386/kernel/ldt.o arch/i386/kernel/ldt.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.setup.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dsetup -DKBUILD_MODNAME=3Dsetup -c -o =
arch/i386/kernel/setup.o arch/i386/kernel/setup.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.time.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dtime -DKBUILD_MODNAME=3Dtime -c -o =
arch/i386/kernel/time.o arch/i386/kernel/time.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.sys_i386.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dsys_i386 -DKBUILD_MODNAME=3Dsys_i386 -c -o =
arch/i386/kernel/sys_i386.o arch/i386/kernel/sys_i386.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.pci-dma.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dpci_dma -DKBUILD_MODNAME=3Dpci_dma -c -o =
arch/i386/kernel/pci-dma.o arch/i386/kernel/pci-dma.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.i386_ksyms.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Di386_ksyms -DKBUILD_MODNAME=3Di386_ksyms -c -o =
arch/i386/kernel/i386_ksyms.o arch/i386/kernel/i386_ksyms.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.i387.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Di387 -DKBUILD_MODNAME=3Di387 -c -o =
arch/i386/kernel/i387.o arch/i386/kernel/i387.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.dmi_scan.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Ddmi_scan -DKBUILD_MODNAME=3Ddmi_scan -c -o =
arch/i386/kernel/dmi_scan.o arch/i386/kernel/dmi_scan.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.bootflag.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dbootflag -DKBUILD_MODNAME=3Dbootflag -c -o =
arch/i386/kernel/bootflag.o arch/i386/kernel/bootflag.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.doublefault.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Ddoublefault -DKBUILD_MODNAME=3Ddoublefault -c -o =
arch/i386/kernel/doublefault.o arch/i386/kernel/doublefault.c=0A=
make -f scripts/Makefile.build obj=3Darch/i386/kernel/acpi=0A=
  gcc -Wp,-MD,arch/i386/kernel/acpi/.boot.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dboot -DKBUILD_MODNAME=3Dboot -c -o =
arch/i386/kernel/acpi/boot.o arch/i386/kernel/acpi/boot.c=0A=
   ld -m elf_i386  -r -o arch/i386/kernel/acpi/built-in.o =
arch/i386/kernel/acpi/boot.o=0A=
make -f scripts/Makefile.build obj=3Darch/i386/kernel/cpu=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.common.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dcommon -DKBUILD_MODNAME=3Dcommon -c -o =
arch/i386/kernel/cpu/common.o arch/i386/kernel/cpu/common.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.proc.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dproc -DKBUILD_MODNAME=3Dproc -c -o =
arch/i386/kernel/cpu/proc.o arch/i386/kernel/cpu/proc.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.amd.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Damd -DKBUILD_MODNAME=3Damd -c -o =
arch/i386/kernel/cpu/amd.o arch/i386/kernel/cpu/amd.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.cyrix.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dcyrix -DKBUILD_MODNAME=3Dcyrix -c -o =
arch/i386/kernel/cpu/cyrix.o arch/i386/kernel/cpu/cyrix.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.centaur.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dcentaur -DKBUILD_MODNAME=3Dcentaur -c -o =
arch/i386/kernel/cpu/centaur.o arch/i386/kernel/cpu/centaur.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.transmeta.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dtransmeta -DKBUILD_MODNAME=3Dtransmeta -c -o =
arch/i386/kernel/cpu/transmeta.o arch/i386/kernel/cpu/transmeta.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.intel.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dintel -DKBUILD_MODNAME=3Dintel -c -o =
arch/i386/kernel/cpu/intel.o arch/i386/kernel/cpu/intel.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.rise.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Drise -DKBUILD_MODNAME=3Drise -c -o =
arch/i386/kernel/cpu/rise.o arch/i386/kernel/cpu/rise.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.nexgen.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dnexgen -DKBUILD_MODNAME=3Dnexgen -c -o =
arch/i386/kernel/cpu/nexgen.o arch/i386/kernel/cpu/nexgen.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/.umc.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dumc -DKBUILD_MODNAME=3Dumc -c -o =
arch/i386/kernel/cpu/umc.o arch/i386/kernel/cpu/umc.c=0A=
make -f scripts/Makefile.build obj=3Darch/i386/kernel/cpu/mtrr=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.main.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dmain -DKBUILD_MODNAME=3Dmain -c -o =
arch/i386/kernel/cpu/mtrr/main.o arch/i386/kernel/cpu/mtrr/main.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.if.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dif -DKBUILD_MODNAME=3Dif -c -o =
arch/i386/kernel/cpu/mtrr/if.o arch/i386/kernel/cpu/mtrr/if.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.generic.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dgeneric -DKBUILD_MODNAME=3Dgeneric -c -o =
arch/i386/kernel/cpu/mtrr/generic.o arch/i386/kernel/cpu/mtrr/generic.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.state.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dstate -DKBUILD_MODNAME=3Dstate -c -o =
arch/i386/kernel/cpu/mtrr/state.o arch/i386/kernel/cpu/mtrr/state.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.amd.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Damd -DKBUILD_MODNAME=3Damd -c -o =
arch/i386/kernel/cpu/mtrr/amd.o arch/i386/kernel/cpu/mtrr/amd.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.cyrix.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dcyrix -DKBUILD_MODNAME=3Dcyrix -c -o =
arch/i386/kernel/cpu/mtrr/cyrix.o arch/i386/kernel/cpu/mtrr/cyrix.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.centaur.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dcentaur -DKBUILD_MODNAME=3Dcentaur -c -o =
arch/i386/kernel/cpu/mtrr/centaur.o arch/i386/kernel/cpu/mtrr/centaur.c=0A=
   ld -m elf_i386  -r -o arch/i386/kernel/cpu/mtrr/built-in.o =
arch/i386/kernel/cpu/mtrr/main.o arch/i386/kernel/cpu/mtrr/if.o =
arch/i386/kernel/cpu/mtrr/generic.o arch/i386/kernel/cpu/mtrr/state.o =
arch/i386/kernel/cpu/mtrr/amd.o arch/i386/kernel/cpu/mtrr/cyrix.o =
arch/i386/kernel/cpu/mtrr/centaur.o=0A=
   ld -m elf_i386  -r -o arch/i386/kernel/cpu/built-in.o =
arch/i386/kernel/cpu/common.o arch/i386/kernel/cpu/proc.o =
arch/i386/kernel/cpu/amd.o arch/i386/kernel/cpu/cyrix.o =
arch/i386/kernel/cpu/centaur.o arch/i386/kernel/cpu/transmeta.o =
arch/i386/kernel/cpu/intel.o arch/i386/kernel/cpu/rise.o =
arch/i386/kernel/cpu/nexgen.o arch/i386/kernel/cpu/umc.o =
arch/i386/kernel/cpu/mtrr/built-in.o=0A=
make -f scripts/Makefile.build obj=3Darch/i386/kernel/timers=0A=
  gcc -Wp,-MD,arch/i386/kernel/timers/.timer.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dtimer -DKBUILD_MODNAME=3Dtimer -c -o =
arch/i386/kernel/timers/timer.o arch/i386/kernel/timers/timer.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/timers/.timer_none.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dtimer_none -DKBUILD_MODNAME=3Dtimer_none -c -o =
arch/i386/kernel/timers/timer_none.o arch/i386/kernel/timers/timer_none.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/timers/.timer_tsc.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dtimer_tsc -DKBUILD_MODNAME=3Dtimer_tsc -c -o =
arch/i386/kernel/timers/timer_tsc.o arch/i386/kernel/timers/timer_tsc.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/timers/.timer_pit.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dtimer_pit -DKBUILD_MODNAME=3Dtimer_pit -c -o =
arch/i386/kernel/timers/timer_pit.o arch/i386/kernel/timers/timer_pit.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/timers/.common.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dcommon -DKBUILD_MODNAME=3Dcommon -c -o =
arch/i386/kernel/timers/common.o arch/i386/kernel/timers/common.c=0A=
   ld -m elf_i386  -r -o arch/i386/kernel/timers/built-in.o =
arch/i386/kernel/timers/timer.o arch/i386/kernel/timers/timer_none.o =
arch/i386/kernel/timers/timer_tsc.o arch/i386/kernel/timers/timer_pit.o =
arch/i386/kernel/timers/common.o=0A=
  gcc -Wp,-MD,arch/i386/kernel/.reboot.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dreboot -DKBUILD_MODNAME=3Dreboot -c -o =
arch/i386/kernel/reboot.o arch/i386/kernel/reboot.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.msr.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dmsr -DKBUILD_MODNAME=3Dmsr -c -o =
arch/i386/kernel/msr.o arch/i386/kernel/msr.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.cpuid.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dcpuid -DKBUILD_MODNAME=3Dcpuid -c -o =
arch/i386/kernel/cpuid.o arch/i386/kernel/cpuid.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.smp.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dsmp -DKBUILD_MODNAME=3Dsmp -c -o =
arch/i386/kernel/smp.o arch/i386/kernel/smp.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.smpboot.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dsmpboot -DKBUILD_MODNAME=3Dsmpboot -c -o =
arch/i386/kernel/smpboot.o arch/i386/kernel/smpboot.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.trampoline.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ =
-Iinclude/asm-i386/mach-default -traditional   -c -o =
arch/i386/kernel/trampoline.o arch/i386/kernel/trampoline.S=0A=
  gcc -Wp,-MD,arch/i386/kernel/.mpparse.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dmpparse -DKBUILD_MODNAME=3Dmpparse -c -o =
arch/i386/kernel/mpparse.o arch/i386/kernel/mpparse.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.apic.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dapic -DKBUILD_MODNAME=3Dapic -c -o =
arch/i386/kernel/apic.o arch/i386/kernel/apic.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.nmi.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dnmi -DKBUILD_MODNAME=3Dnmi -c -o =
arch/i386/kernel/nmi.o arch/i386/kernel/nmi.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.io_apic.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dio_apic -DKBUILD_MODNAME=3Dio_apic -c -o =
arch/i386/kernel/io_apic.o arch/i386/kernel/io_apic.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.module.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dmodule -DKBUILD_MODNAME=3Dmodule -c -o =
arch/i386/kernel/module.o arch/i386/kernel/module.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.sysenter.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dsysenter -DKBUILD_MODNAME=3Dsysenter -c -o =
arch/i386/kernel/sysenter.o arch/i386/kernel/sysenter.c=0A=
  gcc -Wp,-MD,arch/i386/kernel/.vsyscall-int80.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-D__ASSEMBLY__ -Iinclude/asm-i386/mach-default -traditional   -c -o =
arch/i386/kernel/vsyscall-int80.o arch/i386/kernel/vsyscall-int80.S=0A=
  gcc -Wp,-MD,arch/i386/kernel/.vsyscall-sysenter.o.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-D__ASSEMBLY__ -Iinclude/asm-i386/mach-default -traditional   -c -o =
arch/i386/kernel/vsyscall-sysenter.o arch/i386/kernel/vsyscall-sysenter.S=0A=
  gcc -Wp,-MD,arch/i386/kernel/.head.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ =
-Iinclude/asm-i386/mach-default -traditional   -c -o =
arch/i386/kernel/head.o arch/i386/kernel/head.S=0A=
  gcc -Wp,-MD,arch/i386/kernel/.init_task.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dinit_task -DKBUILD_MODNAME=3Dinit_task -c -o =
arch/i386/kernel/init_task.o arch/i386/kernel/init_task.c=0A=
  gcc -E -Wp,-MD,arch/i386/kernel/.vmlinux.lds.s.d -nostdinc =
-iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  =
-D__ASSEMBLY__ -Iinclude/asm-i386/mach-default -traditional -P -C -Ui386 =
   -o arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/vmlinux.lds.S =0A=
  gcc -nostdlib -shared -s -Wl,-soname=3Dlinux-gate.so.1 =
-Wl,-T,arch/i386/kernel/vsyscall.lds arch/i386/kernel/vsyscall-int80.o =
-o arch/i386/kernel/vsyscall-int80.so=0A=
  gcc -nostdlib -shared -s -Wl,-soname=3Dlinux-gate.so.1 =
-Wl,-T,arch/i386/kernel/vsyscall.lds =
arch/i386/kernel/vsyscall-sysenter.o -o =
arch/i386/kernel/vsyscall-sysenter.so=0A=
  gcc -nostdlib -r -Wl,-T,arch/i386/kernel/vsyscall.lds =
arch/i386/kernel/vsyscall-sysenter.o -o arch/i386/kernel/vsyscall-syms.o=0A=
  gcc -Wp,-MD,arch/i386/kernel/.vsyscall.o.d -nostdinc -iwithprefix =
include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ =
-Iinclude/asm-i386/mach-default -traditional   -c -o =
arch/i386/kernel/vsyscall.o arch/i386/kernel/vsyscall.S=0A=
   ld -m elf_i386  -R arch/i386/kernel/vsyscall-syms.o -r -o =
arch/i386/kernel/built-in.o arch/i386/kernel/process.o =
arch/i386/kernel/semaphore.o arch/i386/kernel/signal.o =
arch/i386/kernel/entry.o arch/i386/kernel/traps.o arch/i386/kernel/irq.o =
arch/i386/kernel/vm86.o arch/i386/kernel/ptrace.o =
arch/i386/kernel/i8259.o arch/i386/kernel/ioport.o =
arch/i386/kernel/ldt.o arch/i386/kernel/setup.o arch/i386/kernel/time.o =
arch/i386/kernel/sys_i386.o arch/i386/kernel/pci-dma.o =
arch/i386/kernel/i386_ksyms.o arch/i386/kernel/i387.o =
arch/i386/kernel/dmi_scan.o arch/i386/kernel/bootflag.o =
arch/i386/kernel/doublefault.o arch/i386/kernel/cpu/built-in.o =
arch/i386/kernel/timers/built-in.o arch/i386/kernel/acpi/built-in.o =
arch/i386/kernel/reboot.o arch/i386/kernel/msr.o =
arch/i386/kernel/cpuid.o arch/i386/kernel/smp.o =
arch/i386/kernel/smpboot.o arch/i386/kernel/trampoline.o =
arch/i386/kernel/mpparse.o arch/i386/kernel/apic.o =
arch/i386/kernel/nmi.o arch/i386/kernel/io_apic.o =
arch/i386/kernel/module.o arch/i386/kernel/sysenter.o =
arch/i386/kernel/vsyscall.o=0A=
make -f scripts/Makefile.build obj=3Darch/i386/mm=0A=
  gcc -Wp,-MD,arch/i386/mm/.init.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dinit -DKBUILD_MODNAME=3Dinit -c -o =
arch/i386/mm/init.o arch/i386/mm/init.c=0A=
  gcc -Wp,-MD,arch/i386/mm/.pgtable.o.d -nostdinc -iwithprefix include =
-D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Di686 =
-Iinclude/asm-i386/mach-default -fomit-frame-pointer     =
-DKBUILD_BASENAME=3Dpgtable -DKBUILD_MODNAME=3Dpgtable -c -o =
arch/i386/mm/pgtable.o arch/i386/mm/pgtable.c=0A=

------=_NextPart_000_0468_01C3B5F0.CB873480--

