Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136247AbRECIpn>; Thu, 3 May 2001 04:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136249AbRECIpd>; Thu, 3 May 2001 04:45:33 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:19182 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136247AbRECIpY>; Thu, 3 May 2001 04:45:24 -0400
Date: Thu, 3 May 2001 10:45:11 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
Message-ID: <20010503104511.C754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010503034755.A27693@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010503034755.A27693@thyrsus.com>; from esr@thyrsus.com on Thu, May 03, 2001 at 03:47:55AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 03:47:55AM -0400, Eric S. Raymond wrote:
> OK, so you want CML2's "make oldconfig" to do something more graceful than
> simply say "Foo! You violated this constraint! Go fix it!"
 
Yes, that would be nice.

> The obvious thing to try is to start with the configuration you have
> and try mutating the variables that occur in the broken constraint(s).

No, that is not the obvious way for me.

> Have I got the point across yet?  There are *no* good solutions 
> to this problem.  There aren't even any clean ways to separate 
> easy cases from hard ones.  

There might be.

If the current dependencies of the symbols can be represented as
a tree (or can be topologically sorted, to be CS-correct), then I
would only care about the "leaves" of that tree.

Most added symbols in newer configs are added as leaves. So this
should suffice in most situations.

We also have defaults for all new values in our arch/$ARCH/defconfig.

So we read all symbols from .config and from defconfig into 2
flat tables (no constraints applied here!) together with their
values.

If we miss a symbol from .config, we ask the user, using the one
from defconfig as default, if we cannot derive its value from
our constraints.

If we have a symbol in .config, that we don't know about, we
simply ignore it (and tell the user that it's "obsolete or
renamed").

If the value for a symbol is there, but doesn't fit our
constraints: Ask the user or use the opposite (if it is boolean).

That was the 99% case: "leaves". They are easy.

Now the nodes. We can try fixing the config by changing the
symbols from leaves, to root (to save derives). 

But we only give this solution a certain amount of "tries" and
give up (or tell the user, that we have a hard time here and aks
for continue or abort and fixing by hand), if we either tried to
often or a certain amount of time has passed (30secs maximum
until next prompt).

This is no "perfect" solution, but it covers the common cases
well enough.

Eric, what do you think about that "dirty hack" variant? ;-)

And will the derivation be in nearly constant time, if I change
one symbol?

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
