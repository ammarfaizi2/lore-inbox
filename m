Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268182AbRG2U3h>; Sun, 29 Jul 2001 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268184AbRG2U31>; Sun, 29 Jul 2001 16:29:27 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:55612 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268182AbRG2U3S>; Sun, 29 Jul 2001 16:29:18 -0400
Date: Sun, 29 Jul 2001 22:28:30 +0200
From: Kurt Garloff <garloff@suse.de>
To: PEIFFER Pierre <ppeiffer@free.fr>
Cc: linux-kernel@vger.kernel.org, Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010729222830.A25964@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	PEIFFER Pierre <ppeiffer@free.fr>, linux-kernel@vger.kernel.org,
	Bart Hartgers <bart@etpmod.phys.tue.nl>
In-Reply-To: <E15QE4v-0006R5-00@the-village.bc.nu> <20010728083724.A1571@weta.f00f.org> <3B62F660.FAAB2071@free.fr> <20010728142157.A6487@pckurt.casa-etp.nl> <3B6335EB.14F9866D@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <3B6335EB.14F9866D@free.fr>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

thanks for your info!

On Sat, Jul 28, 2001 at 06:00:11PM -0400, PEIFFER Pierre wrote:
> Kurt Garloff a =E9crit :
> In attached files are the result. I've only kept the (what I suppose to
> be) northbridge info.
> This doesn't tell me anything...

Me neither. I was hoping that only a bit differs. Unfortunately that's not
the case, so I need to have a look in the datasheet.
But those are not publically available :-(
Anybody having them?

> Note: both has been done after booting on  Mandrake-kernel 2.4.3 which
> come with Mandrake distribution (i.e. with lot of patches and
> options...) I don't know the impact on the result...

With a newer lspci you would have seen that 1106:0305 is VT8363/8365
[KT133/KM133].

I removed everything except for the differences. Underlined. Anybody able to
decode? Otherwise trying out all of them can get boring. (Well, I'd start
with 0x68, followed by 0x6b and 0xac  ...)

Working:

> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
> 	Subsystem: ABIT Computer Corp.: Unknown device a401
> 	Flags: bus master, medium devsel, latency 0
                                                  ^ This looks wrong to me.
> 	Memory at d8000000 (32-bit, prefetchable) [size=3D64M]
> 	Capabilities: [a0] AGP version 2.0
> 	Capabilities: [c0] Power Management version 2
> 00: 06 11 05 03 06 00 10 a2 03 00 00 06 00 00 00 00
                                              ^ Latency.
> 50: 17 a3 eb b4 02 00 10 10 c0 00 08 10 10 10 10 10
                  ^^ ^^
> 60: 03 aa 02 20 e6 d6 d6 c6 51 28 43 0d 08 3f 00 00
                              ^^       ^^
> a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 2b 12 14 00
                                          ^^
> b0: 49 da 00 60 31 ff 80 05 67 00 00 00 00 00 00 00
            ^^
> f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 00 00
                                                ^^ ^^

Buggy: (Own, buggy settings in parens)

> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
> 	Subsystem: ABIT Computer Corp.: Unknown device a401
> 	Flags: bus master, medium devsel, latency 8
                                                  ^ That's more reasonable.
> 	Memory at d8000000 (32-bit, prefetchable) [size=3D64M]
> 	Capabilities: [a0] AGP version 2.0
> 	Capabilities: [c0] Power Management version 2
> 00: 06 11 05 03 06 00 10 a2 03 00 00 06 00 08 00 00
                                              ^ Latency
> 50: 17 a3 eb b4 43 89 10 10 c0 00 08 10 10 10 10 10
                  ^^ ^^					(47 8d here)
> 60: 03 aa 02 20 e6 d6 d6 c6 45 28 43 0f 08 3f 00 00
                              ^^       ^^		(41 .. 21 here)
> a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 2f 12 14 00
                                          ^^		(6b here)
> b0: 49 da 88 60 31 ff 80 05 67 00 00 00 00 00 00 00
            ^^						(22 here)
> f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 91 06
                                                ^^ ^^	(00 00 here)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZHHtxmLh6hyYd04RApOJAKDNf49nwaK9LLZbsa3K5hwc5UJG3gCgqLvl
B+YmSCekL4sSZZYuFP+muM8=
=ABE3
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
