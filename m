Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWGKWlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWGKWlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWGKWlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:41:42 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58759 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932217AbWGKWlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:41:40 -0400
X-Sasl-enc: NqRgrcOaWhiTyboEFjOJF2zEaO/uG5DZT6Gi+jUdjgok 1152657695
Message-ID: <44B4297E.3040802@imap.cc>
Date: Wed, 12 Jul 2006 00:43:10 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kkeil@suse.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, hjlipp@web.de
Subject: Re: [mm Patch] isdn4linux: Gigaset driver: fix __must_check warning
References: <20060711115359.C9A4D1B8F4F@gx110.ts.pxnet.com> <20060711145117.25dd09f2.akpm@osdl.org>
In-Reply-To: <20060711145117.25dd09f2.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD508CBDE3C4EC1E2C82AF433"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD508CBDE3C4EC1E2C82AF433
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11.07.2006 23:51, Andrew Morton wrote:

> Tilman Schmidt <tilman@imap.cc> wrote:
>=20
>>-	class_device_create_file(cs->class, &class_device_attr_cidmode);
>>+	if (class_device_create_file(cs->class, &class_device_attr_cidmode))
>>+		dev_warn(cs->dev, "could not create sysfs attribute\n");
>=20
> With this change we'll emit a warning (actually it's an error - I'll ma=
ke
> it dev_err(), OK?)

Fine with me. It's not fatal to the driver which is quite capable of
operating without that sysfs file, but ok, it *is* an error, and in
fact, if class_device_create_file() fails there must be something
seriously wrong.

> and then we'll continue execution, pretending that the
> sysfs file actually got registered.  Later, we'll try to unregister a
> not-registered sysfs file.

Well, from my reading of the source, class_device_remove_file() should
be able to cope with that. The alternative would be to save off the
fact that the original creation failed somewhere in the driver data,
for the sole purpose of avoiding calling class_device_remove_file()
for it later.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigD508CBDE3C4EC1E2C82AF433
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtCmIMdB4Whm86/kRAp4UAJwNv9mKJ/5dhbwgEmr7ueIZmDXfEQCdH31m
VrER0QLluXaW5NmJ3h+ie5s=
=q1eA
-----END PGP SIGNATURE-----

--------------enigD508CBDE3C4EC1E2C82AF433--
