Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTAFSQK>; Mon, 6 Jan 2003 13:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267082AbTAFSQK>; Mon, 6 Jan 2003 13:16:10 -0500
Received: from ppp-217-133-219-133.dialup.tiscali.it ([217.133.219.133]:23169
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267041AbTAFSQJ>; Mon, 6 Jan 2003 13:16:09 -0500
Date: Mon, 6 Jan 2003 19:17:37 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Set TIF_IRET in more places
Message-ID: <20030106181737.GA6867@ldb>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
References: <20030106144601.GA2447@ldb> <Pine.LNX.4.44.0301060755510.2084-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301060755510.2084-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've looked again at it and it is actually less problematic that I
first thought but I still see the following two cases:

1. vfork seems to not set any TIF_ flags so a ptracer setting regs
while a vforking task is stopped in ptrace_notify called from vfork
would result in clobbered %ecx and %edx.

2. A ptracer could use %ecx or %edx to pass information to signal
handlers and this would not work with the current [rt_]sigsuspend.

These only need setting TIF_IRET on ptrace setregs though.

There is also the very small advantage of being able to hardcode
SYSENTER_RETURN as the return eip for sysexit if TIF_IRET is set in
all the 3 places.

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GchAdjkty3ft5+cRAmlmAJ0dw/LnDXDwg+M8Luq8gjX4adJpFQCfdUfl
W+iIlCFMHMiTihw+cuGPxCI=
=DMN9
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
