Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbTCVPRQ>; Sat, 22 Mar 2003 10:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTCVPRQ>; Sat, 22 Mar 2003 10:17:16 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:50927 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S262037AbTCVPRP>; Sat, 22 Mar 2003 10:17:15 -0500
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030322141006.A8159@flint.arm.linux.org.uk>
References: <20030322103121.A16994@flint.arm.linux.org.uk>
	 <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>
	 <20030322141006.A8159@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I3rp8G6QUI7mrjB/6ZlW"
Organization: Red Hat, Inc.
Message-Id: <1048346885.1708.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Mar 2003 16:28:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I3rp8G6QUI7mrjB/6ZlW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> --- orig/kernel/ptrace.c	Wed Mar 19 15:54:45 2003
> +++ linux/kernel/ptrace.c	Sat Mar 22 10:14:01 2003
> @@ -22,7 +22,7 @@
>  int ptrace_check_attach(struct task_struct *child, int kill)
>  {
>  	mb();
> -	if (!is_dumpable(child))
> +	if (!is_dumpable(child) && !(child->ptrace & PT_PTRACE_CAP))
>  		return -EPERM;
> =20
>  	if (!(child->ptrace & PT_PTRACED))

this sounds really wrong; the child says it doesn't want to be ptraced
and now you allow it anyway. I think the problem is more that the child
isn't dumpable.... checking why

--=-I3rp8G6QUI7mrjB/6ZlW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fIEFxULwo51rQBIRAkCqAJ975Arr9hyugxFiSafSZOI/6Ywz9wCeNLEk
2ZVTEYzWaRqEz9+9t0xP4dQ=
=ceZ/
-----END PGP SIGNATURE-----

--=-I3rp8G6QUI7mrjB/6ZlW--
