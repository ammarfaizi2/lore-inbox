Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSJ0TNJ>; Sun, 27 Oct 2002 14:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSJ0TNJ>; Sun, 27 Oct 2002 14:13:09 -0500
Received: from ppp-217-133-216-156.dialup.tiscali.it ([217.133.216.156]:22403
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262492AbSJ0TNH>; Sun, 27 Oct 2002 14:13:07 -0500
Date: Sun, 27 Oct 2002 20:19:21 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] x86 multiple user-mode privilege rings
Message-ID: <20021027191921.GA5484@ldb.ods.org>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
References: <1035686893.2272.20.camel@ldb> <m11y6blskf.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <m11y6blskf.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> But there are privilege switches.

Of course, they are unavoidable. However, they are as fast as the one
needed to make kernel syscalls.
=20
> Let me get the gist of the idea.
> To accelerate UML, and wine type applications:
> 1) setup segments with restricted limits, so their children cannot
>    write into their supervisor process even though they share a mm.
> 2) load a special system call table that switches processor modes
>    when any system call is activated.
>=20
> Unless I am mistaken all of the above can be accomplished without
> using the cpus multiple rings of privilege.  Which would allow nesting
> only limited by the address space reduction of each task.

You also need:
3) Prevent less privileged subtasks from loading segments belonging to
   more privileged ones

This can be done in hardware using the x86 privilege rings, at the
cost of limitations on the number of subtasks and the inability to have
protected pairs of subtasks where none is more privileged than the other.

Of course it is also possible to do this in the kernel, or in a
privileged user-mode task using LDT/TLS system calls, by modifying
descriptor tables on interprivilege jumps but this is obviously
significantly slower.

Anyway hardware-based and kernel-based privilege separation can
perfectly coexist.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9vDw5djkty3ft5+cRAl1AAJ9363B25LcAlmcMTHlx6ZIB7QEUPACeOGd7
KtNK6C9/irGP/inOc3K/ZYA=
=nvjO
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
