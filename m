Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVBPPRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVBPPRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVBPPRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:17:16 -0500
Received: from matheson.swishmail.com ([209.10.110.114]:18903 "EHLO
	matheson.swishmail.com") by vger.kernel.org with ESMTP
	id S262039AbVBPPRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:17:02 -0500
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
From: "Richard F. Rebel" <rrebel@whenu.com>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <3f250c7105021607022362013c@mail.gmail.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com>
	 <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com>
	 <1108219160.12693.184.camel@blue.obulous.org>
	 <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com>
	 <3f250c710502160241222dce47@mail.gmail.com>
	 <Pine.LNX.4.61.0502161142240.17264@goblin.wat.veritas.com>
	 <3f250c7105021607022362013c@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eU9z0KDtdSJ6+IjhpjRG"
Organization: Whenu.com
Date: Wed, 16 Feb 2005 10:17:01 -0500
Message-Id: <1108567021.32711.529.camel@rebel.corp.whenu.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.1.101mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eU9z0KDtdSJ6+IjhpjRG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hello,

I have heard that this particular information, while very important to
userland developers like me, is probably too expensive to keep track of
for most users.

Perhaps a way to enable it for developers, whom are willing to spend the
cpu cycles, and disable it for regular use would be a solution.

Would it be possible develop a solution allowing us to enable/disable
this tracking via a sysctl call?

Richard F. Rebel

On Wed, 2005-02-16 at 11:02 -0400, Mauricio Lin wrote:
> Hi Hugh,
>=20
> Thanks by your suggestion. I did not know that kernel 2.4.29 has
> changed the statm implementation. As I can see the statm
> implementation is different between 2.4 and 2.6.
>=20
> Let me see if I can use the 2.4.29 statm idea to improve the smaps for
> kernel 2.6.11-rc.
>=20
> BR,
>=20
> Mauricio Lin.
>=20
> On Wed, 16 Feb 2005 12:00:55 +0000 (GMT), Hugh Dickins <hugh@veritas.com>=
 wrote:
> > On Wed, 16 Feb 2005, Mauricio Lin wrote:
> > > Well, for each vma it is checked how many pages are mapped to rss. So
> > > I have to check per page if it is allocated in physical memory. I kno=
w
> > > that this is a heavy function, but do you have any suggestion to
> > > improve this?  What do you mean "needs refactoring into pgd_range,
> > > pud_range, pmd_range, pte_range levels like 2.4's statm"? Could you
> > > give more details, please?
> >=20
> > Just look at, say, linux-2.4.29/fs/proc/array.c proc_pid_statm:
> > which calls statm_pgd_range which calls statm_pmd_range which
> > calls statm_pte_range which scans along the array of ptes doing
> > the pte examination you're doing.  There are plenty of examples
> > in 2.6.11-rc mm/memory.c of how to do it with pud level too.
> >=20
> > Whereas your way starts at the top and descends the tree each time
> > for every leaf, repeatedly mapping and unmapping the page table if
> > that pagetable is in highmem.  You took follow_page as your starting
> > point, which is good for a single pte, but inefficient for many.
> >=20
> > Your function(s) will still be heavyweight, but somewhat faster.
> >=20
> > Hugh
> >
--=20
Richard F. Rebel

cat /dev/null > `tty`

--=-eU9z0KDtdSJ6+IjhpjRG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCE2Ptx1ZaISfnBu0RAqpJAJ49z2xkv5YL3a8O8JrsYAeAQhdDuwCcCtXP
cff0XwTEfOKXUQGG6V7+2HQ=
=oDUx
-----END PGP SIGNATURE-----

--=-eU9z0KDtdSJ6+IjhpjRG--

