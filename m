Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTFIRCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTFIRCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:02:21 -0400
Received: from hc652c3a8.dhcp.vt.edu ([198.82.195.168]:5248 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264448AbTFIRCT (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:02:19 -0400
Message-Id: <200306091715.h59HFwTQ001604@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.70-mm6 (and earlier) wonkyness with orinoco_cs versus xircom.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1737856375P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jun 2003 13:15:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1737856375P
Content-Type: text/plain; charset=us-ascii

Situation:

Dell Latitude C840, has a builtin wireless card.  'cardctl ident' says:

Socket 2:
  product info: "Dell", "TrueMobile 1150 Series PC Card", "Version 01.01", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)

Works fine with the orinoco_cs driver - when pcmcia is started, dmesg says:

eth1: Station identity 001f:0001:0008:000a
eth1: Looks like a Lucent/Agere firmware version 8.10
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:5C:11:48
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f
eth1: New link status: Connected (0001)
eth1: no IPv6 routers present

(cut and paste from the current dmesg)

and it DHCP's and we're good to go.

Problem:  I also have a "Xircom RealPort CardBus Ethernet 10/100+Modem 56" that
usually lives in socket 1.  Now, I don't NEED the ethernet, I just use it for
the modem (the C840 onboard modem is a winmodem).  But.. If it's plugged in,
this happens instead (from this morning's syslogs):

(first, the xircom configs)
Jun  8 04:22:23 turing-police kernel: PCI: Enabling device 03:00.0 (0000 -> 0003)
Jun  8 04:22:23 turing-police kernel: PCI: Setting latency timer of device 03:00.0 to 64
Jun  8 04:22:23 turing-police kernel: eth1: Xircom cardbus revision 3 at irq 11 
Jun  8 04:22:23 turing-police kernel: PCI: Enabling device 03:00.1 (0000 -> 0003)
Jun  8 04:22:23 turing-police kernel: ttyS14 at I/O 0x1080 (irq = 11) is a 16550A
Jun  8 04:22:24 turing-police kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfffff
Jun  8 04:22:24 turing-police kernel: eth1: Station identity 001f:0001:0008:000a
(Now /sbin/cardmgr tries to kick-start the card)
Jun  8 04:22:24 turing-police kernel: eth1: Looks like a Lucent/Agere firmware version 8.10
Jun  8 04:22:24 turing-police kernel: eth1: Ad-hoc demo mode supported
Jun  8 04:22:24 turing-police kernel: eth1: IEEE standard IBSS ad-hoc mode supported
Jun  8 04:22:24 turing-police kernel: eth1: WEP supported, 104-bit key
Jun  8 04:22:24 turing-police kernel: eth1: MAC address 00:02:2D:5C:11:48
Jun  8 04:22:24 turing-police kernel: eth1: Station name "HERMES I"
Jun  8 04:22:24 turing-police kernel: eth1: ready
Jun  8 04:22:24 turing-police kernel: orinoco_cs: register_netdev() failed

Why register_netdev() fails after getting as far as 'eth1: ready' is beyond
me. It just takes a left turn before the 'index 0x01' line'.

Incidentally, the reason the two cards both show as eth1 is because the
Xircom gets nameif'ed to eth2 - this *MAY* be part of the cause of the problem.

If I boot without the Xircom card inserted, and insert it after the wireless
card comes up, sometimes THAT ethernet will config correctly and everything is
fine, and sometimes the system hangs hard (I haven't ad a chance to replicate
it in runlevel 3 so I can see an OOPS if any).

This ring a bell with anybody?  Suggestions for further information gathering?

--==_Exmh_1737856375P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+5MDNcC3lWbTT17ARAtRHAKCMpVwqDTVCOta7h1a1bilbTczXzACg7AOh
0GsZA3r15oUXy0t8sA4pAJM=
=Dgit
-----END PGP SIGNATURE-----

--==_Exmh_1737856375P--
