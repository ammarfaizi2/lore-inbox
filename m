Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTLXJcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 04:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTLXJcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 04:32:33 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:34688 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263388AbTLXJcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 04:32:31 -0500
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Andres Salomon <dilinger@voxel.net>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
       jt@hpl.hp.com
In-Reply-To: <3FE8FC2E.3080701@pobox.com>
References: <1072229780.5300.69.camel@spiral.internal>
	 <20031223182817.0bd3dd3c.akpm@osdl.org>  <3FE8FC2E.3080701@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FVPA7lfpXJV0xCJGJBYj"
Organization: Red Hat, Inc.
Message-Id: <1072258184.5223.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 24 Dec 2003 10:29:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FVPA7lfpXJV0xCJGJBYj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Ummm...  there are many changes to the pcmcia net drivers in my=20
> net-drivers-2.5-exp queue.  All can be classified as fixes, to a greater=20
> or lesser degree, and I would put those at a higher priority than API=20
> cleanups and such.=20

This set is not so much about API cleanup as about fixing a REAL bug:
CardServices() has a very broken prototype that miscompiles on amd64 on
possibly others (even x86 with the right gcc flags).

Basically the function is implemented like this:

int CardServices(int func, void *a1, void *a2, void *a3)
{
...
}

however the prototype that drivers see is using varargs like this:

extern int CardServices(int func, ...);

varargs functions on amd64 have a different calling convention than
"normal" functions so this mismatches the actual implementation's
calling convention and goes west quite spectacular. The same might be
true for other architectures, and is true for x86 when you use
-mregparm.

You could argue we should just fix CardServices() instead, but well once
you do that you might as well kill it; even in 2.4 it's an optional API
which abstracts the real API.



--=-FVPA7lfpXJV0xCJGJBYj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6VyIxULwo51rQBIRApReAJ47BSd6WQ5S+HnxCTa9wpxwKPPbxQCfQ+Zs
Ccb15F4jm5qg6oUS3n60w0o=
=N5+y
-----END PGP SIGNATURE-----

--=-FVPA7lfpXJV0xCJGJBYj--
