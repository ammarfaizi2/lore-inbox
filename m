Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWBMLGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWBMLGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBMLGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:06:09 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:40094 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S1751234AbWBMLGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:06:07 -0500
From: Mws <mws@twisted-brains.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: 2.6.16, sk98lin out of date
Date: Mon, 13 Feb 2006 12:06:19 +0100
User-Agent: KMail/1.9.1
References: <200602131058.03419.s0348365@sms.ed.ac.uk>
In-Reply-To: <200602131058.03419.s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1349375.Uu1qyH9Mtf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602131206.26285.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1349375.Uu1qyH9Mtf
Content-Type: multipart/mixed;
  boundary="Boundary-01=_rgG8D8DfNZGx2Yq"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_rgG8D8DfNZGx2Yq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 13 February 2006 11:58, you wrote:
> Hi,
>=20
> As I'm sure the drivers/net maintainers are well aware, SysKonnect consta=
ntly=20
> update their sk98lin/sky2 driver without bothering to sync their changes =
with=20
> the official linux kernel.
>=20
> I quickly downloaded driver version 8.31 from http://www.skd.de/ today an=
d=20
> used the install script to generate a diff against 2.6.16-rc3. Even after=
=20
> fixing up some DOS EOLs in the package, the diff was still well over 1.5M=
Bs.=20
> This is an enormous number of changes.
>=20
> The reason I'm posting is that my DFI LanParty-UT SLI-D works with this=20
> version of the driver, but not the version 2.6.16-rc3.
>=20
> [alistair] 10:55 [~] dmesg | grep sk98lin
> sk98lin: Could not read VPD data.
> sk98lin: probe of 0000:01:0a.0 failed with error -5
>=20
> I wonder if it's worth just identifying the "quick fix" (I've seen workar=
ounds=20
> for corrupt VPDs like mine) or whether a general merge up would be=20
> beneficial..
>=20
> If nobody's maintaining this driver I wouldn't mind helping out.
>=20
hi,
as i do have the same problem i may help you out.

at first, syskonnect did send their kernel diffs/patches but they we're rej=
ected caused
by coding style, indention and some people thinking that things can be done=
 better.

i personally do apply these drivers with the generate patch function of the=
 install.sh.

there were small modifications within kernel 2.6.16 with i also sended as a=
 diff to syskonnect,=20
but got not reply.

i attached the diff, maybe it helps ya out. it works with my 2 onboard marv=
ell yukon gbit adapters.

regards
marcel


--Boundary-01=_rgG8D8DfNZGx2Yq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sk98lin_v8.28.1.3_adjustments_for_2.6.16.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sk98lin_v8.28.1.3_adjustments_for_2.6.16.patch"

diff -ruN linux/drivers/net/sk98lin/h/skdrv2nd.h linux-new/drivers/net/sk98=
lin/h/skdrv2nd.h
=2D-- linux/drivers/net/sk98lin/h/skdrv2nd.h	2006-01-18 10:11:04.000000000 =
+0100
+++ linux-new/drivers/net/sk98lin/h/skdrv2nd.h	2005-09-29 10:26:12.00000000=
0 +0200
@@ -61,7 +61,7 @@
 #ifdef HAVE_POLL_CONTROLLER
 #define SK_POLL_CONTROLLER
 #define CONFIG_SK98LIN_NAPI
+#elif defined CONFIG_NET_POLL_CONTROLLER
=2D#elif CONFIG_NET_POLL_CONTROLLER
 #define SK_POLL_CONTROLLER
 #define CONFIG_SK98LIN_NAPI
 #endif
diff -ruN linux/drivers/net/sk98lin/skge.c linux-new/drivers/net/sk98lin/sk=
ge.c
=2D-- linux/drivers/net/sk98lin/skge.c	2006-01-18 10:22:44.000000000 +0100
+++ linux-new/drivers/net/sk98lin/skge.c	2005-09-29 10:26:12.000000000 +0200
@@ -107,7 +107,7 @@
 static int 	__devinit sk98lin_init_device(struct pci_dev *pdev, const stru=
ct pci_device_id *ent);
 static void 	sk98lin_remove_device(struct pci_dev *pdev);
 #ifdef CONFIG_PM
+static int	sk98lin_suspend(struct pci_dev *pdev, pm_message_t state);
=2Dstatic int	sk98lin_suspend(struct pci_dev *pdev, u32 state);
 static int	sk98lin_resume(struct pci_dev *pdev);
 static void	SkEnableWOMagicPacket(SK_AC *pAC, SK_IOC IoC, SK_MAC_ADDR MacA=
ddr);
 #endif
@@ -971,7 +971,7 @@
  */
 static int sk98lin_suspend(
 struct pci_dev	*pdev,   /* pointer to the device that is to suspend */
+pm_message_t	state)  /* what power state is desired by Linux?    */
=2Du32		state)  /* what power state is desired by Linux?    */
 {
 	struct net_device   *dev  =3D pci_get_drvdata(pdev);
 	DEV_NET		    *pNet =3D (DEV_NET*) dev->priv;
@@ -1024,7 +1024,7 @@
 #else
 	pci_save_state(pdev, pAC->PciState);
 #endif
+	pci_set_power_state(pdev, pci_choose_state(pdev, state)); /* set the stat=
e */
=2D	pci_set_power_state(pdev, state); /* set the state */
=20
 	return 0;
 }
diff -ruN linux/drivers/net/sk98lin/sky2.c linux-new/drivers/net/sk98lin/sk=
y2.c
=2D-- linux/drivers/net/sk98lin/sky2.c	2006-01-18 10:51:36.000000000 +0100
+++ linux-new/drivers/net/sk98lin/sky2.c	2005-09-29 10:26:12.000000000 +0200
@@ -33,7 +33,7 @@
 #include "h/skdrv1st.h"
 #include "h/skdrv2nd.h"
 #include <linux/tcp.h>
+#include <linux/ip.h>
=2D
 /*************************************************************************=
*****
  *
  * Local Function Prototypes
@@ -337,7 +337,7 @@
 			PUSH_PKT_AS_LAST_IN_QUEUE(&pAC->TxPort[Port][0].TxQ_free, pSkPacket);
 			POP_FIRST_PKT_FROM_QUEUE(&pAC->TxPort[Port][0].TxAQ_working, pSkPacket);
 		}
+#ifdef USE_SYNC_TX_QUEUE
=2D#if USE_SYNC_TX_QUEUE
 		POP_FIRST_PKT_FROM_QUEUE(&pAC->TxPort[Port][0].TxSQ_working, pSkPacket);
 		while (pSkPacket !=3D NULL) {
 			if ((pSkFrag =3D pSkPacket->pFrag) !=3D NULL) {
@@ -902,7 +902,7 @@
 	pAC->TxPort[Port][TX_PRIO_LOW].TxAQ_waiting.pTail =3D NULL;
 	spin_lock_init(&pAC->TxPort[Port][TX_PRIO_LOW].TxAQ_waiting.QueueLock);
 =09
+#ifdef USE_SYNC_TX_QUEUE
=2D#if USE_SYNC_TX_QUEUE
 	pAC->TxPort[Port][TX_PRIO_LOW].TxSQ_working.pHead =3D NULL;
 	pAC->TxPort[Port][TX_PRIO_LOW].TxSQ_working.pTail =3D NULL;
 	spin_lock_init(&pAC->TxPort[Port][TX_PRIO_LOW].TxSQ_working.QueueLock);
@@ -2311,7 +2311,7 @@
 					SK_DBG_MSG(pAC, SK_DBGMOD_DRV, SK_DBGCAT_DRV_INT_SRC,
 						("No changes for TxA%d\n", Port + 1));
 				}
+#ifdef USE_SYNC_TX_QUEUE
=2D#if USE_SYNC_TX_QUEUE
 				if (HW_SYNC_TX_SUPPORTED(pAC)) {
 					/*=20
 					** Do we have a new Done idx ?=20

--Boundary-01=_rgG8D8DfNZGx2Yq--

--nextPart1349375.Uu1qyH9Mtf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8GgyPpA+SyJsko8RAgVgAJ9m3/aW2GB1bLSEwghV1WBN2mGNRACgtVI3
ZkUdNcxe61xJQ7eMsdMLCGA=
=WS46
-----END PGP SIGNATURE-----

--nextPart1349375.Uu1qyH9Mtf--
