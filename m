Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286911AbSABKKz>; Wed, 2 Jan 2002 05:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286899AbSABKKq>; Wed, 2 Jan 2002 05:10:46 -0500
Received: from [194.206.157.151] ([194.206.157.151]:20349 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S286909AbSABKKj>; Wed, 2 Jan 2002 05:10:39 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E3ED@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
        Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: RE: [PATCH] C undefined behavior fix
Date: Wed, 2 Jan 2002 11:02:12 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]
> Sent: Wednesday, January 02, 2002 12:44 AM
> To: Momchil Velikov
> Cc: linux-kernel@vger.kernel.org; gcc@gcc.gnu.org;
> linuxppc-dev@lists.linuxppc.org
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:
> 
> > The appended patch fix incorrect code, which interferes badly with
> > optimizations in GCC 3.0.4 and GCC 3.1.
> > 
> > The GCC tries to replace the strcpy from a constant string 
> source with
> > a memcpy, since the length is know at compile time.
> 
> Check the linuxppc-dev archives, but this has been discussed 
> before, and
> it came down to a few things.
> 1) gcc shouldn't be making this optimization, and Paulus (who 
> wrote the
> code) disliked this new feature.  

Why? If memcpy can then be expanded in line, and the string is short, this
can be a *huge* win...

> As a subnote, what you sent was sent
> to Linus with a comment about working around a gcc-3.0 
> bug/feature, and
> was rejected because of this.
> 2) We could modify the RELOC macro, and not have this problem.  The
> patch was posted, but not acted upon.

I think we MUST modify the RELOC macro. Currently the code has an undefined
meaning WRT th eC standard, so is allowed to do almost anything from working
as expected (quite bad in fact: it may suddenly fail when sth is modified
elsewhere), to triggering the 3rd World War :-)

> 3) We could also try turning off this particular optimization
> (-fno-builtin perhaps) on this file, and not worry about it.

That's a compiler dependant way to fix the problem that creates a constraint
on the compiler: it MUST then from now continue to have a given behaviour to
some undefined feature (that is in fact not even documented...) 

Note that the RELOC macro triggers an UNDEFINED behaviour, not an
IMPLEMENTATION DEFINED one, so the compiler writer is free of any constraint
and that would be a genuine extension the the C language to fix the
behaviour.

	Bernard

--------------------------------------------
Bernard Dautrevaux
Microprocess Ingenierie
97 bis, rue de Colombes
92400 COURBEVOIE
FRANCE
Tel:	+33 (0) 1 47 68 80 80
Fax:	+33 (0) 1 47 88 97 85
e-mail:	dautrevaux@microprocess.com
		b.dautrevaux@usa.net
-------------------------------------------- 
