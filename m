Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVGTPqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVGTPqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVGTPqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:46:06 -0400
Received: from mivlgu.ru ([81.18.140.87]:59842 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S261392AbVGTPqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:46:05 -0400
Date: Wed, 20 Jul 2005 19:46:04 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: dtor_core@ameritech.net
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics and TrackPoint problems in 2.6.12
Message-ID: <20050720154604.GA20656@master.mivlgu.local>
References: <a71293c2050719204047bd2afe@mail.gmail.com> <20050720183420.282f72f4.vsu@altlinux.ru> <d120d50005072008057d8a9043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <d120d50005072008057d8a9043@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2005 at 10:05:13AM -0500, Dmitry Torokhov wrote:
> On 7/20/05, Sergey Vlasov <vsu@altlinux.ru> wrote:
> > Another option is to change the
> > PSMOUSE_TRACKPOINT value so that it is less than PSMOUSE_GENPS,=20
>=20
> No, protocol numbers should not be changed as userspace drivers/setups
> check them and rely on them being stable.

Found that now:

	psmouse->dev.id.product =3D psmouse->type;

So the type is visible through the input device interface.  Probably this
should be mentioned in a comment near "enum psmouse_type" - its definition
in drivers/input/mouse/psmouse.h looks just like some driver-internal
enum.

> > In theory, someone could attach a device which uses 6-byte packets to
> > the Synaptics pass-thru port; I'm not sure what would happen in this
> > case, but with Synaptics confugured for 3-byte packets (as the patch
> > below will do) this configuration even has a chance of working.
>=20
> I don't think it can support more than 4 byte packets. bytes 0 and 3
> are protocol markers and can't be readily used for transmitting other
> protocols data.

At least the Synaptics protocol description mentions that its 6-byte
protocol was designed to look like two 3-byte PS/2 mouse packets, so that
it would work even if the controller looks at those markers; other such
protocols are likely to have the same property for the same reason.  Now,
if the Synaptics touchpad would be able to accept a 6-byte packet from the
pass-thru port as two 3-byte packets...

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC3nG7W82GfkQfsqIRAsXtAJ9qMN7Z/DppIg6S5G4p52UNfj2zTACfaaE3
ElcJymtbvFFzC6691FrsGDg=
=FVHh
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
