Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbTHAMTm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272519AbTHAMTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:19:42 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:32184
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S270751AbTHAMTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:19:40 -0400
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
From: Ian Kumlien <pomac@vapor.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F2A0863.5070806@cyberone.com.au>
References: <1059697921.30747.54.camel@big.pomac.com>
	 <3F2A0863.5070806@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mmIbkdt0sDaWAV0a6w1J"
Message-Id: <1059740304.5285.60.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 14:18:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mmIbkdt0sDaWAV0a6w1J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-01 at 08:27, Nick Piggin wrote:
> Ian Kumlien wrote:
>=20
> >Hi all,
> >
> >I have been following the sheduler and interactivity discussions closely
> >but via the marc.theaimsgroup.com archive, So i might be behind etc...
> >=3DP
> >
> >[Note: sorry if i sound like mr.know-it-all etc, just trying to get a
> >point across]
> >
> >Anyways, i think that the AS discussions that i have seen has missed
> >some points. Getting the processes priority in AS is one thing, but fist
> >of all i think there should be a stand off layer. Let me explain:
> >
> >I liked Jens Axobe's 'CBQ' alike implementation (based on the idea of
> >Andrea A. (afair i have the names right) since it does the most
> >important thing... which is *nothing* when there is no load (ie, pass
> >trough).
> >
> >AS might be/is the best damn io sheduler for loaded machines but when
> >there is no load, it's overhead. So in my opinion there should be
> >something that first warrants the usage of AS before it's actually
> >engaged.
> >
> >And, if it's only engaged during high load, additions like basing the
> >requests priority on the process/tasks priority would make total sense,
> >adding the 'wakeup on wait' or what it was would also make total
> >sense... But how many of your machines uses the disk 100% of the time?
> >(in the real world... )
> >
> >I don't know how 'CBQ' was implemented but any 'we are under load now'
> >trigger would do it for me.
> >
> >Please see to it that my CC is included in any discussions =3D)
> >
> >PS. Or was it a version of SFQ? in that case s/CBQ/SFQ/g
> >
>=20
> To start with its CFQ. Also could you clarify what you mean by
> load and what you mean by CFQ doing nothing, and why AS is overhead
> in the no load case. I can't really follow what you are saying.

CFQ passes the req's on directly until there is enough load... In the
load case it builds queues. Just like SFQ (but sfq can drop packets
afair).

This way, we wouldn't have the initial
'can-we-merge-this-with-other-data-coming' delay when not needed.

If as could be attached to the 'queue build up' then AS would only be
doing what it's good at, throughput and minimizing head movements.

Also patches that move prioritized data (data for processes with high
pri) would fit right in there since you'd only be doing it during actual
load.

(note: load as in disk load)
--=20
Ian Kumlien <pomac@vapor.com>

--=-mmIbkdt0sDaWAV0a6w1J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/KlqQ7F3Euyc51N8RAir9AJ9gGCojD5YD4RJdPYREhTyjhSIxxACfY8JX
1LB7S6QKlEykfxs4SO+t8mc=
=CZzy
-----END PGP SIGNATURE-----

--=-mmIbkdt0sDaWAV0a6w1J--

