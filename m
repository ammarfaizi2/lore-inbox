Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVJGNqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVJGNqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVJGNqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:46:11 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58828 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932592AbVJGNqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:46:10 -0400
Message-Id: <200510071346.j97Dk3va005818@laptop11.inf.utfsm.cl>
To: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc). 
In-Reply-To: Message from =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net> 
   of "Fri, 07 Oct 2005 12:09:05 +0200." <200510071209.05656.pluto@agmk.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 07 Oct 2005 09:46:03 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 07 Oct 2005 09:46:03 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paweł Sikora <pluto@agmk.net> wrote:
> I've a simple program called empty.c.
> 
> $ cat empty.c
> 
> int main(int argc, char* argv[])
> {
>     return 0;
> }
> 
> $ cat empty410.s
> 
>         .file   "empty.c"
>         .text
>         .p2align 4,,15
> .globl main
>         .type   main, @function
> main:
>         xorl    %eax, %eax
>         ret
>         .size   main, .-main
>         .ident  "GCC: (GNU) 4.1.0 20050922 (experimental)"
>         .section        .note.GNU-stack,"", at progbits

I get a substantially different empty.s (gcc-4.0.2, Fedora rawhide on i686):

        .file   "empty.c"
        .text
        .p2align 2,,3
.globl main
        .type   main, @function
main:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $8, %esp
        andl    $-16, %esp
        subl    $16, %esp
        xorl    %eax, %eax
        leave
        ret
        .size   main, .-main
        .ident  "GCC: (GNU) 4.0.2 20050928 (Red Hat 4.0.2-1)"
        .section        .note.GNU-stack,"",@progbits

> binutils-2.15.94.0.2.2 produces for this code empty .data and .bss
> sections:

binutils-2.16.91.0.2-4 doesn't. It looks like you are using broken tools.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
