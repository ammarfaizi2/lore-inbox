Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUFTXM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUFTXM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 19:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUFTXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 19:12:27 -0400
Received: from wblv-246-169.telkomadsl.co.za ([165.165.246.169]:35511 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262380AbUFTXMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 19:12:10 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: arjanv@redhat.com, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <200406210026.43988.agruen@suse.de>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <1087767752.2805.18.camel@laptop.fenrus.com>
	 <1087768362.14794.53.camel@nosferatu.lan>
	 <200406210026.43988.agruen@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q36DO0F12ONKlzn/B0Jl"
Message-Id: <1087771141.14794.89.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 00:39:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q36DO0F12ONKlzn/B0Jl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-21 at 00:26, Andreas Gruenbacher wrote:
> On Sunday 20 June 2004 23:52, Martin Schlemmer wrote:
> > On Sun, 2004-06-20 at 23:42, Arjan van de Ven wrote:
> > > > Given, but to 'use' the kbuild infrastructure, you must still call =
it
> > > > via:
> > > >
> > > >   make -C _path_to_sources M=3D`pwd`
> > >
> > > I see no problem with requiring this though; requiring a correct
> > > makefile is perfectly fine with me, and this is the only and document=
ed
> > > way for 2.6 already.
> > > (And it's also the only way to build modules against Fedora Core 2
> > > kernels by the way)
> >
> > I did not mean I have a problem with that.  Say you take svgalib, and
> > you want the build system to automatically compile the kernel module,
> > you might do something like:
> >
> > ---
> > build_2_6_module:
> > 	@make -C /lib/modules/`uname -r`/build M=3D`PWD`
> > ---
> >
> > will break with proposed patch ...
>=20
> No it won't.
>=20
> You always need to figure out $(objtree) to build external modules, with =
or=20
> without a separate output directory. Many modules don't need to know=20
> $(srctree) explicitly at all.
>=20
> In case you want to do something depending on the sources/confguration, t=
here=20
> are two ways:
>   - follow the new source symlink,
>   - let kbuild take you to $(srctree): When the makefile in the M directo=
ry
>     is included, the current working directory is $(srctree). besides, al=
l the
>     usual variables like $(srctree), $(objtree), CONFIG_* variables, etc.=
 are
>     all available. That's a good time to check for features, etc.
>=20

But my original concern (that the only way to figure where the source
are for the running kernel will be broken) is still valid.  And to do
all that you mentioned above, you still need to figure out _where_ the
kernel source are ...

> > And the point I wanted to make was that AFIAK
> > '/lib/modules/`uname -r`/build' is an interface to figure
> > out where the _sources_ for the current running kernel are
> > located.
>=20
> That's a misconception. At the minimum, you want to be able to build the=20
> module. Directly messing with the sources is usually wrong. I know extern=
al=20
> module authors like to do that nevertheless; in a few cases it's actually=
=20
> useful. Most of the time it really is not. Most external modules have tot=
ally=20
> braindead/broken makefiles.
>=20

I never said anything about messing with the source.  But anything that
needs access to the running kernel's headers need to know where the
sources are - and that could have been figured out by looking at the
'build' symlink.

Say you maintain an opensource (just to throw out the 'its closed
source, so screw them' arguments) external module that supports both
2.4 and 2.6, and easy way to implement it is to have:

makefile - make will first look for this, and then process it.
           in here you check what kernel is running (via uname -r
           or whatever), and then create the proper 'Makefile'
           symlink, and then call make with arguments to properly
           handle the external module build process for that
           version kernel.

Makefile-pre_M_flag - 100% valid kbuild Makefile for kernels that
                      do not support M=3D

Makefile-post_M_flag - 100% valid kbuild Makefile for kernels
                       supporting M=3D

Makefile-2_4 - 100% valid kbuild/whatever Makefile for 2.4 kernels
               (Ok, I am not so sure about how 2.4 handles things
               these days anymore ...)

now the clueless user just calls 'make && make install' and it should
work perfectly.

Or you create an install.sh that does things properly, or whatever,
but point remains that you need to know where the source are ...


Thanks,

--=20
Martin Schlemmer

--=-q36DO0F12ONKlzn/B0Jl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1hIFqburzKaJYLYRAi1aAJ9q4fnbnrKJ2+0Nv6pz4AC9dhSzcQCfc5mg
R5UBmyu0EzxkVHFWzQwwtnM=
=q57v
-----END PGP SIGNATURE-----

--=-q36DO0F12ONKlzn/B0Jl--

