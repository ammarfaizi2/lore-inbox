Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUGTACS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUGTACS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUGTACS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 20:02:18 -0400
Received: from smtp06.auna.com ([62.81.186.16]:7921 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264923AbUGTACM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 20:02:12 -0400
Date: Tue, 20 Jul 2004 02:02:10 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1-mm1
Message-ID: <20040720000210.GA4680@werewolf.able.es>
References: <20040713182559.7534e46d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org> (from akpm@osdl.org on Wed, Jul 14, 2004 at 03:25:59 +0200)
X-Mailer: Balsa 2.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.07.14, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2=
.6.8-rc1-mm1/
>=20

It oopses if you try to write on a CDRW without media loaded. Who would do
such a stupid thing ? Me the impatient trying to write before the drive ends
to load the disc...

The bad thing is that it leaves the drive in an ususable state:

Error trying to open /dev/hdc exclusively (Device or resource busy)... retr=
ying in 1 second.
Error trying to open /dev/hdc exclusively (Device or resource busy)... retr=
ying in 1 second.

It does not happen with 2.6.8-rc2. I am not using a pure rc1-mm1, but appli=
ed
all the patches neded to build with gcc-3.4.1:

- fix for usb-locking
- sg.c changes to use standard jiffies
- inline corrections from Adrian Bunk for e1000, smp, sunrpc, eth1394.

Yup, nvidia loaded, but does it really matter ?

Opps follows:

Jul 20 01:52:35 werewolf kernel: ------------[ cut here ]------------
Jul 20 01:52:35 werewolf kernel: kernel BUG at mm/page_alloc.c:796!
Jul 20 01:52:35 werewolf kernel: invalid operand: 0000 [#1]
Jul 20 01:52:35 werewolf kernel: PREEMPT SMP=20
Jul 20 01:52:35 werewolf kernel: Modules linked in: microcode snd_pcm_oss s=
nd_mixer_oss tuner msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx
_risc videodev nvidia snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_pag=
e_alloc snd_mpu401_uart snd_rawmidi snd soundcore w83627hf i2c_sensor i
2c_isa i2c_i801 i2c_core ipt_MASQUERADE iptable_nat ipt_state ip_conntrack =
iptable_filter ip_tables e1000 ide_floppy ide_cd 3c59x intel_agp agpgar
t joydev evdev usb_storage usblp usbhid uhci_hcd ehci_hcd usbcore
Jul 20 01:52:35 werewolf kernel: CPU:    0
Jul 20 01:52:35 werewolf kernel: EIP:    0060:[__free_pages+48/58]    Taint=
ed: P   VLI
Jul 20 01:52:35 werewolf kernel: EIP:    0060:[<c013c916>]    Tainted: P   =
VLI
Jul 20 01:52:35 werewolf kernel: EFLAGS: 00210246   (2.6.8-rc1-mm1)=20
Jul 20 01:52:35 werewolf kernel: EIP is at __free_pages+0x30/0x3a
Jul 20 01:52:35 werewolf kernel: eax: ffffffff   ebx: f7667f60   ecx: c15f6=
c40   edx: 00000000
Jul 20 01:52:35 werewolf kernel: esi: f1dff740   edi: f7448a40   ebp: 00000=
001   esp: f2351d6c
Jul 20 01:52:35 werewolf kernel: ds: 007b   es: 007b   ss: 0068
Jul 20 01:52:35 werewolf kernel: Process cdrecord (pid: 4889, threadinfo=3D=
f2351000 task=3Df23d7970)
Jul 20 01:52:35 werewolf kernel: Stack: c015c930 fffffff2 f740b9cc 00000000=
 f2351e1c f740b9cc c0228603 f2351ea8=20
Jul 20 01:52:35 werewolf kernel:        00029b05 c022bd3c 00000040 00000001=
 00000000 f7448a40 f7e4bd80 f7dcf94c=20
Jul 20 01:52:35 werewolf kernel:        0005005a 00000000 c0130040 0002eb5f=
 00000000 00000000 00000000 00000000=20
Jul 20 01:52:35 werewolf kernel: Call Trace:
Jul 20 01:52:35 werewolf kernel:  [bio_uncopy_user+94/125] bio_uncopy_user+=
0x5e/0x7d
Jul 20 01:52:35 werewolf kernel:  [<c015c930>] bio_uncopy_user+0x5e/0x7d
Jul 20 01:52:35 werewolf kernel:  [blk_rq_unmap_user+31/80] blk_rq_unmap_us=
er+0x1f/0x50
Jul 20 01:52:35 werewolf kernel:  [<c0228603>] blk_rq_unmap_user+0x1f/0x50
Jul 20 01:52:35 werewolf kernel:  [sg_io+550/633] sg_io+0x226/0x279
Jul 20 01:52:35 werewolf kernel:  [<c022bd3c>] sg_io+0x226/0x279
Jul 20 01:52:35 werewolf kernel:  [sys_timer_settime+602/637] sys_timer_set=
time+0x25a/0x27d
Jul 20 01:52:35 werewolf kernel:  [<c0130040>] sys_timer_settime+0x25a/0x27d
Jul 20 01:52:35 werewolf kernel:  [scsi_cmd_ioctl+737/993] scsi_cmd_ioctl+0=
x2e1/0x3e1
Jul 20 01:52:35 werewolf kernel:  [<c022c2f8>] scsi_cmd_ioctl+0x2e1/0x3e1
Jul 20 01:52:35 werewolf kernel:  [pty_write+297/321] pty_write+0x129/0x141
Jul 20 01:52:35 werewolf kernel:  [<c020d483>] pty_write+0x129/0x141
Jul 20 01:52:35 werewolf kernel:  [opost_block+264/358] opost_block+0x108/0=
x166
Jul 20 01:52:35 werewolf kernel:  [<c0209f01>] opost_block+0x108/0x166
Jul 20 01:52:35 werewolf kernel:  [pty_write+297/321] pty_write+0x129/0x141
Jul 20 01:52:35 werewolf kernel:  [<c020d483>] pty_write+0x129/0x141
Jul 20 01:52:35 werewolf kernel:  [tty_default_put_char+30/35] tty_default_=
put_char+0x1e/0x23
Jul 20 01:52:35 werewolf kernel:  [<c0209498>] tty_default_put_char+0x1e/0x=
23
Jul 20 01:52:35 werewolf kernel:  [cdrom_ioctl+51/3282] cdrom_ioctl+0x33/0x=
cd2
Jul 20 01:52:35 werewolf kernel:  [<c027c9b2>] cdrom_ioctl+0x33/0xcd2
Jul 20 01:52:35 werewolf kernel:  [default_wake_function+0/12] default_wake=
_function+0x0/0xc
Jul 20 01:52:35 werewolf kernel:  [<c0119b07>] default_wake_function+0x0/0xc
Jul 20 01:52:35 werewolf kernel:  [tty_write+743/819] tty_write+0x2e7/0x333
Jul 20 01:52:35 werewolf kernel:  [<c020683f>] tty_write+0x2e7/0x333
Jul 20 01:52:35 werewolf kernel:  [free_pages_and_swap_cache+85/121] free_p=
ages_and_swap_cache+0x55/0x79
Jul 20 01:52:35 werewolf kernel:  [<c0152a25>] free_pages_and_swap_cache+0x=
55/0x79
Jul 20 01:52:35 werewolf kernel:  [pg0+944604295/1069400064] idecd_ioctl+0x=
5d/0x71 [ide_cd]
Jul 20 01:52:35 werewolf kernel:  [<f88fa487>] idecd_ioctl+0x5d/0x71 [ide_c=
d]
Jul 20 01:52:35 werewolf kernel:  [blkdev_ioctl+131/1018] blkdev_ioctl+0x83=
/0x3fa
Jul 20 01:52:35 werewolf kernel:  [<c022a5a3>] blkdev_ioctl+0x83/0x3fa
Jul 20 01:52:35 werewolf kernel:  [sys_ioctl+425/673] sys_ioctl+0x1a9/0x2a1
Jul 20 01:52:35 werewolf kernel:  [<c016a084>] sys_ioctl+0x1a9/0x2a1
Jul 20 01:52:35 werewolf kernel:  [sys_gettimeofday+44/101] sys_gettimeofda=
y+0x2c/0x65
Jul 20 01:52:35 werewolf kernel:  [<c01215a9>] sys_gettimeofday+0x2c/0x65
Jul 20 01:52:35 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_=
esp+0x52/0x71
Jul 20 01:52:35 werewolf kernel:  [<c0104005>] sysenter_past_esp+0x52/0x71
Jul 20 01:52:35 werewolf kernel: Code: c4 08 75 1f 8b 41 04 83 f8 ff 74 1f =
f0 83 41 04 ff 0f 98 c0 84 c0 74 0b 85 d2 75 08 89 c8 e9 40 fa ff ff c3
 89 c8 e9 61 f4 ff ff <0f> 0b 1c 03 6c 55 31 c0 eb d7 85 c0 74 1e 05 00 00 =
00 40 c1 e8=20

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Alpha 1) for i586
Linux 2.6.8-rc1-jam1 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-1mdk)) #1

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA/GECRlIHNEGnKMMRAh8FAKCG5xCUMsa7eG9suJpUW9NCTchaFwCfSVcM
IZlJw3EmDL1A5cQQzmSeI5I=
=GKty
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
