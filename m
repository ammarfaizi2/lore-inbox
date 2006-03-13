Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWCMBqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWCMBqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 20:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbWCMBqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 20:46:25 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61637 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751076AbWCMBqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 20:46:25 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Date: Mon, 13 Mar 2006 11:43:55 +1000
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <200603130930.11800.kernel@kolivas.org>
In-Reply-To: <200603130930.11800.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2606928.AAVdVmza96";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603131144.01462.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2606928.AAVdVmza96
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 13 March 2006 08:30, Con Kolivas wrote:
> On Monday 13 March 2006 08:32, Andreas Mohr wrote:
> > And... well... this sounds to me exactly like a prime task
> > for the newish swap prefetch work, no need for any other
> > special solutions here, I think.
> > We probably want a new flag for swap prefetch to let it know
> > that we just resumed from software suspend and thus need
> > prefetching to happen *much* faster than under normal
> > conditions for a short while, though (most likely by
> > enabling prefetching on a *non-idle* system for a minute).
>
> Adding a resume_swap_prefetch() called just before the resume finishes th=
at
> aggressively prefetches from swap would be easy. Please tell me if you
> think adding such a function would be worthwhile.

My 2c would be that swsusp is broken in a number of ways in discarding thos=
e=20
pages in the first place:

=2D Forcing pages out to swap by vm pressure is an inefficient way of writi=
ng=20
the pages.
=2D It doesn't get the pages compressed, and so makes inefficient use of th=
e=20
storage and forces more pages to be discarded that would otherwise be=20
necessary.
=2D Bringing the pages back in by swap prefetching or swapoffing or whateve=
r is=20
equally inefficient (I was going to say 'particularly in low memory=20
situations', but immediately ate my words as I remembered that if you've ju=
st=20
swsusp'd, you've freed at least half of memory anyway).
=2D This technique doesn't guarantee that the pages you end up with in memo=
ry=20
are the pages that you're actually most likely to want. The vast majority o=
f=20
what you really want will simply have been discarded rather than swapped.

Having said that, Rafael is making some progress in these areas, such that=
=20
swsusp is eating less memory than it used to, so that swap prefetching will=
=20
be less important at resume time than it has been in the past.

Hope this helps.

Nigel

--nextPart2606928.AAVdVmza96
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFM5hN0y+n1M3mo0RAsxyAJ0RRCPgJBOyKYetQm/Ojs4BnHYslACeMzHd
xN3dpsBLWL6KyYFfZyrsiuA=
=Nu1T
-----END PGP SIGNATURE-----

--nextPart2606928.AAVdVmza96--
