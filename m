Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWHQFXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWHQFXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHQFXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:23:12 -0400
Received: from 1wt.eu ([62.212.114.60]:61967 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751297AbWHQFXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:23:11 -0400
Date: Thu, 17 Aug 2006 07:16:16 +0200
From: Willy Tarreau <w@1wt.eu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060817051616.GB13878@1wt.eu>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816235459.GM7813@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 01:54:59AM +0200, Adrian Bunk wrote:
> Hi Willy!

Hi Adrian !

(I knew you would be the first one to raise your hand :-))

> My points against allowing to compile kernel 2.4 with gcc 4 are:
> 
> - There isn't much testing coverage - and will never be much testing
>   coverage - of using a kernel 2.4 compiled with gcc 4.
>   We've already seen several cases where only some compiler versions
>   caused miscompilations or exposed a runtime bug in the kernel.

Yes, and the same arguments were true when moving on to support gcc 3,
and the 3.4 that you propose below has not received much testing
coverage on 2.4 either. However, when you talk about exposing runtime
bugs, I notice that gcc 4 emits a lot of very valid compile time warnings
about constructs that can produced undefined code.

I was a bit disappointed when I saw the bugs Mikael had to fix to make
the kernel compilable by gcc 4. Also, for bad code generation, it's good
to be able to build 2.4 and 2.6 with the same kernels, because it helps
detecting compiler bugs faster.

Right now, I'd prefer getting gcc 4 support than gcc 3.4, because I don't
know if even one common distro has shipped with gcc 3.4 by default. 2.95,
3.0, and 3.3 have been common, and right now, 4.[01] is almost everywhere.

>   Since there shouldn't be any reason for still using a 2.4 kernel
>   except for "never change a running system",

I think that by "never change", you meant "except for regular updates".

> I don't see a good
>   reason for allowing such an untested gcc/kernel combination.

You're very well placed to know that every new 2.6 that comes out has
received too little testing for some people to generally deploy it
everywhere. Probably that one year from now, 2.6.16 will be considered
the most stable kernel (and I hope it too) and people will deploy it
on thousands of remotely managed sites, but right now, they still rely
on 2.4 for this. And it's easier for them to check that a new gcc on
their old kernel runs as expected than to validate that a completely
new kernel (with a new gcc too) runs like the old one.

> - Even if your distribution does no longer ship any gcc 3, it's
>   easy building and using your own gcc 3.4.6:
>     wget ftp://ftp.gnu.org/gnu/gcc/gcc-3.4.6/gcc-3.4.6.tar.bz2
>     tar xjf gcc-3.4.6.tar.bz2
>     mkdir build-gcc
>     cd build-gcc
>     ../gcc-3.4.6/configure --enable-languages=c --prefix=/usr/local/gcc-3.4.6
>     make bootstrap
>     make install
>     # change HOSTCC and CC in the toplevel Makefile of the kernel:
>     # HOSTCC = /usr/local/gcc-3.4.6/bin/gcc
>     # CC = /usr/local/gcc-3.4.6/bin/gcc

Agreed, and this is what *I* do, but I would understand people who don't
feel confident enough in a freshly built compiler to build their kernel
when they don't know all the relevant build options. BTW, you don't have
to change the makefile contents, you can simply pass CC= to make.

I know that our opinions diverge on the gcc+kernel subject because we
don't evaluate it from the same point of view, but you raised interesting
points anyway.

Thanks,
Willy

