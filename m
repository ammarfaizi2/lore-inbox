Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270069AbTGMVTP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270403AbTGMVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:19:15 -0400
Received: from main.gmane.org ([80.91.224.249]:31973 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270069AbTGMVTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:19:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: 2.4.22-pre5: rmmod i810_audio caused an oops
Date: Sun, 13 Jul 2003 14:34:50 -0700
Message-ID: <m2smpayuth.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:DbwLuLZ3yqq+TdEDoN8G15YNgZ4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Typing 'rmmod i810_audio' proced this oops. Perhaps that's useful info.
I can't reproduce this at will -- this happened after unloading alsa,
loading i810_audio, then trying to unload it.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
d09dccdf
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d09dccdf>]    Tainted: P Z
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cfb295a0   ecx: d09df9b8   edx: 00000000
esi: cf6f85f8   edi: cf6f8400   ebp: 00000003   esp: c8e0ff5c
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 10044, stackpage=3Dc8e0f000)
Stack: 00000000 d09e54b9 cfb295a0 00000000 cfe2dc00 d09e7240 d09e1000 bfffe=
b08=20
       c01f7996 cfe2dc00 d09e1000 fffffff0 d09e58aa d09e7240 c01181f3 d09e1=
000=20
       fffffff0 cb610000 bfffeb08 c0117597 d09e1000 00000000 c8e0e000 00000=
001=20
Call Trace:    [<d09e54b9>] [<d09e7240>] [<c01f7996>] [<d09e58aa>] [<d09e72=
40>]
  [<c01181f3>] [<c0117597>] [<c01086df>]
Code: 89 50 04 89 02 c7 03 00 00 00 00 c7 43 04 00 00 00 00 ff 05=20


>>EIP; d09dccdf <[ac97_codec]ac97_release_codec+1b/58>   <=3D=3D=3D=3D=3D

>>ebx; cfb295a0 <_end+f820788/10501248>
>>ecx; d09df9b8 <[ac97_codec]codec_sem+0/13>
>>esi; cf6f85f8 <_end+f3ef7e0/10501248>
>>edi; cf6f8400 <_end+f3ef5e8/10501248>
>>esp; c8e0ff5c <_end+8b07144/10501248>

Trace; d09e54b9 <[ac97_codec].data.end+5aee/9695>
Trace; d09e7240 <[ac97_codec].data.end+7875/9695>
Trace; c01f7996 <pci_unregister_driver+3a/54>
Trace; d09e58aa <[ac97_codec].data.end+5edf/9695>
Trace; d09e7240 <[ac97_codec].data.end+7875/9695>
Trace; c01181f3 <free_module+17/98>
Trace; c0117597 <sys_delete_module+f3/1b0>
Trace; c01086df <system_call+33/38>

Code;  d09dccdf <[ac97_codec]ac97_release_codec+1b/58>
00000000 <_EIP>:
Code;  d09dccdf <[ac97_codec]ac97_release_codec+1b/58>   <=3D=3D=3D=3D=3D
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=3D=3D=3D=3D=3D
Code;  d09dcce2 <[ac97_codec]ac97_release_codec+1e/58>
   3:   89 02                     mov    %eax,(%edx)
Code;  d09dcce4 <[ac97_codec]ac97_release_codec+20/58>
   5:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  d09dccea <[ac97_codec]ac97_release_codec+26/58>
   b:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  d09dccf1 <[ac97_codec]ac97_release_codec+2d/58>
  12:   ff 05 00 00 00 00         incl   0x0

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EdB7Lth4/7/QhDoRAqLtAJ9IOspBPVcaadFkSdRQEczt1F9bnACfdFjB
e2gifcQMQnSt6CSbVweq0l0=
=c9dP
-----END PGP SIGNATURE-----
--=-=-=--

