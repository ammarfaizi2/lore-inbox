Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315401AbSEBUVo>; Thu, 2 May 2002 16:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315405AbSEBUVn>; Thu, 2 May 2002 16:21:43 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:56225 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315401AbSEBUVl>;
	Thu, 2 May 2002 16:21:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: discontiguous memory platforms
Date: Thu, 2 May 2002 22:14:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E173LNK-00027F-00@starship> <3CD19640.3B85BF76@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173MyQ-00028q-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 21:40, Roman Zippel wrote:
> Daniel Phillips wrote:
> 
> > Patching the kernel how, and where?
> 
> Check for example in asm-ppc/page.h the __va/__pa functions.

OK, by 'patching the kernel' you must mean 'initialize the m68k_memory array'.

The loop you use does have one advantage: it can handle size variation vs a
shift-lookup strategy.  It's a lot more expensive though, and these are
heavily used operations.

> > > Anyway, I agree with Andrea, that another mapping isn't really needed.
> > > Clever use of the mmu should give you almost the same result.
> > 
> > We *are* making clever use of the mmu in config_nonlinear, it is doing the
> > nonlinear kernel virtual mapping for us.  Did you have something more clever
> > in mind?
> 
> I mean to map the memory where you need it. The physical<->virtual
> mapping won't be one to one, but you won't need another abstraction and
> the current vm is already basically able to handle it.

I'll accept 'not needed for 68K', though I guess config_nonlinear will work
perfectly well for you and be faster than the loops.  However, some of the
problems that config_nonlinear solves cannot be solved by any existing kernel
mechanism.  We've been over the NUMA-Q and mips32 cases in detail, so I won't
reiterate.

Thanks for your input.

-- 
Daniel
