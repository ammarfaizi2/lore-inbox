Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTEMKqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 06:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbTEMKqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 06:46:02 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:49367 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S263464AbTEMKqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 06:46:00 -0400
Subject: kernel BUG at inode.c:562!
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rPgPanQeLHLmpO+2o/tO"
Organization: Trudheim Technology Limited
Message-Id: <1052823517.5022.3.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 13 May 2003 11:58:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rPgPanQeLHLmpO+2o/tO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Running kernel 2.4.21-rc2 and using reiserfs (built as module) on an IBM
X31 laptop. I have hit a kernel bug (as per subject line).

Decoded Oops follows:

ksymoops 2.4.8 on i686 2.4.21-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc2/ (default)
     -m /boot/System.map-2.4.21-rc2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at inode.c:562!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01554da>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210202
eax: c37f5220   ebx: c37f5200   ecx: 00000001   edx: c37f5220
esi: 00000000   edi: c37f5268   ebp: c37f5200   esp: cbd5df04
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 16212, stackpage=3Dcbd5d000)
Stack: c37f5200 cbd5df1c f0824b37 c37f5200 00000000 00000024 f08495c3
00000000=20
       00000024 00001494 ef333c00 c37f52ac c012ff67 00000000 c37f5200
f0824a60=20
       f08499a0 e81b30c0 c0155fdd c37f5200 00000000 00000000 00000000
e905c200=20
Call Trace:    [<f0824b37>] [<f08495c3>] [<c012ff67>] [<f0824a60>]
[<f08499a0>]
  [<c0155fdd>] [<c014c565>] [<c014c67a>] [<c010920f>]
Code: 0f 0b 32 02 a0 7d 26 c0 8b 83 f8 00 00 00 a8 10 75 08 0f 0b=20


>>EIP; c01554da <clear_inode+1a/f0>   <=3D=3D=3D=3D=3D

>>eax; c37f5220 <_end+34d0a7c/304e88bc>
>>ebx; c37f5200 <_end+34d0a5c/304e88bc>
>>edx; c37f5220 <_end+34d0a7c/304e88bc>
>>edi; c37f5268 <_end+34d0ac4/304e88bc>
>>ebp; c37f5200 <_end+34d0a5c/304e88bc>
>>esp; cbd5df04 <_end+ba39760/304e88bc>

Trace; f0824b37 <[reiserfs]reiserfs_delete_inode+d7/100>
Trace; f08495c3 <[reiserfs].rodata.end+56e8/58e5>
Trace; c012ff67 <truncate_inode_pages+67/80>
Trace; f0824a60 <[reiserfs]reiserfs_delete_inode+0/100>
Trace; f08499a0 <[reiserfs]reiserfs_sops+0/50>
Trace; c0155fdd <iput+1bd/280>
Trace; c014c565 <vfs_unlink+185/1e0>
Trace; c014c67a <sys_unlink+ba/130>
Trace; c010920f <system_call+33/38>

Code;  c01554da <clear_inode+1a/f0>
00000000 <_EIP>:
Code;  c01554da <clear_inode+1a/f0>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01554dc <clear_inode+1c/f0>
   2:   32 02                     xor    (%edx),%al
Code;  c01554de <clear_inode+1e/f0>
   4:   a0 7d 26 c0 8b            mov    0x8bc0267d,%al
Code;  c01554e3 <clear_inode+23/f0>
   9:   83 f8 00                  cmp    $0x0,%eax
Code;  c01554e6 <clear_inode+26/f0>
   c:   00 00                     add    %al,(%eax)
Code;  c01554e8 <clear_inode+28/f0>
   e:   a8 10                     test   $0x10,%al
Code;  c01554ea <clear_inode+2a/f0>
  10:   75 08                     jne    1a <_EIP+0x1a>
Code;  c01554ec <clear_inode+2c/f0>
  12:   0f 0b                     ud2a  =20


1 warning issued.  Results may not be reliable.


--=-rPgPanQeLHLmpO+2o/tO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+wM/dLYywqksgYBoRAiKfAKCyaOJQxVZ6aoClWCeHaFd4rpqSCQCeMwor
T2W/ITxhEuJbulCAP0PUWI8=
=quMy
-----END PGP SIGNATURE-----

--=-rPgPanQeLHLmpO+2o/tO--

