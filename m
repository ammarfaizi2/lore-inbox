Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTBXOzG>; Mon, 24 Feb 2003 09:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbTBXOzG>; Mon, 24 Feb 2003 09:55:06 -0500
Received: from crack.them.org ([65.125.64.184]:43155 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S263137AbTBXOzF>;
	Mon, 24 Feb 2003 09:55:05 -0500
Date: Mon, 24 Feb 2003 10:02:02 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: fcorneli@elis.rug.ac.be
Cc: linux-kernel@vger.kernel.org, Frank.Cornelis@elis.rug.ac.be
Subject: Re: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
Message-ID: <20030224150202.GA25526@nevyn.them.org>
Mail-Followup-To: fcorneli@elis.rug.ac.be, linux-kernel@vger.kernel.org,
	Frank.Cornelis@elis.rug.ac.be
References: <20030224141608.GA24699@nevyn.them.org> <Pine.LNX.4.44.0302241538570.1277-100000@tom.elis.rug.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302241538570.1277-100000@tom.elis.rug.ac.be>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 03:51:22PM +0100, fcorneli@elis.rug.ac.be wrote:
> Hi,
> 
> > FYI Frank, three things.  First of all, I really don't like the
> > interface of adding a second address to ptrace; I believe it interferes
> > with PIC on x86, since IIRC the extra argument would go in %ebx.  
> > The BSDs have a nice interface involving passing a request structure. 
> 
> I don't see the problem since we can pass up to 6 parameters on the i386 
> architecture. The extra argument will be passed on using the stack as the 
> other arguments do because of the asmlinkage directive. Using a structure 
> slows everything down too much; if you can use the stack I think it's 
> better to do so. What about that PIC?

I seem to remember this (five-arg syscalls) causing problems before. 
Maybe it was on a different platform.

> > Secondly, the implementation should be in kernel/ptrace.c not under
> > i386, we're trying to stop doing that.
> 
> The implementation is already in kernel/ptrace.c, only the usage lives 
> under the arch-dependent directories since there the sys_ptrace entries 
> are located.

Not any more; it should be in ptrace_request for anything new.  Yes, if
you're adding an argument, that makes this more work.

> > Thirdly, I was going to do this, but I ended up making GDB use pread64
> > on /dev/mem instead.  It works with no kernel modifications, and is
> > just as fast.
> 
> mmm... I thought it would be convenient to use ptrace for all the trace 
> work.

I've found it really doesn't make a difference.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
