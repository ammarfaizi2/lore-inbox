Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVBQQdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVBQQdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVBQQdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:33:49 -0500
Received: from matheson.swishmail.com ([209.10.110.114]:6904 "EHLO
	matheson.swishmail.com") by vger.kernel.org with ESMTP
	id S262303AbVBQQdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:33:24 -0500
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
From: "Richard F. Rebel" <rrebel@whenu.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <Pine.LNX.4.61.0502161559360.18376@goblin.wat.veritas.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com>
	 <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com>
	 <1108219160.12693.184.camel@blue.obulous.org>
	 <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com>
	 <3f250c710502160241222dce47@mail.gmail.com>
	 <Pine.LNX.4.61.0502161142240.17264@goblin.wat.veritas.com>
	 <3f250c7105021607022362013c@mail.gmail.com>
	 <1108567021.32711.529.camel@rebel.corp.whenu.com>
	 <Pine.LNX.4.61.0502161559360.18376@goblin.wat.veritas.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q/PRfsN3ZKD8I60TQ9PU"
Organization: Whenu.com
Date: Thu, 17 Feb 2005 11:33:22 -0500
Message-Id: <1108658002.32711.753.camel@rebel.corp.whenu.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.1.101mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q/PRfsN3ZKD8I60TQ9PU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Hugh,

On Wed, 2005-02-16 at 16:10 +0000, Hugh Dickins wrote:
> On Wed, 16 Feb 2005, Richard F. Rebel wrote:
> >=20
> > I have heard that this particular information, while very important to
> > userland developers like me, is probably too expensive to keep track of
> > for most users.
> >=20
> > Perhaps a way to enable it for developers, whom are willing to spend th=
e
> > cpu cycles, and disable it for regular use would be a solution.
> >=20
> > Would it be possible develop a solution allowing us to enable/disable
> > this tracking via a sysctl call?
>=20
> Possible, but I don't think a sysctl would make much sense here.
>=20
> The most important thing is that any heavyweight information gathering
> should not be happening by default, as a side-effect of something
> frequently run.

Okay and agreed.

> So a lot of people would oppose putting back any such heavyweight
> work into any of the /proc/<pid>/statm fields.  But if it goes into
> a separate /proc/<pid>/whatever, not read by current tools, then
> it's much less of a problem.
>=20
> I'm still resistant, because I think if the information you're
> interested in (how many private pages shared across forks) really
> were of interest to many people, then someone would soon write a
> top-like tool which kept sampling these values, and we'd be back to
> the original situation.  Or if it's not of interest to many people,
> then isn't it better off as an out-of-tree patch?

Well, let's put it this way.  In general, would you agree that the bulk
of Linux servers on the internet run apache?  It's also not hard to
assume that many of these also run apache+php or apache+mod_perl.

Apache has lots of modules and code that can easily be shared between
processes.  Especially when you use mod_perl or php.  This sharing
significantly effects the memory footprint and saves us all from having
gigabytes of memory that we don't really need.  My apache2 processes
have a VSS of around 120MB!

The capacity of a web serving machine is some combination of CPU,
Memory, and IO bandwidth.  Being able to measure the copy-on-write pages
for processes is a key variable to determining a machine capacity.  This
figure changes over the life of the process as well, and can be used to
tell children to exit once they reach a certain point.

Now, about keeping it in the vanilla kernel:  AFAIK, the only way to
acquire this information is from the kernel.  It's useful to developers,
and available on most other platforms.  Copy on write pages make sense,
why waste tons of RAM when there is no real need?  It makes sense to be
able to observe this behavior, and the information can guide developers
to make their applications more efficient.

In many organizations developers do not have the ability/skill to make
custom kernels.  They are given development platforms, told to write
their applications, and so on and so on.  Patching the kernel for
keeping track of cow's and subsequently maintaining that patch really
doesn't help them much.  I could go on but this is getting a bit off
topic.

Best,

Richard Rebel

> But I don't have a dogmatic position on it,
> and trust others' judgement better than my own.
>=20
> Hugh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Richard F. Rebel

cat /dev/null > `tty`

--=-Q/PRfsN3ZKD8I60TQ9PU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCFMdSx1ZaISfnBu0RAgCiAJ47QYKzlq9kYT19RzwRU8WO8FQmSQCfdpFS
Qi7uqi+1CqRHS75uwrL9oUg=
=Bie0
-----END PGP SIGNATURE-----

--=-Q/PRfsN3ZKD8I60TQ9PU--

