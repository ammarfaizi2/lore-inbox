Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264161AbUEXIvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUEXIvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264166AbUEXIu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:50:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47007 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264170AbUEXIeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:34:10 -0400
Date: Mon, 24 May 2004 04:33:38 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 11/14 linux-2.6.7-rc1] prism54: Touched up kernel compatibility
Message-ID: <20040524083338.GL3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1lE8Wy7Exphh2Vpg"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1lE8Wy7Exphh2Vpg
Content-Type: multipart/mixed; boundary="Fh5LqGQwq8YwuKb/"
Content-Disposition: inline


--Fh5LqGQwq8YwuKb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-04-20      Aurelien Alleaume <slts@free.fr>

        * prismcompat.h, prismcompat24.h: splitted PRISM_DEFWAITQ into
	PRISM_DEFWAITQ and PRISM_PREPWAITQ for
	islpci_mgt_transaction
	(islpci_mgt.c). Adapted related code
	(islpci_mgt.c, islpci_dev.c).
--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--Fh5LqGQwq8YwuKb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="11-fix-prismcompat.patch"
Content-Transfer-Encoding: quoted-printable

2004-04-20	Aurelien Alleaume <slts@free.fr>

	* prismcompat.h, prismcompat24.h: splitted PRISM_DEFWAITQ into=20
	PRISM_DEFWAITQ and PRISM_PREPWAITQ for islpci_mgt_transaction=20
	(islpci_mgt.c). Adapted related code (islpci_mgt.c, islpci_dev.c).

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v
retrieving revision 1.75
retrieving revision 1.76
diff -u -r1.75 -r1.76
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	17 Apr 2004 0=
8:46:04 -0000	1.75
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	19 Apr 2004 1=
8:33:45 -0000	1.76
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.75 2004/04/17 0=
8:46:04 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.76 2004/04/19 1=
8:33:45 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -348,7 +348,8 @@
 	int result =3D -ETIME;
 	int count;
=20
-	PRISM_DEFWAITQ(priv->reset_done, wait);
+	PRISM_DEFWAITQ(wait);
+	PRISM_PREPWAITQ(priv->reset_done, wait);
 =09
 	/* now the last step is to reset the interface */
 	isl38xx_interface_reset(priv->device_base, priv->device_host_address);
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v
retrieving revision 1.45
retrieving revision 1.46
diff -u -r1.45 -r1.46
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	10 Apr 2004 0=
3:16:55 -0000	1.45
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	19 Apr 2004 1=
8:33:45 -0000	1.46
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.45 2004/04/10 0=
3:16:55 msw Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.46 2004/04/19 1=
8:33:45 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright 2004 Jens Maurer <Jens.Maurer@gmx.net>
@@ -456,11 +456,12 @@
 	const long wait_cycle_jiffies =3D (ISL38XX_WAIT_CYCLE * 10 * HZ) / 1000;
 	long timeout_left =3D ISL38XX_MAX_WAIT_CYCLES * wait_cycle_jiffies;
 	int err;
+	PRISM_DEFWAITQ(wait);
=20
 	if (down_interruptible(&priv->mgmt_sem))
 		return -ERESTARTSYS;
=20
-	PRISM_DEFWAITQ(priv->mgmt_wqueue, wait);
+	PRISM_PREPWAITQ(priv->mgmt_wqueue, wait);
 	err =3D islpci_mgt_transmit(ndev, operation, oid, senddata, sendlen);
 	if (err)
 		goto out;
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/prismcompat.h,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -r1.2 -r1.3
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h	5 Apr 2004 0=
4:19:25 -0000	1.2
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h	19 Apr 2004 =
18:33:45 -0000	1.3
@@ -39,8 +39,9 @@
=20
 #define prism54_synchronize_irq(irq) synchronize_irq(irq)
=20
-#define PRISM_DEFWAITQ(x, y)	DEFINE_WAIT(y); \
-	prepare_to_wait(&(x), &(y), TASK_UNINTERRUPTIBLE)
+#define PRISM_DEFWAITQ(y)	DEFINE_WAIT(y)
+
+#define PRISM_PREPWAITQ(x, y)	prepare_to_wait(&(x), &(y), TASK_UNINTERRUPT=
IBLE)
=20
 #define PRISM_ENDWAITQ(x, y)	finish_wait(&(x), &(y))
=20
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/prismcompat24.h,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -r1.2 -r1.3
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h	13 Apr 200=
4 08:20:13 -0000	1.2
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h	19 Apr 200=
4 18:33:45 -0000	1.3
@@ -55,8 +55,8 @@
=20
 #define prism54_synchronize_irq(irq) synchronize_irq()
=20
-#define PRISM_DEFWAITQ(x, y)	DECLARE_WAITQUEUE(y, current); \
-	set_current_state(TASK_UNINTERRUPTIBLE); \
+#define PRISM_DEFWAITQ(y)	DECLARE_WAITQUEUE(y, current)
+#define PRISM_PREPWAITQ(x, y)	set_current_state(TASK_UNINTERRUPTIBLE); \
 	add_wait_queue(&(x), &(y))
=20
 #define PRISM_ENDWAITQ(x, y)	remove_wait_queue(&(x), &(y)); \

--Fh5LqGQwq8YwuKb/--

--1lE8Wy7Exphh2Vpg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbNiat1JN+IKUl4RAn4lAJ9aWxmwdaahFZSnXtDTGcevmAkjXQCgoQMg
+6vP2iasG0vvPpQjoXo15nI=
=VcEb
-----END PGP SIGNATURE-----

--1lE8Wy7Exphh2Vpg--
