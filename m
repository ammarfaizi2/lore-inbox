Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbULNSwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbULNSwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbULNSwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:52:16 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:49813 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261603AbULNSvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:51:49 -0500
Date: Tue, 14 Dec 2004 19:51:45 +0100
From: Harald Welte <laforge@netfilter.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Patrick McHardy <kaber@trash.net>, akpm@osdl.org, torvalds@osdl.org,
       coreteam@netfilter.org, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [netfilter-core] [PATCH] no __initdata in netfilter?
Message-ID: <20041214185145.GE22577@sunbeam.de.gnumonks.org>
References: <20041114013724.GA21219@apps.cwi.nl> <41970FAD.6010501@trash.net> <20041114112610.GB8680@pclin040.win.tue.nl> <20041214130041.GU22577@sunbeam.de.gnumonks.org> <20041214183911.GA15606@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0o87AgJoEixQl6Nr"
Content-Disposition: inline
In-Reply-To: <20041214183911.GA15606@apps.cwi.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0o87AgJoEixQl6Nr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 14, 2004 at 07:39:11PM +0100, Andries Brouwer wrote:
> > If we _know_ that it works, and there is no  bug, we could just add a
> > comment "This is handled correctly, since the ip_tables core copies the
> > data just as rulesets comming from userspace."
>=20
> I think that argument is valid only when satisfying the static tool
> is especially cumbersome or inefficient, requires ugly code, etc.
> In most cases a trivial rewrite will suffice, and the result is cleaner
> code, easier to maintain, fewer bugs.
=20
yes, and that rewrite is what I did with the patch.  Not really trivial,
but a small change.

Also, you only removed __initdata from ip_tables, but not arp_tables and
ip6_tables (which should have hit the same trigger in the tool)

> You say "but today nothing is wrong". But the longer the reasoning is,
> the easier one of the steps in the argument will be broken by some
> trivial change. By someone who did not know about all the invariants
> required by a certain piece of code.

Yes, but we're not talking about VM or filesystems, but a specific
function used by ip_tables internally. =20

I understand your point, though I think this is one of the cases where
your arguments apply the least. OTOTH, the __initdata structures we're
talking about are fairly big, space that you probably won't waste on
your embedded dsl router/firewall.

> > or alternatively pick up the (incremental) change attached to this mail.
> > I hope this makes your checker not spit any warnings.
>=20
> I checked, and indeed, no warnings for this patch.

great.

> But that is the only thing I checked. I would never submit it.

I checked that it compiles ;)  The changes are fairly trivial.

> Probably you should send it to davem and see whether he likes it.

We'll include it with the next patchset that goes to davem for mainline
inclusion.

> Andries

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--0o87AgJoEixQl6Nr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBvzZBXaXGVTD0i/8RAsmQAJ98DI08nSLXotgkGP0A8jnGDQpIFACgmmTH
D8fW3ok/C2/axw6SJ0svsLk=
=UxMB
-----END PGP SIGNATURE-----

--0o87AgJoEixQl6Nr--
