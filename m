Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUJQRoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUJQRoz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbUJQRoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:44:55 -0400
Received: from pop.gmx.de ([213.165.64.20]:16875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269237AbUJQRnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:43:06 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Date: Sun, 17 Oct 2004 19:46:31 +0200
User-Agent: KMail/1.7
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <200410162344.41533.dominik.karall@gmx.net> <87k6tpwebi.fsf@devron.myhome.or.jp>
In-Reply-To: <87k6tpwebi.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2517290.xttWXIDIS9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410171946.33472.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2517290.xttWXIDIS9
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 17 October 2004 17:32, OGAWA Hirofumi wrote:
> Dominik Karall <dominik.karall@gmx.net> writes:
> > i could reproduce it now, but only once. it appeared when i started an
> > avi movie from my fat32 partition. mplayer stopped at buffering 2% and
> > does not play the movie. i tried to start mplayer again and reproduce i=
t,
> > but the bug does not appear again. mplayer only stopped at 2% buffering
> > and does nothing more. it seems like the file couldn't be read clearly
> > now from the fat32 partition, as it does not work with xine and others
> > too.
> > here is the bug i get now:
> >
> > ------------[ cut here ]------------
> > kernel BUG at fs/fat/cache.c:150!
>
> Probably this BUG_ON() was wrong. Does this bug occur only by the
> specific file?
>
> If so, please do "filefrag -v filename" against that file.
>
> Then, can you try the attached patch? This patch removes the BUG_ON(),
> and instead adds printk() for debugging. When the bug occured, it prints
> the current cache.
>
> Thanks.

yes, the bug only occurs on a specific file.
as the bug is present in -mm1 (without vp) too, i applied your patch to tha=
t=20
one. here is the output:

fat_cache_check: id 0, contig 6415, fclus 38231, dclus 1010103
contig 6416, fclus 38231, dclus 1010103
contig 0, fclus 32, dclus 603964
contig 1, fclus 30, dclus 603960
contig 7, fclus 22, dclus 603950
contig 4, fclus 17, dclus 603943
contig 1, fclus 15, dclus 603940
contig 6, fclus 8, dclus 603931
contig 0, fclus 7, dclus 603929

and the movie starts to play in mplayer without problems. tell me if you ne=
ed=20
more debugging!

best regards,
dominik

--nextPart2517290.xttWXIDIS9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQXKv+QvcoSHvsHMnAQIjzgP/R3C9RgbwnCoYPeGjcVINlMgQGMvsioob
9jXOj4tYd+g1jcALyLhpQDGisySsnkk99jB+Deq0GV2SupWlPkUVwjjaSMkE/i2W
D9IRsKwtlW8BW3A3qGQW8bmVPkMmZL0IXapDKoe+QR/VgI45YwlHU7LoMmEWu0dU
+aA0EuGFEwE=
=w52T
-----END PGP SIGNATURE-----

--nextPart2517290.xttWXIDIS9--
