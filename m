Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262150AbRENPqI>; Mon, 14 May 2001 11:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbRENPp6>; Mon, 14 May 2001 11:45:58 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:43269 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S262132AbRENPpn>; Mon, 14 May 2001 11:45:43 -0400
Date: Mon, 14 May 2001 11:25:54 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>, Wayne.Brown@altec.com,
        Hacksaw <hacksaw@hacksaw.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Not a typewriter
Message-ID: <20010514112554.A10909@munchkin.spectacle-pond.org>
In-Reply-To: <mharris@opensourceadvocate.org> <200105140103.f4E13U3r010249@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105140103.f4E13U3r010249@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, May 13, 2001 at 09:03:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 09:03:30PM -0400, Horst von Brand wrote:
> "Mike A. Harris" <mharris@opensourceadvocate.org> said:
> > On Fri, 11 May 2001 Wayne.Brown@altec.com wrote:
> 
> [...]
> 
> > >why creat doesn't end in an "e;" and so forth.  I tell the
> 
> The old C compiler/old Unix linker guaranteed 6 chars in an external symbol
> name only, and C functions got an underscore prepended: _creat. I guess
> this is the reason for this wart. As to why 6 chars only, I'd guess some
> data structure in the linker was laid out that way. Machines had a few
> dozen Kbs of RAM then, space was precious.

IIRC, the 6 character linker requirement came from when the Bell Labs folk
ported the C compiler the IBM mainframe world, not from the early UNIX (tm)
world.  During the original ANSI C meetings, I got the sense from the IBM rep,
that part of the problem was the linker was owned by the OS folk, and not the
language group, and it was hard to make a business case why the linker should
be extended to handle newer languages (since it was a different office that was
responsible).  The 6 character limit came from the fact that the linker
actually supported 8 characters, but the first 2 characters were used to denote
different products (I recall IBM stuff all tended to be IE....).  The VMS folk
also had a similar problem (but there they had a 31 character, one case limit),
though by the end of the process, the linker had been moved into the languages
group in that case.

The mainframe linker is also why the 1989 C standard required there to be only
one definition of a global variable (ie, only one module can say "int x;" while
others must say "extern int x"), even though the UNIX compilers have
traditionally used the common model (ie, "int x" creates a common relocation,
so that if there is no other non-common definition, the linker will create
one).  Evidently, the mainframe linker decided to put each unique common
variable on its own page.

I vaguelly recall that somebody went back to Ritchie & Thompson and asked if
they could go back in time and make one change, what would it be.  Ritchie's
answer was to make default chars be unsigned instead of signed (since it really
messes up internation character support), and Thompson's answer was to spell
"create" with an trailing e.


> > What is the reason for that?  Also wondered why it is resolv.conf
> > and not resolve.conf or resolver.conf...
> 
> Old FS handled only 14 chars in names, but that clearly isn't the reason
> here (11 chars). Some other operating system perhaps?

I would imagine you should ask the Berkely folks, since the TCP/IP support all
came from there, and not Bell Labs.

> > Were they afraid that "e" being the most widely used letter in
> > the English language was going to war out thir xpnsiv kyboards if
> > thy usd it all th tim?
> 
> Funny conspiracy suscpicion, that... ;-)

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
