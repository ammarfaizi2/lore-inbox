Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUHWW76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUHWW76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUHWW6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:58:36 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:44226 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S268004AbUHWW57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:57:59 -0400
Date: Mon, 23 Aug 2004 15:57:53 -0700
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: Re: [PATCH] 2.6.8.1 modprobe tg3 oopses
In-reply-to: <20040821173654.6e5b9982.rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: bero@arklinux.org, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, ak@suse.de
Message-id: <1093301873.7841.7.camel@duffman>
MIME-version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-S06csJT8i284W9GUjdC+"
References: <20040820161141.28043ee8.rddunlap@osdl.org>
 <20040821173654.6e5b9982.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S06csJT8i284W9GUjdC+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-08-21 at 17:36 -0700, Randy.Dunlap wrote:
> I wouldn't expect this to be compiler-dependent.  There's an obvious
> problem with add_pin_to_irq().  It shouldn't be __init.  Patch below.
> (I thought that I had already mailed this one time, but I don't
> see it anywhere.)
>=20
> arch/i386/kernel/io_apic.c |    2 +-

There also needs to be a similar patch for arch/x86_64/kernel/io_apic.c.
Doing this fixed the oops for me.

Thanks,

-tduffy

--- arch/x86_64/kernel/io_apic.c.orig	2004-08-23 15:28:16.574961000 -0700
+++ arch/x86_64/kernel/io_apic.c	2004-08-23 15:10:41.319960000 -0700
@@ -80,7 +80,7 @@
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static void __init add_pin_to_irq(unsigned int irq, int apic, int pin)
+static void add_pin_to_irq(unsigned int irq, int apic, int pin)
 {
 	static int first_free_entry =3D NR_IRQS;
 	struct irq_pin_list *entry =3D irq_2_pin + irq;
z

--=-S06csJT8i284W9GUjdC+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKnZxdY502zjzwbwRAoayAJ0WLFOoEdrnJ0Qgp0Z1xL5juxl1+ACeIE3q
IH3VS90D1ykqSWIEonFBA3g=
=1biK
-----END PGP SIGNATURE-----

--=-S06csJT8i284W9GUjdC+--

