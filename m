Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264736AbSJOUzk>; Tue, 15 Oct 2002 16:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264789AbSJOUzk>; Tue, 15 Oct 2002 16:55:40 -0400
Received: from kim.it.uu.se ([130.238.12.178]:59068 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S264736AbSJOUzf>;
	Tue, 15 Oct 2002 16:55:35 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15788.33319.329418.824364@kim.it.uu.se>
Date: Tue, 15 Oct 2002 23:01:27 +0200
To: Daniele Lugli <genlogic@inrete.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
In-Reply-To: <3DAC7AAC.B81A406E@inrete.it>
References: <20021014202404.GA10777@tapu.f00f.org>
	<Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
	<15788.8728.734070.225906@kim.it.uu.se>
	<3DAC7AAC.B81A406E@inrete.it>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Lugli writes:
 > Mikael Pettersson wrote:
 > > 
 > > Rik van Riel writes:
 > >  > On Mon, 14 Oct 2002, Chris Wedgwood wrote:
 > >  > > On Mon, Oct 14, 2002 at 09:46:08PM +0200, Daniele Lugli wrote:
 > >  > >
 > >  > > > I recently wrote a kernel module which gave me some mysterious
 > >  > > > problems. After too many days spent in blood, sweat and tears, I found the cause:
 > >  > >
 > >  > > > *** one of my data structures has a field named 'current'. ***
 > >  > >
 > >  > > gcc -Wshadow
 > >  >
 > >  > Would it be a good idea to add -Wshadow to the kernel
 > >  > compile options by default ?
 > > 
 > > While I'm not defending macro abuse, please note that Daniele's problem
 > > appears to have been caused by using g++ instead of gcc or gcc -x c to
 > > compile a kernel module. Daniele's later example throws a syntax error
 > > in gcc, since the cpp output isn't legal C ...
 > > 
 > > Hence I fail to see the utility of hacking in kludges for something
 > > that's not supposed to work anyway.
 > 
 > Yes i confess, i'm writing a kernel module in c++ (and i'm not the only
 > one).
 > Anyway my consideration was general and IMHO applies to C too. What is
 > the benefit of redefining commonly used words? I would say nothing
 > against eg #define _I386_current get_current(), but just #define current
 > get_current() seems to me a little bit dangerous. What is the limit?
 > What do you consider a bad practice? Would #define i j be tolerated?

As I wrote above: "While I'm not defending macro abuse". #define i j is
definitely macro abuse, and no sane programmer should do it.

Any programming language has a set of reserved words, and any large piece
of software has its own reserved words. Think of C++ "this" or C typedef names,
for example. You don't expect new code to work if it violates the syntax of
the system in which it is compiled, do you?

"current" is just that: one of the Linux kernel's reserved words, one
that kernel programmers are supposed to know about.

 > But let me at least summarize my poor-programmer-not-kernel-developer
 > point of view: at present the kernel if a mined field for c++ and i
 > understand it is not viable nor interesting for the majority to rewrite
 > it in a more c++-friendly way. But why not at least keep in mind, while
 > writing new stuff (not the case of current.h i see), that kernel headers
 > could be included by c++?

1. The kernel is not written in C++.
2. C++ is not C, and a C++ compiler is not a substitute for a C compiler.
3. User-space should't include raw kernel headers but "sanitized" ones,
   provided e.g. by the C library.

Ergo, the kernel headers should never be processed by a C++ compiler, and
anyone doing it anyway is on their own.

/Mikael
