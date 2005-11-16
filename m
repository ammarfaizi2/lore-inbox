Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbVKPVm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbVKPVm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVKPVm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:42:26 -0500
Received: from mail.gondor.com ([212.117.64.182]:24590 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1030516AbVKPVmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:42:25 -0500
Date: Wed, 16 Nov 2005 22:42:23 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051116214222.GB4935@knautsch.gondor.com>
References: <20051116181612.GA9231@knautsch.gondor.com> <437B912B.7090505@samwel.tk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <437B912B.7090505@samwel.tk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2005 at 09:06:03PM +0100, Bart Samwel wrote:
> First of all, you having resized your fs is a smoking gun, if you ask=20
> me. Your fs is dead/dying, and you know you've recently been tinkering=20
> with it. It's the most probable cause.

Well, it would be nice if the explanation was that easy - but the recent
corruption (with the man page) was on my root partition, which is not on
LVM and has never been resized.

> Secondly, I think that your resize sequence is missing an e2fsck -f=20
> after resize2fs.

Be assured that at least after the first corruption I observed, I did
forced e2fsck on all partitions. Without any errors found.

> after the resize2fs -- seeing as all the subsequent fscks were probably=
=20
> done by journal.

What do you mean with 'by journal'? The filesystems were unmounted (or
remounted r/o), so the journal should have been committed and empty at
e2fsck time.

> >But now, I got another hint pointing to a possible cause of this
> >problem: I found a file - /usr/lib/libatlas.so.3.0 - which was corrupted
> >by 4k of it being overwritten by a different file, which I recognized.=
=20
> >And that file happened to be an uncompressed manual page.
>=20
> This sounds like your filesystem's block bitmaps are "fscked up". These=
=20
> problems can definitely cause "creeping corruption" when undetected,=20

But this should definitely have been detected by an fsck, right?

> (especially if your filesystem has a relatively large amount of free=20
> space, as it probably does because you just resized it)

Root fs is 94% full, and during apt-get upgrade sometimes becomes
completely full. (Which I don't like, because it probably causes bad
fragmentation...)

> About the laptop mode hypothesis: I think it's just a coincidence. If=20
> it's not, then it could be a "sync-time-only" problem (because what=20
> laptop mode does before spindown is a sync), but not a specific laptop=20
> mode problem -- laptop mode doesn't influence block numbers whatsoever.=
=20
>  But if it were a sync problem, we would be seeing a lot more reports=20
> of corruption. For now my vote is with the resize. :)

I agree it's probably not a sync problem. And therefore, probably not
really a laptop-mode bug, even if laptop-mode triggered the corruption.
I suspected the hard drive to mess up write requests during spin-up. Or
perhaps giving some kind of error message, which could trigger a bug in
a rarely tested error-handling path in the kernel. But the fact that you
never got similar reports makes this less likely. In the end, I have to
consider there may be some bad hardware in my laptop. (Already did a
memtest86, of course.)

Jan



--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ3unt4FL8fYptN/eAQLA4AP+KB1AipOfks2P1k9n2YLy+W7V6i/DOoh9
hIN6A7HAMCC/8EHrgWhHeJ9tpyoQ/6ggqF8YFBg0XdOMr++7/Qjg9SEOFQyeErNd
WH5wuO/c8qvLW/cB5zzvCyVqZ2Df4qP9O82U/ykK3dVjVmSFkBE1FWIXnCNiBKu2
X6elVjjPi8g=
=8mC+
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
