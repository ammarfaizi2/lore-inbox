Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVA0BBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVA0BBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVA0BAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 20:00:51 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:34067 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262472AbVA0A5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 19:57:06 -0500
Date: Wed, 26 Jan 2005 21:31:18 +0100
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
To: linux-kernel@vger.kernel.org
Cc: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       netdev@oss.sgi.com
Subject: Re: waiting for ppp0 to become free (Re: ppp0 out of control)
Message-ID: <20050126203118.GB3705@roxor.be>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.be>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
	netdev@oss.sgi.com
References: <20050121144444.GA2100@roxor.be> <20050126094422.GA31040@lk8rp.mail.xeon.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20050126094422.GA31040@lk8rp.mail.xeon.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 26, 2005 at 10:44:22AM +0100, Janos Farkas wrote:
> On 2005-01-21 at 15:44:44, Aur=E9lien G=C9R=D4ME wrote:
> > I am running 2.6.10 from kernel.org on Debian Sid ppc/x86, the same
> > issue occurs with 2.6.9. Though, 2.6.8.1 and previous are fine.
> >=20
> > When my ISP connection via PPPoE (kernel side) goes down, reconnection
> > does not occur, and the kernel displays continuous:
> >=20
> > kernel: unregister_netdevice: waiting for ppp0 to become free. Usage co=
unt =3D 1
>=20
> BTW, I have seen many cases when this symptom annoyed me too, the last
> one is that my shutdown scripts tried unloading the network driver
> modules.  Is your setup doing this by any chance?  In my case,
> apparently there were conntrack entries keeping the device in use,
> which is almost useless when preparing to shutdown :)

Actually, it happens after my ISP's LCP echos are not coming anymore,
and then when pppd try to reconnect.

> OTOH, I couldn't find a way to flush those conntracks, so I worked
> around it by not rmmoding ethernet drivers.

I have conntrack modules loaded too. I will try removing 8139too
(on x86) and sungem (on ppc) if the issue occurs again. By the way,
I also have IPv6 loaded, since I use a dual-stacked connection with
native IPv6. How lucky I am! :)

> In your case, it's probably conntrack too, I'd presume you are using
> that PPPoE machine as a masquerading gateway, which by definition needs
> connection tracking...  I'm not sure either if this is a "real" change,
> I only vaguely recollect as some moons earlier this wasn't a problem in
> 2.6.

Yep, 2.6.8.1 works fine, this issue appears on 2.6.9 and 2.6.10. I
switched to a Debian 2.6.10 kernel for security reasons, and
the issue has not come yet. I had a glance at the changelog and
saw some network related patches. This is the -as patchset, see
<http://kerneltrap.org/node/4545> about it.

Cheers.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB9/4WI2xgxmW0sWIRAgcfAKDAfTExqnEouPtAnjH9XZpGc0kANwCfcdSU
XZvwJNjym00EPqzyod6JU5o=
=0MKM
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
