Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUILSFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUILSFR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUILSDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:03:41 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:9443 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S268771AbUILSC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:02:57 -0400
Date: Sun, 12 Sep 2004 20:02:42 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: usb: device not accepting address
Message-ID: <20040912180242.GA15109@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-1-k7 i686
X-Mailer: Mutt 1.5.6+20040818i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a USB device in this 2.6.8.1 machine of mine, and it's acting
up:

  usb 4-6: new high speed USB device using address 47
  usb 4-6: control timeout on ep0in
  usb 4-6: device not accepting address 47, error -71

I don't know what the problem is because I did get that device to
work before. However, now it does not work anymore. Would you agree
with me that the device firmware is probably messed up? Or what else
could be the cause?

What's worse is that my entire USB subsystem seems to hang. So
I tried to restart hotplug (which usually helps) but that resulted
in khubd crashing upon removal of uhci-hcd:

  root      6215  0.0  0.0  1520  408 pts/4    DN+  11:54   0:00 rmmod uhci=
-hcd

This is what dmesg says:

  Unable to handle kernel NULL pointer dereference at virtual address 00000=
008
  printing eip:
  f8b3a394
  *pde =3D 00000000
  Oops: 0000 [#1]
  PREEMPT=20
  Modules linked in: visor usbserial bnep rfcomm l2cap sd_mod ide_cd cdrom =
ipv6 lp thermal fan button processor ac battery af_packet ipt_LOG ipt_limit=
 ipt_REJECT ipt_state iptable_filter ipt_MASQUERADE iptable_nat ip_conntrac=
k ip_tables hci_usb bluetooth 8139cp bt878 eth1394 sata_promise libata scsi=
_mod ohci1394 ieee1394 pci_hotplug via_agp agpgart pcspkr parport_pc parpor=
t tuner tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc i=
2c_core videodev 8139too mii crc32 tg3 firmware_class snd_bt87x via_ircc ir=
da crc_ccitt uhci_hcd usbcore snd_via82xx snd_ac97_codec snd_pcm_oss snd_mi=
xer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmi=
di snd_seq_device snd soundcore dm_mod tsdev mousedev evdev capability comm=
oncap psmouse rtc xfs reiserfs vfat fat isofs ext2 ext3 jbd mbcache ide_gen=
eric via82cxxx ide_disk ide_core unix font vesafb cfbcopyarea cfbimgblt cfb=
fillrect
  CPU:    0
  EIP:    0060:[<f8b3a394>]    Not tainted
  EFLAGS: 00010002   (2.6.8-1-k7)=20
  EIP is at hcd_endpoint_disable+0x74/0x1e0 [usbcore]
  eax: 00000000   ebx: 00000080   ecx: f783e000   edx: f7b53400
  esi: ffffffed   edi: 00000000   ebp: 00000008   esp: f783fee0
  ds: 007b   es: 007b   ss: 0068
  Process khubd (pid: 1016, threadinfo=3Df783e000 task=3Df7af5770)
  Stack: 00000400 f8b451c0 f783ff00 ffffffed f4c97000 f4c97400 00000000 000=
00080=20
        ffffffed 00000101 f4c97000 f8b3bd74 f7b53400 00000080 f7b53400 f8b3=
80bc=20
        f7b53400 00000080 00000001 f8b35fd8 f783e000 00000001 f7dc8ba0 f7dc=
8bb0=20
  Call Trace:
  [<f8b3bd74>] usb_disable_endpoint+0x74/0x80 [usbcore]
  [<f8b380bc>] hub_port_connect_change+0x1bc/0x400 [usbcore]
  [<f8b35fd8>] clear_port_feature+0x58/0x60 [usbcore]
  [<f8b38575>] hub_events+0x275/0x3c0 [usbcore]
  [<f8b386f5>] hub_thread+0x35/0x110 [usbcore]
  [<c0119d30>] autoremove_wake_function+0x0/0x60
  [<c0105fde>] ret_from_fork+0x6/0x14
  [<c0119d30>] autoremove_wake_function+0x0/0x60
  [<f8b386c0>] hub_thread+0x0/0x110 [usbcore]
  [<c0104291>] kernel_thread_helper+0x5/0x14
  Code: 8b 50 08 8d 5a f4 8b 43 0c 0f 18 00 90 39 ea 74 2d 89 4c 24=20
  <6>note: khubd[1016] exited with preempt_count 1

Thanks for any hints,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"sobald man =FCber niveau spricht
 ist man l=E4ngst dar=FCber hinweg."
                                                      -- thomas krafft

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRI9CIgvIgzMMSnURAplaAKCxv0oZEajsUbJKkzcxq9iOn3mbhQCg5/Jg
66e1zEuclJwmU68AHluku/I=
=bXE1
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
