Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSGYWCo>; Thu, 25 Jul 2002 18:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSGYWCn>; Thu, 25 Jul 2002 18:02:43 -0400
Received: from [195.223.140.120] ([195.223.140.120]:41277 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316541AbSGYWCn>; Thu, 25 Jul 2002 18:02:43 -0400
Date: Fri, 26 Jul 2002 00:06:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725220643.GT1180@dualathlon.random>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725150525.Q2276@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 03:05:25PM -0600, Cort Dougan wrote:
> That's only true for kernel names.  Function names that are not static in
> modules are given - and it's been useful for quickly finding which function
> in what module caused the trap.

Hmm no, only functions that are explicitly exported through
EXPORT_SYMBOL are given, they're the only one needed, if you were right
the modules would be wasting an overkill of kernel not swappable ram for
no good reason. This is true for both kernel and modules, no difference.

And even if only the non static ones would not be given still it would
be an high probability to need the system.map to resolve it.

> I must misunderstand you since it seems you're suggesting that the symbol
> names aren't useful.  That's the whole point of the patch - to give symbol
> names :)

I appreciated it as a good start to get more reliable module reports,
but I think it's not the best way to do it (but still it's way better
than nothing! :).

> } valuable for what? you need the system.map or the .o disassembly of the
> } module anyways to take advantage of such symbol. I don't find it useful.
> } Furthmore ksymoops will prefer to work with hex numbers rather than
> } doing the reverse lookup to the number and then resolving to the right
> } symbol (and not only ksymoops, me too while doing by hand and that's why
> } I prefer hex there)
> 
> On PPC I just tack the system.map.gz to the xmon debugger and lookup
> there.  That doesn't help with module oops' since it doesn't enter the
> debugger.  It's also an extra set of steps when looking at a symbol name
> and the actual address is much easier when looking at a target board.

I'm not trying to make it easier, I'm trying to make it possible at all.

Right now if I get an oops into a module from an user I cannot debug it
period. I'm missing information that I cannot generate on my side. Every
time he loads the module it will be at a different address (in
particular with my tree where I try to allocate modules in multipages to
get faster performance of the binary image at runtime even if they will
use more ram), so unless he managed running ksymoops on the "after-oops"
semi broken kernel, the oops will be totally useless.

Printing the start of each affected module into the oops will solve the
problem and it will make possible for us to debug oopses that involves
modules.  Then to automate it we ""only"" need to teach ksymoops to
parse those module-start informations.

Andrea
