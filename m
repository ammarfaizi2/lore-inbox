Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUGZJwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUGZJwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUGZJwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:52:07 -0400
Received: from hydra.gt.owl.de ([195.71.99.218]:37828 "EHLO hydra.gt.owl.de")
	by vger.kernel.org with ESMTP id S264903AbUGZJwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:52:01 -0400
Date: Mon, 26 Jul 2004 11:51:54 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: tg3 - card generated broken arp queries ?
Message-ID: <20040726095154.GA5872@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
we are debugging networking problems and stumpled over interesting arp
queries from one of our machines. Its currently an 2.6.5 vanilla.
Ethernet card is an tg3.

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gi=
gabit Ethernet (rev 02)
        Subsystem: Unknown device 1734:100b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fa110000 (64-bit, non-prefetchable)
        Region 2: Memory at fa100000 (64-bit, non-prefetchable) [size=3D64K]
        Capabilities: [40]      Capabilities: [48] Power Management version=
 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=3D0 DScale=3D1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=3D0/3=
 Enable-
                Address: 0000000100000000  Data: a02d

I changed the mac address with "ifconfig eth0 hw ether de:ad:be:ef:00:00"
and watched the ethernet with a port mirror.  Original mac address of
the interface is: 0:30:5:46:b1:9e

The broken arps were still coming with the original mac address:

tcpdump -s 1600 -vvv -n -e -i eth0 arp
09:48:03.168087 0:30:5:46:b1:9e ff:ff:ff:ff:ff:ff 0806 60: arp who-has 0.0.=
0.0 tell 0.0.0.0

On the machine itself i couldnt see those arp queries in the tcpdump -
It seems the card itself generates those arp queries.

Is this possible at all ? Is it a known bug ?=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBNQ5Uaz2rXW+gJcRAh2VAKDmzowtbA+k/54rIcYYtFVgPxWGJwCfRLy0
dulNRqjir8z5Nr844pH0XWs=
=v1oO
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
