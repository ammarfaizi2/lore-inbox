Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUAKSfw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUAKSfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:35:50 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:23945 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265951AbUAKSfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:35:42 -0500
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
	0x37ffffff" warning.
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Bart Samwel <bart@samwel.tk>, Tim Cambrant <tim@cambrant.com>,
       Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0401110948590.19685-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0401110948590.19685-100000@bigblue.dev.mdolabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6IaRhatbu5mg2OIQvjDu"
Message-Id: <1073846318.9096.131.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 20:38:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6IaRhatbu5mg2OIQvjDu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 19:53, Davide Libenzi wrote:
> On Sun, 11 Jan 2004, Martin Schlemmer wrote:
>=20
> > On Sun, 2004-01-11 at 18:53, Davide Libenzi wrote:
> > > On Sun, 11 Jan 2004, Bart Samwel wrote:
> > >=20
> > > > Now it seems to behave correctly: for '~' it always warns, for '-' =
it=20
> > > > only warns if the negative value is below -0x80000000. I'll submit =
a=20
> > > > patch to this effect (including the format extensions) to the binut=
ils=20
> > > > people.
> > >=20
> > > binutils 2.14 works fine, so I believe they already fixed it.
> > >=20
> >=20
> > I would beg to differ:
> >=20
> > --
> > nosferatu linux # make
> > make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
> >   CHK     include/asm-i386/asm_offsets.h
> >   CHK     include/linux/compile.h
> >   AS      arch/i386/boot/setup.o
> > arch/i386/boot/setup.S: Assembler messages:
> > arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37=
ffffff
> >   LD      arch/i386/boot/setup
> >   BUILD   arch/i386/boot/bzImage
> > Root device is (8, 3)
> > Boot sector 512 bytes.
> > Setup is 4799 bytes.
> > System is 1366 kB
> > Kernel: arch/i386/boot/bzImage is ready
> >   Building modules, stage 2.
> >   MODPOST
> > nosferatu linux # ld --version
> > GNU ld version 2.14.90.0.7 20031029
> > Copyright 2002 Free Software Foundation, Inc.
> > This program is free software; you may redistribute it under the terms =
of
> > the GNU General Public License.  This program has absolutely no warrant=
y.
> > nosferatu linux #
>=20
> Ouch ! I have:
>=20
> GNU assembler 2.14 20030612
>=20
> and it works fine. Can you try:
>=20
> $ as << EOF
>=20
> 	PG=3D0xC0000000
> 	VM=3D(128 << 20)
>=20
> 	.long (-PG -VM)
> 	.long (~PG + 1 - VM)
> EOF
>=20
> $ objdump -D a.out
>=20
>=20

--
azarah@nosferatu tar $ as << EOF > PG=3D0xC0000000
> VM=3D(128 << 20)
> .long (-PG -VM)
> .long (~PG + 1 - VM)
> EOF
{standard input}: Assembler messages:
{standard input}:3: Warning: value 0x38000000 truncated to 0x38000000
{standard input}:4: Warning: value 0x38000000 truncated to 0x38000000
azarah@nosferatu tar $ objdump -D a.out
=20
a.out:     file format elf32-i386
=20
Disassembly of section .text:
=20
00000000 <.text>:
   0:   00 00                   add    %al,(%eax)
   2:   00 38                   add    %bh,(%eax)
   4:   00 00                   add    %al,(%eax)
   6:   00 38                   add    %bh,(%eax)
azarah@nosferatu tar $
--



--=20
Martin Schlemmer

--=-6IaRhatbu5mg2OIQvjDu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAZguqburzKaJYLYRAhUKAJ9px6FITDii6Kpm8CiKpw8JrC98IwCfVq+N
YY0Ljcj+LKltUoRtlb2YD7w=
=m3AY
-----END PGP SIGNATURE-----

--=-6IaRhatbu5mg2OIQvjDu--

