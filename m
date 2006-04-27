Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWD0Ny3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWD0Ny3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWD0Ny3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:54:29 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:4746
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S965051AbWD0Ny2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:54:28 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Roman Kononov <kononov195-far@yahoo.com>
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 15:58:46 +0200
User-Agent: KMail/1.9.1
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44505891.8080300@yahoo.com>
In-Reply-To: <44505891.8080300@yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5882120.UtbjVi2nQC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604271558.46212.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5882120.UtbjVi2nQC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 27 April 2006 07:37, you wrote:
> > If C++ doesn't work=20
> > properly for a simple and clean example like struct list_head, why=20
> > should we assume that it's going to work any better for more complicate=
d=20
> > examples in the rest of the kernel?  Whether or not some arbitrary=20
> > function is inlined should be totally orthogonal to adding type-checkin=
g.
>=20
> You misunderstood something. The struct list_head is indeed a perfect=20
> type to be templatized with all members inlined. C++ works properly in=20
> this case.

I am not sure, if you can relieably use the container_of() magic
in C++. Do you know?
I have a C++ linked list example here:
http://websvn.kde.org/trunk/extragear/security/pwmanager/pwmanager/libpwman=
ager/linkedlist.h?rev=3D421676&view=3Dmarkup
It is very simple and in some points different from the kernel
linked lists. It has a separate "head" and "entry" class and it stores
a pointer to the entry (the kernel linked lists would use container_of()
instead)

> Nothing works by default. I did not say that static constructors are=20
> advantageous. I said that it is easy for the kernel to make static=20
> constructors working. Global variables should be deprecated anyway.

You are kidding. Must be...

> > Plus this would=20
> > break things like static spinlock initialization.  How would you make=20
> > this work sanely for this static declaration:
> >=20
> > spinlock_t foo_lock =3D SPIN_LOCK_UNLOCKED;
> >=20
> > Under C that turns into (depending on config options):
> >=20
> > spinlock_t foo_lock =3D { .value =3D 0, .owner =3D NULL, (...) };
>=20
> I would make it exactly like this:
> 	#define SPIN_LOCK_UNLOCKED (spinlock_t){0,-1,whatever}
> 	spinlock_t foo_lock=3DSPIN_LOCK_UNLOCKED;
> This is easy to change. The empty structures look far more painful.

The lack of named initializers is one of the main reasons (for me)
why C++ damn sucks. Hopefully they will include them in the
next C++ standard.

=2D-=20
Greetings Michael.

--nextPart5882120.UtbjVi2nQC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEUM4Wlb09HEdWDKgRAg8CAKCz/0BrBOtBIBkkOjt1p6TSpIyusACeL2h6
FmzetV3ugDpECx8B18WbJIg=
=Gd4M
-----END PGP SIGNATURE-----

--nextPart5882120.UtbjVi2nQC--
