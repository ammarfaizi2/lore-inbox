Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTIZPQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTIZPQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:16:59 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:19115 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262347AbTIZPQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:16:56 -0400
Date: Fri, 26 Sep 2003 18:16:42 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
Message-ID: <20030926151642.GL729@actcom.co.il>
References: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2003 at 04:05:50PM +0200, Maciej Zenczykowski wrote:

> I'm wondering if there is any way to provide per process bitmasks of=20
> available/illegal syscalls.  Obviously this should most likely be=20
> inherited through exec/fork.

syscalltrack can do it, per executable / user / syscall parameters /
whatever, but it's per syscall. Writing a perl script or C program to
iterate over the supplied syscall list and write the allow/deny rules
is pretty simple. Also, syscalltrack is meant for debugging, not
security, so if you want something that's 100% tight you'd better go
with one of the Linux security modules based on the LSM framework.=20

> For example specyfying that pid N should return -ENOSYS on all syscalls=
=20
> except read/write/exit.

Yeah, syscalltrack can do that ;-)=20

> The reason I'm asking is because I want to run totally untrusted=20
> statically linked binary code (automatically compiled from user=20
> submitted untrusted sources) which only needs read/write access to stdio=
=20
> which means it only requires syscalls read/write/exit + a few more for
> memory alloc/free (like brk) + a few more generated before main is called=
=20
> (execve and uname I believe).

Since it's a known binary, if you can handle the increased run time,
strace is your best shot. syscalltrack and other kernel based
solutions are best when you need something that is "system wide".=20

> Basically my question is: has this been done before (if so where/when?),=
=20
> what would be considered 'the right' way to do this, would this be a=20
> feature to include in the main kernel source?

Previous discussion seemed to conclude that features like these are
"not interesting enough to the majority of users". Maybe it's time to
revise those discussions (c.f. the inclusion of SELinux, for
example).=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/dFhaKRs727/VN8sRAjljAJ0XcbiKW66qJwjG0wEcrhtEeY0HFQCfWfwK
jaHIo+p0AvyOBwldPZZpB7o=
=mjp9
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
