Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286672AbRLVFBi>; Sat, 22 Dec 2001 00:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286675AbRLVFBS>; Sat, 22 Dec 2001 00:01:18 -0500
Received: from dracula.gtri.gatech.edu ([130.207.193.70]:34832 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP
	id <S286672AbRLVFBL>; Sat, 22 Dec 2001 00:01:11 -0500
Date: Sat, 22 Dec 2001 00:01:05 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] - 2.4.17 - if_arp.h - Add the Prism2 ARP type
Message-ID: <20011222000105.A22554@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Please CC: me responses; I'm not subscribed)

Hey, this one-line patch (I diffed it against 2.4.17-rc2) defines the
ARPHRD_IEEE80211_PRISM arp type.

A little background.  The prism2 series of wireless ethernet cards are
capable of operating in true promiscious mode, capturing raw 802.11
frames.  When it's doing this, the driver prepends a special monitoring
header onto the packet with useful information.=20

Since the v0.1.6 release of the driver, this was handled via NETLINK
broadcasts.. but that's Bad(tm).  Instead, the next version (0.1.14) of
the driver will support raw capture using the PF_PACKET interface, which
means that it'll need its own arp type for libpcap to recognize and
handle the special headers.  (without the header, it sends standard
ARPHRD_IEEE80211 frames)=20

libpcap/ethereal/etc already have dissectors for this special header, so
all that's left is to define a fixed arp type.

So, I humbly submit this patch for inclusion.

Thanks!
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prism_arp.diff"

--- linux/include/linux/if_arp.h	Wed Dec 19 20:55:17 2001
+++ linux-old/include/linux/if_arp.h	Wed Dec 19 20:59:07 2001
@@ -82,6 +82,7 @@
 	/* 787->799 reserved for fibrechannel media types */
 #define ARPHRD_IEEE802_TR 800		/* Magic type ident for TR	*/
 #define ARPHRD_IEEE80211 801		/* IEEE 802.11			*/
+#define ARPHRD_IEEE80211_PRISM 802	/* IEEE 802.11 + Prism2 header  */
 
 #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
 

--r5Pyd7+fXNt84Ff3--

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8JBORysXuytMhc5ERAvqzAJsGP6omLA+JdR4NPosz7oHt++23sQCfUjb3
43pgeZYEk0VEA1QCnXbNiXE=
=tNbJ
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
