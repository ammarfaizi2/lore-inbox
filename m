Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129317AbRBLNEo>; Mon, 12 Feb 2001 08:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbRBLNEe>; Mon, 12 Feb 2001 08:04:34 -0500
Received: from air.lug-owl.de ([62.52.24.190]:33289 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129317AbRBLNEX>;
	Mon, 12 Feb 2001 08:04:23 -0500
Date: Mon, 12 Feb 2001 14:04:20 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: PCI bridge handling 2.4.0-test10 -> 2.4.2-pre3
Message-ID: <20010212140419.A11619@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've got a "Bull Express5800/Series" (dual P3) with a DAC1164 RAID
controller. The mainboard is ServerWorks based and however, 2.4.2-pre3
fails to find the RAID controller. I think there's a problem at
scanning PCI busses behind PCI bridges. Here's the PCI bus layout as
2.4.0-test10 recognizes it:

-+-[01]-+-04.0  Adaptec 7899P
 |      +-04.1  Adaptec 7899P
 |      \-0a.0-[02]--+-08.0  Digital Equipment Corporation: Unknown device =
1065
 |                   \-09.0  Mylex Corporation eXtremeRAID support Device
 \-[00]-+-00.0  Relience Computer CNB20HE
        +-00.1  Relience Computer CNB20HE
        +-02.0  ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
        +-03.0  Intel Corporation 82557 [Ethernet Pro 100]
        +-06.0  Intel Corporation 82557 [Ethernet Pro 100]
        +-07.0  Intel Corporation 82557 [Ethernet Pro 100]
        +-0f.0  Relience Computer: Unknown device 0200
        \-0f.1  Relience Computer: Unknown device 0211

Here's log output from both 2.4.0-test10 (successfully booting) and
2.4.2-pre3 (no success due to missing root fs):

----------------------- 2.4.0-test10 -----------------------
PCI: PCI BIOS revision 2.10 entry at 0xfdb3c, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ServerWorks host bridge: secondary bus 00
PCI: ServerWorks host bridge: secondary bus 01
PCI->APIC IRQ transform: (B1,I4,P0) -> 16
PCI->APIC IRQ transform: (B1,I4,P1) -> 17
PCI->APIC IRQ transform: (B2,I8,P0) -> 20
PCI->APIC IRQ transform: (B0,I2,P0) -> 19
PCI->APIC IRQ transform: (B0,I3,P0) -> 18
PCI->APIC IRQ transform: (B0,I6,P0) -> 26
PCI->APIC IRQ transform: (B0,I7,P0) -> 23
[...]
DAC960: ***** DAC960 RAID Driver Version 2.4.8 of 19 August 2000 *****
DAC960: Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: Configuring Mylex DAC1164P PCI RAID Controller
DAC960#0:   Firmware Version: 5.07-0-79, Channels: 3, Memory Size: 16MB
DAC960#0:   PCI Bus: 2, Device: 8, Function: 0, I/O Address: Unassigned
DAC960#0:   PCI Address: 0xFB110000 mapped at 0xE0800000, IRQ Channel: 20
DAC960#0:   Controller Queue Depth: 128, Maximum Blocks per Command: 128
DAC960#0:   Driver Queue Depth: 127, Scatter/Gather Limit: 33 of 33 Segments
DAC960#0:   Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 255/63
DAC960#0:   SAF-TE Enclosure Management Enabled

----------------------- 2.4.2-pre3 -------------------------------
PCI: PCI BIOS revision 2.10 entry at 0xfdb3c, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ServerWorks host bridge: last bus ff
PCI->APIC IRQ transform: (B0,I2,P0) -> 19
PCI->APIC IRQ transform: (B0,I3,P0) -> 18
PCI->APIC IRQ transform: (B0,I6,P0) -> 26
PCI->APIC IRQ transform: (B0,I7,P0) -> 23


Can you give me some advice on how to hack those PCI bridges?

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjqH31MACgkQHb1edYOZ4bvAjgCfbnj1t1Tj6sLuEV9fXKsc06aW
ATIAnRisc9lJCABP0akLdD/2kgqVHCl3
=DCqP
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
