Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUIOHcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUIOHcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUIOHcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:32:50 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:737 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S262406AbUIOHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:32:18 -0400
Date: Wed, 15 Sep 2004 09:32:08 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: oops in usbserial / removing visor.o
Message-ID: <20040915073208.GA21518@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-1-k7 i686
X-Mailer: Mutt 1.5.6+20040818i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yesterday, I hotsynced my palm and surprisingly, for the first time,
My 2.6.8.1 (Debian stock) kernel oopsed:

  kernel: Unable to handle kernel NULL pointer dereference at virtual addre=
ss 00000070
  kernel:  printing eip:
  kernel: f8eb9584
  kernel: *pde =3D 00000000
  kernel: Oops: 0000 [#1]
  kernel: PREEMPT=20
  kernel: Modules linked in: visor usbserial ehci_hcd usb_storage hci_usb u=
hci_hcd usbcore nls_iso8859_1 nls_cp437 bnep rfcomm l2cap ide_cd cdrom ipv6=
 lp thermal fan button processor ac battery af_packet ipt_LOG ipt_limit ipt=
_REJECT ipt_state iptable_filter ipt_MASQUERADE iptable_nat ip_conntrack ip=
_tables 8139cp bt878 eth1394 sata_promise libata ohci1394 ieee1394 pci_hotp=
lug via_agp agpgart pcspkr parport_pc parport bluetooth sd_mod scsi_mod tun=
er tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_co=
re videodev 8139too mii crc32 tg3 firmware_class snd_bt87x via_ircc irda cr=
c_ccitt snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_ti=
mer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd =
soundcore dm_mod tsdev mousedev evdev capability commoncap psmouse rtc xfs =
reiserfs vfat fat isofs ext2 ext3 jbd mbcache ide_generic via82cxxx ide_dis=
k ide_core unix font vesafb cfbcopyarea cfbimgblt cfbfillrect
  kernel: CPU:    0
  kernel: EIP:    0060:[__crc_bio_phys_segments+294547/1648624]    Not tain=
ted
  kernel: EFLAGS: 00010246   (2.6.8-1-k7)=20
  kernel: EIP is at serial_chars_in_buffer+0x24/0xa0 [usbserial]
  kernel: eax: f5910000   ebx: 00000000   ecx: 00000000   edx: d99d7b20
  kernel: esi: ffffffea   edi: 00000000   ebp: c1dd74c0   esp: f0c99ea4
  kernel: ds: 007b   es: 007b   ss: 0068
  kernel: Process pilot-xfer (pid: 23205, threadinfo=3Df0c98000 task=3Dc1df=
88e0)
  kernel: Stack: c1df8a88 00000000 7fffffff 00000004 00000000 f5910000 c01d=
d3ff f5910000=20
  kernel:        f591091c f0c99f44 c1dd74c0 00000008 00000003 00000003 c01d=
8f85 f5910000=20
  kernel:        c1dd74c0 00000000 00000000 c016727e c1dd74c0 00000000 0000=
0000 00000000=20
  kernel: Call Trace:
  kernel:  [normal_poll+239/336] normal_poll+0xef/0x150
  kernel:  [tty_poll+101/128] tty_poll+0x65/0x80
  kernel:  [do_select+606/720] do_select+0x25e/0x2d0
  kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
  kernel:  [sys_select+703/1216] sys_select+0x2bf/0x4c0
  kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
  kernel: Code: 8b 53 70 85 d2 75 35 a1 84 00 ec f8 85 c0 75 0e 89 f0 8b 5c=
=20

The result is surprising: USB still works, but the usbserial subtree
(in terms of dependencies) seems to be ballooney. At least, visor.o
seems to be used by 2^32-1 which I don't think exists. ;^>

$ lsmod
[...]
visor                  18256  4294967295=20
usbserial              29928  3 visor
[...]

So this post fulfills two purposes. First, it's a bug report, and if
you need any more info, please let me know.

Second, I am wondering how to remove or reinitialise visor.o now.

# rmmod visor
ERROR: Module visor is in use

CONFIG_MODULE_FORCE_UNLOAD is set, but I am cautious because I do
not want to crash the system right now, it's being intensively used.
This is also the reason why I don't simply reboot to fix the
problem.

What else can I do?

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"for art to exist, for any sort of aesthetic activity or perception
 to exist, a certain physiological precondition is indispensable:
 intoxication."
                                                -- friedrich nietzsche

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBR+/4IgvIgzMMSnURAgc/AKDVU7mHnRSlUC2UV3ykuXVNjSP0EACcDYR7
j+eUhm6LPIl7KF/PGNnjccY=
=X7sn
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
