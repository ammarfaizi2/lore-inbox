Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVA3Nih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVA3Nih (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 08:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVA3Nih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 08:38:37 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:58831 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261702AbVA3Nia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 08:38:30 -0500
Subject: [ANNOUNCEMENT] vSecurity 0.1-cvs available publicly
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3B4S9+H/ABLnp+1cre5g"
Date: Sun, 30 Jan 2005 14:37:55 +0100
Message-Id: <1107092275.3754.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3B4S9+H/ABLnp+1cre5g
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Yesterday night, the first release of vSecurity was made publicly
available at tuxedo-es.org cvs, which can be found at:

http://cvs.tuxedo-es.org/cgi-bin/viewcvs.cgi/vsecurity/

As a short introduction, "vSecurity is a new approach to Linux kernel
security inspired and partially based on grSecurity, using the Linux
Security Modules framework, improving and bringing several security
enhancements in a non-intrusive manner to the Linux kernel sources."

I was working on it since the thread about Linux kernel security ramped
into a "flame", without giving things so clear for those who only wanted
to know what was the final decision (and the kernel hackers thoughts) on
it.

During the (around) 3 weeks that it needed to be at least more stable
and well-documented (regarding the source code comments and not a
technical paper explaining it, which is going to be finished and
published ASAP) code, I knew that, in most cases, some of the typical
security faults that happen to Linux users could be solved without using
much more than the LSM and a well designed engine using it and adding
hooks on those places where we can catch up the "exploitation" of the
security faults.

vSecurity currently protects (in a "Plug & Play" manner) against:

 - Execution (mmap()'ing in elf_map()) of binaries in untrusted paths.
   (and also protection against tricky uses of mprotect() to bypass such
   protections, which are formerly known as Trusted Path Execution,
   TPE).

 - BSD Jails implementation, based on Serge Hallyn's code.

 - Chroot() Jails (even if they are broken by design *sigh*)
   protections.
   (Basic anti-escaping: double chroot()'ing, etc, a few capabilities
   protections, etc.IPC and SHM protections are not yet implemented,
   also setuid bit protections are not yet implemented too).
   Anyways, I encourage to use the BSD Jails functionality instead of
   simple chroot() jails.
   (An userland support tool for change namespaces, "auto" jailing, is
   going to be available as soon as Serge and me finish it, that will
   help on BSD Jails use automation).

 - Linking protections: symlinking and hardlinking,FIFOs not yet in
   0.1-cvs.

 - Socket restrictions: per-socket-type style restrictions: "server" =20
   sockets, "client" sockets and all-sockets.Supports per-GID and
   per-UID configuration basis, prepared for kernel-configuration time
   and if module is compiled outside and separate of the kernel, with
   module parameters, same as TPE protections).
   (Using an ACL engine relying on a sysfs subsystem "secfs").

- RAW I/O protections and kernel symbols protections.
  (No so-called live-patching for a while :) )

- RLIMIT_NPROC enforcing, check also in fork() calls so ulimits will
  apply and checked each call to know if user can do it or not).
  Native and enhanced support in BSD Jails (which also have Serge's
  "network virtualization" engine.
  Useful against so-called fork() bombs.

- Other enhancements and security improvements.

It's not as mature as I want, but I decided to release it as soon as
possible to get feedback, bug reporting (sure it has, we all do
mistakes ;) ), etc.

Please, keep in mind that It's a development release, I wouldn't like to
receive comments about "how a big crap is this" and such, until a stable
release gets finished :).

Code is well-documented, but as I commented a few lines above, I will
make available a paper explaining it further, ASAP.

Also, I would like to thank Seth Arnold from Immunix for helping me with
my (again) extensive lack of knowledge, Serge Hallyn from IBM for
helping with BSD Jails code and testing, suggestions, etc, Stephen
Smalley for his suggestions, comments and help on some protections
implementation, Brad Spengler for helping when I asked about some
grSecurity pearls, and David B. Harris from OFTC (and whole OFTC staff)
for hosting my crap there :).

I hope this would be useful and interesting, and, again, I would
appreciate any feedback on it.

Thanks in advance, enjoy it.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-3B4S9+H/ABLnp+1cre5g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/OMzDcEopW8rLewRAsM2AKDMBD3fJ5VsDb/CED5IWdBSwlTApgCg1WU7
umZ/ng88yD7iEEB5GJJSwUs=
=O5fA
-----END PGP SIGNATURE-----

--=-3B4S9+H/ABLnp+1cre5g--

