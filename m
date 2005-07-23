Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVGWDpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVGWDpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVGWDpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:45:06 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:58531 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S262325AbVGWDpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:45:03 -0400
Date: Sat, 23 Jul 2005 09:33:53 -0400
From: Harald Welte <laforge@netfilter.org>
To: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>
Cc: davem@davemloft.net, johnpol@2ka.mipt.ru,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
Message-ID: <20050723133353.GB11177@rama>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= <yoshfuji@linux-ipv6.org>,
	davem@davemloft.net, johnpol@2ka.mipt.ru,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <20050723125427.GA11177@rama> <20050722.230559.123762041.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20050722.230559.123762041.yoshfuji@linux-ipv6.org>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2005 at 11:05:59PM -0400, YOSHIFUJI Hideaki / =E5=90=89=E8=
=97=A4=E8=8B=B1=E6=98=8E wrote:
> In article <20050723125427.GA11177@rama> (at Sat, 23 Jul 2005 08:54:27 -0=
400), Harald Welte <laforge@netfilter.org> says:
>=20
> > --- a/include/linux/netlink.h
> > +++ b/include/linux/netlink.h
> > @@ -20,7 +20,7 @@
> >  #define NETLINK_IP6_FW		13
> >  #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
> >  #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
> > -#define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
> > +#define NETLINK_W1		16	/* 16 to 31 are ethertap */
> > =20
> >  #define MAX_LINKS 32	=09
> > =20
>=20
> Comment says that 16-31 are used for ethertap.
> So, probably assigh NETLINK_W1 at 32, and bump MAX_LINKS?

MAX_LINKS > 32 would result in larger statically allocated pointer
arrays.  It would also only work if NPROTO is increased too, IIRC.

I strongly disrecommend increasing NPROTO.  Maybe we should look into
reusing NETLINK_FIREWALL (which was an old 2.2.x kernel interface).

But to be honest, I don't really care all that much as long as existing
and still very actively used values are not just overloaded.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4kdBXaXGVTD0i/8RAvreAJ944vt2zJ4xHKnekAg9JA3erj3/5QCfYX4Y
UZlN+GVAacw2MqUOjH1Y178=
=sQrS
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
