Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWD1AHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWD1AHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWD1AHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:07:52 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:53257 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751689AbWD1AHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:07:51 -0400
Message-ID: <44515CCF.7040100@gmail.com>
Date: Fri, 28 Apr 2006 02:07:20 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc2-mm1 compiling problems
References: <44515A27.1060703@gmail.com>
In-Reply-To: <44515A27.1060703@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: lklm

Jiri Slaby napsal(a):
> Hello,
> 
> I have problems with compiling 2.6.17-rc2-mm1 and 2.6.17-rc1-mm3:
> $ make O=../my V=1
> make -C /l/latest/my \
> KBUILD_SRC=/l/latest/xxx \
> KBUILD_EXTMOD="" -f /l/latest/xxx/Makefile _all
> make -f /l/latest/xxx/Makefile silentoldconfig
> make -f /l/latest/xxx/scripts/Makefile.build obj=scripts/basic
> if test ! /l/latest/xxx -ef /l/latest/my; then \
> /bin/sh /l/latest/xxx/scripts/mkmakefile              \
>     /l/latest/xxx /l/latest/my 2 6         \
>     > /l/latest/my/Makefile;                                 \
>     echo '  GEN    /l/latest/my/Makefile';                   \
> fi
>   GEN    /l/latest/my/Makefile
> mkdir -p include/linux include/config
> make -f /l/latest/xxx/scripts/Makefile.build obj=scripts/kconfig silentoldconfig
> scripts/kconfig/conf -s arch/i386/Kconfig
> init/Kconfig:3: unknown option "option"
> make[3]: *** [silentoldconfig] Error 1
> make[2]: *** [silentoldconfig] Error 2
> make[1]: *** [include/config/auto.conf] Error 2
> make: *** [_all] Error 2
> 
> Then, when I delete the line, there is another problem:
> 
>   gcc -m32 -Wp,-MD,mm/.nommu.o.d  -nostdinc -isystem
> /usr/lib/gcc/i386-redhat-linux/4.1.0/include -D__KERNEL__ -Iinclude -Iinclude2
> -I/l/latest/xxx/include -include include/linux/autoconf.h -I/l/latest/xxx/mm
> -Imm -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -O2 -fomit-frame-pointer -pipe -msoft-float
> -mpreferred-stack-boundary=2 -ffreestanding
> -I/l/latest/xxx/include/asm-i386/mach-default -Iinclude/asm-i386/mach-default
> -Wdeclaration-after-statement -Wno-pointer-sign  -D"KBUILD_STR(s)=#s"
> -D"KBUILD_BASENAME=KBUILD_STR(nommu)"  -D"KBUILD_MODNAME=KBUILD_STR(nommu)" -c
> -o mm/nommu.o /l/latest/xxx/mm/nommu.c
> /l/latest/xxx/mm/nommu.c: In function ‘sys_brk’:
> /l/latest/xxx/mm/nommu.c:250: error: ‘mm_context_t’ has no member named ‘end_brk’
> /l/latest/xxx/mm/nommu.c: In function ‘do_mmap_pgoff’:
> /l/latest/xxx/mm/nommu.c:753: error: ‘struct vm_area_struct’ has no member named
> ‘vm_usage’
> /l/latest/xxx/mm/nommu.c:793: error: ‘struct vm_area_struct’ has no member named
> ‘vm_usage’
> /l/latest/xxx/mm/nommu.c:831: error: ‘mm_context_t’ has no member named ‘vmlist’
> /l/latest/xxx/mm/nommu.c:832: error: ‘mm_context_t’ has no member named ‘vmlist’
> /l/latest/xxx/mm/nommu.c: In function ‘put_vma’:
> /l/latest/xxx/mm/nommu.c:885: error: ‘struct vm_area_struct’ has no member named
> ‘vm_usage’
> /l/latest/xxx/mm/nommu.c: In function ‘do_munmap’:
> /l/latest/xxx/mm/nommu.c:920: error: ‘mm_context_t’ has no member named ‘vmlist’
> /l/latest/xxx/mm/nommu.c: In function ‘exit_mmap’:
> /l/latest/xxx/mm/nommu.c:961: error: ‘mm_context_t’ has no member named ‘vmlist’
> /l/latest/xxx/mm/nommu.c:962: error: ‘mm_context_t’ has no member named ‘vmlist’
> /l/latest/xxx/mm/nommu.c: In function ‘do_mremap’:
> /l/latest/xxx/mm/nommu.c:1015: error: ‘mm_context_t’ has no member named ‘vmlist’
> /l/latest/xxx/mm/nommu.c: In function ‘find_vma’:
> /l/latest/xxx/mm/nommu.c:1047: error: ‘mm_context_t’ has no member named ‘vmlist’
> make[2]: *** [mm/nommu.o] Error 1
> make[1]: *** [mm] Error 2
> make: *** [all] Error 2
> 
> The config is here http://www.fi.muni.cz/~xslaby/sklad/config-desk (I just did
> oldconfig from -rc1-mm2 config). It's x86.
> 
> regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
