Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbTF1VRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTF1VRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 17:17:32 -0400
Received: from h80ad25cd.async.vt.edu ([128.173.37.205]:17280 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265418AbTF1VRb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 17:17:31 -0400
Message-Id: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.73-mm2 - odd audio problem, bad intel8x0/ac97 clocking.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1617367797P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Jun 2003 17:31:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1617367797P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

2.5.73-mm1 is fine.

This is *not* the "clock runs really really fas"t issue - I left -mm2 run=
ning overnight and
in some 8 hours the system clock only drifted a few seconds versus wall c=
lock (and it's
possible it was off a few seconds when it booted, as it didn't get an NTP=
 sync at boot).

Audio plays "too fast" - a 4 minute .ogg goes through in about 3:40, soun=
ding a bit
high-pitched in the process.

lspci -v:
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio =
(rev 02)
        Subsystem: Cirrus Logic: Unknown device 5959
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at d800 [size=3D256]
        I/O ports at dc80 [size=3D64]

relevant dmesg output:
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:=
18 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error =3D -16
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 51084
ALSA sound/pci/intel8x0.c:2520: joystick(s) found
ALSA device list:
  #0: Intel 82801CA-ICH3 at 0xd800, irq 11

The 'clocking to 51084' is *VERY* suspicious, as previously this value wa=
s
*always* 48000. Something very strange obviously happened in
intel8x0_measure_ac97_clock(), but I can't figure out what.  I don't
think the mdelay(50) is off - the Bogomips value hasn't changed from 3185=
=2E04.
The problem is deterministic - on 3 reboots, I've gotten 51084 twice and =
51085
once. Unless an odd latency is hitting spin_lock_irq(save,restore), I don=
't
see how that code can break?

Any ideas?


--==_Exmh_1617367797P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+/glBcC3lWbTT17ARAiCiAKC6pBovx3eLgfb2ciOM86nw9witmwCg9/3A
d77xtRylCHLjUjAOco0Mgng=
=LO7T
-----END PGP SIGNATURE-----

--==_Exmh_1617367797P--
