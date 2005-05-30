Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVE3Ts4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVE3Ts4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVE3TrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:47:18 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:33430 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261725AbVE3Tor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:44:47 -0400
Date: Mon, 30 May 2005 21:44:44 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050530194443.GA22760@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ohWw6IXhY39HKnGA"
Content-Disposition: inline
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.9 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi! I've been working on some usb chipcard reader
	drivers in which I use the asynchronous usb devio URB delivery to
	usrerspace. There have always been some bug reports of kernel oopses
	while terminating a program that uses the driver. [...] 
	Content analysis details:   (0.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	0.1 TW_XD                  BODY: Odd Letter Triples with XD
	0.1 TW_XC                  BODY: Odd Letter Triples with XC
	0.1 TW_KD                  BODY: Odd Letter Triples with KD
	0.1 TW_XS                  BODY: Odd Letter Triples with XS
	0.1 TW_SN                  BODY: Odd Letter Triples with SN
	0.1 TW_UH                  BODY: Odd Letter Triples with UH
	0.1 TW_XF                  BODY: Odd Letter Triples with XF
	0.1 TW_BL                  BODY: Odd Letter Triples with BL
	0.1 TW_NR                  BODY: Odd Letter Triples with NR
	0.1 TW_JB                  BODY: Odd Letter Triples with JB
	0.1 TW_EB                  BODY: Odd Letter Triples with EB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ohWw6IXhY39HKnGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've been working on some usb chipcard reader drivers in which I use the
asynchronous usb devio URB delivery to usrerspace.

There have always been some bug reports of kernel oopses while
terminating a program that uses the driver.

Now I found out a way to relatively easy trigger that oops from pcscd
(part of pcsc-lite) on any kernel, at least tested with 2.6.8 to
2.6.12-rc5:

Unable to handle kernel NULL pointer dereference at virtual address 00000508
 printing eip:                                                             =
=20
c02c8591     =20
*pde =3D 00000000
Oops: 0000 [#1]
SMP           =20
Modules linked in: ipv6 autofs4 i810_audio ac97_codec amd74xx snd_intel8x0 =
snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ext3 jbd mbca=
che lp thermal processor fan button ac battery evdev eth1394 ohci1394 ieee1=
394 ohci_hcd pl2303 usbserial usblp tg3 e1000 ehci_hcd uhci_hcd parport_ser=
ial parport_pc parport hw_random i2c_amd8111 tpm_nsc tpm_atmel tpm dm_mod w=
83627hf eeprom lm85 w83781d i2c_sensor i2c_isa i2c_amd756 i2c_core ide_cd i=
de_core genrtc sr_mod cdrom sd_mod sata_sil libata usb_storage aic7xxx scsi=
_transport_spi sg scsi_mod unix
CPU:    1                                                                  =
=20
EIP:    0060:[<c02c8591>]    Not tainted VLI
EFLAGS: 00010086   (2.6.12-rc5kdb1)        =20
EIP is at _spin_lock_irqsave+0x11/0x60
eax: 00000504   ebx: 00000286   ecx: f7def898   edx: f7def890
esi: 00000504   edi: f5cea060   ebp: c1861d84   esp: c1861d74
ds: 007b   es: 007b   ss: 0068                              =20
Process swapper (pid: 0, threadinfo=3Dc1860000 task=3Ddfa87540)
Stack: 00000000 c1861da0 00000021 f4664800 c1861da4 c0125fa9 f7def8b0 f7def=
8a8=20
       00000001 f7def890 f4664800 f7def880 c1861e44 c023cfd9 00000021 c1861=
db8=20
       f5cea060 00000021 ffffff94 fffffffc 080ef770 c1861e68 c023cf90 341fc=
000=20
Call Trace:                                                                =
   =20
 [<c0103dbf>] show_stack+0x7f/0xa0
 [<c0103f60>] show_registers+0x160/0x1c0
 [<c0104156>] die+0xf6/0x1a0           =20
 [<c0112cd6>] do_page_fault+0x356/0x68f
 [<c01039bf>] error_code+0x4f/0x54    =20
 [<c0125fa9>] send_sig_info+0x39/0x80
 [<c023cfd9>] async_completed+0xa9/0xb0
 [<c0237e31>] usb_hcd_giveback_urb+0x31/0x80
 [<f8a21e84>] finish_urb+0x74/0x100 [ohci_hcd]
 [<f8a22f88>] finish_unlinks+0x2b8/0x2e0 [ohci_hcd]
 [<f8a23d1d>] ohci_irq+0x17d/0x190 [ohci_hcd]     =20
 [<c0237eb8>] usb_hcd_irq+0x38/0x70         =20
 [<c0139ab3>] handle_IRQ_event+0x33/0x70
 [<c0139bcd>] __do_IRQ+0xdd/0x150      =20
 [<c010551c>] do_IRQ+0x1c/0x30  =20
 [<c010388a>] common_interrupt+0x1a/0x20
 [<c0100ca9>] cpu_idle+0x79/0x80       =20
 [<c03ed56a>] start_secondary+0x6a/0xa0
 [<00000000>] 0x0                     =20
 [<c1861fb4>] 0xc1861fb4
Code: ff c9 c3 0f 0b d7 00 81 63 2e c0 eb e9 8d b6 00 00 00 00 8d bc 27 00 =
00 00 00 55 89 e5 83 ec 10 89 75 fc 89 5d f8 89 c6 9c 5b fa <81> 78 04 ad 4=
e ad de 75 22 f0 fe 0e 79 13 f7 c3 00 02 00 00 74=20
                                       =20
Entering kdb (current=3D0xdfa87540, pid 0) on processor 1 Oops: Oops
due to oops @ 0xc02c8591                                         =20
eax =3D 0x00000504 ebx =3D 0x00000286 ecx =3D 0xf7def898 edx =3D 0xf7def890=
=20
esi =3D 0x00000504 edi =3D 0xf5cea060 esp =3D 0xc1861d74 eip =3D 0xc02c8591=
=20
ebp =3D 0xc1861d84 xss =3D 0x00000068 xcs =3D 0x00000060 eflags =3D 0x00010=
086=20
xds =3D 0x0000007b xes =3D 0x0000007b origeax =3D 0xffffffff &regs =3D 0xc1=
861d40

[1]kdb> bt                                                      =20

Stack traceback for pid 0
0xdfa87540        0        1  1    1   R  0xdfa87700 *swapper
EBP        EIP        Function (args)                       =20
0xc1861d84 0xc02c8591 _spin_lock_irqsave+0x11 (0xf7def8b0, 0xf7def8a8,
0x1, 0xf7def890, 0xf4664800)
0xc1861da4 0xc0125fa9 send_sig_info+0x39 (0x21, 0xc1861db8, 0xf5cea060,
0x21, 0xffffff94)
0xc1861e44 0xc023cfd9 async_completed+0xa9 (0xf6245c80, 0xc1861f60,
0xf79e4800, 0xf6245c80)
0xc1861e5c 0xc0237e31 usb_hcd_giveback_urb+0x31 (0xf79e4800, 0xf6245c80,
0xc1861f60, 0xf6245c80, 0xf6948160)
0xc1861e7c 0xf8a21e84 [ohci_hcd]finish_urb+0x74 (0xf79e4928, 0xf6245c80,
0xc1861f60, 0xc1ac8060, 0xf79e4800)
0xc1861ec4 0xf8a22f88 [ohci_hcd]finish_unlinks+0x2b8 (0xf79e4928,
0x9acb, 0xc1861f60, 0xf79e4800, 0x1)
0xc1861ee4 0xf8a23d1d [ohci_hcd]ohci_irq+0x17d (0xf79e4800, 0xc1861f60,
0xdf940b60, 0x0)
0xc1861efc 0xc0237eb8 usb_hcd_irq+0x38 (0xe1, 0xf79e4800, 0xc1861f60,
0x0, 0xe1)
0xc1861f24 0xc0139ab3 handle_IRQ_event+0x33 (0xe1, 0xc1861f38,
0xc011fcd8, 0xc03dcb1c, 0xdf940b60)
0xc1861f50 0xc0139bcd __do_IRQ+0xdd
0xc1861f58 0xc010551c do_IRQ+0x1c (0xc1860000, 0xc170f2e0, 0xc0100bc0,
0xffffe000, 0xc0410380)
0xc1861f94 0xc010388a common_interrupt+0x1a
           0xc0100ca9 cpu_idle+0x79       =20

So what do we learn from that?  That usb_hcd_giveback_urb() is called
=66rom in_interrupt() context and calls async_completed().=20

async_completed() calls send_sig_info(), which in turn does a
spin_lock(&tasklist_lock) to protect itself from task_struct->sighand
=66rom going away.  However, the call to
"spin_lock_irqsave(task_struct->sighand->siglock)" causes an oops.  So
either sighand or the task have disappeared.

I think there is currently no protection/locking/refcounting going on.

If a process issues an URB from userspace and starts to terminate before
the URB comes back, we run into the issue described above.  This is
because the urb saves a pointer to "current" when it is posted to the
device, but there's no guarantee that this pointer is still valid
afterwards. =20

I'm not familiar with the scheduler code to decide what fix
is the way to go.  Is it sufficient to do {get,put}_task_struct() from
the usb code?

Any comments welcome...

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--ohWw6IXhY39HKnGA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCm20rXaXGVTD0i/8RAotTAJ0aF8m/mR0U80Qo7DNSTBW1lu2hcQCfbk0m
9KVyY2KxW6qWUQoBjuWOBG0=
=f2en
-----END PGP SIGNATURE-----

--ohWw6IXhY39HKnGA--
