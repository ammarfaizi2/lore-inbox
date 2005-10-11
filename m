Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVJKMgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVJKMgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 08:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVJKMgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 08:36:09 -0400
Received: from cimice0.lam.cz ([212.71.168.90]:61887 "EHLO cimice.yo.cz")
	by vger.kernel.org with ESMTP id S932086AbVJKMgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 08:36:07 -0400
Date: Tue, 11 Oct 2005 14:35:35 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, mikulas@artax.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051011123535.GD16249@djinn>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <20051010223636.GB11427@br.ibm.com> <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk> <20051010163648.3e305b63.akpm@osdl.org> <20051011000734.GC13399@br.ibm.com> <20051011000503.GR7992@ftp.linux.org.uk> <20051011004043.GD13399@br.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20051011004043.GD13399@br.ibm.com>
User-Agent: Mutt/1.5.11
X-Spam-Score: -4.5 (----)
X-Spam-Report: Spam detection software, running on "shpek.cybernet.src", has inspected this
	incomming email and gave it -4.5 points (spam is above 5.0)
	Content analysis details:
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.9 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2005 at 21:40:43 -0300, Glauber de Oliveira Costa wrote:
> [...]
> In the code you commented, I thought that we get the same case testing
> from or to conditions, and thus, it would be correct to threat them in
> the same way.

In that code (below), the first test can safely just return. But the
second has to undo the first call before returning. When you test new,
the bh is already non-null. So you must release it.

> [...]
>=20
> On Tue, Oct 11, 2005 at 01:05:03AM +0100, Al Viro wrote:
> > On Mon, Oct 10, 2005 at 09:07:34PM -0300, Glauber de Oliveira Costa wro=
te:
> > >  	if (!bh)
> > >  		return -EIO;
> > >  	new =3D sb_getblk(sb, to);
> > > +	if (!new)
> > > +		return -EIO;
> >=20
> > You've just introduced a leak here, obviously.
> >=20
> > Please, read the code before "fixing" that stuff; slapping returns at r=
andom
> > and hoping that it will help is not a good way to deal with that - the =
only
> > thing you achieve is hiding the problem.
> >=20
> > The same goes for the rest of patch - in each case it's not obvious tha=
t your
> > changes are correct.

--
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDS7GXRel1vVwhjGURAoORAJ9jPv/2FNOD1HKnsmKQ7RaC9GqWzACgyKN/
oCAjOpt4ltlnKWKK3zHmLmM=
=E4oh
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
