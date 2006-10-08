Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWJHWzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWJHWzF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWJHWzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:55:05 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:30376 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S932085AbWJHWzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:55:04 -0400
Message-ID: <45298184.1050006@web.de>
Date: Mon, 09 Oct 2006 00:53:56 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: linux-kernel@vger.kernel.org, Willy Tarreau <wtarreau@hera.kernel.org>
Subject: Re: 2.4.x: i386/x86_64 bitops clobberings
References: <452970AF.8020605@web.de> <20061008224440.GA30172@1wt.eu>
In-Reply-To: <20061008224440.GA30172@1wt.eu>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig482D501C0D7113736C6155AF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig482D501C0D7113736C6155AF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Willy Tarreau wrote:
> Hi Jan,
>=20
> On Sun, Oct 08, 2006 at 11:42:07PM +0200, Jan Kiszka wrote:
>> Hi,
>>
>> after going through debugging hell with some out-of-tree code, I
>> realised that this patch
>>
>> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git=
;a=3Dcommit;h=3D92934bcbf96bc9dc931c40ca5f1a57685b7b813b
>>
>> makes a difference: current 2.6 works with the following code sequence=

>> as expected (printk is executed), 2.4 fails.
>>
>>
>> #include <asm/bitops.h>
>> #include <linux/module.h>
>>
>> unsigned long a =3D 1;
>>
>> int module_init(void)
>> {
>> 	unsigned long b =3D 0;
>> 	int x;
>>
>> 	x =3D __test_and_set_bit(0, &b);
>> 	if (__test_and_set_bit(0, &a))
>> 		printk("x =3D %d\n", x);
>>
>> 	return -1;
>> }
>>
>>
>> There will likely be a way to work around my issue. Nevertheless, I
>> wondered if that patch was already considered for 2.4 inclusion. Or is=

>> there no risk that in-tree code is affected?
>=20
> While I remember some discussion on the subject for 2.6, I don't
> recall anything similiar in 2.4. Wouldn't you happen to build with
> gcc-3.4 ? IIRC, the clobbering changed around this version. Could

I used gcc 3.3.6-13 (Debian).

> you confirm that the patch you pointed above fixes the problem for
> your case ?

Yes. I ported the x86 part back to 2.4.33 and my problem disappeared.

Jan


--------------enig482D501C0D7113736C6155AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD0DBQFFKYGFniDOoMHTA+kRAiEMAJjpvdaPiebKBX0djSCT4miap/R0AJjIETeN
O2L1J4NXz6rkeY7NV4jk
=gU0k
-----END PGP SIGNATURE-----

--------------enig482D501C0D7113736C6155AF--
