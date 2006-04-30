Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWD3MFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWD3MFW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWD3MFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:05:17 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:11483 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750798AbWD3MFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:05:15 -0400
Subject: Re: led_class: storing a value can act but return -EINVAL
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       John Lenz <lenz@cs.wisc.edu>, Richard Purdie <rpurdie@openedhand.com>
In-Reply-To: <1146398270.6254.9.camel@localhost.localdomain>
References: <1146310432.5019.45.camel@localhost>
	 <20060430100243.GB4452@ucw.cz>  <1146394862.5019.53.camel@localhost>
	 <1146398270.6254.9.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0yXEiJ/mlUWamJWQi9me"
Date: Sun, 30 Apr 2006 14:05:11 +0200
Message-Id: <1146398711.17814.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0yXEiJ/mlUWamJWQi9me
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-04-30 at 12:57 +0100, Richard Purdie wrote:

> echo 255> brightness works, returns success.

??
For me (bash) that doesn't do anything useful.
Were you looking for "echo -n 255 > brightness"?

> echo 255 > brightness works but then returns -EINVAL.

> So we currently do b, quite strictly. Its the trailing space thats the
> problem. It also shouldn't have altered the brightness value if it ends
> up returning -EINVAL.

Yes, but you do change the actual value, which IMHO you shouldn't when
it will return -EINVAL. I should have said

b) reject anything that isn't *only* a number and take no action

instead.

> I've looked around other implementations and it would appear we should
> accept an optional space. Most sysfs attributes seem to handle this
> differently, each with its own "bugs".

Yeah, unfortunately that is true. Maybe there should've been helper
functions like when you have a sysfs-int attribute that is set directly
without get/set calls. I'd suggest looking at that code.

> I've some fixes in mind both for the led and backlight classes which
> I'll post once I've done a little more testing. I'd be interested to
> know the official view on what the attributes should/shouldn't accept
> is.

I have a question about the backlight class: I'm writing a patch
currently to control the *keyboard* backlight on powerbooks, is that
appropriate for the backlight class (setting the fbdev callback to
reject everything)?

johannes

--=-0yXEiJ/mlUWamJWQi9me
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFSn9KVg1VMiehFYAQKVSg/9GxUR8fGcQI6dj+ZmNaxOxmmgZfUSBvz9
RcxB71JwZ5R1TEU0pzwItA0QrvCi+g0qfRSUq301uYAKPKYwe9O/B+FVl6WVMmIT
WN0iaFxi+3v9c0SIdsa1JaJDy3uVJnejmrpQH7wQYK7jOx/TZi7KL8XcCCpECXHE
on3t4JiFWATp9y3qoHtinl2wAfCbqe3rbulfIiOjRnAjdvneXgkB9e78rsBk84wL
C+AXxLs8ptKkD9uUYpwSQ33ETKmJBKl/C5340bTQKN5vH+qsTFWl3J9v6yxfuyhd
pthTzTOK21b+XINUcNYj+laHOzvPosUQGk1a1J6gvVoIQD4wBHFnPnf2tXaaBPU8
i6OYSgptPpP/f2nH2H4Q3vEPXHP5DVus6tfSJDTaROp4+UaKQ7UVY+eiwcCPlJmV
wA9KpGwQY+RA2lomzrBHRTCkk8YonaPOUQUYz+YiY0uHuEp2WQuPDB+bPIN2cq9m
a1id+xW+DhsVo6iDLyVDU3ndtxtol/34tvFWpX0grK3dl7IC//nvnB/PyKaoG46B
Maq/tCuCSfexpU9FEQY1eSQcduJ8zwvH+3/4Rg3zbvYtRNMPcC3/MgUOBWtE+wEq
t5PfcYpJpfzl4/0AHmcnORNeLwityV9WivfqdscRWlSHazP3GGAhNZqEZ3P7r9za
OwyAP1aoe74=
=2oJW
-----END PGP SIGNATURE-----

--=-0yXEiJ/mlUWamJWQi9me--

