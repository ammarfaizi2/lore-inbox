Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293703AbSCKL0Y>; Mon, 11 Mar 2002 06:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293704AbSCKL0G>; Mon, 11 Mar 2002 06:26:06 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:61259 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S293703AbSCKLZx>; Mon, 11 Mar 2002 06:25:53 -0500
Date: Mon, 11 Mar 2002 12:25:49 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        "S. Chandra Sekharan" <sekharan@us.ibm.com>
Subject: Re: [PATCH] Support for assymmetric SMP
Message-ID: <20020311122549.I2346@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	"S. Chandra Sekharan" <sekharan@us.ibm.com>
In-Reply-To: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl> <20020311052954.R8949@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Content-Disposition: inline
In-Reply-To: <20020311052954.R8949@dualathlon.random>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Mon, Mar 11, 2002 at 05:29:54AM +0100, Andrea Arcangeli wrote:
> the only problem is if you happen to get the timer irq always in the
> same cpu for a few seconds, then the last_tsc_low will wrap around and
> gettimeofday will be wrong. And even if you snapshot the full 64bit of the
> tsc you'll run into some trouble if the timer irq will be delivered only
> to the same cpu for a long time (for example if you use irq bindings).
> you'd lose precision and you'll run into the measuration errors of
> fast_gettimeoffset_quotient. The right support for asynchronous TSC
> handling is a bit more complicated unfortunately.

If your APIC works, your CPUs should get the timer IRQs in alternating orde=
r.
At least that is what seems to happen on the SMP box where I created and
tested this patch. It works perfectly there.

In the more general case, you may need to do more, right.
You could make the xtime global again and send IPIs for every timer
interrupt to make all CPUs update their TSC offset.
Storing the full 64bit TSC may be a good option though.

So, if people wanted to have this included I'd rather document the
limitations (don't bind the timer IRQ to one CPU) than introducing
complexity which may hurt the normal SMP user.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8jJQ9xmLh6hyYd04RAiFeAKCqC6KOWNVD5rS4shejjUCaEldD/wCgpHP0
qigqt3oQYQLWbE5HUyM2J8A=
=RDeO
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--
