Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290370AbSAXV6N>; Thu, 24 Jan 2002 16:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290378AbSAXV6F>; Thu, 24 Jan 2002 16:58:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19727 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290375AbSAXV5S>;
	Thu, 24 Jan 2002 16:57:18 -0500
Message-ID: <3C50833B.221D6A86@mandrakesoft.com>
Date: Thu, 24 Jan 2002 16:57:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Oliver Xymoron <oxymoron@waste.org>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.3.95.1020124165419.1859A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 24 Jan 2002, Oliver Xymoron wrote:
> 
> > On Thu, 24 Jan 2002, Richard B. Johnson wrote:
> >
> > > On Thu, 24 Jan 2002, Oliver Xymoron wrote:
> > >
> > > > On Thu, 24 Jan 2002, Jeff Garzik wrote:
> > > >
> > > > > A small issue...
> > > > >
> > > > > C99 introduced _Bool as a builtin type.  The gcc patch for it went into
> > > > > cvs around Dec 2000.  Any objections to propagating this type and usage
> > > > > of 'true' and 'false' around the kernel?
> > > >
> > > > Ugh, no. C doesn't need booleans, neither do Perl or Python. This is a
> > > > sickness imported from _recent_ C++ by way of Java by way of Pascal. This
> > > > just complicates things.
> > > >
> > > > > Where variables are truly boolean use of a bool type makes the
> > > > > intentions of the code more clear.  And it also gives the compiler a
> > > > > slightly better chance to optimize code [I suspect].
> > > >
> > > > Unlikely. The compiler can already figure this sort of thing out from
> > > > context.
> > >
> > > IFF the 'C' compiler code-generators start making better code, i.e.,
> > > ORing a value already in a register, with itself and jumping on
> > > condition, then bool will be helpful. Right now, I see tests against
> > > numbers (like 0). This increases the code-size because the 0 is
> > > in the instruction stream, plus the comparison of an immediate
> > > value to a register value (on Intel) takes more CPU cycles.
> >
> > The compiler _will_ turn if(a==0) into a test of a with itself rather than
> > a comparison against a constant. Since PDP days, no doubt.
> 
> Don't you wish!
> 
> int foo(int i)
> {
> 
>     if(i) return 0;
>     else
>     return 1;
> }

compile with -O2 on a modern compiler :)

        .file   "x.c"
        .text
        .align 16
.globl foo
        .type   foo,@function
foo:
        pushl   %ebp
        movl    %esp, %ebp
        movl    8(%ebp), %eax
        popl    %ebp
        testl   %eax, %eax
        sete    %al
        andl    $255, %eax
        ret
.Lfe1:
        .size   foo,.Lfe1-foo
        .ident  "GCC: (GNU) 3.0.3 (Mandrake Linux 8.2 3.0.3-1mdk)"

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
