Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310686AbSCRLne>; Mon, 18 Mar 2002 06:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310658AbSCRLn0>; Mon, 18 Mar 2002 06:43:26 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:63790 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S310657AbSCRLnN>; Mon, 18 Mar 2002 06:43:13 -0500
Date: Mon, 18 Mar 2002 12:43:12 +0100
From: Kurt Garloff <garloff@suse.de>
To: Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>,
        linux-kernel@vger.kernel.org,
        Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: SCSI-Problem with AM53C974
Message-ID: <20020318124311.D19273@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>,
	linux-kernel@vger.kernel.org,
	Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <200203171439.g2HEdwX00738@orion.steiner.local> <20020318123038.B19273@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iBwuxWUsK/REspAd
Content-Type: multipart/mixed; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2002 at 12:30:38PM +0100, Kurt Garloff wrote:
> Can you try the attached patch please? Patch is against 2.4.18.

Grmpff! Second try.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="AM53C974-ioport-register.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.18.ipt_fixes2.ix86/drivers/scsi/AM53C974.c.orig	Sun Sep 30 21=
:26:07 2001
+++ linux-2.4.18.ipt_fixes2.ix86/drivers/scsi/AM53C974.c	Mon Mar 18 11:59:3=
1 2002
@@ -732,6 +732,12 @@
 	hostdata->disconnecting =3D 0;
 	hostdata->dma_busy =3D 0;
=20
+	if (request_region (instance->io_port, 128, "AM53C974")) {
+		printk ("AM53C974 (scsi%d): Could not get IO region %04lx. Detaching ...=
\n",
+			instance->host_no, instance->io_port);
+		scsi_unregister(instance);
+		return 0;
+	}
 /* Set up an interrupt handler if we aren't already sharing an IRQ with an=
other board */
 	for (search =3D first_host;
 	     search && (((the_template !=3D NULL) && (search->hostt !=3D the_temp=
late)) ||
@@ -2441,6 +2447,7 @@
 static int AM53C974_release(struct Scsi_Host *shp)
 {
 	free_irq(shp->irq, shp);
+	release_region(shp->io_port, 128);
 	scsi_unregister(shp);
 	return 0;
 }

--+JUInw4efm7IfTNU--

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ldLPxmLh6hyYd04RAqSzAJ0TXh7mSn2pfvO4kqggjrbtqAriDACfeV/0
NQ4vzszGwjq+SQ8VULxYs8A=
=Wdj3
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
