Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUGFJYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUGFJYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 05:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUGFJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 05:24:42 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:9660 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263731AbUGFJYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 05:24:39 -0400
Date: Tue, 6 Jul 2004 11:24:38 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: system calls-(query)
Message-ID: <20040706092438.GT18841@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040706080030.35778.qmail@web8310.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qyZ1VOjRGk8hBWhg"
Content-Disposition: inline
In-Reply-To: <20040706080030.35778.qmail@web8310.mail.in.yahoo.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qyZ1VOjRGk8hBWhg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-06 09:00:30 +0100, Susheel Raj <susheel_nuguru@yahoo.co.in>
wrote in message <20040706080030.35778.qmail@web8310.mail.in.yahoo.com>:
> i have been trying to understand how the system calls
> are being made by applications and how the kernel
> reacts to them...this is what i got into my brain....
> when an application makes a system call ( for i386)
> %eax register is filled with the system call number
> and some other registers are to be given some
> appropriate values..for example ..if i amke an exit ()
> system call.. then its system call number "1" is
> filled in %eax and the status code is filled in
> %ebx...
> =20
> so i want to know what are the requirements for other
> systems calls to execute ...what all registers they
> access..any documentation would be a great help....=20

Userland has to place arguments where the kernel expects them. Have a
look at ./linux/asm-$ARCH/unistd.h to see how syscalls can be made. You
can think of the _syscallX() macros as the lowest-level "function" to
get access to a system call slot. From there, the syscall is usually
dispatched from entry.S.

Syscalls trigger some kind of interrupt or exception; an exception
handler then gets the system call number and dispatches it through the
syscall function pointer's addresses in sys_call_table (in entry.S).

MfG, JBG


--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--qyZ1VOjRGk8hBWhg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6m/WHb1edYOZ4bsRAi5nAKCQAgeX2YRrX5rpKV0jzmB3wAwAUQCbBEaB
udm8u/hiGs+vgdWa2CvF9Yk=
=8RrW
-----END PGP SIGNATURE-----

--qyZ1VOjRGk8hBWhg--
