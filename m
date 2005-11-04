Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKDQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKDQzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVKDQzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:55:46 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:2827 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750708AbVKDQzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:55:45 -0500
Date: Fri, 4 Nov 2005 11:54:34 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: bonding-devel@lists.sourceforge.net, nhorman@tuxdriver.com,
       ctindel@users.sourceforge.net, fubar@us.ibm.com, akpm@osdl.org
Subject: [PATCH] fix ifenslave to not fail on lack of IP information
Message-ID: <20051104165434.GB17181@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current version of ifenslave fails to attach slave interfaces to a bond=
 if
the masters doesn't have appropriate IP information.  While its common for
bonded interface to have IP information its not required (bond as part of a
bridge for instance).  This patch modifies ifenslave to not fail if IP
information is not available in the master at the time of enslaving.

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 ifenslave.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)


diff --git a/Documentation/networking/ifenslave.c b/Documentation/networkin=
g/ifenslave.c
--- a/Documentation/networking/ifenslave.c
+++ b/Documentation/networking/ifenslave.c
@@ -517,11 +517,10 @@ static int if_getconfig(char *ifname)
 	       ifname, ifr.ifr_flags);
=20
 	strcpy(ifr.ifr_name, ifname);
-	if (ioctl(skfd, SIOCGIFADDR, &ifr) < 0)
-		return -1;
-	printf("The result of SIOCGIFADDR is %2.2x.%2.2x.%2.2x.%2.2x.\n",
-	       ifr.ifr_addr.sa_data[0], ifr.ifr_addr.sa_data[1],
-	       ifr.ifr_addr.sa_data[2], ifr.ifr_addr.sa_data[3]);
+	if (ioctl(skfd, SIOCGIFADDR, &ifr) >=3D 0)
+		printf("The result of SIOCGIFADDR is %2.2x.%2.2x.%2.2x.%2.2x.\n",
+		       ifr.ifr_addr.sa_data[0], ifr.ifr_addr.sa_data[1],
+		       ifr.ifr_addr.sa_data[2], ifr.ifr_addr.sa_data[3]);
=20
 	strcpy(ifr.ifr_name, ifname);
 	if (ioctl(skfd, SIOCGIFHWADDR, &ifr) < 0)
@@ -1085,7 +1084,6 @@ static int set_if_addr(char *master_ifna
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

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDa5JKM+bEoZKnT6ERAi5OAJwPoYfzHqpfjRagg/3e2XatEKSiCwCePRTn
mY0uIE9mmJkQM8bp0YMBEYA=
=9pUR
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
