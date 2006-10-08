Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWJHVnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWJHVnl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWJHVnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:43:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:30601 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S932073AbWJHVnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:43:40 -0400
Message-ID: <452970AF.8020605@web.de>
Date: Sun, 08 Oct 2006 23:42:07 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Willy Tarreau <wtarreau@hera.kernel.org>
Subject: 2.4.x: i386/x86_64 bitops clobberings
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBE4F6381060BAC674C8C7479"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE4F6381060BAC674C8C7479
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

after going through debugging hell with some out-of-tree code, I
realised that this patch

http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D92934bcbf96bc9dc931c40ca5f1a57685b7b813b

makes a difference: current 2.6 works with the following code sequence
as expected (printk is executed), 2.4 fails.


#include <asm/bitops.h>
#include <linux/module.h>

unsigned long a =3D 1;

int module_init(void)
{
	unsigned long b =3D 0;
	int x;

	x =3D __test_and_set_bit(0, &b);
	if (__test_and_set_bit(0, &a))
		printk("x =3D %d\n", x);

	return -1;
}


There will likely be a way to work around my issue. Nevertheless, I
wondered if that patch was already considered for 2.4 inclusion. Or is
there no risk that in-tree code is affected?

Jan



--------------enigBE4F6381060BAC674C8C7479
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKXCvniDOoMHTA+kRAg9oAJ9PA6pYrdr42KbuOb/LuMjkc0SARgCcD/jE
llTy8UyHXgZDh9JL7MvQJUQ=
=e74T
-----END PGP SIGNATURE-----

--------------enigBE4F6381060BAC674C8C7479--
