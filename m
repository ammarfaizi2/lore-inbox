Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269566AbUHZUDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269566AbUHZUDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269266AbUHZT7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:59:04 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:54353 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269526AbUHZTzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:55:46 -0400
Date: Thu, 26 Aug 2004 21:56:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel-image-2.6.7
Message-ID: <20040826195643.GI9539@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	"Christian T. Steigies" <cts@debian.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20040809073126.GA4669@skeeve> <Pine.LNX.4.58.0408221129590.25793@anakin> <Pine.LNX.4.58.0408221145090.25793@anakin> <20040822101914.GA7480@skeeve> <Pine.GSO.4.58.0408221224310.12638@waterleaf.sonytel.be> <Pine.LNX.4.58.0408221333460.13834@anakin> <4128C3F4.6070507@linux-m68k.org> <Pine.GSO.4.58.0408230947190.29370@waterleaf.sonytel.be> <Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 10:50:36PM +0200, Geert Uytterhoeven wrote:
 
> Indeed, in arch/m68k/kernel/setup.o .bss and .init.data become zero-sized,
> while all other sections have the same size.
Not good.. Se below.

> 
> If I do `make V=1 arch/m68k/kernel/setup.o', I get:
> 
> | anakin$ make V=1 arch/m68k/kernel/setup.o
> | make -C /home/geert/linux/testing/linux-m68k-2.6.9-rc1 O=/home/geert/linux/testing/linux-m68k-2.6.x-amiga-mod arch/m68k/kernel/setup.o
> | make -C /home/geert/linux/testing/linux-m68k-2.6.x-amiga-mod            \
> | KBUILD_SRC=/home/geert/linux/testing/linux-m68k-2.6.9-rc1            KBUILD_VERBOSE=1   \
> | KBUILD_CHECK= KBUILD_EXTMOD=""  \
> |         -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/Makefile arch/m68k/kernel/setup.o
> | make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts/basic
> | make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts
> | make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts/genksyms
> | make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts/mod
> | make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=arch/m68k/kernel arch/m68k/kernel/setup.o
> |   m68k-linux-gcc -Wp,-MD,arch/m68k/kernel/.setup.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/geert/linux/testing/linux-m68k-2.6.9-rc1/include -I/home/geert/linux/testing/linux-m68k-2.6.9-rc1/arch/m68k/kernel -Iarch/m68k/kernel -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -fno-strength-reduce -ffixed-a2 -m68040 -O2 -fomit-frame-pointer  -DKBUILD_BASENAME=setup -DKBUILD_MODNAME=setup -c -o arch/m68k/kernel/.tmp_setup.o /home/geert/linux/testing/linux-m68k-2.6.9-rc1/arch/m68k/kernel/setup.c
> | anakin$
> 
> Note that according to the last line, m68k-linux-gcc will store its output in
> arch/m68k/kernel/.tmp_setup.o instead of arch/m68k/kernel/setup.o! But
> afterwards there is no arch/m68k/kernel/.tmp_setup.o, only
> arch/m68k/kernel/setup.o?
> 
> If I execute the m68k-linux-gcc command by hand, it does create
> arch/m68k/kernel/.tmp_setup.o, and ... surprise! The sizes of the .bss and .init.data sections in that file are correct:
> 
> | anakin$ m68k-linux-objdump -h arch/m68k/kernel/.tmp_setup.o
> |
> | arch/m68k/kernel/.tmp_setup.o:     file format elf32-m68k
> |
> | Sections:
> | Idx Name          Size      VMA       LMA       File off  Algn
> |   0 .text         0000024a  00000000  00000000  00000034  2**2
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> |   1 .data         0000001a  00000000  00000000  00000280  2**2
> |                   CONTENTS, ALLOC, LOAD, RELOC, DATA
> |   2 .bss          00000188  00000000  00000000  0000029c  2**2
>                     ^^^^^^^^
> |                   ALLOC
> |   3 .note         00000014  00000000  00000000  0000029c  2**0
> |                   CONTENTS, READONLY
> |   4 .init.data    00000008  00000000  00000000  000002b0  2**1
>                     ^^^^^^^^
> |                   CONTENTS, ALLOC, LOAD, DATA
> |   5 __kcrctab     00000004  00000000  00000000  000002b8  2**1
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> |   6 __ksymtab_strings 0000000f  00000000  00000000  000002bc  2**0
> |                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> |   7 __ksymtab     00000008  00000000  00000000  000002cc  2**1
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> |   8 .rodata       00000256  00000000  00000000  000002d4  2**0
> |                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> |   9 .init.text    00000396  00000000  00000000  0000052a  2**1
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> |  10 .comment      0000002f  00000000  00000000  000008c0  2**0
> |                   CONTENTS, READONLY
> | anakin$
> 
> while .bss and .init.data are of size zero in arch/m68k/kernel/setup.o:
> 
> | anakin$ m68k-linux-objdump -h arch/m68k/kernel/setup.o
> |
> | arch/m68k/kernel/setup.o:     file format elf32-m68k
> |
> | Sections:
> | Idx Name          Size      VMA       LMA       File off  Algn
> |   0 .text         0000024a  00000000  00000000  00000034  2**2
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> |   1 __kcrctab     00000004  00000000  00000000  0000027e  2**1
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> |   2 __ksymtab_strings 0000000f  00000000  00000000  00000282  2**0
> |                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> |   3 __ksymtab     00000008  00000000  00000000  00000292  2**1
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> |   4 .rodata       00000256  00000000  00000000  0000029a  2**0
> |                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> |   5 .init.text    00000396  00000000  00000000  000004f0  2**1
> |                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> |   6 .data         0000001a  00000000  00000000  00000888  2**2
> |                   CONTENTS, ALLOC, LOAD, RELOC, DATA
> |   7 .bss          00000000  00000000  00000000  000008a4  2**2
>                     ^^^^^^^^
> |                   ALLOC
> |   8 .init.data    00000000  00000000  00000000  000008a4  2**1
>                     ^^^^^^^^
> |                   CONTENTS, ALLOC, LOAD, DATA
> |   9 .note         00000014  00000000  00000000  000008a4  2**0
> |                   CONTENTS, READONLY
> |  10 .comment      0000002f  00000000  00000000  000008b8  2**0
> |                   CONTENTS, READONLY
> | anakin$
> 
> Now the remaining questions are:
>   1. Why does kbuild create arch/m68k/kernel/.tmp_setup.o?
>   2. How does kbuild create setup.o from .tmp_setup.o, destroying .bss and
>      .init.data?
>   3. Why doesn't the above step show up with `make V=1'?
> 
> [ digging into scripts/Makefile.build ]
> 
> Aha, kbuild does this only if CONFIG_MODVERSIONS=y.
> 
> So it goes wrong during this step:
> 
> | m68k-linux-ld -r -o x.o arch/m68k/kernel/.tmp_setup.o -T \
> | arch/m68k/kernel/.tmp_setup.ver
> 
> | anakin$ cat arch/m68k/kernel/.tmp_setup.ver
> | __crc_mach_heartbeat = 0x39638af7 ;
> | anakin$

A bit code from Makefile.build:
cmd_modversions =						\
if ! $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
	mv $(@D)/.tmp_$(@F) $@;					\
else								\
	$(CPP) -D__GENKSYMS__ $(c_flags) $<			\
	| $(GENKSYMS)						\
	> $(@D)/.tmp_$(@F:.o=.ver);				\
								\
	$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
		-T $(@D)/.tmp_$(@F:.o=.ver);			\
	rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);	\
fi;

First part checks if there is any exported symbols - which we have in this case.
The $(CPP) and $(GENKSYMS) part finds exported symbols and creates the .ver file.
Your .ver file looked fine - so this step has succeded..
Then we do the linking.

Could you try to stuff in an echo line here - something like:
	echo  $(LD) $(LDFLAGS) 					\
        $(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F)              \
                -T $(@D)/.tmp_$(@F:.o=.ver);                    \

Just to be confirmed that there is no LDFLAGS that fouls us here.

Otherwise I have no good suggestions.

	Sam
