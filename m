Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSDKPgy>; Thu, 11 Apr 2002 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSDKPgx>; Thu, 11 Apr 2002 11:36:53 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:1419 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S314078AbSDKPgv>;
	Thu, 11 Apr 2002 11:36:51 -0400
Date: Thu, 11 Apr 2002 17:37:14 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: CHECKSUM_HW not behaving as expected
Message-ID: <20020411173714.A3869@crystal.2d3d.co.za>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020411170458.A2786@crystal.2d3d.co.za> <Pine.LNX.3.95.1020411111450.14550A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 5:32pm  up 15 days,  7:48,  9 users,  load average: 0.10, 0.07, 0.02
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard!

> > In Rubini's "Linux Device Drivers 2nd edition" he states in his network=
ing
> > chapter that skb->ip_summed =3D CHECKSUM_HW means that the hardware alr=
eady
> > performed a checksum and that the upper layers therefore don't need to =
do it
> > (He also states that CHECKSUM_NONE (default) means that it still needs =
to be
> > verified).
> >=20
> > I'm currently writing a network driver for 2.4.17 and the chip automati=
cally
> > performs checksums and you can tell it to exclude the CRC from the pack=
et or
> > not before making it available for the host. Now, if I configure it to
> > exclude the CRC and use skb->ip_summed =3D CHECKSUM_HW I get:
> >=20
>=20
> CRC not!
> The IP checksum is not the CRC. Some new network boards "know" about
> the IP checksum and can compute it. The CRC is a hardware-computed CRC
> that is appended to every Ethernet packet. The CRC must be received
> intact or the packet is rejected (dropped). If it's possible to 'tell'
> your board to exclude the CRC, this is not what you want.

No, you misunderstood. The card still verify the CRC. You can just instruct
it not to include it in the frame that you want to copy, e.g. say you
receive a 64-byte ethernet frame, then it can either tell you "copy from my
buffer 64 bytes" or if you're not interested in the CRC, "copy 60 bytes from
my buffer"

What I don't want is for the kernel to verify the CRC again since it's
already been done by the hardware (and I save 4 bytes on the copy (: )

> If you already know this, then the possible problem is that the
> packet length is wrong. The IP checksum is a 16-bit integer of
> 16-bit integers. This means that the packet length must be an even
> number. Your driver may be returning the wrong length. Also, when
> you transmit, if the hardware is going to do the checksum, what
> does it expect at the checksum offset in the IP packet? Hardware
> checksums usually don't 'skip' some offset so the checksum value
> should probably be 0 when it goes to your hardware.

Dope. Somehow I thought it was the "ethernet frame checksum" - not quite the
same thing :P

--=20

Regards
 Abraham

You will pioneer the first Martian colony.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ta2qzNXhP0RCUqMRAmaaAJ0Un7DWxjTnZ+W/HZea8YQ73Y4MNgCeNtaM
m7ysIWaJXSccmyYJPR8ceQk=
=GG8h
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
