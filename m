Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbTDLNEA (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 09:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTDLNEA (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 09:04:00 -0400
Received: from [62.75.136.201] ([62.75.136.201]:63370 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263265AbTDLND6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 09:03:58 -0400
Message-ID: <3E98117F.8090705@g-house.de>
Date: Sat, 12 Apr 2003 15:15:43 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030312
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: >=2.5.66 compiling errors on Alpha
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i don't know if it a known issue but perhaps this helps to find out.
i was able to compile 2.5.65 with gcc version 2.95.4 on an Alpha 
EV45/Avtanti and it is running quite stable.

but compiling a 2.5.66 or 2.5.67 fails with gcc (GCC) 3.2.3 20030309 :

(before patching i always do "make clean". patches applied with no 
errors. same config used.)

-----
lila:/usr/src/linux-2.5.x# export LANG=C
lila:/usr/src/linux-2.5.x# make vmlinux
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=arch/alpha/kernel 
arch/alpha/kernel/asm-offsets.s
make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make -f scripts/Makefile.build obj=init
   CHK     include/linux/compile.h
make -f scripts/Makefile.build obj=usr
make -f scripts/Makefile.build obj=arch/alpha/kernel
make -f scripts/Makefile.build obj=arch/alpha/mm
make -f scripts/Makefile.build obj=arch/alpha/math-emu
make -f scripts/Makefile.build obj=kernel
   gcc -Wp,-MD,kernel/.sys.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mno-fp-regs -ffixed-8 -msmall-data -mcpu=ev4 -Wa,-mev6 
-fomit-frame-pointer -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=sys -DKBUILD_MODNAME=sys -c -o kernel/sys.o kernel/sys.c
kernel/sys.c:226: conflicting types for `sys_sendmsg'
include/linux/socket.h:245: previous declaration of `sys_sendmsg'
kernel/sys.c:227: conflicting types for `sys_recvmsg'
include/linux/socket.h:246: previous declaration of `sys_recvmsg'
make[1]: *** [kernel/sys.o] Error 1
make: *** [kernel] Error 2
lila:/usr/src/linux-2.5.x#
----

do you need further infos to debug this?
compiling a kernel on this machine is very slow, i think i can't take 
the "BUG-HUNTING" approach.

Thank you,
Christian.

