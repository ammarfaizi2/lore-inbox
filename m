Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbULFCXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbULFCXp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 21:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbULFCXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 21:23:45 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.69]:17493 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261455AbULFCXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 21:23:41 -0500
Date: Sun, 05 Dec 2004 21:23:38 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH] Time sliced CFQ #2
In-reply-to: <41B3BD0F.6010008@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <20041206022338.GA5472@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary="5mCyUwZo2JvN/JJP";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
References: <20041204104921.GC10449@suse.de>
 <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de>
 <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2004 at 12:59:43PM +1100, Con Kolivas wrote:
> Jeff Sipek wrote:
> >I started working on the rudimentary io prio code, and it got me=20
> >thinking...
> >Why use the cpu scheduler priorities? Wouldn't it make more sense to add
> >io_prio to task_struct? This way you can have a process which you know=
=20
> >needs
> >a lot of CPU but not as much io, or the other way around.
>=20
> That is the design the Jens' original ioprio code used which we used in=
=20
> -ck for quite a while. What myself and -ck users found, though, was that=
=20
> being tied to cpu 'nice' meant that most tasks behaved pretty much as=20
> we'd expect based on one sys call.
>=20
> I think what is ideal is to have both.

Agreed.

> First the ioprio should be set to=20
> what the cpu 'nice' level is as a sort of global "this is the priority=20
> of this task" setting. Then it should also support changing of this=20
> priority with a different call separate from the cpu nice. That way we=20
> can take into account access privileges of the caller making it=20
> impossible to set a high ioprio if the task itself is heavily niced by a=
=20
> superuser and so on.

This sounds very reasonable. How would a situation like this one get
handeled:

nice =3D x
io_prio =3D y

where x!=3Dy

then, user changes nice. Does the nice level change alone? If so,
providing some "reset to nice=3D=3Dio_prio" capability would make sense, no?

Jeff.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBs8KqwFP0+seVj/4RAgsmAKCdtBFVfKT0nNllqj6J4KjjvpgcqgCgzDy8
D/fXi2HNwWmGF1OuczBCyv0=
=VXVq
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
