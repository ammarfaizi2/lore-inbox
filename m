Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVLGQTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVLGQTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVLGQTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:19:14 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:58034 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751169AbVLGQTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:19:14 -0500
Date: Wed, 7 Dec 2005 14:23:11 -0200
From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051207162311.GH20451@duckman.conectiva>
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org> <1133968943.2869.26.camel@laptopd505.fenrus.org> <20051207160047.GG20451@duckman.conectiva> <1133971353.2869.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <1133971353.2869.41.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2005 at 05:02:33PM +0100, Arjan van de Ven wrote:
>=20
> > > No they're not. Both are just about equally expensive cpu wise,
> > > sometimes the atomic_t ones are a bit more expensive (like on parisc
> > > architecture). But on x86 in either case it's a locked cycle, which is
> > > just expensive no matter which side you flip the coin...=20
> >=20
> > But if a lock is used exclusively to protect a int variable, an atomic_t
> > seems to be more appropriate to me. Isn't it?
>=20
> sounds like it...=20
>=20
> > Please, if you could, review the patches with this in mind: we aren't
> > changing any behaviour neither creating any weird lock scheme, we are
> > only doing two things:
>=20
> ... however you are NOT changing the behavior, which is EXACTLY my
> point; the current "lock emulation" behavior is wrong, all you're doing
> is replacing how you do the wrong thing ;)

But now doing the Right Thing will be easy, as the wrong code isn't
duplicated all around anymore: it is only in one place.  ;)

We have just done a small refactoring, trying to keep behaviour.
I haven't analysed deeply the current code to check if the "lock
emulation" could be replaced by a better approach. But at a first look,
it didn't look wrong to me. I am open to suggestions on how to replace
the write_urb_busy checking by something better.

So, at least we agree that using atomic_t is better than the current
approach, right? So, do you agree that, _if_ we chose to keep the
write_urb_busy "pseudo-locking", we could at least remove the code
duplication for that and use an atomic_t instead of spin_lock+int?

>=20
> It's like having a bike with square wheels, and replacing a flat tire
> with one with air in, as opposed to replacing it with a round wheel...
>=20

I am open to suggestions on how to build a round wheel in this case.  :)

--=20
Eduardo

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlwxvcaRJ66w1lWgRAqRhAJ9yh6+GIEWL06IddJCYCDPb0quhOACbBacc
KTKoXS1e7CJqPCRWe7kZEr8=
=Ydmk
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
