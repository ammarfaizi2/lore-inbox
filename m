Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSDKPEc>; Thu, 11 Apr 2002 11:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSDKPEb>; Thu, 11 Apr 2002 11:04:31 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:48522 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S314082AbSDKPEa>;
	Thu, 11 Apr 2002 11:04:30 -0400
Date: Thu, 11 Apr 2002 17:04:58 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: CHECKSUM_HW not behaving as expected
Message-ID: <20020411170458.A2786@crystal.2d3d.co.za>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 5:00pm  up 15 days,  7:16,  9 users,  load average: 0.09, 0.07, 0.01
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In Rubini's "Linux Device Drivers 2nd edition" he states in his networking
chapter that skb->ip_summed =3D CHECKSUM_HW means that the hardware already
performed a checksum and that the upper layers therefore don't need to do it
(He also states that CHECKSUM_NONE (default) means that it still needs to be
verified).

I'm currently writing a network driver for 2.4.17 and the chip automatically
performs checksums and you can tell it to exclude the CRC from the packet or
not before making it available for the host. Now, if I configure it to
exclude the CRC and use skb->ip_summed =3D CHECKSUM_HW I get:

root@frodo:/# ./ldm
Using /cs8900.o
CS8900A driver for 2d3D, SA-1110 Development Board.
eth0: CS8900A rev D detected
configuring network:.
root@frodo:/# icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
icmp v4 hw csum failure
NET: 3 messages suppressed.
icmp v4 hw csum failure

root@frodo:/#
------------< snip <------< snip <------< snip <------------

If I used CHECKSUM_NONE, it works fine which obviously means that the CRC is
not computed in software.

Is that a bug in the kernel or does Alessandro have it wrong?

--=20

Regards
 Abraham

There is one difference between a tax collector and a taxidermist --
the taxidermist leaves the hide.
		-- Mortimer Caplan

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8taYazNXhP0RCUqMRAj+pAJwKAmClwBnDHeKuKSzwt7MfoxpBygCfc+fZ
0CsVwIcMazJ/rlSTUKM5USg=
=BA3z
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
