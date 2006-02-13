Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWBMIrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWBMIrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWBMIrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:47:03 -0500
Received: from rzcomm22.rz.tu-bs.de ([134.169.9.68]:23425 "EHLO
	rzcomm22.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id S1751354AbWBMIrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:47:01 -0500
Message-ID: <43F04780.7020605@l4x.org>
Date: Mon, 13 Feb 2006 09:46:56 +0100
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc3
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The most user-visible one (eventually) is the unshare() system call, which 
> glibc wanted. Along with some fixes for fstatat() (use the proper 64-bit 
> interfaces, not the "newer old" one).

This breaks compilation on 3 archs compared to -rc2:

- mips: broke
     AR      arch/mips/lib-32/lib.a
     GEN     .version
     CHK     include/linux/compile.h
     UPD     include/linux/compile.h
     CC      init/version.o
     LD      init/built-in.o
     LD      .tmp_vmlinux1
   arch/mips/kernel/built-in.o(.text+0x9820): In function `einval':
   /usr/src/ctest/rc/kernel/arch/mips/kernel/scall32-o32.S: undefined reference to `sys_newfstatat'
   make[1]: *** [.tmp_vmlinux1] Error 1
   make: *** [cdbuilddir] Error 2


   Details: http://l4x.org/k/?d=10888

- sparc: broke
     SYSMAP  System.map
     SYSMAP  .tmp_System.map
     HOSTCC  arch/sparc/boot/btfixupprep
     BTFIX   arch/sparc/boot/btfix.S
     AS      arch/sparc/boot/btfix.o
     LD      arch/sparc/boot/image
   arch/sparc/kernel/built-in.o(.data+0x794): In function `sys_call_table':
   : undefined reference to `sys_newfstatat'
   make[2]: *** [arch/sparc/boot/image] Error 1
   make[1]: *** [image] Error 2
   make: *** [cdbuilddir] Error 2


   Details: http://l4x.org/k/?d=10897

- sparc64: broke
     AR      arch/sparc64/lib/lib.a
     GEN     .version
     CHK     include/linux/compile.h
     UPD     include/linux/compile.h
     CC      init/version.o
     LD      init/built-in.o
     LD      .tmp_vmlinux1
   arch/sparc64/kernel/head.o(.text+0xe78): In function `sys_call_table':
   /usr/src/ctest/rc/kernel/arch/sparc64/kernel/head.S: undefined reference to `sys_newfstatat'
   make[1]: *** [.tmp_vmlinux1] Error 1
   make: *** [cdbuilddir] Error 2


   Details: http://l4x.org/k/?d=10898

Jan
