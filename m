Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUJJL7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUJJL7b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 07:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJJL7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 07:59:31 -0400
Received: from kyle.spoiled.org ([217.172.183.188]:36242 "EHLO
	kyle.spoiled.org") by vger.kernel.org with ESMTP id S268265AbUJJL7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 07:59:06 -0400
Subject: kernel BUG at include/asm/spinlock.h:136!
From: Philipp Stucke <ps@roqe.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JGUdVhJuipNV/NM2/iHw"
Date: Sun, 10 Oct 2004 13:58:50 +0200
Message-Id: <1097409530.14456.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JGUdVhJuipNV/NM2/iHw
Content-Type: multipart/mixed; boundary="=-0lJBRc3uzIGIFcuBUtB8"


--=-0lJBRc3uzIGIFcuBUtB8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

problem occures when a program (dvbscan) speaks to a usb device (TwinHan
DVB-T Visionplus). Kernel is 2.6.9-rc3-mm3; but it also happened with
earlier kernels (2.6.8, 2.6.8.1, 2.6.9-rc*-mm*). Other USB devices
(chipcard reader) work flawlessly.=20

The problem seems to be related to SMP, since if I boot a UP kernel, the
device works as expected.

I've attached .config and dmesg. Please CC me since I'm not subscribed.
I'll provide further information on request.

With kind regards,
Phil

Output of ksymoops:

ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
testing NMI watchdog ... OK.
Machine check exception polling timer started.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:08.0: 3Com PCI 3c905C Tornado at 0x9800. Vers LK1.1.19
eip: c02b83e1
kernel BUG at include/asm/spinlock.h:136!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c012f2f5>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092   (2.6.9-rc3-mm3)
eax: 0000000e   ebx: dea6401c   ecx: c02f5494   edx: 00000096
esi: 00000246   edi: 00000000   ebp: db705e1c   esp: db705e04
ds: 007b   es: 007b   ss: 0068
Stack: c02c5fd3 c02b83e1 00000163 00000246 dea6401c 00000000 db705e28
c02b83e1
       dea64000 db705e3c e09c92a4 e09e8000 e09e8000 dea64000 db705e58
e09c9491
       dea6463c db705e50 00000000 e09e8000 dea6463c db705e70 e09d7174
dea64458
Call Trace:
 [<c0104e1a>]
 [<c0104f95>]
 [<c01051a0>]
 [<c0105654>]
 [<c0104a3d>]
 [<c02b83e1>]
 [<e09c92a4>]
 [<e09c9491>]
 [<e09d7174>]
 [<e09d4bb4>]
 [<e09d5425>]
 [<e09d383a>]
 [<e09d551a>]
 [<c0164535>]
 [<c0103f81>]
Code: f8 8b 7d fc c9 c3 8b 55 f0 31 c9 89 d8 e8 34 fd ff ff 66 89 43 02
eb e3 8b 45 04 c7 04 24 d3 5f 2c c0 89 44 24 04 e8 1b a9 fe ff <0f> 0b
88 00 3c 58 2c c0 e9 57 ff ff ff 8b 45 04 c7 04 24 d3 5f


>>EIP; c012f2f5 <_metered_spin_lock_flags+c5/100>   <=3D=3D=3D=3D=3D

>>ebx; dea6401c <pg0+1e6c301c/3fc5d400>
>>ecx; c02f5494 <log_wait+8/10>
>>ebp; db705e1c <pg0+1b364e1c/3fc5d400>
>>esp; db705e04 <pg0+1b364e04/3fc5d400>

Trace; c0104e1a <show_stack+7a/90>
Trace; c0104f95 <show_registers+145/1c0>
Trace; c01051a0 <die+f0/180>
Trace; c0105654 <do_invalid_op+d4/f0>
Trace; c0104a3d <error_code+2d/38>
Trace; c02b83e1 <_spin_lock_irqsave+11/20>
Trace; e09c92a4 <pg0+206282a4/3fc5d400>
Trace; e09c9491 <pg0+20628491/3fc5d400>
Trace; e09d7174 <pg0+20636174/3fc5d400>
Trace; e09d4bb4 <pg0+20633bb4/3fc5d400>
Trace; e09d5425 <pg0+20634425/3fc5d400>
Trace; e09d383a <pg0+2063283a/3fc5d400>
Trace; e09d551a <pg0+2063451a/3fc5d400>
Trace; c0164535 <sys_ioctl+1d5/230>
Trace; c0103f81 <sysenter_past_esp+52/71>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c012f2ca <_metered_spin_lock_flags+9a/100>
00000000 <_EIP>:
Code;  c012f2ca <_metered_spin_lock_flags+9a/100>
   0:   f8                        clc
Code;  c012f2cb <_metered_spin_lock_flags+9b/100>
   1:   8b 7d fc                  mov    0xfffffffc(%ebp),%edi
Code;  c012f2ce <_metered_spin_lock_flags+9e/100>
   4:   c9                        leave
Code;  c012f2cf <_metered_spin_lock_flags+9f/100>
   5:   c3                        ret
Code;  c012f2d0 <_metered_spin_lock_flags+a0/100>
   6:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
Code;  c012f2d3 <_metered_spin_lock_flags+a3/100>
   9:   31 c9                     xor    %ecx,%ecx
Code;  c012f2d5 <_metered_spin_lock_flags+a5/100>
   b:   89 d8                     mov    %ebx,%eax
Code;  c012f2d7 <_metered_spin_lock_flags+a7/100>
   d:   e8 34 fd ff ff            call   fffffd46 <_EIP+0xfffffd46>
Code;  c012f2dc <_metered_spin_lock_flags+ac/100>
  12:   66 89 43 02               mov    %ax,0x2(%ebx)
Code;  c012f2e0 <_metered_spin_lock_flags+b0/100>
  16:   eb e3                     jmp    fffffffb <_EIP+0xfffffffb>
Code;  c012f2e2 <_metered_spin_lock_flags+b2/100>
  18:   8b 45 04                  mov    0x4(%ebp),%eax
Code;  c012f2e5 <_metered_spin_lock_flags+b5/100>
  1b:   c7 04 24 d3 5f 2c c0      movl   $0xc02c5fd3,(%esp)
Code;  c012f2ec <_metered_spin_lock_flags+bc/100>
  22:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  c012f2f0 <_metered_spin_lock_flags+c0/100>
  26:   e8 1b a9 fe ff            call   fffea946 <_EIP+0xfffea946>

This decode from eip onwards should be reliable

Code;  c012f2f5 <_metered_spin_lock_flags+c5/100>
00000000 <_EIP>:
Code;  c012f2f5 <_metered_spin_lock_flags+c5/100>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c012f2f7 <_metered_spin_lock_flags+c7/100>
   2:   88 00                     mov    %al,(%eax)
Code;  c012f2f9 <_metered_spin_lock_flags+c9/100>
   4:   3c 58                     cmp    $0x58,%al
Code;  c012f2fb <_metered_spin_lock_flags+cb/100>
   6:   2c c0                     sub    $0xc0,%al
Code;  c012f2fd <_metered_spin_lock_flags+cd/100>
   8:   e9 57 ff ff ff            jmp    ffffff64 <_EIP+0xffffff64>
Code;  c012f302 <_metered_spin_lock_flags+d2/100>
   d:   8b 45 04                  mov    0x4(%ebp),%eax
Code;  c012f305 <_metered_spin_lock_flags+d5/100>
  10:   c7                        .byte 0xc7
Code;  c012f306 <_metered_spin_lock_flags+d6/100>
  11:   04 24                     add    $0x24,%al
Code;  c012f308 <_metered_spin_lock_flags+d8/100>
  13:   d3                        .byte 0xd3
Code;  c012f309 <_metered_spin_lock_flags+d9/100>
  14:   5f                        pop    %edi


--=-0lJBRc3uzIGIFcuBUtB8
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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


--=-0lJBRc3uzIGIFcuBUtB8
Content-Disposition: attachment; filename=dmesg.gz
Content-Type: application/x-gzip; name=dmesg.gz
Content-Transfer-Encoding: base64

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


--=-0lJBRc3uzIGIFcuBUtB8
Content-Disposition: attachment; filename=output_ver_linux.gz
Content-Type: application/x-gzip; name=output_ver_linux.gz
Content-Transfer-Encoding: base64

H4sICEYiaUEAA291dHB1dF92ZXJfbGludXgAbVTdT9swEH/PX3HSXkBTgpO0hfKGyoSmUYZU9hw5
9tF49Uew40D/+108Clo7v/jufvf5yznfnyE4g/CsUMsA3COg6Yc9OA/auR1EG0PkGvYuguF76PiI
wC04LWFEH5SzRbZypp9CBwdDhyCi92gHMMoqQ7EeX6LyaMgWQFm4dSJOCh8o+mLVcbvFUGSQ3Ssb
36BjpvZQFYtimXtR58bU8KWGzfoRNtHCTzFAyaCsr6vqmi1h9W3zBBVjM1CLqwXcrG/hZui0s2dP
63OgoGrG2Fe4idSaHZSYHO4efl2kYlT0zkZYwcmpi1lRJdDwHZ6AVyxrKcGgdDjCqqKcF8uqYBQ+
4blOUx25VG1mXCSSTs4BlFFjTgwO+eDcoUpdsAyr59B7tz0qXBb1PPOoAvoTnFrAd2x2HFpOnea9
x/Kd/xXcq9Zzv//siMjIbveWGyWmXDv0cKalPP8AH70T/TETU7sEZw/4zwyfhRcs+9HKUwomrKyy
TZf/j+A5JS2zdSIowL3jEj9z2FFJxUGqtmaMmRbEvkX/mwta5dDS/IoWUo5tQx5kSKJwtLuCVq2i
d+DNK61yIzQPAbATqumEhHgQVCUabuTlfJHEFEp6s7ts+LYHHCWOEKxshFG9UEl0va4brdqkdK8S
+ySZPs5Y2UTuh6R7/mqo+SQHfGkcNXCQJ6DBcXpV76YPiAoqgUnthfmIIjndgzL0tZKFb7HhWjvx
t7x6Q39wp79AtDJNQ6ykuxbz5Vv2BwsvFY8hBAAA


--=-0lJBRc3uzIGIFcuBUtB8--

--=-JGUdVhJuipNV/NM2/iHw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBaSP6E8DvpiOlZMERAoOrAJ9s4KIeraHkitXS3I7W9bAmAyDCxACeNq6x
2oOCcpZbYq4lSOXjGs2I/Fg=
=wZVH
-----END PGP SIGNATURE-----

--=-JGUdVhJuipNV/NM2/iHw--

