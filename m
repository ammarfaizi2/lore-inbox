Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVAWCVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVAWCVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVAWCVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:21:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:54922 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261187AbVAWCVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:21:42 -0500
Message-ID: <41F30848.6050408@osdl.org>
Date: Sat, 22 Jan 2005 18:13:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: can't compile 2.6.11-rc2 on sparc64
References: <200501230238.55584@gj-laptop> <41F2FFBB.7020300@osdl.org> <200501230248.27332@gj-laptop>
In-Reply-To: <200501230248.27332@gj-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Piotr Jaskiewicz wrote:
> On Sunday 23 January 2005 02:36, Randy.Dunlap wrote:
> 
> 
>>Please look for another error.  Run 'make' again.
>>Those are all just warnings and don't cause a build error.
> 
> 
> all output past make:
> 
> [root@gjsparc64 linux-2.6.11-rc2]# make V=1
> if test ! /usr/src/linux-2.6.11-rc2 -ef /usr/src/linux-2.6.11-rc2; then \
> /bin/bash /usr/src/linux-2.6.11-rc2/scripts/mkmakefile              \
>     /usr/src/linux-2.6.11-rc2 /usr/src/linux-2.6.11-rc2 2 6         \
>     > /usr/src/linux-2.6.11-rc2/Makefile;                                 \
>     echo '  GEN    /usr/src/linux-2.6.11-rc2/Makefile';                   \
> fi
>   CHK     include/linux/version.h
> rm -rf .tmp_versions
> mkdir -p .tmp_versions
> make -f scripts/Makefile.build obj=scripts/basic
> make -f scripts/Makefile.build obj=scripts
> make -f scripts/Makefile.build obj=scripts/genksyms
> make -f scripts/Makefile.build obj=scripts/mod
> make -f scripts/Makefile.build obj=init
>   CHK     include/linux/compile.h
> make -f scripts/Makefile.build obj=usr
> set -e; echo '  CHK     usr/initramfs_list'; mkdir -p 
> usr/; /bin/bash /usr/src/linux-2.6.11-rc2/scripts/gen_initramfs_list.sh    > 
> usr/initramfs_list.tmp; if [ -r usr/initramfs_list ] && cmp -s 
> usr/initramfs_list usr/initramfs_list.tmp; then rm -f usr/initramfs_list.tmp; 
> else echo '  UPD     usr/initramfs_list'; mv -f usr/initramfs_list.tmp 
> usr/initramfs_list; fi
>   CHK     usr/initramfs_list
> make -f scripts/Makefile.build obj=arch/sparc64/kernel
>   /usr/bin/sparc64-pld-linux-gcc -Wp,-MD,arch/sparc64/kernel/.ioctl32.o.d 
> -nostdinc -isystem /usr/lib/gcc/sparc64-pld-linux/3.4.2/include -D__KERNEL__ 
> -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
> -fno-common -ffreestanding -O2     -fomit-frame-pointer -m64 -pipe -mno-fpu 
> -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 
> -Wno-sign-compare -Wa,--undeclared-regs -finline-limit=100000 
> -Wdeclaration-after-statement  -Werror -Ifs/  -DKBUILD_BASENAME=ioctl32 
> -DKBUILD_MODNAME=ioctl32 -c -o arch/sparc64/kernel/.tmp_ioctl32.o 
> arch/sparc64/kernel/ioctl32.c
> include/asm/uaccess.h: In function `siocdevprivate_ioctl':
> fs/compat_ioctl.c:648: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result
> fs/compat_ioctl.c: In function `put_dirent32':
> fs/compat_ioctl.c:2346: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result
> fs/compat_ioctl.c: In function `serial_struct_ioctl':
> fs/compat_ioctl.c:2489: warning: ignoring return value of `copy_from_user', 
> declared with attribute warn_unused_result
> fs/compat_ioctl.c:2502: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result
> make[1]: *** [arch/sparc64/kernel/ioctl32.o] Error 1
> make: *** [arch/sparc64/kernel] Error 2
> [root@gjsparc64 linux-2.6.11-rc2]#
> 
> I have no idea what causes error here. What shall I input to get more info 
> about that error ?

It's the '-Werror' option that makes warnings become fatal
errors that is stopping you here.  You could edit
arch/sparc64/kernel/Makefile and remove/comment that for now.


-- 
~Randy
