Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270756AbTHANDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 09:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270757AbTHANDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 09:03:05 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:43192
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S270756AbTHANC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 09:02:58 -0400
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
From: Ian Kumlien <pomac@vapor.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ihar Philips Filipau <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030801123236.GS7920@suse.de>
References: <fw7N.3DP.11@gated-at.bofh.it> <3F2A2C14.9030801@softhome.net>
	 <1059740622.30747.67.camel@big.pomac.com>  <20030801123236.GS7920@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W0OHFgtFRSxir+2aXEjn"
Message-Id: <1059742902.5285.77.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 15:01:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W0OHFgtFRSxir+2aXEjn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-01 at 14:32, Jens Axboe wrote:
> On Fri, Aug 01 2003, Ian Kumlien wrote:
> > On Fri, 2003-08-01 at 11:00, Ihar "Philips" Filipau wrote:
> > >    Am I right - judging from your posting - that we finally reached=20
> > > moment than Linux will have network-like queueing disciplines for dis=
ks=20
> > > and CPUs?
> >=20
> > CPU's? well, we do have a nice sheduler but i wouldn't say network-like
> > queuing.
> >=20
> > >    In any way, CPU/disk throughput just another types of limited reso=
urce.
> > >    It would be nice to be able to manage it - who gets more, who gets=
=20
> > > less. CPU/disk schedulers by manageability are far behind network.
> > >    IMHO must have for servers.
> >=20
> > Yes, but, thats not what I'm saying.
> >=20
> > CFQ as it apparently was called, builds a queue list when the disk is
>=20
> I coined that phrase as a variant of SFQ, with C being Complete.

Yeah, i remember that now, but late at night your mind can be playing
tricks on you =3DP

> > under load. So you get really fast data access if there is no load, and
> > a common queue when there is load. The common queue is the bad thing
> > about CFQ, imagine putting AS there instead... This would mean fast dat=
a
> > access on unloaded systems, better throughput on loaded systems and
> > prioritization features could hook right in since AS would only be used
> > during load. IE, you can add all kinds of patches that only matters
> > during heavy load.
>=20
> I dunno where you get this from, but you seem to have a misguide picture
> of how io schedulers work in Linux. AS works like deadline, but adds
> anticipation. This means you try to anticipate whether a process will
> issue a nearby read soon, and if so stall the disk head. deadline itself
> has a single queue for merging/sorting, and a single queue as a deadline
> fifo (for each data direction, read and write).

Hummm, from what i gathered from reading this list it has a 'standoff
period' (like you said after getting data but also) before it initiates
a read... And afair, CFQ did just about 'nothing' when the disk wasn't
under 'load'.

I also thought that deadline didn't merge and sort on the same level as
AS.

> Where CFQ differs is that it maintains such a backend system for each
> "class" (user, could be a task grouping of some sort too), with a small
> front end (class independent scheduler is used in some contexts) to
> select which class we do IO from. The old design just round-robined
> between all "busy" tasks, with some heuristics to minimize seeks.

Ahhh

> So for a single task, deadline and CFQ works the same basically. AS
> differs because of the anticipation of course.

Yes, but...=20
I was more referring to the stalls in AS (the waits). If one could
eliminate them and just enable AS when the disk is loaded... Then we
could add all the 'bonus on wait' and or process priorities being
honored etc, atm, it just feels like overhead, it might be small but
still.

And, if sfq would build up one queue and feed it to AS, don't you think
there would be a gain? Esp in small reads when not loaded and scattered
small reads... Aswell as during heavy load?

> > > > I liked Jens Axobe's 'CBQ' alike implementation (based on the idea =
of
> > > > Andrea A. (afair i have the names right) since it does the most
>=20
> Nope, it's Axboe :)

Argh!
/me fires himself =3D)

--=20
Ian Kumlien <pomac@vapor.com>

--=-W0OHFgtFRSxir+2aXEjn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/KmS27F3Euyc51N8RAoD3AJ0TcHd9WRLWBdJts7a5st24sJimkgCfW5R6
eMzU4koNPrQD+NzzikweKG4=
=CzCw
-----END PGP SIGNATURE-----

--=-W0OHFgtFRSxir+2aXEjn--

