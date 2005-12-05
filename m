Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVLERWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVLERWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVLERWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:22:46 -0500
Received: from mivlgu.ru ([81.18.140.87]:30413 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S932460AbVLERWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:22:46 -0500
Date: Mon, 5 Dec 2005 20:22:28 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: "Sergei Organov" <osv@javad.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: SATA ICH6M problems on Sharp M4000
Message-Id: <20051205202228.13232c10.vsu@altlinux.ru>
In-Reply-To: <87u0dri996.fsf@javad.com>
References: <200511221013.04798.marekw1977>
	<87u0dri996.fsf@javad.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__5_Dec_2005_20_22_28_+0300_/TvvCIs5RJodaIAg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__5_Dec_2005_20_22_28_+0300_/TvvCIs5RJodaIAg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 02 Dec 2005 22:33:57 +0300 Sergei Organov wrote:

> Sorry, but provided ata_piix has ignored the optical drive, couldn't
> corresponding I/O resource be left free so that subsequently loaded,
> say, generic-ide module is able to get over and support the drive?
> 
> BTW, loading the modules in reverse order helped on 2.6.13 kernel (that
> I'm currently using) as generic-ide didn't recognize the hard-drive at
> all allowing ata_piix to get over it later. With 2.6.14 kernel
> generic-ide does recognize both hard-drive and optical drive thus
> preventing ata_piix from managing the hard-drive :(

See http://lkml.org/lkml/2005/10/18/167 and the reply to it :-\

If you want to build IDE as modules and still have support for
combined mode, you will need the patch below:

-------------------------------------------------------------------------

ide/libata: fix SCSI_SATA_INTEL_COMBINED setting with modular IDE

SCSI_SATA_INTEL_COMBINED should be set in any case when both IDE and
libata drivers are present in the configuration, even if both of them
are modular.  Checking for IDE=y breaks existing configurations with
modular IDE drivers, because without SCSI_SATA_INTEL_COMBINED there is
no way to use libata drivers for SATA and IDE drivers for PATA.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- linux-2.6.14/drivers/scsi/Kconfig.alt-intel-combined	2005-10-28 04:02:08 +0400
+++ linux-2.6.14/drivers/scsi/Kconfig	2005-11-30 17:39:22 +0300
@@ -555,7 +555,7 @@ config SCSI_SATA_VITESSE
 
 config SCSI_SATA_INTEL_COMBINED
 	bool
-	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
+	depends on IDE && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
 	default y
 
 config SCSI_BUSLOGIC

--Signature=_Mon__5_Dec_2005_20_22_28_+0300_/TvvCIs5RJodaIAg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDlHdYW82GfkQfsqIRAml8AJ9dB+Fj9l8UuuUGZzQ4YyPqqY6p3QCfX1uk
+ap4DKkWJ1++WMwD8LJG9mc=
=LyyB
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Dec_2005_20_22_28_+0300_/TvvCIs5RJodaIAg--
