Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286944AbSABL3P>; Wed, 2 Jan 2002 06:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286945AbSABL3F>; Wed, 2 Jan 2002 06:29:05 -0500
Received: from vitelus.com ([64.81.243.207]:60940 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S286944AbSABL2y>;
	Wed, 2 Jan 2002 06:28:54 -0500
Date: Wed, 2 Jan 2002 03:28:21 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102112821.GA13212@vitelus.com>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:
> Thus=20
>    strcpy (dst, "abcdef" + 2)
> gives
>    memcpy (dst, "abcdef" + 2, 5)

IMHO gcc should not be touching these function calls, as they are not
made to a standard C library, and thus have different behaviors. I'm
suprised that gcc tries to optimize calls to these functions just
based on their names.

The gcc manpage mentions

       -ffreestanding
           Assert that compilation takes place in a freestanding
           environment.  This implies -fno-builtin.  A freestand=AD
           ing environment is one in which the standard library
           may not exist, and program startup may not necessarily
           be at "main".  The most obvious example is an OS ker=AD
           nel.  This is equivalent to -fno-hosted.

Why is Linux not using this? It sounds very appropriate. The only
things the manpage mentions that -fno-builtin would inhibit from being
optimized are memcpy() and alloca(). memcpy() has its own assembly
optimization and inlining on some (most?) archs, and as for alloca(),
I only see it being used a bit in the S/390 code, where the gcc
optimizations could quite possibly break something. I think
-ffreestanding definately should be used by the kernel to prevent gcc
from messing with its code in broken ways.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Mu7VdtqQf66JWJkRAhUmAJ4nsHAVyUHIjpDvcG+6Efg4L54U5ACaA5HP
hPDf4de5XmyxtfLQW0EOtBw=
=Mkjc
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
