Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUEKLsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUEKLsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEKLsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:48:13 -0400
Received: from ns.suse.de ([195.135.220.2]:15056 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262972AbUEKLsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:48:03 -0400
Date: Tue, 11 May 2004 13:47:59 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: qlogicisp
Message-ID: <20040511114759.GH4828@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-9-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--D6z0c4W1rkZNF4Vu
Content-Type: multipart/mixed; boundary="Yia77v5a8fyVHJSl"
Content-Disposition: inline


--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

minimal fix for qlogicisp error handling ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogicisp-eh.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.5/drivers/scsi/qlogicisp.h.orig	2004-04-04 05:36:13.000000000=
 +0200
+++ linux-2.6.5/drivers/scsi/qlogicisp.h	2004-05-11 08:49:17.339970940 +0200
@@ -63,7 +63,7 @@ int isp1020_release(struct Scsi_Host *);
 const char * isp1020_info(struct Scsi_Host *);
 int isp1020_queuecommand(Scsi_Cmnd *, void (* done)(Scsi_Cmnd *));
 int isp1020_abort(Scsi_Cmnd *);
-int isp1020_reset(Scsi_Cmnd *, unsigned int);
+int isp1020_reset(Scsi_Cmnd *);
 int isp1020_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int[]);
 #endif /* _QLOGICISP_H */
--- linux-2.6.5/drivers/scsi/qlogicisp.c.orig	2004-04-04 05:38:22.000000000=
 +0200
+++ linux-2.6.5/drivers/scsi/qlogicisp.c	2004-05-11 08:54:50.501143895 +0200
@@ -1202,7 +1202,7 @@ int isp1020_abort(Scsi_Cmnd *Cmnd)
 }
=20
=20
-int isp1020_reset(Scsi_Cmnd *Cmnd, unsigned int reset_flags)
+int isp1020_reset(Scsi_Cmnd *Cmnd)
 {
 	u_short param[6];
 	struct Scsi_Host *host;
@@ -1985,6 +1985,8 @@ static Scsi_Host_Template driver_templat
 	.release		=3D isp1020_release,
 	.info			=3D isp1020_info,=09
 	.queuecommand		=3D isp1020_queuecommand,
+	.eh_abort_handler	=3D isp1020_abort,
+	.eh_bus_reset_handler	=3D isp1020_reset,
 	.bios_param		=3D isp1020_biosparam,
 	.can_queue		=3D QLOGICISP_REQ_QUEUE_LEN,
 	.this_id		=3D -1,

--Yia77v5a8fyVHJSl--

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoL1vxmLh6hyYd04RAtZmAKDSWy2uQeLVKDJq2UzP9ddy5A6Q5QCfV+ky
9yc6/V2jOXEIvXRwC3nCOco=
=KUKp
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--
