Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSKEAeX>; Mon, 4 Nov 2002 19:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263277AbSKEAeX>; Mon, 4 Nov 2002 19:34:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56560 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263270AbSKEAeV>;
	Mon, 4 Nov 2002 19:34:21 -0500
Message-ID: <3DC71375.F92D0F5B@mvista.com>
Date: Mon, 04 Nov 2002 16:40:21 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Dave Kleikamp <shaggy@shaggy.austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
References: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com> <20021105001031.GA3348@fs.tum.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   /usr/src/hardhat/devkit/x86/pentium3/bin/pentium3-ld -m
elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/do_mounts.o init/initramfs.o
make -f scripts/Makefile.build obj=usr
  gcc -Wp,-MD,usr/.gen_init_cpio.d -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer   -o usr/gen_init_cpio
usr/gen_init_cpio.c
( cd usr ; ./gen_init_cpio | gzip -9c >
initramfs_data.cpio.gz )
/usr/src/hardhat/devkit/x86/pentium3/bin/pentium3-objcopy -I
binary -O elf32-i386 -B i386 \
	--rename-section .data=.init.initramfs \
	usr/initramfs_data.cpio.gz usr/initramfs_data.o
/usr/src/hardhat/devkit/x86/pentium3/bin/pentium3-objcopy:
invalid option -- B
Usage:
/usr/src/hardhat/devkit/x86/pentium3/bin/pentium3-objcopy
<switches> in-file [out-file]
 The switches are:
  -I --input-target <bfdname>      Assume input file is in
format <bfdname>
  -O --output-target <bfdname>     Create an output file in
format <bfdname>
  -F --target <bfdname>            Set both input and output
format to <bfdname>
     --debugging                   Convert debugging
information, if possible
  -p --preserve-dates              Copy modified/access
timestamps to the output
  -j --only-section <name>         Only copy section <name>
into the output
  -R --remove-section <name>       Remove section <name>
from the output
  -S --strip-all                   Remove all symbol and
relocation information
  -g --strip-debug                 Remove all debugging
symbols
     --strip-unneeded              Remove all symbols not
needed by relocations
  -N --strip-symbol <name>         Do not copy symbol <name>
  -K --keep-symbol <name>          Only copy symbol <name>
  -L --localize-symbol <name>      Force symbol <name> to be
marked as a local
  -W --weaken-symbol <name>        Force symbol <name> to be
marked as a weak
     --weaken                      Force all global symbols
to be marked as weak
  -x --discard-all                 Remove all non-global
symbols
  -X --discard-locals              Remove any
compiler-generated symbols
  -i --interleave <number>         Only copy one out of
every <number> bytes
  -b --byte <num>                  Select byte <num> in
every interleaved block
     --gap-fill <val>              Fill gaps between
sections with <val>
     --pad-to <addr>               Pad the last section up
to address <addr>
     --set-start <addr>            Set the start address to
<addr>
    {--change-start|--adjust-start} <incr>
                                   Add <incr> to the start
address
    {--change-addresses|--adjust-vma} <incr>
                                   Add <incr> to LMA, VMA
and start addresses
    {--change-section-address|--adjust-section-vma}
<name>{=|+|-}<val>
                                   Change LMA and VMA of
section <name> by <val>
     --change-section-lma <name>{=|+|-}<val>
                                   Change the LMA of section
<name> by <val>
     --change-section-vma <name>{=|+|-}<val>
                                   Change the VMA of section
<name> by <val>
    {--[no-]change-warnings|--[no-]adjust-warnings}
                                   Warn if a named section
does not exist
     --set-section-flags <name>=<flags>
                                   Set section <name>'s
properties to <flags>
     --add-section <name>=<file>   Add section <name> found
in <file> to output
     --change-leading-char         Force output format's
leading character style
     --remove-leading-char         Remove leading character
from global symbols
     --redefine-sym <old>=<new>    Redefine symbol name
<old> to <new>
     --srec-len <number>           Restrict the length of
generated Srecords
     --srec-forceS3                Restrict the type of
generated Srecords to S3
  -v --verbose                     List all object files
modified
  -V --version                     Display this program's
version number
  -h --help                        Display this output
/usr/src/hardhat/devkit/x86/pentium3/bin/pentium3-objcopy:
supported targets: elf32-i386 a.out-i386-linux efi-app-ia32
elf32-little elf32-big srec symbolsrec tekhex binary ihex
make[1]: *** [usr/initramfs_data.o] Error 1
make: *** [usr] Error 2

It seems that CONFIG_RAMFS is on and without a prompt string
it can not be changed:

--- /usr/src/linux-2.5.46-hrposix/fs/Kconfig~	Mon Nov  4
16:39:26 2002
+++ /usr/src/linux-2.5.46-hrposix/fs/Kconfig	Mon Nov  4
16:34:12 2002
@@ -588,7 +588,7 @@
 	  See <file:Documentation/filesystems/tmpfs.txt> for
details.
 
 config RAMFS
-	bool
+	bool "Ram file system"
 	default y
 	---help---
 	  Ramfs is a file system which keeps all files in RAM. It
allows

Does NOT fix the problem, but does allow you to side step it
:)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
