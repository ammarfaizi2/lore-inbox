Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbSJOUXx>; Tue, 15 Oct 2002 16:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbSJOUXx>; Tue, 15 Oct 2002 16:23:53 -0400
Received: from inrete-46-20.inrete.it ([81.92.46.20]:63915 "EHLO
	pdamail1-pdamail.inrete.it") by vger.kernel.org with ESMTP
	id <S263208AbSJOUXt>; Tue, 15 Oct 2002 16:23:49 -0400
Message-ID: <3DAC7AAC.B81A406E@inrete.it>
Date: Tue, 15 Oct 2002 22:29:32 +0200
From: Daniele Lugli <genlogic@inrete.it>
Organization: General Logic srl
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rthal5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
References: <20021014202404.GA10777@tapu.f00f.org>
		<Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com> <15788.8728.734070.225906@kim.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> Rik van Riel writes:
>  > On Mon, 14 Oct 2002, Chris Wedgwood wrote:
>  > > On Mon, Oct 14, 2002 at 09:46:08PM +0200, Daniele Lugli wrote:
>  > >
>  > > > I recently wrote a kernel module which gave me some mysterious
>  > > > problems. After too many days spent in blood, sweat and tears, I found the cause:
>  > >
>  > > > *** one of my data structures has a field named 'current'. ***
>  > >
>  > > gcc -Wshadow
>  >
>  > Would it be a good idea to add -Wshadow to the kernel
>  > compile options by default ?
> 
> While I'm not defending macro abuse, please note that Daniele's problem
> appears to have been caused by using g++ instead of gcc or gcc -x c to
> compile a kernel module. Daniele's later example throws a syntax error
> in gcc, since the cpp output isn't legal C ...
> 
> Hence I fail to see the utility of hacking in kludges for something
> that's not supposed to work anyway.

Yes i confess, i'm writing a kernel module in c++ (and i'm not the only
one).
Anyway my consideration was general and IMHO applies to C too. What is
the benefit of redefining commonly used words? I would say nothing
against eg #define _I386_current get_current(), but just #define current
get_current() seems to me a little bit dangerous. What is the limit?
What do you consider a bad practice? Would #define i j be tolerated?

I wouldn't like to open a discussion about using c++ for kernel modules
because i know that the large majority of kernel developers is against.
And in fact i had to make my own version of the kernel sources turning
all 'new' into 'nEw', 'class' into 'klass' and so on, but this last
problem was more subtle.

But let me at least summarize my poor-programmer-not-kernel-developer
point of view: at present the kernel if a mined field for c++ and i
understand it is not viable nor interesting for the majority to rewrite
it in a more c++-friendly way. But why not at least keep in mind, while
writing new stuff (not the case of current.h i see), that kernel headers
could be included by c++?

Regards, Daniele
