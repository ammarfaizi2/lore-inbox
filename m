Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265968AbUAEXMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUAEXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:11:07 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:23728 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265994AbUAEXIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:08:48 -0500
Date: Tue, 6 Jan 2004 00:08:41 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: problem booting aic7xxx-old with reiserfs
Message-ID: <20040105230841.GA12917@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[please CC me on replies!]

Hi all,

I just tried to migrate my 200million year old router/firewall
machine to 2.6.0 without much success. The machine is a K6/200 with
an Adaptec 2940 controlling a Quantum Fireball drive, with an ext3
/boot partition. The whole thing is connected to the external
network with a 3c509 and the internal network with a RTL8139. The
machine works just fine with kernel 2.4.23, grsecurity and freeswan.
The configuration is here: [1].

I configured the 2.6.0 kernel [2] with the old aic7xxx driver, as well
as the 3c59x and 8139too drivers. Now, when I start the system, it
loads the kernel just fine, the SCSI driver recognises the
harddrive, but when it tries to mount / (reiserfs) (right after
initialising TCP, GRE, IPsec, IPv6 and SCTP), it just hangs with the
following message:

  found reiserfs format "3.6" with standard journal

This will stay for a couple of minutes, when the system finally
proceeds, coming to another hang after it told me that init is
booting.

I haven't gotten further than that yet. I imaging this is a problem
with the SCSI driver, but there are no errors logged, and in 2.4.23
it works just fine.

What is also curious is that after booting 2.6.0, if I don't
physically shut off and then restart the system, 2.4.23 can't seem
to communicate via eth0 (3c59x) anymore. It gives messages of the
following form:

  eth0: command 0x3002 did not complete! status=3D0xffff

and can't even obtain an IP address from the DHCP server. Only
physically powering off the system and starting it from zero will
fix this problem, allowing 2.4.23 to boot as normal.

I wonder if the two are related, but I don't think so. If I can boot
2.6.0, I couldn't care less about the 3c59x card, which is
apparently being configured by 2.6.0 in such a way that 2.4.23 can't
handle it.

Thus, I would be eternally grateful for hints as to why 2.6.0 causes
my system to hang. Thanks!

[please CC me on replies!]

  1. ftp://ftp.madduck.net/scratch/config-2.4.23-wall.gz [5.5 Kb]
  2. ftp://ftp.madduck.net/scratch/config-2.6.0-wall.gz [4.5 Kb]

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"in a country where the sole employer is the state, opposition means
 death by slow starvation. the old principle: who does not work shall
 not eat, has been replaced by a new one: who does not obey shall not
 eat."
                                                 -- leon trotsky, 1937

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+e55IgvIgzMMSnURAgTYAKDE/WoYRHbZV7t6pto4Ty16fxIpAgCglaiA
fj9vPpvj+p7/AUlFezmentw=
=1kfy
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
