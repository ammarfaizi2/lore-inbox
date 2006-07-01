Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWGAVZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWGAVZM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWGAVZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:25:11 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:15172 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751892AbWGAVZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:25:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sQrqbZKWfR/EUzdA2NUM591aRdZ0dyUe2ZzaOrHKXeml4akKwz9R/lZrm2wZ7nJkwxYGEbYhfg/unUtVN27n1ZvH8XTK6J1bOB+VUocIlPbysCEI04qLEOn2hXJM5hk3SjiuH/kNSXRkRx2jnyL4TONwOno74FV4rrCdrvIzW68=
Message-ID: <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
Date: Sat, 1 Jul 2006 14:25:08 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151788673.3195.58.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-07-01 at 14:09 -0700, Miles Lane wrote:
> > I am getting this:
> >
> >   KLIBCLD usr/klibc/libc.so
> > usr/klibc/execl.o: In function `execl':
> > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > usr/klibc/execle.o: In function `execle':
> > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > usr/klibc/execvpe.o: In function `execvpe':
> > usr/klibc/execvpe.c:75: undefined reference to `__stack_chk_fail'
> > usr/klibc/execlp.o: In function `execlp':
> > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > usr/klibc/execlpe.o: In function `execlpe':
> > usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> > usr/klibc/vfprintf.o:usr/klibc/vfprintf.c:26: more undefined
> > references to `__stack_chk_fail' follow
> > make[2]: *** [usr/klibc/libc.so] Error 1
> >
> > But I've searched all the .h and .c files in the tree and found no
> > reference to __stack_chk_fail.  I am running Ubuntu's Edgy Eft (the
> > latest development tree).
>
> somehow you're getting -fstack-protector added to your CFLAGs.. which
> won't do you any good unless you link to glibc or another library that
> implements the user side of the feature...

The only reference to -fstack-protector in my linux kernel tree is here:

arch/i386/kernel/asm-offsets.s

        .file   "asm-offsets.c"
# GNU C version 4.1.2 20060613 (prerelease) (Ubuntu 4.1.1-2ubuntu5)
(i486-linux-gnu)
#       compiled by GNU C version 4.1.2 20060613 (prerelease) (Ubuntu
4.1.1-2ubuntu5).
# GGC heuristics: --param ggc-min-expand=96 --param ggc-min-heapsize=125021
# options passed:  -nostdinc -Iinclude -Iinclude/asm-i386/mach-default
# -D__KERNEL__ -DKBUILD_STR(s)=#s -DKBUILD_BASENAME=KBUILD_STR(asm_offsets)
# -DKBUILD_MODNAME=KBUILD_STR(asm_offsets) -isystem -include -MD -m32
# -msoft-float -mpreferred-stack-boundary=2 -march=i686 -mtune=pentium4
# -mregparm=3 -auxbase-strip -Os -Wall -Wundef -Wstrict-prototypes
# -Wno-trigraphs -Wdeclaration-after-statement -Wno-pointer-sign
# -fno-strict-aliasing -fno-common -fno-omit-frame-pointer
# -fno-optimize-sibling-calls -fasynchronous-unwind-tables -ffreestanding
# -fverbose-asm
# options enabled:  -falign-loops -fargument-alias
# -fasynchronous-unwind-tables -fbranch-count-reg -fcaller-saves
# -fcprop-registers -fcrossjumping -fcse-follow-jumps -fcse-skip-blocks
# -fdefer-pop -fdelete-null-pointer-checks -fearly-inlining
# -feliminate-unused-debug-types -fexpensive-optimizations -ffunction-cse
# -fgcse -fgcse-lm -fguess-branch-probability -fident -fif-conversion
# -fif-conversion2 -finline-functions -finline-functions-called-once
# -fipa-pure-const -fipa-reference -fipa-type-escape -fivopts
# -fkeep-static-consts -fleading-underscore -floop-optimize
# -floop-optimize2 -fmath-errno -fmerge-constants -foptimize-register-move
# -fpcc-struct-return -fpeephole -fpeephole2 -fregmove -freorder-functions
# -frerun-cse-after-loop -frerun-loop-opt -fsched-interblock -fsched-spec
# -fsched-stalled-insns-dep -fshow-column -fsplit-ivs-in-unroller
# -fstack-protector -fstrength-reduce -fthread-jumps -ftrapping-math
# -ftree-ccp -ftree-copy-prop -ftree-copyrename -ftree-dce
# -ftree-dominator-opts -ftree-dse -ftree-fre -ftree-loop-im
# -ftree-loop-ivcanon -ftree-loop-optimize -ftree-lrs -ftree-salias
# -ftree-sink -ftree-sra -ftree-store-ccp -ftree-store-copy-prop -ftree-ter
# -ftree-vect-loop-version -ftree-vrp -funit-at-a-time -funwind-tables
# -fverbose-asm -fzero-initialized-in-bss -m32 -m96bit-long-double
# -malign-stringops -mieee-fp -mno-fancy-math-387 -mno-red-zone -mpush-args
# -mtls-direct-seg-refs

# Compiler executable checksum: 08eb10034110f95d4c3c06297525c871

        .text
.globl foo
        .type   foo, @function
foo:
.LFB517:
        pushl   %ebp    #
.LCFI0:
        movl    %esp, %ebp      #,
.LCFI1:
#APP

->SIGCONTEXT_eax $44 offsetof(struct sigcontext, eax)   #

->SIGCONTEXT_ebx $32 offsetof(struct sigcontext, ebx)   #

->SIGCONTEXT_ecx $40 offsetof(struct sigcontext, ecx)   #

->SIGCONTEXT_edx $36 offsetof(struct sigcontext, edx)   #

->SIGCONTEXT_esi $20 offsetof(struct sigcontext, esi)   #

->SIGCONTEXT_edi $16 offsetof(struct sigcontext, edi)   #

->SIGCONTEXT_ebp $24 offsetof(struct sigcontext, ebp)   #

->SIGCONTEXT_esp $28 offsetof(struct sigcontext, esp)   #

->SIGCONTEXT_eip $56 offsetof(struct sigcontext, eip)   #

->

->CPUINFO_x86 $0 offsetof(struct cpuinfo_x86, x86)      #

->CPUINFO_x86_vendor $1 offsetof(struct cpuinfo_x86, x86_vendor)        #

->CPUINFO_x86_model $2 offsetof(struct cpuinfo_x86, x86_model)  #

->CPUINFO_x86_mask $3 offsetof(struct cpuinfo_x86, x86_mask)    #

->CPUINFO_hard_math $6 offsetof(struct cpuinfo_x86, hard_math)  #

->CPUINFO_cpuid_level $8 offsetof(struct cpuinfo_x86, cpuid_level)      #

->CPUINFO_x86_capability $12 offsetof(struct cpuinfo_x86,
x86_capability)       #

->CPUINFO_x86_vendor_id $40 offsetof(struct cpuinfo_x86, x86_vendor_id) #

->

->TI_task $0 offsetof(struct thread_info, task) #

->TI_exec_domain $4 offsetof(struct thread_info, exec_domain)   #

->TI_flags $8 offsetof(struct thread_info, flags)       #

->TI_status $12 offsetof(struct thread_info, status)    #

->TI_cpu $16 offsetof(struct thread_info, cpu)  #

->TI_preempt_count $20 offsetof(struct thread_info, preempt_count)      #

->TI_addr_limit $24 offsetof(struct thread_info, addr_limit)    #

->TI_restart_block $32 offsetof(struct thread_info, restart_block)      #

->TI_sysenter_return $28 offsetof(struct thread_info, sysenter_return)  #

->

->EXEC_DOMAIN_handler $4 offsetof(struct exec_domain, handler)  #

->RT_SIGFRAME_sigcontext $164 offsetof(struct rt_sigframe,
uc.uc_mcontext)      #

->

->pbe_address $0 offsetof(struct pbe, address)  #

->pbe_orig_address $4 offsetof(struct pbe, orig_address)        #

->pbe_next $8 offsetof(struct pbe, next)        #

->TSS_sysenter_esp0 $-8700 offsetof(struct tss_struct, esp0) -
sizeof(struct tss_struct)        #

->PAGE_SIZE_asm $4096 PAGE_SIZE #

->VDSO_PRELINK $-8192 VDSO_PRELINK      #

->crypto_tfm_ctx_offset $48 offsetof(struct crypto_tfm, __crt_ctx)      #
#NO_APP
        popl    %ebp    #
        ret
.LFE517:
        .size   foo, .-foo
        .section        .eh_frame,"a",@progbits
.Lframe1:
        .long   .LECIE1-.LSCIE1
.LSCIE1:
        .long   0x0
        .byte   0x1
        .string ""
        .uleb128 0x1
        .sleb128 -4
        .byte   0x8
        .byte   0xc
        .uleb128 0x4
        .uleb128 0x4
        .byte   0x88
        .uleb128 0x1
        .align 4
.LECIE1:
.LSFDE1:
        .long   .LEFDE1-.LASFDE1
.LASFDE1:
        .long   .LASFDE1-.Lframe1
        .long   .LFB517
        .long   .LFE517-.LFB517
        .byte   0x4
        .long   .LCFI0-.LFB517
        .byte   0xe
        .uleb128 0x8
        .byte   0x85
        .uleb128 0x2
        .byte   0x4
        .long   .LCFI1-.LCFI0
        .byte   0xd
        .uleb128 0x5
        .align 4
.LEFDE1:
        .ident  "GCC: (GNU) 4.1.2 20060613 (prerelease) (Ubuntu 4.1.1-2ubuntu5)"
        .section        .note.GNU-stack,"",@progbits
