Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWAIJs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWAIJs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWAIJs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:48:56 -0500
Received: from mail.gmx.de ([213.165.64.21]:63159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751213AbWAIJs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:48:56 -0500
X-Authenticated: #24128601
Date: Mon, 9 Jan 2006 10:49:23 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060109094923.GA8373@section_eight.mops.rwth-aachen.de>
References: <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de> <20060107160622.GA25918@section_eight.mops.rwth-aachen.de> <43BFFE08.70808@wasp.net.au> <20060107180211.GA12209@section_eight.mops.rwth-aachen.de> <43C00C32.9050002@wasp.net.au> <20060109093025.GO3389@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20060109093025.GO3389@suse.de>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mo, Jan 09, 2006 at 10:30:25 +0100, Jens Axboe wrote:
> Sebastian, care to try one more thing? Patch your kernel with this
> little patch and try ripping a known "faulty" track again _not_ using
> SG_IO. See if that produces the same faulty results again, or if it
> actually works.
>=20
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 1539603..2e44d81 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -426,7 +426,7 @@ int register_cdrom(struct cdrom_device_i
>  		cdi->exit =3D cdrom_mrw_exit;
> =20
>  	if (cdi->disk)
> -		cdi->cdda_method =3D CDDA_BPC_FULL;
> +		cdi->cdda_method =3D CDDA_BPC_SINGLE;
>  	else
>  		cdi->cdda_method =3D CDDA_OLD;
> =20
>=20
> --=20
> Jens Axboe
>=20
Hi Jens,

I applied your patch, recompiled the kernel, rebooted and recompiled
cdparanoia without the Red Hat patches. Extracting the first track of my
test cd the result was the same as without the kernel patch with ide-cd
using the cooked interface (md5 e8319ccc20d053557578b9ca3eb368dd).

Sorry :)

Sebastian
--=20
"When the going gets weird, the weird turn pro." (HST)

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDwjGjTWouIrjrWo4RAisWAKCQZsG+o4CTJ/TAH+SJr+XW2wJxEACfWN3r
xsrvolSVZIYgOC53J0b02jQ=
=hxZp
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

