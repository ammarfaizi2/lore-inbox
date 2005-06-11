Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVFKXri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVFKXri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 19:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVFKXri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 19:47:38 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:5572 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261852AbVFKXrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 19:47:33 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12-rc6-mm1
Date: Sun, 12 Jun 2005 09:47:08 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <200506120820.05627.kernel@kolivas.org> <674540000.1118532454@[10.10.2.4]>
In-Reply-To: <674540000.1118532454@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1774366.JH50LUvJSv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506120947.13709.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1774366.JH50LUvJSv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 12 Jun 2005 09:27, Martin J. Bligh wrote:
> >> not sure what the benefits of the patch are,=20

I should have answered this. Since we moved to one runqueue per cpu with th=
e=20
current scheduler, 'nice' levels basically fall apart on SMP. Balancing ten=
ds=20
to group together all the wrong tasks to have any meaningful 'nice' support=
=20
where often on a 2 cpu machine if we run 4 tasks, 2 nice 0 and 2 nice 19 we=
=20
end up with:

cpu 1: nice 19 + nice 19
cpu 2: nice 0 + nice 0

which means each nice 19 task gets half a cpu and each nice 0 task gets hal=
f a=20
cpu which is lousy fairness.=20

The smp nice patches should end up with
cpu 1: nice 0 + nice 19
cpu 2: nice 0 + nice 19

so that the nice 0 tasks get 95% of a cpu and nice 19 tasks get 5% of a cpu.

The patches should balance things as fairly as possible according to nice=20
levels across cpus. As you can see this is clearly a bug in behaviour and h=
as=20
been a showstopper for many trying to move from 2.4.

Cheers,
Con

--nextPart1774366.JH50LUvJSv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCq3gBZUg7+tp6mRURAklkAJ9pl8lKSqHbs10DnopmLxEHhV0t6gCeKPvG
r8oguv5LFQEnZ+Y7TYJ+aM8=
=8AB5
-----END PGP SIGNATURE-----

--nextPart1774366.JH50LUvJSv--
