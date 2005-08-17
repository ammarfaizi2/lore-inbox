Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVHQLRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVHQLRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVHQLRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:17:09 -0400
Received: from sipsolutions.net ([66.160.135.76]:59662 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1751065AbVHQLRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:17:08 -0400
Subject: pmac_nvram problems
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: benh@kernel.crashing.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DnrwuaXU9nvaMrl7hxaQ"
Date: Wed, 17 Aug 2005 13:16:55 +0200
Message-Id: <1124277416.6336.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DnrwuaXU9nvaMrl7hxaQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Please CC me on answers, I'm not subscribed. I wasn't too sure where to
send this, so CC'ing to Benjamin Herrenschmidt as the author of the
relevant driver.

Note that this might apply to the copy in ppc64 as well, not sure.

Currently, the pmac_nvram driver can be built as a module, but doesn't
specify its license and also fails to load because it uses
alloc_bootmem:
| pmac_nvram: module license 'unspecified' taints kernel.
| pmac_nvram: Unknown symbol __alloc_bootmem

I'm not sure why alloc_bootmem is used at all (is the nvram larger than
a couple of pages on any machine? And if it is, should it really be
cached in RAM?), but I think it should be sufficient to just use kmalloc
(well, it works for me).

Secondly, this driver misses power management. Having suspended, I
booted OSX which always resets the boot volume. But after resuming
linux, nvsetvol(8) still reports 0 as the boot volume because the
pmac_nvram driver caches the nvram contents. Fixing this would require
converting the driver to the new model though, I think.

johannes

--=-DnrwuaXU9nvaMrl7hxaQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQwMcpaVg1VMiehFYAQLNJxAApPipdK+cvIMcy45vclfaRJyD1KKEvSDO
sErQjg3xmH9TghsGbrhlSW4mDKrXSF+XwNFAR+5/dDvYsJObLPkhdfK+WIj10w1x
nCL9tMNCZH0Gxat5u8ljl2/0A4kWmImMBxs7DDrjl1DloHdtuqIrQt+VvLnWIYXG
DUyiLI+o0ny/DkKR7yUsfjdbLueu5WSbvnmJ1L7StUkVruovjmh9ZO3cv89ZtV8g
HXvdwpVets67JQr+cEyKFmhgR6hRTHtMPgwJRbYrU9lDZXO20E8kJlL4ZTDmVg+P
Pb1Y3dlg8sw6nvtNZ3y9MyXvmDuXU5vk06gnJeEpaqoQ1Pg9hEcl0Bv7ULB4I1OL
/Pmj0gV21jvFu5uDGv+JS80psqNT0GkGE9LccrgxfbXNUr8k1kMvbKqaVdRx0Ccr
6dINqnO74/oIf4eapEJ5vtKmJdMKE2V5VE2jOXLXEzHRf0RS6WAmSQgO88m6hcGJ
Ss2b4Hc8Q8NBotlVALg7ELf+IyaVIsMcB+1lIZnsrUO95UH2Izb9u2JaZ03Fz8DM
LQnLBvKDHa0ymTl1K1GOAV617xPBvRuA3ndzvHonJseIS8qlSYnZsrgpS78VLFyp
mnfhvTY9srgJ5LVbEIKWQgYZLJWqXFDNTcXza2GiUflhFCGdNwU2F5geWsVNr4pF
QDXoPeqbj9M=
=83nK
-----END PGP SIGNATURE-----

--=-DnrwuaXU9nvaMrl7hxaQ--

