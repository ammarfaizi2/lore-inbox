Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbUKRRiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUKRRiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUKRRgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:36:17 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:8365 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S262795AbUKRRfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:35:07 -0500
Date: Thu, 18 Nov 2004 18:35:04 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.9 nfsd crashing often
Message-ID: <20041118173504.GA24187@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-cirrus i686
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We upgraded our cluster master server to 2.6.9 this morning and are
now experiencing major problems with the kernel NFS server, which
crashes every hours or so:

  Unable to handle kernel NULL pointer dereference at virtual address 00000=
000
  printing eip:
  00000000
  *pde =3D 00000000
  Oops: 0000 [#1]
  PREEMPT=20
  Modules linked in: sd_mod scsi_mod af_packet ipv6 ipt_mac ipt_LOG ipt_lim=
it ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables uhci_hcd ohci=
_hcd ehci_hcd usbcore 8139cp shpchp pciehp pci_hotplug via_agp agpgart pcsp=
kr evdev 8139too mii crc32 via_ircc irda crc_ccitt nfsd exportfs lockd sunr=
pc capability commoncap ide_cd cdrom rtc isofs xfs ext2 ext3 jbd mbcache id=
e_generic via82cxxx ide_disk ide_core raid1 md unix fbcon font vesafb cfbco=
pyarea cfbimgblt cfbfillrect
  CPU:    0
  EIP:    0060:[<00000000>]    Not tainted VLI
  EFLAGS: 00010286   (2.6.9-1-k7)=20
  EIP is at 0x0
  eax: c0390f00   ebx: fffffff4   ecx: d131bae4   edx: d131bae4
  esi: d1c6f22c   edi: d131ba28   ebp: 00000000   esp: db4abeac
  ds: 007b   es: 007b   ss: 0068
  Process nfsd (pid: 2134, threadinfo=3Ddb4aa000 task=3Ddea3e020)
  Stack: c0166197 d1c6f22c d131ba28 00000000 ffffffff dfd49aba 0000000a dfd=
49ab0=20
        c01661ef db4abee8 d131bab4 00000000 c0166261 db4abee8 d131bab4 ead0=
df9b=20
        0000000a dfd49ab0 daf85804 d131bab4 daf85804 e0a99493 dfd49ab0 d131=
bab4=20
  Call Trace:
  [<c0166197>] __lookup_hash+0xa7/0xe0
  [<c01661ef>] lookup_hash+0x1f/0x30
  [<c0166261>] lookup_one_len+0x61/0x70
  [<e0a99493>] nfsd_lookup+0x113/0x4e0 [nfsd]
  [<e0aa26a1>] nfsd3_proc_lookup+0xa1/0xe0 [nfsd]
  [<e0a96729>] nfsd_dispatch+0xd9/0x230 [nfsd]
  [<e0a3e6ed>] svc_process+0x56d/0x780 [sunrpc]
  [<c011a120>] default_wake_function+0x0/0x20
  [<e0a96495>] nfsd+0x1f5/0x3b0 [nfsd]
  [<e0a962a0>] nfsd+0x0/0x3b0 [nfsd]
  [<c01042b1>] kernel_thread_helper+0x5/0x14
  Code:  Bad EIP value.

We had experienced this problem exactly once before with a 2.6.8.1
kernel, where it otherwise ran very stable.

There are no reasons to believe that the hardware is at fault.
Everything else seems to work fine, memtest86 does not report
any problems, and the harddrives are okay.

The machine runs Debian sarge. The kernel is a stock kernel.

The hardware is an AMD Athlon XP 2200+ with 512 Mb of RAM. /dev/hda
and /dev/hdc run as part of a software RAID 1.

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A=
/333]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/=
333 AGP]
0000:00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/=
8139C/8139C+ (rev 10)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B=
/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 M=
X/MX 400] (rev b2)

Reverting to 2.6.8.1 for now. I would appreciate any help, would be
glad to provide additional information, and hope that this is either
fixable, or not a kernel problem at all.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"verbing weirds language."
                                                           -- calvin

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnN1IIgvIgzMMSnURAr7HAJ41rCCQCBvbNEcCft5rcM4VCfem3gCgpGFW
aKmpTBxTmIt+18UdFHDlhmw=
=StA7
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
