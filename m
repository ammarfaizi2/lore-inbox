Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWEDRyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWEDRyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWEDRyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:54:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:55015 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030246AbWEDRys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:54:48 -0400
X-Authenticated: #2308221
Date: Thu, 4 May 2006 19:54:41 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Herbert Rosmanith <kernel@wildsau.enemy.org>, linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
Message-ID: <20060504175441.GA2910@hermes.uziel.local>
References: <200605041232.k44CWnFn004411@wildsau.enemy.org> <1146750532.20677.38.camel@localhost.localdomain> <20060504141402.GB8348@hermes.uziel.local> <1146756522.22308.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <1146756522.22308.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2006 at 04:28:42PM +0100, Alan Cox wrote:
>=20
> > Since you've been busy I didn't want to bother you, but now that you
> > mention your PATA efforts again, is there a git tree to pull from,
> > which contains code similar to that in the latest patches?
>=20
> Not for the current code. The core stuff is mostly in the tree now and
> I'll try and push a patch some time today or tomorrow thats versus
> 2.6.17-rc and should match.
>=20

Sounds great! I'll build new kernels for all my boxes as soon as I can
get a hold on said patch. At least it "felt" cleaner and I/O was a
little less of a handbrake using libata, so I'll go for it once again.

Just one more thing, I had to hack a little on Kconfig files to make the
"newer" promise driver available - if my memory doesn't fail me I sent a
patch, more like a RFC. Are some drivers intentionally left out of
Kbuild? I could not trigger any problem so far, using ata_piix on this
laptop, and pata_via / pata_pdc2027x on my desktop.

The only strangeness I had was some windoze firmware upgrade tool for my
ATAPI CDRW drive running in wine, poking on every sg device in
existence, thus triggering a freeze as it messed with the disks in some
wicked way. But since this was never intended to work in the first
place, I was happy with it working after simply deleting all sg devs
corresponding with disks. And I guess it is worth mentioning that the
SCSI IOCTLs in question are only accepted by the SCSI stack when the
process is run as root, so it's not exactly something anybody could try
on a machine he cannot already kill.  Attempts to run this as an
ordinary user would make the firmware tool get stuck with an all-empty
progress bar, and the wine processes were easily TERM-able.

If there's anything I might want to try out or you'd want to know, like
lspci output and such, please let me know. I'm not home right now, but
here goes for starters.


lspci excerpt:

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) (=
prog-if 80 [Master])


lspci -vvvxxxn excerpt:

00:07.1 0101: 8086:7111 (rev 01) (prog-if 80)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 0860 [size=3D16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 e3 07 e3 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00


This one has been working perfectly so far, on an ancient Dell Latitude
CPiA.


Kind regards,
Chris

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRFo/4F2m8MprmeOlAQIVrw//dZOIneEf+o96NAvdx6UUv1Y8YF9QAjcA
9mv4tquZVfVC4VZjgsL30c4EXXwfMGWmtdqmMh7AnsZa7ca7LLGVzxXNtj57HeXc
26+nRUwARTtAECWkwWPwbzo2M943kOFOK7K+YuYpKylOZjWU/3QK/iG/oGl3A2yK
H2QS5Iue4dRA/50Ca1rDxgky7tGRVpGiipMuHFpqmHFPk7J2AyFytk5gZFEtuXza
DblCxB8gWxYRXCwU1UNcJnHYWnK9xWnITM6I8Z1MGuvTWwnW2L8yXyHCxk279nH8
cA5CGlh6OAwfNnji31jlNbqonsgA/UDOrLNFn0wNt7q3ZJ4G6v5C7w/1s3PrTHLY
BRVXxR+GzNIeT9p7qspdCzOsNsCXlx/JL21K9f0oaLrUIvjM/zmvDld/ymw63CBg
EdEmkJLzblaRWgsp4Vnj4eWQM1ayafv9dPFFKwzDBMgcxINXVxFKBmPKR45cr2XB
p631xOTrKJQp934QqjIm3eTDzy3HZX40j/MExpfpNH05y4BgFHkIkHmkZk3f9u4V
2i+H4P5xLnzVl+9gp3dTzFtlvhka78HHyNbzFn5BJ9AU+yhucQq7ufKc7l/RZjWb
90YwTQWfMyrONPqnMynA9G03YAWmFps205QzFdQWZkKu4lRDgoLZrN0LzgrcYMB6
Y017akmEg9k=
=ELee
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

