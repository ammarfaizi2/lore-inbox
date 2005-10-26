Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVJZSYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVJZSYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVJZSYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:24:19 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:41159 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S964849AbVJZSYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:24:18 -0400
Date: Wed, 26 Oct 2005 20:24:17 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.6.13.3 and a Intel Corp. 82547EI Gigabit Ethernet
	Controller (LOM)
Message-ID: <20051026182416.GA19168@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Oct 27 20:04:07 CEST 2005
X-MSMail-Priority: High
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Reproducable i get a kernel panic when inserting the e1000 module on my
system. It is P4 with hyperthreading enabled. 1GB ram.
lspci output:
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev =
02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (re=
v 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (re=
v 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (re=
v 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (re=
v 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Contr=
oller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Br=
idge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 St=
orage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC=
'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra =
TF
02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controlle=
r (LOM)
03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Control=
ler (rev 80)
03:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (r=
ev 24)
03:0a.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 50)
03:0a.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 50)
03:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
03:0b.0 Communication controller: Individual Computers - Jens Schoenfeld In=
tel 537
03:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capt=
ure (rev 11)
03:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (r=
ev 11)
03:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)

I've placed the .config here: http://keetweej.vanheusden.com/~folkert/e1000=
_crash_.config
dmesg output (when the system starts, don't have it from a crash as the sys=
tem frashes hard): http://keetweej.vanheusden.com/~folkert/e1000_crash_dmesg
screendump (so that one can verify if I didn't make any typing errors): htt=
p://keetweej.vanheusden.com/~folkert/e1000_crash_screendump.jpg

Ok and what is written in the dump:
c013dfc0 handle_irq_event+0x50/0x60
c0105796 __do_irq+0xc6/0x70
c0103796 common_interrupt+0x1a/0x20
c01f1768 acpi_processor_idle+0x10d/0x2b1
c0100d70 cpu_idle+0x70/0x80
c03ca8db start_kernel+0x14b/0x170

Code: 44 24 0c 0f 31 89 44 24 04 b9 04 etc. (hand to handwrite it down)


Folkert van Heusden

--=20
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkNfydA8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuLN0AnA1hBucp
GfEiOVfTBnWdBucu/xiGAJ9AI0KLhxNBGJL9BYpkzqgE0ZHH9g==
=eoTl
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
