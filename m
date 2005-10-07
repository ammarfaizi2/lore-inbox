Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVJGOVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVJGOVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVJGOVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:21:49 -0400
Received: from agmk.net ([217.73.31.34]:35085 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S964850AbVJGOVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:21:47 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc).
Date: Fri, 7 Oct 2005 16:21:40 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510071346.j97Dk3va005818@laptop11.inf.utfsm.cl>
In-Reply-To: <200510071346.j97Dk3va005818@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510071621.41249.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia piątek, 7 października 2005 15:46, Horst von Brand napisał:
> Paweł Sikora <pluto@agmk.net> wrote:
> > I've a simple program called empty.c.
> >
> > $ cat empty.c
> >
> > int main(int argc, char* argv[])
> > {
> >     return 0;
> > }
> >
> > $ cat empty410.s
> >
> >         .file   "empty.c"
> >         .text
> >         .p2align 4,,15
> > .globl main
> >         .type   main, @function
> > main:
> >         xorl    %eax, %eax
> >         ret
> >         .size   main, .-main
> >         .ident  "GCC: (GNU) 4.1.0 20050922 (experimental)"
> >         .section        .note.GNU-stack,"", at progbits
>
> I get a substantially different empty.s (gcc-4.0.2, Fedora rawhide on
> i686):
>
>         .file   "empty.c"
>         .text
>         .p2align 2,,3
> .globl main
>         .type   main, @function
> main:
>         pushl   %ebp
>         movl    %esp, %ebp
>         subl    $8, %esp
>         andl    $-16, %esp
>         subl    $16, %esp
>         xorl    %eax, %eax
>         leave
>         ret
>         .size   main, .-main
>         .ident  "GCC: (GNU) 4.0.2 20050928 (Red Hat 4.0.2-1)"
>         .section        .note.GNU-stack,"",@progbits
>
> > binutils-2.15.94.0.2.2 produces for this code empty .data and .bss
> > sections:
>
> binutils-2.16.91.0.2-4 doesn't. It looks like you are using broken tools.

I didn't say that is (or not) a binutils bug.
I'm only saying that kernel is killng a valid micro application.

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
