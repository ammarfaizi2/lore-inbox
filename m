Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWBBW11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWBBW11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBBW11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:27:27 -0500
Received: from sipsolutions.net ([66.160.135.76]:36357 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932334AbWBBW10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:27:26 -0500
Subject: [RFC 0/4] firewire: interface to remote memory (mem1394)
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-04BagNTDK3udtUqtDVhq"
Date: Thu, 02 Feb 2006 23:27:18 +0100
Message-Id: <1138919238.3621.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-04BagNTDK3udtUqtDVhq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The following series of four patches adds the possiblity for creating
device nodes for each node attached to the firewire bus and accessing
them (currently read-only) which yields access to the node's RAM, if
supported. This is useful for peeking into machines during debugging
(obviously only if you can attach a firewire cable). This is already
supported via the raw1394 interface, but surfacing this like /dev/mem is
advantageous because then user-space tools can work without
modification.

mem1394 itself is currently a bit limited and lacking on the
error-checking, it will be improved but I wanted to get some comments on
the current patches too. Write support will also be added.

The node interface and dynamic character device allocation are useful on
their own if another layer is ever introduced -- which has been under
discussion once a while to make something similar to raw1394 that gives
access only to certain nodes to separate users.

If you want to test this add a udev rule like the following:
  KERNEL=3D=3D"fwmem-[0-9]*", NAME=3D"fwmem-%s{device/guid}"
and then use
  dd if=3D/dev/fwmem-0x<GUID> bs=3D1K count=3D1024 of=3D/tmp/first-megabyte
to, for example, read the targets first megabyte of memory.

The patches (will be posted as follow-ups):
1/4: node interface
2/4: dynamic cdev allocation below firewire major
3/4: unconditionally export hpsb_send_packet_and_wait
4/4: add mem1394

Comments would be appreciated.

Thanks,
Johannes

--=-04BagNTDK3udtUqtDVhq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ+KHRaVg1VMiehFYAQKiwRAAsAToJRUNo3ppNsM6kDTnlxwKNj7x5Yn/
J7fR8nZSRGWK8FuoUejM3H/3faw+H8G+TF62KxCfqRY01p//SsGpFqx8r5UC3fAA
j56OT4rdlw9aZg+YM/K0b1m2396E0D2TzVat6zrbvqeipRs0C/dAbmhrPZcN8GBd
EOmT4yX8DzUyHJpWB/GjIOFgGoYTRipbU3RfXVZ8g1VMz8b2umd30vIlLpKiSM2b
eD1mUp+Xac4v5/msr7/JY1WvZ3FQ3cy34okU18AjYfIr2uHDLImoFbFR669QYmsD
MV0BMUoWWzqYfdkXxdbjJDheZNqo/X8hB+PucU6KJ8zf2l7qRCLCR75S2lLIrmD4
VfcVZ76f8tXRiIeWs0ev+c2Kj/Q39CTbooijIzneDlBoxonom2qJD0ab328lcrbn
OjhfHLSf6sN007UG0/i+XqvszxxaK7V8UbFoi1Jx7LxNfhhsSC0RBorIHLYluCBt
zVYSjH7jPKP4UdCqbPhc8jUFuF6NyJSAUr9grV5ItkTOAPt9L2wXsn2dxhVGgN6w
5qKhobBgnFAvz7El8LqeRaSeUkVCz7hEPMIkPemGNQb65Zvcich1jLPLyB6eDa34
q/wK6RS8tMliIZcW0jP9XN7YKQ2pWE4v+ReMTAWs7lHGLPZVy77N44JBPcOcTW0S
goeFQbSmIyE=
=+8t2
-----END PGP SIGNATURE-----

--=-04BagNTDK3udtUqtDVhq--

