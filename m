Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUAAXPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUAAXPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:15:07 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:1770 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261929AbUAAXOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:14:55 -0500
Date: Thu, 1 Jan 2004 15:15:16 -0800
From: Paul Jackson <pj@sgi.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040101151516.236cb610.pj@sgi.com>
In-Reply-To: <1072977297.1399.14.camel@nidelv.trondhjem.org>
References: <20040101043333.186a3268.pj@sgi.com>
	<1072977297.1399.14.camel@nidelv.trondhjem.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about therefore instead sending him a patch which fixes the actual
> code that is causing these warnings to be generated?

If such a patch generates more crap code (hence, sooner or later,
bugs) than it fixes, that's the wrong choice.

Right now, compiling a 2.6.0-mm1 (what I had handy) with the 3.3 gcc on
my Pentium system for arch i386 generates 1386 signed and unsigned
warnings, of the two kinds:

   warning: signed and unsigned type in conditional expression
   warning: comparison between signed and unsigned

A patch that resolved these 1386 warnings would (1) generate more
crap than it cleaned up, (2) immediately result in adding more bugs
than removed, and (3) due to the crap level rising, generate more
bugs long term than it avoided.

If Andrew accepted a patch from me that messed with all 1386 code
locations (and that's just for arch = i386) generating these warnings,
then I'd recommend that he be relieved of 2.6 kernel duties for
incompetence.  (Have no fear, Andrew - I would not make such a patch, I
trust you would not accept it, and Linus would not listen to my
recommendation).

> (see, for instance, the somewhat "unconventional" Linux min() and
> max() macros)

There's more going on in min and max than just checking for signed
versus unsigned comparison.  Other type mismatches are seen as well.

==

Let me step back a minute.  There is a useful lesson here.

The single most important technical key to the long term health of Linux
is "good code" - can the competent kernel hacker read and understand and
successfully modify the code.

This probably even outweighs the current 'bug' count, and certainly
outweighs the count of warnings from the compiler.

If a big chunk of intrusive code looked like it had been written in
Richard Gooch's idiosyncratic style, and then run through the Nvidia
obfuscator, then even if it was 'perfect' (mathematically proven to have
zero bugs and zero gcc warnings), we would not want it.

Normally I would agree with your sentiment - change the code to remove
the warning, even if I have to do something a little bit ugly or silly. 
Many a time in my 25 years of serious coding, I have done just that.

But there's always a tradeoff here - the probability of a bug due to
an ignored warning versus the probability of a bug due to the slight
increase in human confusion due to the extra code crap.

If a warning is not seen that often, and has a half decent chance of
catching a real bug when it does fire, and doesn't result in that much
extra code crap when 'worked around', then on net, the warning is worth
dealing with, even at the occassional expense of a little bit of silly
code crap.

But if a warning is seen many times, very few of which catch bugs, and
forces wide spread instances of unnatural coding acts to work around,
then on net, it hurts more than it helps.

What we have here, with this warning, is one of the clearest examples
of this later case that I've seen.

Linus is right - it's a bad warning.

==

There are only two possible resolutions that I can imagine myself
endorsing here.  Either we turn off the warning (-Wno-sign-compare, as
in my patch) or more recent versions of gcc don't complain nearly as
much, making it a mute point.

Have you knowledge that more recent versions of gcc don't complain
nearly as much of this warning?  If so, I will upgrade my gcc and shut
up.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
