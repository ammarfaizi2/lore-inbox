Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbSKQNWu>; Sun, 17 Nov 2002 08:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbSKQNWu>; Sun, 17 Nov 2002 08:22:50 -0500
Received: from ppp-217-133-221-200.dialup.tiscali.it ([217.133.221.200]:48001
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267499AbSKQNWt>; Sun, 17 Nov 2002 08:22:49 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0211171437300.7839-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211171437300.7839-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7y1SA/jnJJkVFoXdZd8h"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Nov 2002 14:29:40 +0100
Message-Id: <1037539780.1597.76.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7y1SA/jnJJkVFoXdZd8h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> On 17 Nov 2002, Luca Barbieri wrote:
>=20
> > I don't understand this: why would glibc use it in exec()?
>=20
> i suspect the idea would be to always make every process a proper pthread
> object as well. (but Ulrich will correct me if this is not the case.) Thi=
s
> means that across fork() we can set up the TID pointer via CLONE_SETTID,
> and after exec() we need the new set_tid_address() syscall to initialize
> it.
"after exec()" =3D=3D "in the initialization code for the exec'ed program"?
=20
> if CLONE_VM is set then the TID is set immediately, before sys_clone() =20
> returns. Or are you worried about the fork() case?
Yes.

> this would be fine to me, but i wanted to get away with a single pointer.
Using two pointers would allow to provide all the functionality
mentioned in the discussion on your first clone/tid patch
<http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.1/1409.html>.

Calling sys_set_tid_address after fork is equivalent (but non-atomic)
but requires an additional system call.

> Also, this makes the TID value
> nonatomic - debugging code would have to know whether the child has
> already executed the syscall.
Debugging tools already need to be aware of this for process
initialization, so this shouldn't be a serious problem.


--=-7y1SA/jnJJkVFoXdZd8h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA915nDdjkty3ft5+cRAijKAJ4sZmNbAJicJMj/WE80GhKTe6QKgwCcCshV
8etLyltsXWvUmlX6OaBxCCc=
=Hyna
-----END PGP SIGNATURE-----

--=-7y1SA/jnJJkVFoXdZd8h--
