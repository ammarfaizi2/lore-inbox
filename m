Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbTHUPXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTHUPXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:23:09 -0400
Received: from coruscant.franken.de ([193.174.159.226]:60039 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S262741AbTHUPXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:23:03 -0400
Date: Thu, 21 Aug 2003 15:49:24 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Vishwas Raman <vishwas@eternal-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netfiltering - NF_IP_LOCAL_OUT - how it works???
Message-ID: <20030821134924.GJ7611@naboo>
References: <3F3C07E2.3000305@eternal-systems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Content-Disposition: inline
In-Reply-To: <3F3C07E2.3000305@eternal-systems.com>
X-Operating-System: Linux naboo 2.4.20-nfpom1101
X-Date: Today is Setting Orange, the 11st day of Bureaucracy in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vishwas, sorry for the late reply.  Most netfilter developers have
been to the netfilter developer workshop, I guess.

you should ask this question on the netfilter-devel mailinglist, where
it is more on-topic than on lkml.

On Thu, Aug 14, 2003 at 03:06:26PM -0700, Vishwas Raman wrote:

> While initializing the module, I register a NF_IP_LOCAL_OUT hook for the=
=20
> outgoing packet and change skb->dst->output to my_ip_output() instead of=
=20
> ip_output() in that hook function. After loading the module, I see=20
> control being transferred to my_ip_output() for all outgoing packets=20
> which in turn calls ip_output() and everything seems to work well.
>=20
> The exit function of the module also unregisters the hook that I am using.
>=20
> The problem is that after I unload the module, which in turn unregisters=
=20
> the hook, I have a kernel panic happening each time I use TCP.
>=20
> The panic occurs at the following point, ip_build_and_send_pkt() in=20
> ip_output.c where it is trying to call
>=20
>     NF_HOOK(PF_INET, NF_IP_LOCAL_OUT, skb, NULL, rt->u.dst.dev,
>                     output_maybe_reroute);
>=20
> I thought once the unregistering of the hook is done, it no longer looks=
=20
> for that hook function. I have no idea why it is failing. May be I am=20
> doing something grossly wrong with netfiltering. Anyone who is familiar=
=20
> with netfiltering and has registered and unregistered hooks before might=
=20
> be able to guide me regarding this.

I think either you are doing something wrong while unregistering from
the netfilter hook - or you are running into a race condition.  It might
happen, that you assign the skb->dst->output function of a packet to
your function, and then you remove the module before that packet is
actually sent.

> -Vishwas.

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/RM3kXaXGVTD0i/8RAuxeAJ41Bvg4wnW/OQMxgGdMtoS7zVY0lACgmhvZ
exsXAeFwe4eMNCqU2xHQ0tg=
=byAb
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
