Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVALO5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVALO5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 09:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVALO5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 09:57:43 -0500
Received: from lug-owl.de ([195.71.106.12]:45749 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261203AbVALO5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 09:57:38 -0500
Date: Wed, 12 Jan 2005 15:57:38 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: Re: problem with syscall macro
Message-ID: <20050112145737.GQ25737@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	sounak chakraborty <sounakrin@yahoo.co.in>
References: <20050112144047.51119.qmail@web53305.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
Content-Disposition: inline
In-Reply-To: <20050112144047.51119.qmail@web53305.mail.yahoo.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-12 14:40:47 +0000, sounak chakraborty <sounakrin@yahoo.co.i=
n>
wrote in message <20050112144047.51119.qmail@web53305.mail.yahoo.com>:
>   i am writing a program which willcopy all the lines
> from system log file /var/log/messages and put it in a
> user log file=20

That's an easy task.

> i am using syslog with syscall3 but when i am using

Why do you want to use syslog with syscall3? syslogd and klogs will
prepare /var/log/messages for you, so you just need to read() it and
write() it to a different file.

> write system cal it is not able to write anything=20
> do i have to add something more=20
> i have added the syscall3 macro for write too

No need for that. You shouldn't fiddle directly with your operating
system's syscall interface. You should use libc's wrappers instead,
which will also correctly set errno and all the like.

> do i have to do it for open system call also
> i am little bit confuse with the kernel-user mode
> switching concept too

Actually, you don't need to know anything about Linux' internals, Linux'
syscall interface etc. You only need to know about the
POSIX/SuSv3/whatever interface the libc presents to userspace. If you
directly use system calls, you'll loose portability and need to fight
against stupid problems like this one.

> could you please help me out

The bottom line is that this isn't a kernel-related question, so you'd
probably ask on a C beginner's mailing list...

See:
man 2 open
man 2 close
man 2 read
man 2 write

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5TrhHb1edYOZ4bsRAg/ZAJ4ibVwI58wT0KO/2enbH+V/oO134gCfYX/f
XqxCfXAHr919dazD/swt464=
=cuh7
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--
