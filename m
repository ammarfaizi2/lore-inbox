Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVAOKL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVAOKL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 05:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVAOKL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 05:11:28 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:59542 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262255AbVAOKKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 05:10:30 -0500
Subject: [ANNOUNCE] vSecurity LSM (under development)
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       torvalds@osdl.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-X6f0M+SIy/rsKwO/WONx"
Date: Sat, 15 Jan 2005 11:09:31 +0100
Message-Id: <1105783771.3737.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X6f0M+SIy/rsKwO/WONx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've been reading the last thread where my TPE was mentioned, also about
the other security-related issues, work models, etc...

I'm just curious about what's the opinion of kernel hackers on the
possibility of including an optional suite of security enhancements in
the mainline, such as grSecurity, but using Vanilla-"default" code base,
without touching the kernel core and messing up things that some hackers
wouldn't like.
I've started a new LSM called vSecurity, inspired by grsecurity aims to
bring to Vanilla sources users most of grsec's features without being a
non usable solution or even an "aggressive" implementation.
Using the LSM framework, it can be handled as a simple LKM, so, it can
be easily enabled and disabled.

Now I've done the TPE features, most of socket restriction ones, and
some jail and raw I/O protections as well.

Past week I haven't a lot of time, because of personal reasons (the
arrival of an exchange student girl was the main one), so, maybe this
weekend i could have a pre-release, before I start the normal school
rhythm (Monday).

The goal is quite simple, solve at least the 50% of the issues that my
(still not released, Rik Van Riel has an old copy) regression test suite
reports:

(...)
FIPS-140-2 Compliance tests for RNG dev  : /dev/urandom
  MonoBit test:                          : Passed
  Poker test:                            : Passed
  RUNS test:                             : Passed
  LongRun test:                          : Passed
(...)
PID Randomization                        : Vulnerable
Raw IO access restrictions               :
  Testing denied ioperm                  : Vulnerable
  Testing denied iopl                    : Vulnerable
DMESG Restrictions                       : Vulnerable
Symlink restrictions                     : Vulnerable
Hardlinking restrictions                 : Vulnerable
Chroot jails regression tests            :
  Chdir("/") on chroot                   : Vulnerable
  Testing double chroot                  : Vulnerable
  Dangerous capabilities inside chroot   : Vulnerable
  Fchmod +s inside chroot                : Vulnerable
  Chmod +s in chroot                     : Vulnerable
  Kill process outside chroot            : Vulnerable
  mknod() inside chroot                  : Vulnerable
  Nice raise in chroot                   : Vulnerable
  Priority raise in chroot               : Vulnerable
  sysctl() inside chroot                 : Vulnerable
  Abstract Unix socket() outside chroot  : Vulnerable
  SHM attach outside chroot (non-root)   : Vulnerable
  SHM attach outside chroot              : Vulnerable
  ptrace() attach outside chroot         : Vulnerable
RSBAC Jail regression test               : rsbac_jail() unsupported
(...)

That's what it reports when running in a default Vanilla sources that
come with most of the distributions.
Should we solve them or leave them unsolved waiting for independent
developers and hackers work?

I think that's not worthy, but it's just my opinion.

This is what currently happens when loading vSecurity:

lorenzo@estila:~/kernel/vsecurity $ sudo insmod vsecurity.ko
lorenzo@estila:~/kernel/vsecurity $ LANG=3D"en" dmesg
klogctl: Operation not permitted

Dmesg output (must have CAP_SYS_ADMIN capabilities):
VSEC: Registering vsecfs subsystem (sysfs).
VSEC: Initializing Access Control Lists.
VSEC: vSecurity engine initialized.
VSEC: Denied syslog access: uid/euid=3D1000/1000 gid/egid=3D1000/1000
suid/sgid=3D1000/1000 pid=3D19826
VSEC: Denied syslog access: uid/euid=3D1000/1000 gid/egid=3D1000/1000
suid/sgid=3D1000/1000 pid=3D19829

...and so on.

Almost all of the restrictions and protections have also an ACL:

lorenzo@estila:~/proyectos/collision-rts-0.1/src $ ls /sys/vsecfs/
all-sockets-add        client-sockets-add        rawio-add
server-sockets-add        tpe-add
all-sockets-add-group  client-sockets-add-group  rawio-add-group
server-sockets-add-group  tpe-add-group
all-sockets-del        client-sockets-del        rawio-del
server-sockets-del        tpe-del
all-sockets-del-group  client-sockets-del-group  rawio-del-group
server-sockets-del-group  tpe-del-group
lorenzo@estila:~/proyectos/collision-rts-0.1/src $


I will try to make most of the remaining  work to get at least the half
of those issues solved, but it depends on how i feel to do it and how
good is the users opinion on it, so, please, tell me your opinion.

BTW, Linus was working on some type of TPE features, Am i right?

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-X6f0M+SIy/rsKwO/WONx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB6OvbDcEopW8rLewRAhf8AKCrQ8teE3PpkAioghHml/YaGSfLbwCePCX2
v6xoMTWGIcc7zjKwz3BENCw=
=9W1e
-----END PGP SIGNATURE-----

--=-X6f0M+SIy/rsKwO/WONx--

