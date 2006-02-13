Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWBMSgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWBMSgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBMSgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:36:31 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:643 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932398AbWBMSgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:36:31 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139779983.5247.39.camel@localhost.localdomain>
Date: Mon, 13 Feb 2006 18:34:34 +0000
In-Reply-To: <1139779983.5247.39.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 13 Feb 2006 08:33:03 +1100")
Message-ID: <87irrj85vp.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2006-02-12 at 17:13 +0000, Roger Leigh wrote:
>> Hi folks,
>>=20
>> When running a 2.6.16-rc2 kernel on a powerpc system (Mac Mini;
>> Freescale 7447A):
>>=20
>> $ date && touch f && ls -l f && rm -f f && date
>> Sun Feb 12 12:20:14 GMT 2006
>> -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 12:23
>> Sun Feb 12 12:20:14 GMT 2006
>>=20
>> Notice the timestamp is 3 minutes in the future compared with the
>> system time.  "make" is not a very happy bunny running on this kernel
>> due to every touched file being 3 minutes in the future.
>>=20
>> When the same command is run on 2.6.15.3:
>>=20
>> $ date && touch f && ls -l f && rm -f f && date
>> Sun Feb 12 14:27:27 GMT 2006
>> -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 14:27
>> Sun Feb 12 14:27:27 GMT 2006
>>=20
>> In this case the times are identical, as you would expect.
>>=20
>> In both these cases, the chrony NTP daemon is running, if that might
>> be a problem.
>
> Can you strace vs. ltrace and see if the gettimeofday or clock_gettime
> syscalls are ever called ?

           | strace        | ltrace
=2D----------+---------------+------------------------------------
2.6.15     |               |
date       | clock_gettime | clock_gettime -> SYS_clock_gettime,
           |               |   localtime, strftime
touch      | utimes        | futimes -> SYS_utimes
           |               |
2.6.16-rc2 |               |
date       | clock_gettime | clock_gettime -> SYS_clock_gettime,
           |               |   localtime, strftime
touch      | utimes        | futimes -> SYS_utimes

[clock_gettime(CLOCK_REALTIME, {1139826613, 157402000}) =3D 0]

> I wonder if you have a glibc new enough to
> use the vDSO to obtain the time or if it's using the syscall... The vDSO
> on ppc32 is very new.

It's glibc 2.3.5 (Debian libc6 2.3.5-13).

> Also, are your kernels built with ARCH=3Dppc or ARCH=3Dpowerpc ?

ppc.


Thanks,
Roger

=2D-=20
Roger Leigh
                Printing on GNU/Linux?  http://gutenprint.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your m=
ail.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8NE+VcFcaSW/uEgRApJ6AKCrULxZ4Dfj2gnQa9XhGV771G+vuQCg7Cey
Oht5Yrn1JVipoyW//EocXE0=
=+uiJ
-----END PGP SIGNATURE-----
--=-=-=--
