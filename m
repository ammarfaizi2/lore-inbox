Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBNOsc>; Wed, 14 Feb 2001 09:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbRBNOsV>; Wed, 14 Feb 2001 09:48:21 -0500
Received: from air.lug-owl.de ([62.52.24.190]:41234 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129137AbRBNOsM>;
	Wed, 14 Feb 2001 09:48:12 -0500
Date: Wed, 14 Feb 2001 15:48:09 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: axp-hardware@talisman.alphalinux.org
Subject: Alpha: bad unaligned access handling
Message-ID: <20010214154808.A15974@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org,
	axp-hardware@talisman.alphalinux.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux air 2.4.0-test8-pre1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

With my currently installed ping (netkit-ping 0.10-6 from Debian Woody)
I get unaligned accesses:

ping(15953): unaligned trap at 00000001200030e4: 0000000120026b34 29 1
ping(15953): unaligned trap at 0000000120003110: 0000000120026b2c 29 2

The worse part is: they seem to be handled The Wrong Way:

[jbglaw@air:/home/jbglaw] $> ping -c 1 localhost
PING localhost (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=3D0 ttl=3D255 time=3D13.8 ms
wrong data byte #8 should be 0x8 but was 0xdc
        c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23=
 24 25 26 27 28 29 2a 2b=20
        2c 2d 2e 2f 0 0 0 0 0 0 0 0 0 0 0 0=20

--- localhost ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max =3D 13.8/13.8/13.8 ms


This is on a NoName Alpha box, running 2.4.0-test8-pre1 (with very good
uptimes), but I think 2.4.2-pre2 would do the same (wrong) things as
arch/alpha/kernel/traps.c wasn't really changed since ages... I don't
know much about alpha assemlbly language so somebody else should have
a look at that;( Btw., when such an unaligned trap has happened, I also
get transmit timeouts on my network card (which is:
00:0c.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]


NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  Flags; bus-master 1, full 1; dirty 1470429(13) current 1470445(13).
  Transmit list 477a42d0 vs. fffffc00077a42d0.
  0: @fffffc00077a4200  length 80000042 status 00000042
=2E..

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjqKmqgACgkQHb1edYOZ4btdHACggJe2OWUyPC1yBdHQbhxOjUpV
gd4An2Tq/HsXNIRGPXvl/znjGz+LoEbd
=hRlD
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
