Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313973AbSDQAIV>; Tue, 16 Apr 2002 20:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313974AbSDQAIU>; Tue, 16 Apr 2002 20:08:20 -0400
Received: from adsl-64-109-202-37.dsl.milwwi.ameritech.net ([64.109.202.37]:52982
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S313973AbSDQAIT>; Tue, 16 Apr 2002 20:08:19 -0400
Date: Tue, 16 Apr 2002 19:08:18 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Larry McVoy <lm@work.bitmover.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020417000818.GB5897@0xd6.org>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Larry McVoy <lm@bitmover.com> on Tue, Apr 16, 2002:

> > Please tell us that primary framebuffer/input/console development will
> > continue in the CVS drop-in tree on SourceForge?  Bitkeeper is unable to
> > support this (easier, more efficient) style of development.
>=20
> Could you please explain why you think CVS is easier and more efficient?
> Last I checked, BK was a superset of CVS, but could be used pretty much
> identically to CVS if that's what you want.

A drop-in tree (also called "shadow trees" by Keith Owens of kbuild), is a
small set of files intended to be applied against a larger parent body of
code.  For example, a kernel subsystem or backend project (linuxconsole,
LinuxSH, Linux-MIPS) will only maintain the minimal number of files that
are specific to that backend, e.g. include/asm-mips/, arch/mips,
/arch/mips64, etc. for any files local to the project.  These could also be
driver files that have architecture-specific changes that haven't been sent
upstream yet.  Because drop-in trees only contain the files that the
project developers care about, they tend to be much smaller and easier to
maintain.  A drop-in tree is usually applied either by copying it over the
stock kernel tree (older method) or by using a simple script that symlinks
the drop-in tree contents (preferred).

I haven't seen a lot of formalization of the basic drop-in tree concepts,
but there are numerous projects that use this style even if they don't
call them drop-in trees, including linux1394.  These types of projects
usually maintain a single directory that is "cp -r"'d on top of the
corresponding directory in the full stock kernel.

=46rom my understanding of Bitkeeper, you can only clone from the master
repository, and you cannot specify a subset of files to work on when doing
so.  Therefore, if you only want to modify the files that pertain to your
backend port, you must first clone the entire Linux tree (or whatever was
imported into the master repository) and then make your local changes.  This
is a bad thing for a couple of reasons.  It becomes a maintainence nightmare
when resolving conflicts with files outside of your project's scope.  If I
maintain the console subsystem, why should I care about the upheaval of SCSI
layer?  Because CVS is simple enough to not require you to clone an entire
repository first, this is never an issue with using drop-in trees.

Secondly, size of the working repository and the size of updates becomes an
issue.  The kernel source sitting on my HD is approximately 151M.  Changes
between -pre versions usually range from 5-10MB.  Am I supposed to waste th=
is
much bandwidth just to clone the master repository and pull updates?

This is why CVS is more suited for this "style" of development.  Purely
technical reasons, not religious.  Now if James is using the drop-in tree
as the import files in the BK repository, versus a full kernel tree, then
that's a different matter.  But I'm really not interested in complex BK
commands that will somewhat allow the development of drop-in trees (if such
commands even exist).  It may seem silly to you, but I prefer KISS methods
of development and CVS is just fine for what we're trying to do in the
kernel backends.  BK is overkill and an impedement.

Granted a lot of the responsibilty of submitting patches and sync'ing falls
on the maintainers shoulders, so perhaps my argument falls on deaf ears
where they are concerned (as they are more concerned with keeping up with
Linus than with project developers such as myself).

[Note I didn't go into any detail about how drop-in trees are tagged
and sync'd against the stock kernels...]

M. R.

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vLzyaK6pP/GNw0URArPbAKCY87FnxfUy1UvT90Rs54TtO+EXnwCfflcy
TfARaaH935nRFnbfCvsR2cc=
=rAfQ
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
