Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWAOPjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWAOPjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 10:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWAOPjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 10:39:36 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:32205 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S932079AbWAOPjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 10:39:36 -0500
Date: Sun, 15 Jan 2006 10:39:20 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (other issues)
Message-ID: <20060115153920.GB1722@shaftnet.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	"John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213237.GH16166@tuxdriver.com> <20060113222408.GM16166@tuxdriver.com> <43C97693.7000109@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <43C97693.7000109@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Sun, 15 Jan 2006 10:39:21 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2006 at 05:09:23PM -0500, Jeff Garzik wrote:
> A big open issue:  should you fake ethernet, or represent 802.11=20
> natively throughout the rest of the net stack?
>=20
> The former causes various and sundry hacks, and the latter requires that=
=20
> you touch a bunch of non-802.11 code to make it aware of a new frame clas=
s.

Internally, we're pure 802.11.  One thing to keep in mind that we're not=20
going to be bridging/translating non-data traffic to other networks, and=20
with that in mind, 802.3<->802.11 translation is trivial, and won't lose=20
anything except for a bit of efficiency.  (and then, just to be=20
contrary, the prism54 hardware actually requires 802.3 frames!)

That said.. we need to make the rest of the stack 802.11-aware. =20
Translating between 802.11 and 802.3 is trivial, as we only need to know=20
about a few operating parameters in order to perform the conversion --=20
AP/STA mode, BSSID, QoS parametsrs. WDS link parameters.   All of these=20
can be attached to the net_device to be used by the hard_header code.

(Part of the problem is that 802.11 has a variable-length header - 24,
 26, 30, or 32 bytes, and each address field means different things=20
 depending on which mode we're using..)

Meanwhile, A current "good enough for most" solution is to make all
"data" interfaces to the 802.11 stack appear as 802.3 interfaces.  Each
of these net_devices could translate to/from 802.11 on the fly.  Thus=20
internally the stack would be pure 802.11, but interacting with the=20
outside world would depend on the "mode" of the net_device.   You want=20
to tx/rx 802.11 management frames with QoS enabled?  Create a "type=20
802_11_a3_qos" inteface.=20

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDymyoPuLgii2759ARAnhlAJoD0Kh8Mr2mSQEdHEq7Kw/rIaU1pwCgt2Xd
uVPVb5TsGfGiKfl9yuTnyWk=
=Mxyl
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
