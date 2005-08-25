Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVHYMSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVHYMSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVHYMSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:18:51 -0400
Received: from sipsolutions.net ([66.160.135.76]:55301 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S964953AbVHYMSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:18:50 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Johannes Berg <johannes@sipsolutions.net>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
In-Reply-To: <430D986E.30209@reub.net>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uo5EdOvpoa2VPIdsbDKv"
Date: Thu, 25 Aug 2005 14:18:27 +0200
Message-Id: <1124972307.6307.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uo5EdOvpoa2VPIdsbDKv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> I have also observed another problem with inotify with dovecot - so I spo=
ke=20
> with Johannes Berg who wrote the inotify code in dovecot.  He suggested I=
 post=20
> here to LKML since his opinion is that this to be a kernel bug.

Allow me to jump in at this point. The small tool below triggers this
problem for Reuben (confirmed via private mail) but works fine for me on
2.6.13-rc6.

johannes

--begin test program--
/* Author: Johannes Berg <johannes@sipsolutions.net>
 *
 * This is a small inotify test program that simply
 * repeatedly adds and removes watches.
 */

#include <stdio.h>
#include <linux/inotify.h>
#include <linux/inotify-syscalls.h>

int main()
{
	int fd;
	int wd1, wd2;
	int ret;

	fd =3D inotify_init();

	if (fd < 0)
		perror("inotify_init");

	printf("inotify_init returned fd %d\n", fd);

	while (1) {
		wd1 =3D inotify_add_watch(fd, "/tmp", IN_ALL_EVENTS);

		if (wd1 < 0) {
			perror("inotify_add_watch");
			break;
		}
		printf("inotify_add_watch returned wd1 %d\n", wd1);

		wd2 =3D inotify_add_watch(fd, "/", IN_ALL_EVENTS);

		if (wd2 < 0) {
			perror("inotify_add_watch");
			break;
		}
		printf("inotify_add_watch returned wd2 %d\n", wd2);

		ret =3D inotify_rm_watch(fd, wd1);
		if (ret < 0) {
			perror("inotify_rm_watch wd1");
			break;
		}
		ret =3D inotify_rm_watch(fd, wd2);
		if (ret < 0) {
			perror("inotify_rm_watch wd2");
			break;
		}
	}
}


--=-uo5EdOvpoa2VPIdsbDKv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQw23EaVg1VMiehFYAQJIqRAAt1iDJN7/dyHXVHrJyR3VKaxSOCARxTqn
FA5izq9aMys/WyIjwjnMv9i/IFXsm0SIEx/bsd30DYn/pG3XYGvzaGqzmgyQD/Uo
ma6PByO/XLwH1y56G6DqtHTOUShXWY6GAQhG/kSja11bLEc3fuVOoaBVeK8CK2oD
9ylK6cjkc41ed9a6t3+AmMvK1SQycxYRNgKeqyGCayHIRSSngxZQWpLRomcnzOxI
TTw+Zx4NU40RIzbNRHY2Qe5MNhzPIrdb0v+/zmiFJXzxqSA2QPUkWPXAEeheuL5K
GItDZJ2Ey7mR9sa63DAybFFg9yc6DkEVOvz38QKTEM4YkXbobvqUxAtqHb5oq2yk
azCi98W4eTclxOmRFGLbjvYCuWrBvFbWH2f9GiXoni3kHlvjcUeqlueTmwd13DTy
Ps35uBPOBoOsZ9BEznz7AIX6rzo9JWM8LWJ3f8mw00UlwoVBHi1ScfSAsJxfO8CB
l7dk6qKoFzxSrjnQym9ZLefx+dH23ij48pdMXDIowdSxRzZ6yv6xUuZ/k8PUkynW
HFd18lafXIuAuTlA0xj5nDE3utpVR5H5HU5MMpjQm2qzddiAMj3pycDRJYGyVsBe
B4/7ypax6W+Ar+I41czPHACCu5KvVig2c3zMcWDCWR/Gy7ci/2Ek3UeovoLD+5/D
k0Tu/ozwC28=
=13Fl
-----END PGP SIGNATURE-----

--=-uo5EdOvpoa2VPIdsbDKv--

