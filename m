Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbTAQOpJ>; Fri, 17 Jan 2003 09:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbTAQOpI>; Fri, 17 Jan 2003 09:45:08 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:13585 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id <S267525AbTAQOpH>;
	Fri, 17 Jan 2003 09:45:07 -0500
Date: Fri, 17 Jan 2003 15:53:58 +0100
From: Florian Lohoff <flo@rfc822.org>
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: eepro100 - 802.1q - mtu size
Message-ID: <20030117145357.GA1139@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
it seems the current (2.4.20) eepro100 driver is not capable of doing
802.1q as the max received packet size seems to be to low - Receiving
packets with more that 1514 bytes get dropped. The vlan page lists a
patch against a 2.2 kernel which is still valid for 2.4.20 and even
works.

Why is this patch not integerated yet ?

Rediffed:

--- linux-2.4.20/drivers/net/eepro100.c	Fri Nov 29 00:53:13 2002
+++ linux-2.4.20.flo/drivers/net/eepro100.c	Fri Jan 17 15:30:52 2003
@@ -502,12 +502,12 @@
 static const char i82557_config_cmd[CONFIG_DATA_SIZE] =3D {
 	22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=3DUse MII  0=3DUse AUI */
 	0, 0x2E, 0,  0x60, 0,
-	0xf2, 0x48,   0, 0x40, 0xf2, 0x80, 		/* 0x40=3DForce full-duplex */
+	0xf2, 0x48,   0, 0x40, 0xfa, 0x80, 		/* 0x40=3DForce full-duplex */
 	0x3f, 0x05, };
 static const char i82558_config_cmd[CONFIG_DATA_SIZE] =3D {
 	22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=3DUse MII  0=3DUse AUI */
 	0, 0x2E, 0,  0x60, 0x08, 0x88,
-	0x68, 0, 0x40, 0xf2, 0x84,		/* Disable FC */
+	0x68, 0, 0x40, 0xfa, 0x84,		/* Disable FC */
 	0x31, 0x05, };
=20
 /* PHY media interface chips. */



I tried on this chip:

02:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet Cont=
roller (rev 03)
        Subsystem: Intel Corp.: Unknown device 3013
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f4900000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: I/O ports at 3000 [size=3D64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+KBkFUaz2rXW+gJcRApKoAJ0VcmOb7sICU1b2AUDGsEszvYKfgACgr+PQ
BKwyF/Fio8h7YFm1OhOmnfA=
=ImRe
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
