Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265716AbUGDOzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbUGDOzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 10:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUGDOzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 10:55:24 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:43428 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265716AbUGDOzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 10:55:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: BAIN <bainonline@gmail.com>
Subject: Re: set_fs() preemption safety? [was sys_fs() safety oops !]
Date: Sun, 4 Jul 2004 16:53:52 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <2ff21628040704073632ffa1c9@mail.gmail.com>
In-Reply-To: <2ff21628040704073632ffa1c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_DoB6AZ96iV6L5Sa";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407041653.55816.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_DoB6AZ96iV6L5Sa
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag, 4. Juli 2004 16:36, BAIN wrote:
> is the following block safe to be used in preemptible kernels?
>=20
> old_fs =3D get_fs();
> set_fs(KERNEL_DS);
>=20
> do_your_things here; (usually call sys calls stuff from kernel space)
>=20
> set_fs(old_fs);

On most architectures, this should not be a problem, because set_fs()
only modifies the state of the current task, not any actual processor
registers as the name suggests.

However, on s390 the state is actually kept in cpu control register cr7
and not in the task_struct. Martin, can you comment on how this is
maintained over a schedule() or if this is a real bug?

	Arnd <><

--Boundary-02=_DoB6AZ96iV6L5Sa
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA6BoD5t5GS2LDRf4RAkxsAJ0UDhx5FGkl1b4FXZUOOY2H5XmWLACfdt4E
bnHOjucEr/lQQZWzKQT4ob0=
=otDu
-----END PGP SIGNATURE-----

--Boundary-02=_DoB6AZ96iV6L5Sa--
