Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUBZVal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUBZVal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:30:41 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:30339 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261387AbUBZVab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:30:31 -0500
Subject: Re: Why no interrupt priorities?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Tim Bird <tim.bird@am.sony.com>
Cc: root@chaos.analogic.com, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <403E5EF7.7080309@am.sony.com>
References: <403E4363.2070908@am.sony.com>
	 <Pine.LNX.4.53.0402261423170.4239@chaos>  <403E5EF7.7080309@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c9Dv4Crscr9ELKFBe8aN"
Organization: Red Hat, Inc.
Message-Id: <1077831001.4443.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Feb 2004 22:30:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c9Dv4Crscr9ELKFBe8aN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-02-26 at 22:02, Tim Bird wrote:
> Richard B. Johnson wrote:
> > On Thu, 26 Feb 2004, Tim Bird wrote:
> >=20
> >>What's the rationale for not supporting interrupt priorities
> >>in the kernel?
> >=20
> > Interrupt priorities are supported and have been supported
> > since the first cascaded interrupt controllers and, now
> > with the APIC.=20
>=20
> Please forgive my ignorance.  I'm not sure what's going
> on with 2.6 and work queues, but do the hardware priorities
> allow you to control scheduling of interrupt bottom halves?


hardware IRQ priorities are useless for the linux model. In linux, the
hardirq runs *very* briefly and then lets the softirq context do the
longer taking work. hardware irq priorities then don't matter really
because the hardirq's are hardly ever interrupted really, and when they
are they cause a performance *loss* due to cache trashing. The latency
added by waiting briefly is going to be really really short for any sane
hardware.

Now doing priorities in softirq context... well... here again it's a
case of a tiny latency hit vs a lot of cache trashing. If your softirq
handler runs in 10 cachemisses (it's useless to talk about cpu cycles
since most of teh time you'll be cache bound) that's not too long
latency, but if you interrupt it it might get 15 or more cachemisses
instead. That again will increase the delay the user context gets from
irq's.... so from a userspace pov you actually increased irq latency....

--=-c9Dv4Crscr9ELKFBe8aN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAPmVZxULwo51rQBIRAo/LAKCENWSdIeR1UNWozRwM5VvdcwkUQQCgp2yh
Xy4tZHPnaZeBzuLKSiAxPLI=
=Hf8j
-----END PGP SIGNATURE-----

--=-c9Dv4Crscr9ELKFBe8aN--
