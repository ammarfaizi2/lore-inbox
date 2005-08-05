Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVHET3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVHET3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVHET05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:26:57 -0400
Received: from neveragain.de ([217.69.76.1]:29126 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S263106AbVHET0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:26:34 -0400
Date: Fri, 5 Aug 2005 21:26:28 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: linux-kernel@vger.kernel.org
Subject: local DDOS? Kernel panic when accessing /proc/ioports
Message-ID: <20050805192628.GA24706@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (hobbit.neveragain.de [217.69.76.1]); Fri, 05 Aug 2005 21:26:29 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I just ran into the following problem: Having updated my box to 2.6.12.3,=
=20
I tried to start YaST2 and noticed a kernel panic (see below). Some quick
debugging brought the result that the kernel crashes while some user (not
even root ...) tries to access /proc/ioports. Is this a known problem and
if so, is a fix available?

Ooops and ksymoops-output is attached.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oops
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Unable to handle kernel paging request at virtual address e081e6a8
 printing eip:
c01d16b2
*pde =3D 1ff5b067
*pte =3D 00000000
Oops: 0000 [#1]
Modules linked in: snd_mixer_oss snd radeon drm dm_mod autofs4 af_packet ex=
t3 jbd i810_audio ac97_codec soundcore b44 mii intel_agp agpgart i2c_i801 i=
2c_core ipw2200 firmware_class ieee80211 ieee80211_crypt parport_pc parport=
 8250 serial_core usbhid ohci_hcd uhci_hcd pcmcia yenta_socket rsrc_nonstat=
ic pcmcia_core video thermal processor fan container button battery ac genr=
tc unionfs loop sbp2 ohci1394 ieee1394 usb_storage ub ehci_hcd usbcore
CPU:    0
EIP:    0060:[<c01d16b2>]    Not tainted VLI
EFLAGS: 00210297   (2.6.12.3)=20
EIP is at vsnprintf+0x332/0x4d0
eax: e081e6a8   ebx: 0000000a   ecx: e081e6a8   edx: fffffffe
esi: c71760e9   edi: 00000000   ebp: c7176fff   esp: c457deb4
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 3275, threadinfo=3Dc457c000 task=3Dc5052020)
Stack: c71760e2 c7176fff 00000323 00000000 00000010 00000004 00000002 00000=
001=20
       ffffffff ffffffff c4f7d640 c031f3ad c4f7d640 000000dd c01789c7 c7176=
0dd=20
       00000f23 c03265ef c457df2c c03265dd c011e934 c4f7d640 c03265dd 00000=
000=20
Call Trace:
 [<c01789c7>] seq_printf+0x37/0x60
 [<c011e934>] r_show+0x84/0x90
 [<c01784c6>] seq_read+0x1d6/0x2d0
 [<c0158b85>] vfs_read+0xe5/0x160
 [<c0158ea1>] sys_read+0x51/0x80
 [<c0102f79>] syscall_call+0x7/0xb
Code: 00 83 cf 01 89 44 24 24 eb bb 8b 44 24 48 8b 54 24 20 83 44 24 48 04 =
8b 08 b8 ec 2b 33 c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 0=
7 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 20=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ksymoops
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>>EIP; c01d16b2 <vsnprintf+332/4d0>   <=3D=3D=3D=3D=3D

>>eax; e081e6a8 <pg0+203236a8/3fb03400>
>>ecx; e081e6a8 <pg0+203236a8/3fb03400>
>>edx; fffffffe <__kernel_rt_sigreturn+1bbe/????>
>>esi; c71760e9 <pg0+6c7b0e9/3fb03400>
>>ebp; c7176fff <pg0+6c7bfff/3fb03400>
>>esp; c457deb4 <pg0+4082eb4/3fb03400>

Trace; c01789c7 <seq_printf+37/60>
Trace; c011e934 <r_show+84/90>
Trace; c01784c6 <seq_read+1d6/2d0>
Trace; c0158b85 <vfs_read+e5/160>
Trace; c0158ea1 <sys_read+51/80>
Trace; c0102f79 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01d1687 <vsnprintf+307/4d0>
00000000 <_EIP>:
Code;  c01d1687 <vsnprintf+307/4d0>
   0:   00 83 cf 01 89 44         add    %al,0x448901cf(%ebx)
Code;  c01d168d <vsnprintf+30d/4d0>
   6:   24 24                     and    $0x24,%al
Code;  c01d168f <vsnprintf+30f/4d0>
   8:   eb bb                     jmp    ffffffc5 <_EIP+0xffffffc5>
Code;  c01d1691 <vsnprintf+311/4d0>
   a:   8b 44 24 48               mov    0x48(%esp),%eax
Code;  c01d1695 <vsnprintf+315/4d0>
   e:   8b 54 24 20               mov    0x20(%esp),%edx
Code;  c01d1699 <vsnprintf+319/4d0>
  12:   83 44 24 48 04            addl   $0x4,0x48(%esp)
Code;  c01d169e <vsnprintf+31e/4d0>
  17:   8b 08                     mov    (%eax),%ecx
Code;  c01d16a0 <vsnprintf+320/4d0>
  19:   b8 ec 2b 33 c0            mov    $0xc0332bec,%eax
Code;  c01d16a5 <vsnprintf+325/4d0>
  1e:   81 f9 ff 0f 00 00         cmp    $0xfff,%ecx
Code;  c01d16ab <vsnprintf+32b/4d0>
  24:   0f 46 c8                  cmovbe %eax,%ecx
Code;  c01d16ae <vsnprintf+32e/4d0>
  27:   89 c8                     mov    %ecx,%eax
Code;  c01d16b0 <vsnprintf+330/4d0>
  29:   eb 06                     jmp    31 <_EIP+0x31>

This decode from eip onwards should be reliable

Code;  c01d16b2 <vsnprintf+332/4d0>
00000000 <_EIP>:
Code;  c01d16b2 <vsnprintf+332/4d0>   <=3D=3D=3D=3D=3D
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=3D=3D=3D=3D=3D
Code;  c01d16b5 <vsnprintf+335/4d0>
   3:   74 07                     je     c <_EIP+0xc>
Code;  c01d16b7 <vsnprintf+337/4d0>
   5:   40                        inc    %eax
Code;  c01d16b8 <vsnprintf+338/4d0>
   6:   4a                        dec    %edx
Code;  c01d16b9 <vsnprintf+339/4d0>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c01d16bc <vsnprintf+33c/4d0>
   a:   75 f4                     jne    0 <_EIP>
Code;  c01d16be <vsnprintf+33e/4d0>
   c:   29 c8                     sub    %ecx,%eax
Code;  c01d16c0 <vsnprintf+340/4d0>
   e:   83 e7 10                  and    $0x10,%edi
Code;  c01d16c3 <vsnprintf+343/4d0>
  11:   89 c3                     mov    %eax,%ebx
Code;  c01d16c5 <vsnprintf+345/4d0>
  13:   75 20                     jne    35 <_EIP+0x35>

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC871kHPo+jNcUXjARAu2ZAJ9qTUrR/UFrdoO8Pwz4i8lQ2GFFWACgqQUA
NZeuYM3t34b+CtPCC8P7wqQ=
=unCd
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
