Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287129AbRL2ElW>; Fri, 28 Dec 2001 23:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287130AbRL2ElL>; Fri, 28 Dec 2001 23:41:11 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:52240 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S287129AbRL2Ekw>; Fri, 28 Dec 2001 23:40:52 -0500
Date: Fri, 28 Dec 2001 20:40:41 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: timothy.covell@ashavan.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, support@redhat.com
Subject: Re: Fwd: Hard Lockup on 2.4.16 with Via ieee1394 (sbp2 mode)
Message-ID: <20011228204041.A14736@one-eyed-alien.net>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	timothy.covell@ashavan.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, support@redhat.com
In-Reply-To: <200112290321.fBT3GCSs007627@svr3.applink.net> <3C2D3DBB.6ADE1CC5@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2D3DBB.6ADE1CC5@zip.com.au>; from akpm@zip.com.au on Fri, Dec 28, 2001 at 07:51:23PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm...

Does this apply to usb-storage also?  Under what conditions do you need to
hold the io_request_lock when calling the done function?

usb-storage calls it from task context, not from IRQ context.... if that
makes any difference.

Matt

On Fri, Dec 28, 2001 at 07:51:23PM -0800, Andrew Morton wrote:
> Timothy Covell wrote:
> >=20
> > lockup
> > ...
> > sbp2
> > ...
> > SMP
> > ...
>=20
> --- linux-2.4.17-pre8/drivers/ieee1394/sbp2.c	Mon Dec 10 13:46:20 2001
> +++ linux-akpm/drivers/ieee1394/sbp2.c	Wed Dec 12 20:50:16 2001
> @@ -2773,7 +2773,9 @@ static void sbp2scsi_complete_command(st
>  	/*
>  	 * Tell scsi stack that we're done with this command
>  	 */
> +	spin_lock_irq(&io_request_lock);
>  	done (SCpnt);
> +	spin_unlock_irq(&io_request_lock);
> =20
>  	return;
>  }
>=20
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Da.  Am thinkink of carbonated borscht for lonk nights of coding.
					-- Pitr
User Friendly, 7/24/1998

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8LUlJz64nssGU+ykRAne4AKD4l3yDpefSIPUvAVkDY45sKTzoKACgin4L
5K2cADnfvPO49ctUUyLnKsI=
=YAiR
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
