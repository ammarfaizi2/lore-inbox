Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbQKCLeD>; Fri, 3 Nov 2000 06:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbQKCLdy>; Fri, 3 Nov 2000 06:33:54 -0500
Received: from nef.ens.fr ([129.199.96.32]:43017 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S129307AbQKCLdl>;
	Fri, 3 Nov 2000 06:33:41 -0500
Date: Fri, 3 Nov 2000 12:33:35 +0100
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Message-ID: <20001103123335.A31768@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A01B8BB.A17FE178@Rikers.org> you write:
> There are two immediate reasons I can come up with for this:

I do not quite follow you on these two reasons. I daily work on an
Alpha machine, which runs under Linux, and I use the Compaq C compiler
since it gives better code on the applications I am developping (I am
a student in cryptography; I gain 30% speed on MD5 code, for instance,
compared to any version of gcc/egcs).

I think that some small parts of the kernel might take advantage of
the better code (/dev/urandom for instance) but, overall, this is not
critical.

However, using two different compilers is a great way to exhibit bugs.
I was told that some of the code in the kernel makes assumptions about
how gcc optimizes code, which on time to time leads to some problems
when a new version of gcc implements a different strategy. I am not
(yet) an optimizer god, therefore I will not comment any further on this
issue; but I think that it is sane practice, if one wants to remain on
the light side of the code (the one that is specified and does not rely
on not-very-well-documented features), to stress-test portability with
different sets of tools.


Anyway, among the points you talked about:

> 1. C++ style comments

Those ones are in C99. All modern compilers know them, or are doomed to
know them in near future since they are a requirement of the standard.

> 7. Macros with variable numbers of arguments

C99 knows them, with the following syntax: the macro is defined with an
ellipsis (...) as last argument, that represents all extra arguments
(possibly none). The arguments are accessed through the identifier
__VA_ARGS__, which contains all of them (with separating commas).

At least gcc-2.95.2 knows this syntax.



If one wants to build a Linux kernel with another compiler, I would
say that the more critical points are:

** inline assembly (must be almost completely rewritten for each new
compiler -- yuck)

** generalized lvalues (the result of a comma operator being a lvalue
if its last operand is a lvalue)

** compound statements (statement blocks inside expressions)


Other features are likely to be implemented in modern compilers, maybe
with a slightly different syntax, that could be adressed through macros,
or an enhanced preprocessing (put some perl script or smart C parser
between cpp and the compiler itself).



All this is only my opinion. But if I were to design a new OS kernel
right now, I would take special care to isolate and document extensions
as much as possible, so that I could ease portability and find bugs more
easily.


	--Thomas Pornin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
