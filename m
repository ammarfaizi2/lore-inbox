Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbUKDEcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUKDEcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUKDEcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:32:25 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:50766 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261903AbUKDEcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:32:17 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Chris Wedgwood <cw@f00f.org>
Subject: Fixing UML against NPTL (was: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2))
Date: Thu, 4 Nov 2004 05:31:21 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <200411040113.27747.blaisorblade_spam@yahoo.it> <20041104003943.GB17467@taniwha.stupidest.org>
In-Reply-To: <20041104003943.GB17467@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8664118.nYX9jWCuay";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411040531.29596.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8664118.nYX9jWCuay
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 01:39, Chris Wedgwood wrote:
> On Thu, Nov 04, 2004 at 01:13:27AM +0100, Blaisorblade wrote:
> > Well, not a lot of new work should go there.
>
> agreed
>
> > Not always. Do you think I'm a luser? Or what?
>
> no, not at all
>
> i was asking what break to see if i can help

Intimate Linking Script and NPTL knowledge would help a lot.

The issues are 2 ones:

1) LKML does not link because the linker does not like it's linker script,=
=20
which defines a special thread_private section (give a look at switcheroo()=
=20
and you could maybe realize the issue of copying the .text to a tmpfs file=
=20
and replacing the mapping to the executable with the tmpfs file mapping).

2) getpid() on a child clone returns the process's pid when run with a=20
NPTL-enabled glibc, while it returns the thread pid with a LinuxThreads one=
;=20
this causes tons of problems with UML, which uses signals as inter-thread a=
nd=20
intra-thread communication.

Note UML is not using pthread_create() to create the threads, where this=20
behaviour is an improvement. I'm using a plain clone() call without the=20
CLONE_THREAD flag (which is not even added in by glibc, according to strace=
).

I've not yet checked if glibc is hijacking getpid() or not, but that would =
be=20
strange anyway.

Also, this behaviour has been reported the first time about at the time of=
=20
2.6.0, but actually UML has almost never runs against NPTL glibc, because=20
it's statically linked most times.

=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart8664118.nYX9jWCuay
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBibChqH9OHC+5NscRAvwSAJ4x14hZhzkEYZGa56P3x9vUERZ4sgCgjwIZ
RaX8F5kuHuOfWorZzrnNiE0=
=XWcS
-----END PGP SIGNATURE-----

--nextPart8664118.nYX9jWCuay--
