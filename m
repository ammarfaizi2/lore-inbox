Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRGSXSr>; Thu, 19 Jul 2001 19:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266176AbRGSXSh>; Thu, 19 Jul 2001 19:18:37 -0400
Received: from ja.ssi.bg ([212.95.166.64]:28677 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S266158AbRGSXSY>;
	Thu, 19 Jul 2001 19:18:24 -0400
Date: Fri, 20 Jul 2001 02:19:25 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <Pine.LNX.4.33.0107191550220.3044-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107200206460.1820-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


	Hello,

On Thu, 19 Jul 2001, Linus Torvalds wrote:

> No. It's correct, because cpuid doesn't have any side effects (*), so we
> don't need to mark it volatile. gcc is free to remove it if nothing uses
> the outputs, for example. But gcc cannot (and generally does not) ignore
> outputs that _are_ specified.

	My understanding was that eax, ... edx are declared as
local vars and so their values can't be used out of the current
function scope, even when they are defined in inline func. So, I
assume they can be optimized (the fact is that they are not used)
and may be gcc forgets them. True, may be the docs do not cover
such situations but my first thought was not to explain everything
with bugs.

> Now, adding the "volatile" doesn't really make things worse, and it will
> make gcc even more anal about optimizations than it normally is, which is
> probably why that also hides the gcc bug.
>
> Note that gcc having bus in the inline asm handling is nothing new. We've
> had that before, and I'm sure we'll have it again. Not very many people
> use them: the kernel tends to be the heaviest user of them (with libc
> probably a good second). Which is why bugs here often take time to get
> fixed. It doesn't help that the documentation has been quite bad, even
> misleading, at times.

	Agreed. It seems I have to read more docs ...

> 		Linus
>
> (*) cpuid has the side effect of being a "synchronizing instruction", and
> as such you can use it for some SMP ordering things etc, but as it's one
> of the slowest such instructions nobody is really ever interested in using
> it that way, and it doesn't have any other "architecturally visible"
> effects that the compiler could care about.


Regards

--
Julian Anastasov <ja@ssi.bg>

