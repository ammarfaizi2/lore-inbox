Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSALL0Z>; Sat, 12 Jan 2002 06:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285730AbSALL0P>; Sat, 12 Jan 2002 06:26:15 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:60882 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S285720AbSALL0L>;
	Sat, 12 Jan 2002 06:26:11 -0500
Date: Sat, 12 Jan 2002 12:25:43 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Message-ID: <20020112122543.N5235@khan.acc.umu.se>
In-Reply-To: <200201121048.CAA11276@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200201121048.CAA11276@adam.yggdrasil.com>; from adam@yggdrasil.com on Sat, Jan 12, 2002 at 02:48:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 02:48:53AM -0800, Adam J. Richter wrote:
> H. Peter Anvin wrote, in response to Andi Kleen:
> >You don't need CMPXCHG8B to do efficient inline mutexes.  In fact, the
> >pthreads code for i386 uses the same mutexes the kernel does (LOCK INC
> >based, I believe), complete with section hacking to make them
> >efficiently inlinable -- and then they're put inside a function call.
> [...]
> 
> 	Your comment prompted me to look at
> linux-2.5.2-pre11/include/asm-i386/spinlock.h, and I now believe that
> the "lock; decb" that it uses for grabbing spinlocks will return an
> incorrect success if 255 or more processors are waiting on the same
> spinlock.  I don't know if anybody has ever built a shared memory x86
> multiprocessor with 257 (not a typo) or more CPU's, but it's possible
> to imagine.  It's also possible to imagine this scenario happening
> with even just one processor and a preemtable kernel.  I believe that
> the current preemtable kernel patch limits the number of preempted
> processes to something like four or six, but that's just a temporary
> limitation of the current version.

AFAIK, there's more code than this that won't work with >255
processors... It's not like each and every person on this list has
such a beast to test with (and probably most never will even if they
do exist, or come to existance...)


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
