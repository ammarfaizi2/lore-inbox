Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWD3LVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWD3LVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 07:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWD3LVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 07:21:40 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:60137 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750924AbWD3LVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 07:21:39 -0400
Subject: Re: led_class: storing a value can act but return -EINVAL
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       John Lenz <lenz@cs.wisc.edu>, Richard Purdie <rpurdie@openedhand.com>
In-Reply-To: <20060430100243.GB4452@ucw.cz>
References: <1146310432.5019.45.camel@localhost>
	 <20060430100243.GB4452@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-joP0NiYI14vneo2ACdnZ"
Date: Sun, 30 Apr 2006 13:01:02 +0200
Message-Id: <1146394862.5019.53.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-joP0NiYI14vneo2ACdnZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> Well, I'd argue current behaviour is okay... can you strace it? It
> should accept the number (return 3) then return -EINVAL.

That's exactly what happens.

Which is totally bogus, because userspace will think that the setting
didn't succeed. Or application authors will ignore the return value
assuming that it always succeeded. Or read the value back to see if it
succeeded. All icky, when we can well have a good return value.

> > There are two possible ways to handle this:
> > a) accept anything that begins with a valid number.
> > b) reject anything that isn't *only* a number
>=20
> c) accept anything that is number, ignore newlines.

Which is kinda hard to implement.

> a) is just way too ugly...

Well, I'd argue that it doesn't matter much since sysfs values are by
definition a single value per file, so you'll already know that putting
multiple "values" in is bogus.

johannes

--=-joP0NiYI14vneo2ACdnZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFSY7KVg1VMiehFYAQKMPg//evh0B72oDda3E4vhtqpKHqD0zBIBmlAo
SYZ8+ec+bjzgycjKXushtY3t572VmpYjVOiNd3XgYgNoAI5ioXMP1nTwlsmHH3VO
47DrhnrbU/BJG6I3hEKMpIpeFyVPaKrTdU2ArKCRyjUaDJIm489ST0cpDg5Bzi7M
lBPNW0LpGk4Bn3H1uR8qEhLE1PGDKrdenpzetotq9pWc4oDgEnBbUuD7BE88rChL
qECMygyNl2bn4JuIHpG8va13VtkaRw0aqQgp+VmhKvO1NPK1s6naEElV04DIwEC0
NEOnw/WnKTVQeIiAm1UD7el+q8fh9XwJMYAwofzbzPTyNCHTkqw5qr74YCFTb+Sj
APzE4EaBoPOp4cUtGn5JKBhfhZ4Vv08CNw4I7zBvam9MWudeT2Exe2j6pAcXQYiu
wmGefBiW15vLzlwFqI3faKDKKXa8+tpikERa4bl+N6ReMV74bMh+azHn2F7NEUqJ
nhAwKTq0dCplebkJKk2NKDBhX7i2dR5W25p/MOgwu679t1Fq9++j7bJhDnKq/A/5
L4WfFVK+xWsTnpRNWuyaW+n5aOrN8oIM7Mvh75JMKmEbPeZZx3CUJZHUL81pRNMd
Uh6yjjcQjICI/kOj78Lc756YjBI9o63MuSs8Bl8BzjU6Z7tzqKYLUyzNVkjiy+Z3
hJy7o3s0law=
=Drrg
-----END PGP SIGNATURE-----

--=-joP0NiYI14vneo2ACdnZ--

