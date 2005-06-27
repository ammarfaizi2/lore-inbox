Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVF0Ovd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVF0Ovd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVF0OuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:50:24 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.4.196]:4659 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262125AbVF0NBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:01:46 -0400
Date: Mon, 27 Jun 2005 09:01:39 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH v2][TRIVIAL] Allocate kprobe_table at runtime
In-reply-to: <p737jggwcln.fsf@verdi.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Prasanna S Panchamukhi <prasanna@in.ibm.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Message-id: <20050627130139.GD22311@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=llIrKcgUOe3dCx0c
Content-disposition: inline
References: <20050626183049.GA22898@optonline.net.suse.lists.linux.kernel>
 <20050627055150.GA10659@in.ibm.com.suse.lists.linux.kernel>
 <p737jggwcln.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2005 at 08:14:12AM +0200, Andi Kleen wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
>=20
> > Jeff,
> >=20
> > On Sun, Jun 26, 2005 at 06:37:29PM +0000, Jeff Sipek wrote:
> > > Allocates kprobe_table at runtime.
> > > -	/* FIXME allocate the probe table, currently defined statically */
> > > +	kprobe_table =3D kmalloc(sizeof(struct hlist_head)*KPROBE_TABLE_SIZ=
E, GFP_ATOMIC);
> >=20
> > Memory allocation using GFP_KERNEL has more chances of success as compa=
red to
> > GFP_ATOMIC. Why can't we use GFP_KERNEL here?
>=20
> I don't see any sense in the change anyways. Just using BSS=20
> should be fine.
>=20
> Jeff, when you submit a patch you should add a small blurb
> describing why you think it is a good idea.

That patch was somewhat impulsive...I was looking at some code and saw a
FIXME that required minimal work. I agree that BSS is good enough.

Patch below removes the FIXME notice.

Pick one ;-) (Patch Monkey is CC'd).

Jeff.


Remove useless FIXME.

Signed-off-by: Josef "Jeff" Sipek

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -261,7 +261,6 @@ static int __init init_kprobes(void)
 {
 	int i, err =3D 0;
=20
-	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
 	for (i =3D 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCv/izwFP0+seVj/4RAoD/AJ4/3xi5x+Yy5oaTrWHbDB1CoQSeGwCdFgsT
j7DbGh8wAB1Cw4MM1Ab9pWk=
=GNi/
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
