Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUEXIzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUEXIzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbUEXIxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:53:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:55967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264182AbUEXIeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:34:36 -0400
Date: Mon, 24 May 2004 04:34:04 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 14/14 linux-2.6.7-rc1] prism54: Fix channel stats; bump to 1.2
Message-ID: <20040524083404.GO3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cjvo8w+V8lMs5Jsv"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cjvo8w+V8lMs5Jsv
Content-Type: multipart/mixed; boundary="lHWX6A2F7795X8SZ"
Content-Disposition: inline


--lHWX6A2F7795X8SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-05-20      Aurelien Alleaume <slts@free.fr>

* islpci_eth.c : use dev_kfree_skb_irq instead of dev_kfree_skb where neede=
d.

* isl_ioctl.c : report channel instead of frequency in scan.

* islpci_hotplug.c : bump version to 1.2

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--lHWX6A2F7795X8SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="14-fix-channel.patch"
Content-Transfer-Encoding: quoted-printable

2004-05-20	Aurelien Alleaume <slts@free.fr>

	* islpci_eth.c : use dev_kfree_skb_irq instead of dev_kfree_skb
	where needed.

	* isl_ioctl.c : report channel instead of frequency in scan.

	* islpci_hotplug.c : bump version to 1.2

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.153
retrieving revision 1.154
diff -u -r1.153 -r1.154
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	22 Apr 2004 12=
:20:39 -0000	1.153
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	20 May 2004 06=
:24:11 -0000	1.154
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.153 2004/04/22 1=
2:20:39 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.154 2004/05/20 0=
6:24:11 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
@@ -629,8 +629,8 @@
 	current_ev =3D iwe_stream_add_point(current_ev, end_buf, &iwe, NULL);
=20
 	/* Add frequency. (short) bss->channel is the frequency in MHz */
-	iwe.u.freq.m =3D bss->channel;
-	iwe.u.freq.e =3D 6;
+	iwe.u.freq.m =3D channel_of_freq(bss->channel);
+	iwe.u.freq.e =3D 0;
 	iwe.cmd =3D SIOCGIWFREQ;
 	current_ev =3D
 	    iwe_stream_add_event(current_ev, end_buf, &iwe, IW_EV_FREQ_LEN);
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v
retrieving revision 1.36
retrieving revision 1.37
diff -u -r1.36 -r1.37
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	26 Apr 2004 1=
0:09:58 -0000	1.36
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	20 May 2004 0=
6:24:12 -0000	1.37
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.36 2004/04/26 1=
0:09:58 msw Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.37 2004/05/20 0=
6:24:12 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2004 Aurelien Alleaume <slts@free.fr>
@@ -275,7 +275,7 @@
 									 avs_80211_1_header),
 								 0, GFP_ATOMIC);
 			if (newskb) {
-				kfree_skb(*skb);
+				dev_kfree_skb_irq(*skb);
 				*skb =3D newskb;
 			} else
 				return -1;
@@ -419,7 +419,7 @@
 	     skb->data[4], skb->data[5]);
 #endif
 	if (unlikely(discard)) {
-		dev_kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		skb =3D NULL;
 	} else
 		netif_rx(skb);
@@ -462,7 +462,7 @@
 			      "Error mapping DMA address\n");
=20
 			/* free the skbuf structure before aborting */
-			dev_kfree_skb((struct sk_buff *) skb);
+			dev_kfree_skb_irq((struct sk_buff *) skb);
 			skb =3D NULL;
 			break;
 		}
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_hotplug.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_hotplug.c,v
retrieving revision 1.59
retrieving revision 1.60
diff -u -r1.59 -r1.60
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_hotplug.c	20 Mar 20=
04 16:58:36 -0000	1.59
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_hotplug.c	13 May 20=
04 13:19:47 -0000	1.60
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_hotplug.c,v 1.59 2004/03/=
20 16:58:36 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_hotplug.c,v 1.60 2004/05/=
13 13:19:47 msw Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -30,7 +30,7 @@
 #include "isl_oid.h"
=20
 #define DRV_NAME	"prism54"
-#define DRV_VERSION	"1.1"
+#define DRV_VERSION	"1.2"
=20
 MODULE_AUTHOR("[Intersil] R.Bastings and W.Termorshuizen, The prism54.org =
Development Team <prism54-devel@prism54.org>");
 MODULE_DESCRIPTION("The Prism54 802.11 Wireless LAN adapter");

--lHWX6A2F7795X8SZ--

--Cjvo8w+V8lMs5Jsv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbN8at1JN+IKUl4RAsNUAJoDxajf9GvRFRywoQA0vnfdJRoregCfXgK6
9EhXsN2WzobIrwrBe0s+Goc=
=JAR5
-----END PGP SIGNATURE-----

--Cjvo8w+V8lMs5Jsv--
