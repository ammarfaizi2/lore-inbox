Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFQJMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFQJMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:12:20 -0400
Received: from mx02.qsc.de ([213.148.130.14]:55998 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261365AbTFQJMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:12:15 -0400
Date: Tue, 17 Jun 2003 11:28:33 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still problems with PCMCIA in 2.5.72
Message-ID: <20030617092833.GB623@gmx.de>
References: <20030617084622.GA623@gmx.de> <20030617095916.B25452@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20030617095916.B25452@flint.arm.linux.org.uk>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.4.20-ww9 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yes, this patch helps. I can insert/remove the card at will without
problems. Thank you.

On Tue, Jun 17, 2003 at 09:59:16AM +0100, Russell King wrote:
> On Tue, Jun 17, 2003 at 10:46:23AM +0200, Wiktor Wodecki wrote:
> > there are still issues with pcmcia in 2.5 series.
>=20
> I believe I have them all sorted.  However, I only received confirmation
> that the latest problem was solved this morning.
>=20
> It appears that some cardbus bridges don't properly debounce the card
> detect signals from the sockets, which sounds similar to the problem
> you're reporting.  Could you check whether this patch solves your issue?
>=20
> diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
> --- a/drivers/pcmcia/cs.c	Tue Jun 17 09:16:20 2003
> +++ b/drivers/pcmcia/cs.c	Tue Jun 17 09:16:20 2003
> @@ -816,7 +816,8 @@
>  				if ((skt->state & SOCKET_PRESENT) &&
>  				     !(status & SS_DETECT))
>  					socket_shutdown(skt);
> -				if (status & SS_DETECT)
> +				if (!(skt->state & SOCKET_PRESENT) &&
> +				    (status & SS_DETECT))
>  					socket_insert(skt);
>  			}
>  			if (events & SS_BATDEAD)
>=20
> --=20
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM L=
inux
>              http://www.arm.linux.org.uk/personal/aboutme.html

--=20
Regards,

Wiktor Wodecki

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+7t9B6SNaNRgsl4MRAo60AKCsXn8m7DgBbJ3pUHhqguWxUvL6YgCdEnCR
HZBWb/C0TMtIOk2fez77T0k=
=sqXP
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
