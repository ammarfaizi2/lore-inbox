Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbUKRJlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbUKRJlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 04:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUKRJlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 04:41:03 -0500
Received: from ns1.nuit.ca ([66.11.160.83]:39296 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S262529AbUKRJkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 04:40:43 -0500
Date: Thu, 18 Nov 2004 04:40:41 -0500
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: OOPS: tulip in 2.6.10-rc2-bk2
Message-ID: <20041118094041.GB7555@nuit.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040907i
X-Scan-Signature: smtp.nuit.ca 1CUimP-0002OX-No 6b143ad6ef5faaa3d4b92f5998395712
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


PPC32, Power Tower Pro, 512 MB RAM, G3/300 CPU

processor       : 0
cpu             : 740/750
temperature     : 35-37 C (uncalibrated)
clock           : 195MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 602.11
machine         : Power Macintosh
motherboard     : AAPL,9500 MacRISC
detected as     : 16 (PowerMac 9500/9600)
pmac flags      : 00000000
memory          : 512MB
pmac-generation : OldWorld

(yeh i know, running hot...)

0000:00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (r=
ev 03)
0000:00:0d.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro=
 (rev dc)
0000:00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 0=
3)
0000:00:10.0 ff00: Apple Computer Inc. Grand Central I/O (rev 02)
0000:01:00.0 Memory controller: Adaptec AIC-7815 RAID+Memory Controller IC =
(rev 02)
0000:01:04.0 SCSI storage controller: Adaptec 78902
0001:02:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (r=
ev 03)
0001:02:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev =
20)
0001:02:0e.0 Ethernet controller: Accton Technology Corporation EN-1216 Eth=
ernet Adapter (rev 11)
0001:02:0f.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U

cat /proc/sys/kernel/l2cr
0xa9000000:  enabled, no parity, 512KB, +2 clock, pipelined burst SRAM, cop=
y-back, 0.5ns hold


compiled with and without NAPI, both OOPS. first time in a hotplug
triggered modprobe on boot, and when ppp interface in brought down.
behaviour is such that the module appears in lsmod, but isn't
functional.

here, the oops got triggered after i exited xmon:

Thu Nov 18 08:57:12 2004: PCI: Enabling device 0001:02:0d.0 (0004 -> 0007)
Thu Nov 18 08:57:12 2004: Oops: kernel access of bad area, sig: 11 [#1]
Thu Nov 18 08:57:12 2004: NIP: E1D0ED48 LR: E1D0ECA8 SP: DF2B3D80 REGS: df2=
b3cd0 TRAP: 0300    Not tainted
Thu Nov 18 08:57:12 2004: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Thu Nov 18 08:57:12 2004: DAR: 90001030, DSISR: 40000000
Thu Nov 18 08:57:12 2004: TASK =3D df5d7170[8042] 'modprobe' THREAD: df2b20=
00Last syscall: 128=20
Thu Nov 18 08:57:12 2004: GPR00: E1D10518 DF2B3D80 DF5D7170 DF144000 000000=
00 00000000 DF1449FC E1D173E4=20
Thu Nov 18 08:57:12 2004: GPR08: DE5B6860 90001000 4B87AD6E 90001030 930335=
33 1001E284 100013A4 00000000=20
Thu Nov 18 08:57:12 2004: GPR16: DF2B3D88 00000000 E1D139E8 0000001B C03E88=
48 DE5B6230 E1D10000 E1D10000=20
Thu Nov 18 08:57:12 2004: GPR24: 00000004 DE5B6220 90001000 C03E8800 DE5B60=
00 00000050 DF144000 00000000=20
Thu Nov 18 08:57:12 2004: NIP [e1d0ed48] tulip_init_one+0x2e0/0xca0 [tulip]
Thu Nov 18 08:57:12 2004: LR [e1d0eca8] tulip_init_one+0x240/0xca0 [tulip]
Thu Nov 18 08:57:12 2004: Call trace:
Thu Nov 18 08:57:12 2004:  [c01698ac] pci_device_probe_static+0x6c/0x88
Thu Nov 18 08:57:12 2004:  [c0169918] __pci_device_probe+0x50/0x70
Thu Nov 18 08:57:12 2004:  [c0169968] pci_device_probe+0x30/0x60
Thu Nov 18 08:57:12 2004:  [c01a1840] driver_probe_device+0x4c/0xa0
Thu Nov 18 08:57:12 2004:  [c01a19d8] driver_attach+0x88/0xc8
Thu Nov 18 08:57:12 2004:  [c01a1fc4] bus_add_driver+0xa0/0x10c
Thu Nov 18 08:57:12 2004:  [c01a2650] driver_register+0x30/0x40
Thu Nov 18 08:57:12 2004:  [c0169c90] pci_register_driver+0x70/0xa0
Thu Nov 18 08:57:12 2004:  [e1d1904c] tulip_init+0x4c/0xf0 [tulip]
Thu Nov 18 08:57:12 2004:  [c0036948] sys_init_module+0x220/0x320
Thu Nov 18 08:57:12 2004:  [c0003ec0] ret_from_syscall+0x0/0x44

=66rom bootlogd (thank you authors of bootlogd :)

no OOPS output available for the pppd one, but there was something about
snmp6 and tulip_init, and then it dropped me into xmon again, i hit x to
exit, then the kernel panics, with something about=20
(heavily paraphrased) "tried to kill init **** registers!"

oh, and my eth1 doesn't come up. i tried to modprobe -r tulip, and
modprobe complained about tulip being in use. that's when i tried to
stop pppd (good ol' poff), and that's when it oopsed the second time.

oh, and atyfb (ATI rage 3d lt pro card) needs that FB_HELPER option,
too (and yes, if i bet that you folks knew about that already, i'd win
*grin*), otherwise i get tiny mouse type at boot, until the=20
console font set up is done (debian sid box).

PS: PLEASE CC: me off-list, not subscribed. thank you. my rebooting
opportunities for testing kernel options and images are limited.

eric c=C3=B4t=C3=A9

--=20
Puritanism: The haunting fear that someone, somewhere may be happy.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQGVAwUBQZxuGGqIeuJxHfCXAQIRpAv/Xa8D3mTChy78cx7dV8v9v1vYLrFUrTEC
UgDQtm+8ZD7nuPt4Qq38pJQjayyu5+DgGQyYzf3T8OZY6EedtomxIubA6IwwIaN+
MVtQ9tnJUZpm4lbAn4PtEbs+MLoHAIG2Y+Gt/xnzcXYnbqniR4K6e3lPMwA1am7o
apRA2HKI+Oe3Ky5wiiHifklccWRwDhevBST5VSYD7ARfNT8Ap1mOu7gdwwTsJ69f
Pq6QpzfNQFuXJEIuEDWzZWO9Wpy0Miy/BvlqINCIJEuM8N8pbpRXtioRzuFS26ls
1TCLjimlAGv1pAQk1UZfYC8lgGGpCIY8ccBsCO1wq1fEzb1XzY59oY3FW0zdXaca
t4169lK5RbrBNDw7qMWFro0G38lw+lyVWc8/JLCYU+gJH/0ZcGiTvBwoCMDyxBRH
o6q1HmOOt96UkBpojQh7aQDkq9FCxeNgu4UxxSxmUeQctAgQSqQE1hjQgA/eMOEg
4NzlwnD40Gh4g4V9OHasENNauWoUAChW
=qazR
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
