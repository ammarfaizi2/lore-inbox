Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312915AbSCZBmb>; Mon, 25 Mar 2002 20:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312916AbSCZBmX>; Mon, 25 Mar 2002 20:42:23 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:50869 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312915AbSCZBmF>; Mon, 25 Mar 2002 20:42:05 -0500
Date: Mon, 25 Mar 2002 20:40:51 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020326014050.GP1853@ufies.org>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe.ml@online.fr>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9FC76F.6050900@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 07:57:19PM -0500, Jeff Garzik wrote:
> This patch causes module defaults to be reused -- potentially incorrectly.

Wrong. How can the fact that a suspend/resume cycle increment the id be
worst than the fact that the same cycle return idx to the previous
state?

The argument you have against this patch is WRONG.

You think about NICs in a PCI slot.=20
That's changed the day the cardbus support was moved from pcmcia to the
today implementation.
You can't expect cardbus user to stop using the suspend mode because you
expect your id to be attributed one time (that doesn't even make sense).

I agree that this patch is not a full fix (I said it in my original
post) but I disagree that it does any bad things. I would be interested
to learn about a real case ?

But ethtool seems to be very interesting and it looks like what I was
looking for. I will have a closer look at it, thank you for pointing it
to me.

> This is a personal solution, that might live on temporary as an=20
> outside-the-tree patch... but we cannot apply this to the stable kernel.
>=20
> I agree the card idx is wrong on remove.  Insert and remove a 3c59x=20
> cardbus card several times, and you will lose your module options too.=20

NO -- If I can remove/insert suspend/remove my card as I want I ever get
the same ID.=20
If you want to fail the patch you need to remove/insert 2 cards in FILO
order. Then you will get a ever bigger ID but this is what you get by
default without the patch.

> However... take note that this problem cannot be solved "the easy way"=20
> -- because one solution people may desire will potentially result in=20
> module options getting re-used incorrectly.  The above is one such soluti=
on.

I am waiting for a real case.

> If you want WOL options to "stick" or vary per-interface, we already=20
> have an API for that -- ethtool.  Check out drivers/net/natsemi.c for an=
=20
> example implementation.  _Tested_ patches to 3c59x that add WOL ethtool=
=20
> support are welcome, pending Andrew's approval.  Do not remove=20
> enable_wol for now in a stable series, but we will deprecate its use=20
> once ethtool support appears.

Noted.

Christophe

>    Jeff

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Dogs come when they're called;
cats take a message and get back to you later. --Mary Bly

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8n9Gij0UvHtcstB4RAkEJAJ9Bn12aRDKpl4sNA905d1SYy0rQJwCgim/o
RmLxkBlB397VwqkIobPPYxc=
=Dwns
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--
