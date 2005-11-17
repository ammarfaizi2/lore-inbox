Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVKQUc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVKQUc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVKQUc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:32:26 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44775 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932411AbVKQUcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:32:25 -0500
Message-ID: <437CF690.5060206@free.fr>
Date: Thu, 17 Nov 2005 21:30:56 +0000
From: =?ISO-8859-1?Q?St=E9phane_BAUSSON?= <stephane.bausson@free.fr>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fail to buil linux-2.6.14
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am failing to build 2.6.14, any idea or direction for investigation ?

======================================
if test ! /usr/src/linux-2.6.14 -ef /usr/src/linux-2.6.14; then \
/bin/sh /usr/src/linux-2.6.14/scripts/mkmakefile              \
    /usr/src/linux-2.6.14 /usr/src/linux-2.6.14 2 6         \
    > /usr/src/linux-2.6.14/Makefile;                                 \
    echo '  GEN    /usr/src/linux-2.6.14/Makefile';                   \
fi
set -e; echo '  CHK     include/linux/version.h'; mkdir -p 
include/linux/;      if [ `echo -n "2.6.14.1" | wc -c ` -gt 64 ]; then 
echo '"2.6.14.1" exceeds 64 characters' >&2; exit 1; fi; (echo \#define 
UTS_RELEASE \"2.6.14.1\"; echo \#define LINUX_VERSION_CODE `expr 2 \\* 
65536 + 6 \\* 256 + 14`; echo '#define KERNEL_VERSION(a,b,c) (((a) << 
16) + ((b) << 8) + (c))'; ) < /usr/src/linux-2.6.14/Makefile > 
include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp -s 
include/linux/version.h include/linux/version.h.tmp; then rm -f 
include/linux/version.h.tmp; else echo '  UPD     
include/linux/version.h'; mv -f include/linux/version.h.tmp 
include/linux/version.h; fi
  CHK     include/linux/version.h
make -f scripts/Makefile.build obj=scripts/basic
rm -rf .tmp_versions
mkdir -p .tmp_versions
make -f scripts/Makefile.build obj=.
mkdir -p arch/i386/kernel/
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/mod
make -f scripts/Makefile.build obj=init
  CHK     include/linux/compile.h
/bin/sh /usr/src/linux-2.6.14/scripts/mkcompile_h include/linux/compile.h \
"i386" "y" "y" "gcc -m32 -Wall -Wundef -Wstrict-prototypes 
-Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     
-fomit-frame-pointer -pipe -msoft-float -mpreferred-stack-boundary=2 
-fno-unit-at-a-time -march=i686 -mtune=pentium4 
-Iinclude/asm-i386/mach-default -Wdeclaration-after-statement "
make -f scripts/Makefile.build obj=usr
set -e; echo '  CHK     usr/initramfs_list'; mkdir -p usr/; /bin/sh 
/usr/src/linux-2.6.14/scripts/gen_initramfs_list.sh   < usr/Makefile > 
usr/initramfs_list.tmp; if [ -r usr/initramfs_list ] && cmp -s 
usr/initramfs_list usr/initramfs_list.tmp; then rm -f 
usr/initramfs_list.tmp; else echo '  UPD     usr/initramfs_list'; mv -f 
usr/initramfs_list.tmp usr/initramfs_list; fi
  CHK     usr/initramfs_list
make -f scripts/Makefile.build obj=arch/i386/kernel
make -f scripts/Makefile.build obj=arch/i386/kernel/acpi
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mcheck
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mtrr
make -f scripts/Makefile.build obj=arch/i386/kernel/timers
  gcc -m32 -m elf_i386 -nostdlib -shared -s -Wl,-soname=linux-gate.so.1 
-Wl,-T,arch/i386/kernel/vsyscall.lds arch/i386/kernel/vsyscall-int80.o 
arch/i386/kernel/vsyscall-note.o -o arch/i386/kernel/vsyscall-int80.so
/local/gnu/binutils/bin/ld: section .text [ffffe400 -> ffffe45f] 
overlaps section .dynstr [ffffe17c -> ffffe9cd]
/local/gnu/binutils/bin/ld: section .note [ffffe460 -> ffffe477] 
overlaps section .dynstr [ffffe17c -> ffffe9cd]
/local/gnu/binutils/bin/ld: section .eh_frame [ffffe478 -> ffffe56b] 
overlaps section .dynstr [ffffe17c -> ffffe9cd]
/local/gnu/binutils/bin/ld: section .dynamic [ffffe56c -> ffffe5eb] 
overlaps section .dynstr [ffffe17c -> ffffe9cd]
/local/gnu/binutils/bin/ld: section .useless [ffffe5ec -> ffffe5f7] 
overlaps section .dynstr [ffffe17c -> ffffe9cd]
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.text lma 0xffffe400 overlaps previous sections
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.note lma 0xffffe460 overlaps previous sections
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.eh_frame_hdr lma 0xffffe478 overlaps previous sections
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.eh_frame lma 0xffffe49c overlaps previous sections
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.dynamic lma 0xffffe590 overlaps previous sections
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.useless lma 0xffffe610 overlaps previous sections
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.gnu.version lma 0xffffe9ce overlaps previous sections
/local/gnu/binutils/bin/ld: arch/i386/kernel/vsyscall-int80.so: section 
.gnu.version_d lma 0xffffe9e0 overlaps previous sections
collect2: ld returned 1 exit status
make[1]: *** [arch/i386/kernel/vsyscall-int80.so] Error 1
make: *** [arch/i386/kernel] Error 2


-- 
 stephane.bausson@free.fr  -  Lherm (31,France)

 
 

