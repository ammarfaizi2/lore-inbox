Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRLGPFx>; Fri, 7 Dec 2001 10:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281780AbRLGPFe>; Fri, 7 Dec 2001 10:05:34 -0500
Received: from ALyon-202-1-2-226.abo.wanadoo.fr ([217.128.85.226]:61659 "EHLO
	alph") by vger.kernel.org with ESMTP id <S281795AbRLGPFW>;
	Fri, 7 Dec 2001 10:05:22 -0500
Subject: PACKET_MR_PROMISC doesn't set IFF_PROMISC
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-G+V8Qw0biXf68Wsvq91V"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 16:06:04 +0100
Message-Id: <1007737564.21312.22.camel@alph>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G+V8Qw0biXf68Wsvq91V
Content-Type: multipart/mixed; boundary="=-gP7ezkmTls9cXJRZzzky"


--=-gP7ezkmTls9cXJRZzzky
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've read a little about the issue at :
http://groups.google.com/groups?hl=3Den&threadm=3Dlinux.kernel.Pine.LNX.4.3=
1.0101240002380.29105-100000%40netcore.fi&rnum=3D4&prev=3D/groups%3Fq%3Dgfl=
ags%2Blinux%2Bnet%26hl%3Den

Apparently, some people think that it is an application problem, and
that the application should be fixed.

However, having two way of putting the interface in promiscuous mode
(and one which is not reported) look like a security bug to me.

IDS host based sensor might be monitoring the machine in order to alert
if the machine goes into promiscuous mode. This mean that anyone might
volontarily use PACKET_MR_PROMISC in order to bypass the sensor...=20

The attached patch should fix the problem, but I don't believe it's the
right way to fix it... Maybe the use of dev->gflags should be corrected
? or am I missing something ?

--=20
Yoann Vandoorselaere
http://www.prelude-ids.org

--=-gP7ezkmTls9cXJRZzzky
Content-Description: 
Content-Disposition: inline; filename=promisc-set.patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- net/core/dev.c.orig	Thu Dec  6 12:53:21 2001
+++ net/core/dev.c	Thu Dec  6 12:54:22 2001
@@ -2082,7 +2082,7 @@ static int dev_ifsioc(struct ifreq *ifr,
 	switch(cmd)=20
 	{
 		case SIOCGIFFLAGS:	/* Get interface flags */
-			ifr->ifr_flags =3D (dev->flags&~(IFF_PROMISC|IFF_ALLMULTI|IFF_RUNNING))
+			ifr->ifr_flags =3D (dev->flags&~(IFF_ALLMULTI|IFF_RUNNING))
 				|(dev->gflags&(IFF_PROMISC|IFF_ALLMULTI));
 			if (netif_running(dev) && netif_carrier_ok(dev))
 				ifr->ifr_flags |=3D IFF_RUNNING;

--=-gP7ezkmTls9cXJRZzzky--

--=-G+V8Qw0biXf68Wsvq91V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8ENrc4tfUv0C+vv8RAgo7AJ977RP/sME3O9s42E8RlIF1Mh1GoACfcLBK
7+0bh3RnnIZMtfREAoA1SRU=
=Mu/H
-----END PGP SIGNATURE-----

--=-G+V8Qw0biXf68Wsvq91V--

