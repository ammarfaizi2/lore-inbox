Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbRG1AF6>; Fri, 27 Jul 2001 20:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbRG1AFj>; Fri, 27 Jul 2001 20:05:39 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:59694 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S265636AbRG1AFS>; Fri, 27 Jul 2001 20:05:18 -0400
Date: Sat, 28 Jul 2001 02:04:43 +0200
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, PEIFFER Pierre <ppeiffer@free.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010728020443.I18981@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
	PEIFFER Pierre <ppeiffer@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <20010728083724.A1571@weta.f00f.org> <E15QEP3-0006TF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X0cz4bGbQuRbxrVl"
Content-Disposition: inline
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--X0cz4bGbQuRbxrVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

as I stumbled across the K7 KT133 MMX problem, let me report my failure.
MSI K7 Turbo Ver. 3 (BIOS 2.8). K7 1.2GHz. 256MB SDRam, tested fine by
memtes86 2.7.

The thing would Oops or just hand at random places at the boot process if
compiled with K7 optimization.

On Fri, Jul 27, 2001 at 09:40:09PM +0100, Alan Cox wrote:
> > On Fri, Jul 27, 2001 at 09:19:21PM +0100, Alan Cox wrote:
> >     Its heavily tied to certain motherboards. Some people found a
> >     better PSU fixed it,=20

PSU =3D Power supply? 300W should be fine IMHO.

> >     others that altering memory settings helped.

Did not. Board allows you to set CL 3 which won't help (and I guess the SPDs
read out 3 anyway) and to turn off some PCI features which does not
help either.
It does also allow you to increase mainboard speed and multiplier but not
decrease!

> >     And in many cases, taking it back and buying a different
> >     vendors board worked.

The best option most probably.

> > Does anyone know *why* stuff breaks? surely VIA do as they have a fix
> > for (some, all?) cases of breakage?
>=20
> At the moment the big problem is I don't have enough reliable info to
> see patterns that I can give to VIA for study.

Well, I did some testing, like reordering the MMX instructions, only using 4
instead of 8 registers, ... to no avail.
It all came down to replacing movntq with movq and the thing magically work=
s.
Looks like the writes just get lost otherwise. (Maybe the sfence is just not
effective? But that would be a CPU bug, not a mainboard one.)

> VIAs fixes for board problems
> are for the fifo problem normally seen with the 686B and SB Live but
> sometimes in other cases.

It also has the 686b southbridge bug, but I believe the workaound works.

> (and it seems also we have a few via + promise weirdnesses on all sorts of
>  boards not yet explained)

No Promise involved here, fortunately.
garloff@gum09:~ $ /sbin/lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev =
03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (r=
ev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Cont=
roller (rev 50)
[...]

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--X0cz4bGbQuRbxrVl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7YgGaxmLh6hyYd04RAjNDAJ4jEYZth+4nm7AnUasYYBaDN+eIgwCdESY6
mkV/LqxqlCQk101EQWzFbW0=
=irof
-----END PGP SIGNATURE-----

--X0cz4bGbQuRbxrVl--
