Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVKONYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVKONYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVKONYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:24:07 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:26893 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932515AbVKONYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:24:06 -0500
Date: Tue, 15 Nov 2005 08:23:34 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: [Bonding-devel] Re: [PATCH] fix ifenslave to not fail on lack of IP information
Message-ID: <20051115132334.GA6027@hmsreliant.homelinux.net>
References: <20051106032432.GA11464@localhost.localdomain> <200511111835.jABIZ1bc023937@death.nxdomain.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <200511111835.jABIZ1bc023937@death.nxdomain.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2005 at 10:35:01AM -0800, Jay Vosburgh wrote:
>=20
> 	You never did say which version of bonding you're using (or I
> just cleverly missed it) , but I assume it's an old one, 2.5.something
> I'd guess, with the old abi.  For that case, yes, your patch makes
> sense.
>=20
The RHEL kernel series use a variety of different versions of the bonding
driver, and yes, some of the prievious update releases use a older version =
of
the bonding abi.

> 	Can you rework your patch to also remove the fprintf and post
> that to the usual lists?  If it's not an error to fail to set the
> address, there's no reason to complain about it.  In truth, the
> set_if_addr() is all cosmetic; the kernel doesn't actually use that
> information for the slaves, so we could arguably remove it totally, but
> that might confuse end users.  Plus, ifenslave is on its way out, so I'd
> just as soon not change it more than necessary.
>=20
> 	-J
>=20
As requested, here is a rework of my previous patch, removing the unneeded
fprintf bits.  Tested successfully by me, and several of the origional repo=
rters.

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 ifenslave.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)



diff --git a/Documentation/networking/ifenslave.c b/Documentation/networkin=
g/ifenslave.c
--- a/Documentation/networking/ifenslave.c
+++ b/Documentation/networking/ifenslave.c
@@ -693,13 +693,7 @@ static int enslave(char *master_ifname,=20
 		/* Older bonding versions would panic if the slave has no IP
 		 * address, so get the IP setting from the master.
 		 */
-		res =3D set_if_addr(master_ifname, slave_ifname);
-		if (res) {
-			fprintf(stderr,
-				"Slave '%s': Error: set address failed\n",
-				slave_ifname);
-			return res;
-		}
+		set_if_addr(master_ifname, slave_ifname);
 	} else {
 		res =3D clear_if_addr(slave_ifname);
 		if (res) {
@@ -1085,7 +1079,6 @@ static int set_if_addr(char *master_ifna
 				slave_ifname, ifra[i].req_name,
 				strerror(saved_errno));
=20
-			return res;
 		}
=20
 		ipaddr =3D ifr.ifr_addr.sa_data;
--=20
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDeeFWM+bEoZKnT6ERAoukAJ9eJshfq0V7hJk3kbc3i4dMQHzrEQCfdgyz
2Fy6AZuOQ9regjNwF+JlLsI=
=VHTV
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
