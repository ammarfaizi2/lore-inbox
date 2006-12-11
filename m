Return-Path: <linux-kernel-owner+w=401wt.eu-S1760489AbWLKLPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760489AbWLKLPw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 06:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762814AbWLKLPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 06:15:51 -0500
Received: from lug-owl.de ([195.71.106.12]:59381 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760489AbWLKLPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 06:15:51 -0500
Date: Mon, 11 Dec 2006 12:15:49 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Tom Kerremans <harakiri@trinityhome.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Segmentation fault on modprobe depca
Message-ID: <20061211111548.GW14042@lug-owl.de>
Mail-Followup-To: Tom Kerremans <harakiri@trinityhome.org>,
	linux-kernel@vger.kernel.org
References: <55427.212.166.5.178.1165835168.squirrel@trinityhome.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kD0q5DIPXzY/lIlp"
Content-Disposition: inline
In-Reply-To: <55427.212.166.5.178.1165835168.squirrel@trinityhome.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kD0q5DIPXzY/lIlp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-12-11 12:06:08 +0100, Tom Kerremans <harakiri@trinityhome.org>=
 wrote:
> I 'm the maintainter of Trinity Rescue Kit (http://trinityhome.org/trk) ,
> a live rescue distribution that tries (amongst many other features) to be
> as generic as possible in terms of hardware detection. Therefore I include
> all network and disk controller drivers in the kernel or as module.
> I recently tried kernel 2.6.19 and stumbled upon the fact that the module
> DEPCA seems to be broken. When I compile it in the kernel, the kernel
> crashes at boot time. Compiled as module it creates a segmentation fault
> on modprobe.
> I 've tested compilation on two different systems: first is my TRK
> workbench, which is a Mandriva 2005 with gcc 3.4.3-7mdk and
> module-init-tools 3.0 (later upgraded to 3.2.2, recompiled kernel, but
> same result). The other system I compiled and tried it on is an
> out-of-the-box Mandriva 2007, which  is quite new and has more recent
> compilers and libraries. The result was the same.
> When I do a "modprobe depca", even though there is no hardware that could
> use this module (it 's for old DEC nics..), I get the following output:
>=20
> [root@vmlinux ~]# modprobe depca
> Segmentation fault
> [root@vmlinux ~]#

Please use `dmesg' the next time to generate output and don't
cut'n'paste it if this adds extra \n into the output. Just reworked
your stuff to get it remotely readable:

Kernel BUG at [verbose debug info unavailable]
invalid opcode: 0000 [#1]
CPU:    0
EIP:    0060:[<c014b738>]    Not tainted VLI
EFLAGS: 00010006   (2.6.19 #2)
EIP is at kfree+0x32/0x59
eax: ef632674   ebx: f64f7800   ecx: f64f7870   edx: c1800000
esi: 00000206   edi: 00000300   ebp: ea4a5e1c   esp: ea4a5e10
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 26866, ti=3Dea4a4000 task=3Dc1a74a70 task.ti=3Dea4a4=
000)
Stack: f64f7800 f64f7870 c0552580 ea4a5e2c c0279ecc 00000300 c05525dc ea4a5=
e44
       c0275ccf f64f7808 ea4a5e44 c0275de3 f64f7870 ea4a5e60 c020d3a2 f64f7=
870
       c05528c8 f64f7888 c020d3c9 00000000 ea4a5e6c c020d3dd f64f7870 ea4a5=
e8c
Call Trace:
 [<c010317a>] show_trace_log_lvl+0x26/0x3c
 [<c010322b>] show_stack_log_lvl+0x9b/0xa3
 [<c01035f6>] show_registers+0x18f/0x229
 [<c01037ba>] die+0x12a/0x1ef
 [<c01038ff>] do_trap+0x80/0x88
 [<c01040fa>] do_invalid_op+0xa0/0xaa
 [<c047f329>] error_code+0x39/0x40
 [<c0279ecc>] platform_device_release+0x1b/0x35
 [<c0275ccf>] device_release+0x2f/0x71
 [<c020d3a2>] kobject_cleanup+0x49/0x70
 [<c020d3dd>] kobject_release+0x14/0x16
 [<c020df30>] kref_put+0x6a/0x78
 [<c020d357>] kobject_put+0x20/0x22
 [<c0275de3>] put_device+0x18/0x1a
 [<c0279efe>] platform_device_put+0x18/0x1a
 [<f8ac98a0>] depca_module_init+0x79/0xc4 [depca]
 [<c012be5a>] sys_init_module+0x1332/0x14b9
 [<c0102c9d>] sysenter_past_esp+0x56/0x79
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 56 53 85 ff 74 47 9c 5e fa 8d 97 00 00 00 40 c1 ea 0c c1 e2 05 03 15 =
a0 26 68 c0 8b 02 f6 c4 40 74 03 8b 52 0c 8b 02 84 c0 78 02 <0f> 0b 8b 4a 1=
8 8b 19 8b 03 3b 43 04 72 0b 89 c8 89 da e8 25 ff
EIP: [<c014b738>] kfree+0x32/0x59 SS:ESP 0068:ea4a5e10

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:  The real problem with C++ for kernel modules is: the languag=
e just sucks.
the second  :                                            -- Linus Torvalds

--kD0q5DIPXzY/lIlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFfT3kHb1edYOZ4bsRAkSAAJ4tiXjm8lz0PeEjfXrE7lGVIYQajQCdHkDj
7YXdzclgkxCswuByzi59qIc=
=FGmh
-----END PGP SIGNATURE-----

--kD0q5DIPXzY/lIlp--
