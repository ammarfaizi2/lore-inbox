Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUGNBVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUGNBVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 21:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267282AbUGNBVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 21:21:18 -0400
Received: from darwin.snarc.org ([81.56.210.228]:39045 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S267286AbUGNBVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 21:21:12 -0400
Date: Wed, 14 Jul 2004 03:21:10 +0200
To: Darren Williams <dsw@gelato.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.8-rc1 fix AFS struct_cpy use which break !X86
Message-ID: <20040714012110.GA5400@snarc.org>
References: <20040714010706.GA31683@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20040714010706.GA31683@cse.unsw.EDU.AU>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040523i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2004 at 11:07:06AM +1000, Darren Williams wrote:
> Including Andrew File System on any arch other
> than i386 and x86_64 will break the compilation
> due to the use of 'struct_cpy()', which is only
> define in the two archs above and both archs
> define it differently:

struct_cpy will be remove as suggest by AKPM in a recent discussion in LKML.

> A quick discussion here suggests that we are not
> doing a deep copy of the struct though others
> may by able to enlighten us on what happens to
> pointers within a struct?

using only *x =3D *y works.

> I have applied the i386 definition to ia64 and
> compiles OK, though I cannot test it since I
> do not have direct access to AFS.=20

Ok, what about the following patch ?

Index: fs/afs/mntpt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- fs/afs/mntpt.c	(revision 1)
+++ fs/afs/mntpt.c	(working copy)
@@ -257,7 +257,7 @@
 	if (IS_ERR(newmnt))
 		return PTR_ERR(newmnt);
=20
-	struct_cpy(&newnd, nd);
+	newnd =3D *nd;
 	newnd.dentry =3D dentry;
 	err =3D do_add_mount(newmnt, &newnd, 0, &afs_vfsmounts);
=20
Index: fs/afs/vlocation.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- fs/afs/vlocation.c	(revision 1)
+++ fs/afs/vlocation.c	(working copy)
@@ -906,7 +906,7 @@
 		if (!vlocation->valid ||
 		    vlocation->vldb.rtime =3D=3D vldb->rtime
 		    ) {
-			struct_cpy(&vlocation->vldb, vldb);
+			vlocation->vldb =3D *vldb;
 			vlocation->valid =3D 1;
 			_leave(" =3D SUCCESS [c->m]");
 			return CACHEFS_MATCH_SUCCESS;
@@ -947,7 +947,7 @@
=20
 	_enter("");
=20
-	struct_cpy(vldb,&vlocation->vldb);
+	*vldb =3D vlocation->vldb;
=20
 } /* end afs_vlocation_cache_update() */
 #endif

--=20
Tab

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9IqGzKe/MInoaQARAnSkAJ4vRtDT+uRj381HAy4Kw3sIz6215wCbBK7k
sr2WHaZv50qPgFWavoFS/uc=
=UEUq
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
