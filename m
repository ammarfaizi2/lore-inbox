Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTLNKks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 05:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTLNKks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 05:40:48 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:16005 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S263661AbTLNKkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 05:40:46 -0500
Date: Sun, 14 Dec 2003 11:37:11 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: In fs/proc/array.c error in function proc_pid_stat
Message-ID: <20031214103711.GA1730@localhost>
References: <20031213192516.4897.qmail@linuxmail.org> <20031213193040.GD11665@holomorphy.com> <20031214092802.GA1481@localhost> <20031214095953.GV8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031214095953.GV8039@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday December 14th 2003 William Lee Irwin III wrote:

> > It shouldn't indeed, but it does anyway. The main fault here is some
> > bug that RedHat's gcc 2.96 has with dealing with 'unsigned long long'
> > variables. It seems to be partly triggered by the relative complexity
> > of the very long printf statement it's part of in this file. An earlier
> > patch that *only* broke up the printf (so without the local variable)
> > also fixed compilation for some people, though not for all. Changing
> > some random local variable to 'volatile' also fixed compilation.
> 
> s/fixed compilation/appeared to work around a compiler bug/

Yes, the patch is only a simple workaround, nothing clever there!

> It breaks elsewhere in various ways (or has broken; maybe they update
> things they still call 2.96).

I didn't know about the other breaks. I very much doubt that 2.96 is
still maintained.

> > Perhaps. But older (server) platforms with this compiler are still in
> > wide use, if a simple patch can make use of an otherwise reasonable
> > compiler again, what's the big deal. And on these platforms dual
> > installing two versions of gcc (and especially g++ for userspace) can
> > lead to other mistakes and very hard to debug artifacts from mixed
> > object code.
 
> (1) I don't trust it for runtime code either; there have been problems.

Ok. This particular case is a simple compile error (which is caught
easily), not a hard to debug runtime bug in code generation.

> (2) These idiotic rearrangements of code to work around compiler bugs
> 	are worthless since you'll eventually end up eventually needing
> 	contradictory changes to work around different compilers' bugs.
> 	They're also total crap changes, worthless code churn, and even
> 	uglify the code.

True, although in this particular case the code can be argued to be very
ugly already. ;-)

> (3) 2.96? You must be kidding. Current is bordering on 3.4 if it's not
> 	there already. Do you think anyone's still taking patches for
> 	2.2.8 Linux kernels? Now apply the same reasoning to gcc. Some
> 	backport TLC from a distro is not going to be able to bring it
> 	up to modern standards.

Yes this is pretty old. But if it allows people to compile and therefore
test a kernel on older systems in setups equivalent to running
production systems this also has its value. Admit that gcc 3.x is about
twice as slow as gcc 2.9x. Not everyone is a developer with multiple
testsystems and a fast compilation machine that (cross)compiles for all
of them.

> (4) 2 versions of gcc is nothing and has zero bearing on the C++ ABI
> 	braindamage that went around a couple of years ago as it's not
> 	a C++ compiler.

Yes of course, but often installing a new or dual gcc forces people
to install newer g++ and binutils which very much may break compiling
existing userspace applications.

I wholeheartedly agree that the latest compilers are a lot better, and
use them myself, but keeping on board willing testers is also *very*
valuable.

Submitting a patch for Documentation/Changes indicating that gcc 3.x is
now required might be appropriate, but I strongly think that is one of
the first actions for 2.7, not yet for 2.6.
-- 
Marco Roeland
