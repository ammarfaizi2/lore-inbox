Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUEQXHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUEQXHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUEQXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:06:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:52944 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263089AbUEQXG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:06:26 -0400
Date: Mon, 17 May 2004 21:52:42 +0200
From: Kurt Garloff <garloff@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
Message-ID: <20040517195241.GA4747@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1084229974.1763.512.camel@mulgrave> <20040511123441.GL4828@tpkurt.garloff.de> <1084282961.1886.8.camel@mulgrave>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <1084282961.1886.8.camel@mulgrave>
X-Operating-System: Linux 2.6.5-10-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

sorry for the late response.

On Tue, May 11, 2004 at 08:42:41AM -0500, James Bottomley wrote:
> On Tue, 2004-05-11 at 07:34, Kurt Garloff wrote:
> > Should I resubmit the other SCSI scanning/blacklist patches or are they
> > queued? Or rejected?
>=20
> I thought' I'd put in all the necessary ones, what's missing?

(0) scsi-log-unlikely
    Add unlikely to SCSI_CHECK_LOGGING() macro
(1) scsi-scan-deprecate-forcelun
    Mark BLIST_FORCELUN as deprecated; it should not be used.
    Don't discourage CONFIG_SCSI_MULTI_LUN so strongly.
    (Actually I believe it should always be switched on and=20
     people with completely broken hardware should get it=20
     blacklisted rather than "black"listing perfectly working
     devices. max_luns=3D1 can still be used to override it, but,
     for some reason there was no agreement about this on LSML,
     so I agreed on merging the patch as is ...)
(2) scsi-scan-blist_replun
    Introduce blacklist flags BLIST_NOREPORTLUN and BLIST_REPORTLUN2,
    so the use of REPORT_LUNS can turned off by passing dev_flags
    for a device or by default_dev_flags globally. The other flag
    allows to explicitly ask the kernel to try REPORT_LUNS on SCSI-2
    devices as well (normally it only uses it for SCSI-3 devices)
    if the host adapter does support more than 8 LUNs. This is=20
    mostly for RAIDs that are connected via FC (which supports more=20
    than 8 LUNs unlike SPI) that report as SCSI-2, so this flag can
    often be turned on. Just look at all the devices with=20
    BLIST_SPARSELUN | BLIST_LARGELUN. Could all be nuked on the long
    term ...
    The CONFIG_SCSI_REPORT_LUNS option is killed by this patch.
(3) scsi-scan-no-offl-pq-notcon
    Don't set devices to offline if the Periph Qual is non-zero.
    Instead don't connect to them from highlevel drivers except
    for sg.
(4) scsi-scan-inq-timeout
    Make the inquiry timeout configurable by boot/module parameter;
    there are some sick devices out there who need >20s to recover
    from a bus reset; we obviously don't want to bump the default
    to 25s because of that sickness.


Only patch 3 can be found in 2.6.6.


Patch 0 should be a no-brainer.
It allows vendors to enable CONFIG_SCSI_LOGGING
without incurring possibly mispredicted branches.

Patch 1 should go in; so we announce that the insanity of blacklisting
perfectly fine SCSI devices will stop at some point in the future (2.7.)

Patch 2 should go in; a config option is only useful for people
compiling their own kernels, i.e. developers. Thus there should be the
possibility to influence the use of REPORT_LUNS at boot or runtime.=20
Meanwhile the conflicting BLIST_MS_192_BYTES_FOR_3F has been defined,=20
which is less than optimal. The patch would need to be rediffed and=20
non-conflicting constants be used.

Patch 4 should go in; it allows users to work around sick SCSI devices
without needing to create crazy defaults.


All of these patches live in the SUSE Enterprise kernel and were
introduced because there was a need for them when supporting customers.

All patches have been discussed extensively on LSML and were changed
until opposition vanished.

If wanted, I can rediff and resubmit.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                        Director SUSE Labs

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqRgJxmLh6hyYd04RAlNBAKCus7Ltr49TLbAiwmktNXyFoYDxxQCeN35m
pEwyvsZmEam2H2lFqPMioZA=
=Msym
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
