Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSHWK66>; Fri, 23 Aug 2002 06:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318751AbSHWK66>; Fri, 23 Aug 2002 06:58:58 -0400
Received: from fysh.org ([212.47.68.126]:1176 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S318743AbSHWK65>;
	Fri, 23 Aug 2002 06:58:57 -0400
Date: Fri, 23 Aug 2002 12:01:52 +0100
From: Athanasius <link@gurus.tf>
To: Rob Speer <rob@twcny.rr.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre2-ac4 IDE is slow
Message-ID: <20020823110152.GA8561@miggy.org.uk>
Mail-Followup-To: Athanasius <link@gurus.tf>, Rob Speer <rob@twcny.rr.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020822175945.GA743@twcny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20020822175945.GA743@twcny.rr.com>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: 95DFC4A7
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2002 at 01:59:45PM -0400, Rob Speer wrote:
> I'm going from 2.4.19 to 2.4.20-pre2-ac4 and the hard drive is noticably
> slower in the new version. (It doesn't use DMA in either version - I
> wish it did in ac4, but that's a separate problem.)
>=20
> What I seem to remember from the other message is that there's some
> parameter that can be changed to bring the speed back up. Could someone
> tell me what it is?
>=20
>=20
> If it helps: output of hdparm /dev/hda
>=20
> /dev/hda:
>  multcount    =3D  0 (off)
>  IO_support   =3D  0 (default 16-bit)

  This could be part of the problem too?  I don't think I set anything
specific to get to 32bit on my system.  Hmmm, the multcount too?
I'm starting to think, if this is your output from 2.4.20-pre2-ac4 that
you're hitting a bug in the current code which is REALLY not doing the
right thing for your controller.

>  unmaskirq    =3D  0 (off)
   ^^^^^^^^^^^^^^^^^^^^^^^

  Try hdparm -u1 /dev/hda

>  using_dma    =3D  0 (off)

  And may as well use -d1 too if it works on the device (yes, I know you
said neither kernel enabled it per default).  Then you're after finding
which DMA mode the IDE bus and drive can do, 'man hdparm' for the
possible values (like -X69 if it's all ATA100 capable for UDMA5).
  With a 60GB Maxtor and an 80pin cable I use:

	/sbin/hdparm -u1 -d1 -X69 /dev/hda

root@emelia:~# hdparm -t -T /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.52 seconds =3D246.15 MB/sec
 Timing buffered disk reads:  64 MB in  2.03 seconds =3D 31.53 MB/sec

Although I'm wondering if with ATA100 and UDMA5 I should be seeing even
better than that.

HTH,

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org.uk / http://www.clan-lovely.org/~a=
than/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1mFiAACgkQzbc+I5XfxKc38wCdEUb/v/45lDwBXMKfd6Ts9ryM
QAYAniC50tMU7Nk0QnrTr+twV/DpYpEO
=zVWq
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
