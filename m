Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTA1TH2>; Tue, 28 Jan 2003 14:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbTA1TH2>; Tue, 28 Jan 2003 14:07:28 -0500
Received: from turing.fb12.de ([193.41.124.37]:28033 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S267473AbTA1TH0>;
	Tue, 28 Jan 2003 14:07:26 -0500
Date: Tue, 28 Jan 2003 20:16:45 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <20030128201645.A29746@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	"David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
	dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
	lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
References: <20030128133606.A21796@turing.fb12.de> <200301281409.RAA28740@sex.inr.ac.ru> <20030128.103534.115458142.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030128.103534.115458142.davem@redhat.com>; from davem@redhat.com on Tue, Jan 28, 2003 at 10:35:34AM -0800
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x82AE75E4
x-gpg-keyid: 0x82AE75E4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David S. Miller(davem@redhat.com)@2003.01.28 10:35:34 +0000:
>    From: kuznet@ms2.inr.ac.ru
>    Date: Tue, 28 Jan 2003 17:09:09 +0300 (MSK)
>=20
>    We apparently have segment of zero length in queue. :-)
>   =20
>    Well, that chunk cannot be responsible for this directly, I am afraid
>    we somewhat arrived to attempt to retransmit already acked segment.
>=20
> Hmmm, it is one of few places where sequence numbers of already
> sent packet are mangled. :-)
>=20
> Good set of debug checks would be the following:

no output, i did 4 tests, everytime i was able to lock the ssh-connection
within a few seconds. kernel 2.5.59 + your debug-patch.

tcpdump of one:

20:07:30.788431 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: . ac=
k 4359 win 13888 <nop,nop,timestamp 591456 50952833> (DF) [tos 0x10]=20
20:07:31.054101 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: P 29=
27:2975(48) ack 4359 win 13888 <nop,nop,timestamp 591722 50952833> (DF) [to=
s 0x10]=20
20:07:31.119062 turing.fb12.de.ssh > ronja.fluchtwagenfahrer.de.32774: P 43=
59:4407(48) ack 2975 win 10944 <nop,nop,timestamp 50952865 591722> (DF) [to=
s 0x10]=20
20:07:31.119102 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: . ac=
k 4407 win 13888 <nop,nop,timestamp 591787 50952865> (DF) [tos 0x10]=20
20:07:31.132819 turing.fb12.de.ssh > ronja.fluchtwagenfahrer.de.32774: P 44=
07:4487(80) ack 2975 win 10944 <nop,nop,timestamp 50952865 591722> (DF) [to=
s 0x10]=20
20:07:31.132842 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: . ac=
k 4487 win 13888 <nop,nop,timestamp 591801 50952865> (DF) [tos 0x10]=20
20:07:31.132930 turing.fb12.de.ssh > ronja.fluchtwagenfahrer.de.32774: P 44=
87:4551(64) ack 2975 win 10944 <nop,nop,timestamp 50952866 591722> (DF) [to=
s 0x10]=20
20:07:31.132951 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: . ac=
k 4551 win 13888 <nop,nop,timestamp 591801 50952866> (DF) [tos 0x10]=20
20:07:31.602060 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: P 29=
75:3023(48) ack 4551 win 13888 <nop,nop,timestamp 592270 50952866> (DF) [to=
s 0x10]=20
20:07:31.687764 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: P 30=
23:3071(48) ack 4551 win 13888 <nop,nop,timestamp 592356 50952866> (DF) [to=
s 0x10]=20
20:07:31.834730 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: P 29=
75:3023(48) ack 4551 win 13888 <nop,nop,timestamp 592503 50952866> (DF) [to=
s 0x10]=20
20:07:31.888875 turing.fb12.de.ssh > ronja.fluchtwagenfahrer.de.32774: P 45=
51:4599(48) ack 3023 win 10944 <nop,nop,timestamp 50952942 592503> (DF) [to=
s 0x10]=20

---- here it hangs ---

20:07:31.888910 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: . ac=
k 4599 win 13888 <nop,nop,timestamp 592557 50952942> (DF) [tos 0x10]=20
20:07:32.300653 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: P ac=
k 4599 win 13888 <nop,nop,timestamp 592969 50952942> (DF) [tos 0x10]=20
20:07:33.232614 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: P ac=
k 4599 win 13888 <nop,nop,timestamp 593901 50952942> (DF) [tos 0x10]=20
20:07:35.096334 ronja.fluchtwagenfahrer.de.32774 > turing.fb12.de.ssh: P ac=
k 4599 win 13888 <nop,nop,timestamp 595765 50952942> (DF) [tos 0x10]=20
20:07:37.269116 ronja.fluchtwagenfahrer.de.32773 > turing.fb12.de.ssh: P ac=
k 1 win 34800 <nop,nop,timestamp 597938 50948566> (DF) [tos 0x10]=20


/B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

Repetition causes insanity. Repetition causes insanity. Repetition causes
insanity. Repetition causes insanity. Repetition causes insanity. Repetition
causes insanity. Repetition causes insanity. Repetition causes insanity.
Repetition causes insanity. Repetition causes insanity. Repetition causes
insanity. Repetition causes insanity. Repetition causes insanity. Repetition
causes insanity. Repetition causes ins

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj421x0ACgkQTsThvluiLwB/9wCcDWbX1CA77uHdB57TnzQUwL/U
yNMAoIAcB2evL8WG+pBBVVdXgPpaglPX
=z+Vb
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
