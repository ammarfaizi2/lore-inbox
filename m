Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290351AbSAXVzM>; Thu, 24 Jan 2002 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290371AbSAXVzG>; Thu, 24 Jan 2002 16:55:06 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25728 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290370AbSAXVyw>; Thu, 24 Jan 2002 16:54:52 -0500
Date: Thu, 24 Jan 2002 16:55:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Oliver Xymoron <oxymoron@waste.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org>
Message-ID: <Pine.LNX.3.95.1020124165419.1859A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Oliver Xymoron wrote:

> On Thu, 24 Jan 2002, Richard B. Johnson wrote:
> 
> > On Thu, 24 Jan 2002, Oliver Xymoron wrote:
> >
> > > On Thu, 24 Jan 2002, Jeff Garzik wrote:
> > >
> > > > A small issue...
> > > >
> > > > C99 introduced _Bool as a builtin type.  The gcc patch for it went into
> > > > cvs around Dec 2000.  Any objections to propagating this type and usage
> > > > of 'true' and 'false' around the kernel?
> > >
> > > Ugh, no. C doesn't need booleans, neither do Perl or Python. This is a
> > > sickness imported from _recent_ C++ by way of Java by way of Pascal. This
> > > just complicates things.
> > >
> > > > Where variables are truly boolean use of a bool type makes the
> > > > intentions of the code more clear.  And it also gives the compiler a
> > > > slightly better chance to optimize code [I suspect].
> > >
> > > Unlikely. The compiler can already figure this sort of thing out from
> > > context.
> >
> > IFF the 'C' compiler code-generators start making better code, i.e.,
> > ORing a value already in a register, with itself and jumping on
> > condition, then bool will be helpful. Right now, I see tests against
> > numbers (like 0). This increases the code-size because the 0 is
> > in the instruction stream, plus the comparison of an immediate
> > value to a register value (on Intel) takes more CPU cycles.
> 
> The compiler _will_ turn if(a==0) into a test of a with itself rather than
> a comparison against a constant. Since PDP days, no doubt.


Don't you wish!


int foo(int i)
{

    if(i) return 0;
    else
    return 1;
}

	.file	"xxx.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl foo
	.type	 foo,@function
foo:
	pushl %ebp
	movl %esp,%ebp
	cmpl $0,8(%ebp)      <-------------- Compare against zero.
	je .L2
	xorl %eax,%eax
	jmp .L1
	jmp .L3
	.align 4
.L2:
	movl $1,%eax
	jmp .L1
	.align 4
.L3:
.L1:
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 foo,.Lfe1-foo
	.ident	"GCC: (GNU) egcs-2.91.66 19990314 (egcs-1.1.2 release)"


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


