Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVBNEvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVBNEvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 23:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVBNEvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 23:51:31 -0500
Received: from cantor.suse.de ([195.135.220.2]:27617 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261340AbVBNEvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 23:51:21 -0500
Date: Sun, 13 Feb 2005 23:51:00 -0500
From: Kurt Garloff <garloff@suse.de>
To: Joe Krahn <krahn@niehs.nih.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bogus REPORT_LUNS responses breaks SCSI LUN detection
Message-ID: <20050214045100.GA27893@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Joe Krahn <krahn@niehs.nih.gov>, linux-kernel@vger.kernel.org
References: <41DF1D96.6030109@niehs.nih.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofQ+NWZjH2FySEVi"
Content-Disposition: inline
In-Reply-To: <41DF1D96.6030109@niehs.nih.gov>
X-Operating-System: Linux 2.6.11-rc3-bk6-20-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ofQ+NWZjH2FySEVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2005 at 06:39:02PM -0500, Joe Krahn wrote:
> There are apparently several devices that return bad data
> for the REPORT_LUNS query, but do not return an error.
> The newer kernels only do sequential LUN scans if REPORT_LUNS
> fails. There may need to be a kernel option to force sequential
> scans.

There is.
Try passing scsi_mod.default_dev_flags=3D0x40000
The SUSE initrd will also understand the better memorizable version
scsi_noreportlun=3D1.

Devices known to be broken should be added to the blacklist with
BLIST_NOREPORTLUN.

> Here are some related reports of problems. All of these are RAID
> systems, so it may be a specific embedded controller at fault,
> but you can't tell this by looking at the Vendor/Model fields.
>=20
> SuSE 9.1
> Vendor: easyRAID Model: X16 Rev: 0001
> Type: Direct-Access ANSI SCSI revision: 03
> scsi: host 0 channel 0 id 5 lun 0x6500737952414944 has a LUN larger than=
=20
> currently supported.

Looks like random garbage.

> SuSE 9.1
> Vendor: FX-1600U Model: 3-R Rev: 0001
> Type: Direct-Access ANSI SCSI revision: 03
> scsi: host 3 channel 0 id 0 lun 0x00000200080c0400 has a LUN larger than=
=20
> currently supported.

This probably uses some of the less common LUN numbering?
REPORT_LUNS reports 8byte LUN numbers, which are flattened according
to the most commonly used scheme to a 32bit unsigned int by Linux.
We might change that the LUNs to be opaque or detect the LUN encoding
before flattening.

> Kernel 2.6, unknown distro
> Vendor: transtec  Model:                   Rev: 0001
> Type:   Direct-Access                      ANSI SCSI revision: 03
> On host 1 channel 0 id 1 only 128 (max_scsi_report_luns) of 536870896=20
> luns reported, try increasing max_scsi_report_luns.
> scsi: host 1 channel 0 id 1 lun 0x7400616e73746563 has a LUN larger than=
=20
> currently supported.

Garbage.

> Fedora Core 2 and 3
> Vendor: Tornado-  Model: F4                Rev: 0001
> Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi: host 1 channel 0 id 8 lun 0x00000200080c0400 has a LUN larger than=
=20
> currently supported.

LUN flattening issue?

> I noticed that these LUN hex values decode to text fragments:
> Easy RAID decodes to: 'e.syRAID'
> Vendor=3DTranstec, lun decodes to 't.anstec'.

Ask them to fix it.

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--ofQ+NWZjH2FySEVi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCEC40xmLh6hyYd04RAgV0AKCW7A/ahjKrNYTcLmrWUNjwKRXJdACeNqt1
aj48fSqGG2cI28jzCFYeoe4=
=5sev
-----END PGP SIGNATURE-----

--ofQ+NWZjH2FySEVi--
