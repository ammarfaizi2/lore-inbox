Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIP0x>; Tue, 9 Jan 2001 10:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbRAIP0o>; Tue, 9 Jan 2001 10:26:44 -0500
Received: from ns.snowman.net ([63.80.4.34]:30477 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S129903AbRAIP0c>;
	Tue, 9 Jan 2001 10:26:32 -0500
Date: Tue, 9 Jan 2001 10:25:25 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, hch@caldera.de,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109102525.Q26953@ns>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, hch@caldera.de,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010109141806.F4284@redhat.com> <Pine.LNX.4.30.0101091532150.4368-100000@e2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="loVroY/sZgZp7srB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101091532150.4368-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 03:40:56PM +0100
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 10:19am  up 145 days, 14:06,  6 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--loVroY/sZgZp7srB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ingo Molnar (mingo@elte.hu) wrote:
>=20
> On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
>=20
> > but it just doesn't apply when you look at some other applications,
> > such as streaming out video data or performing fileserving in a
> > high-performance compute cluster where you are serving bulk data.
> > The multimedia and HPC worlds typically operate on datasets which are
> > far too large to cache, so you want to keep them in memory as little
> > as possible when you ship them over the wire.
>=20
> i'd love to first see these kinds of applications (under Linux) before
> designing for them. Eg. if an IO operation (eg. streaming video webcast)
> does a DMA from a camera card to an outgoing networking card, would it be
> possible to access the packet data in case of a TCP retransmit? Basically
> these applications are limited enough in scope to justify even temporary
> 'hacks' that enable them - and once we *see* things in action, we could
> design for them. Not the other way around.

	Well, I know I for one use a system that you might have heard
of called 'MOSIX'.  It's a (kinda large) kernel patch with some user-space
tools but allows for migration of processes between machines without
modifying any code.  There are some limitations (threaded applications and
shared memory and whatnot) but it works very well for the rendering work
we use it for.  We use radiance which in general has pretty little inter-
process communication and what it has is done through the filesystem.

	Now, the interesting bit here is that the processes can grow to be
pretty large (200M+, up as high as 500M, higher if we let it ;) ) and what
happens with MOSIX is that entire processes get sent over the wire to=20
other machines for work.  MOSIX will also attempt to rebalance the load on
all of the machines in the cluster and whatnot so it can often be moving
processes back and forth.

	So, anyhow, this is just an fyi if you weren't aware of it that I
believe more than a few people are using MOSIX these days for similar
appliactions and that it's availible at http://www.mosix.org if you're
curious.

		Stephen

--loVroY/sZgZp7srB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Wy1lrzgMPqB3kigRAhHzAKCBurTvc8elEFpftqVZDuCVLq7OdgCggFdL
AvU9yTd3BetBFnqTUnKxH1U=
=J92I
-----END PGP SIGNATURE-----

--loVroY/sZgZp7srB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
