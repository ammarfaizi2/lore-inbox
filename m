Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285269AbSACKOP>; Thu, 3 Jan 2002 05:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285316AbSACKOG>; Thu, 3 Jan 2002 05:14:06 -0500
Received: from [194.206.157.151] ([194.206.157.151]:42662 "EHLO
	iis000.microdata.fr") by vger.kernel.org with ESMTP
	id <S285269AbSACKNr>; Thu, 3 Jan 2002 05:13:47 -0500
Message-ID: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000>
From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>
Cc: Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: RE: [PATCH] C undefined behavior fix
Date: Thu, 3 Jan 2002 11:05:06 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]
> Sent: Thursday, January 03, 2002 12:13 AM
> To: jtv
> Cc: Richard Henderson; Momchil Velikov; linux-kernel@vger.kernel.org;
> gcc@gcc.gnu.org; linuxppc-dev@lists.linuxppc.org; Franz Sirl; Paul
> Mackerras; Benjamin Herrenschmidt; Corey Minyard
> Subject: Re: [PATCH] C undefined behavior fix
> 
> 
> On Wed, Jan 02, 2002 at 11:23:21PM +0100, jtv wrote:
> > On Wed, Jan 02, 2002 at 03:05:48PM -0700, Tom Rini wrote:
> > > 
> > > Well, the problem is that we aren't running where the 
> compiler thinks we
> > > are yet.  So what would the right fix be for this?
> > 
> > Obviously -ffreestanding isn't, because this problem could 
> crop up pretty
> > much anywhere.  The involvement of standard library 
> functions is almost
> > coincidence and so -ffreestanding would only fix the 
> current symptom.
> 
> After thinking about this a bit more, why wouldn't this be 
> the fix?  The
> problem is that gcc is assuming that this is a 'normal' program (or in
> this case, part of a program) and that it, and that the standard rules
> apply, so it optimizes the strcpy into a memcpy.  But in this 
> small bit
> of the kernel, it's not.  It's not even using the 'standard library
> functions', but what the kernel provides.  This problem can 
> only crop up
> in the time before we finish moving ourself around.

OH... are you saying that the Linux kernel is not writtent in ANSI C? AFAICR
the standard *requires* that the standard library functions have their
standard meaning. So if the Linux kernel expects them to have some special
meaning it is *non-conforming* and then you need a *special* compiler,
understanding this.

OTOH if you only says that the Linux kernel is built with versions of
strcpy/memcpy that have the exact meaning required by the standard but are
not found in th ecompiler's library, then the program is still OK, but the
compiler is *allowed* to use the optimisations it wants to, regarding the
semantics of strcpy/memcpy. And anyway, in this case the "-ffreestanding"
option is *required* as this is what warn the compiler to use an
strcpy/memcpy/... implementation that *the program" provides instead of the
one that the compiler choose to provide (either by inlining or linking
against the library).

But tho whoel point here is that the RELOC macro has an undefined behaviour;
even if -ffreestanding solves the *current* problem, it's unsafe to build
*any* program on undefined behaviour (and particularly such for the kernel
itself...).

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
