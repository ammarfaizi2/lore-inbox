Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbTDBU2P>; Wed, 2 Apr 2003 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbTDBU2P>; Wed, 2 Apr 2003 15:28:15 -0500
Received: from dsl-213-023-013-209.arcor-ip.net ([213.23.13.209]:36480 "EHLO
	spot.lan") by vger.kernel.org with ESMTP id <S262658AbTDBU1q>;
	Wed, 2 Apr 2003 15:27:46 -0500
From: Oliver Feiler <kiza@gmx.net>
To: Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
Date: Wed, 2 Apr 2003 22:37:45 +0200
User-Agent: KMail/1.5
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <3E87477C.3050208@canada.com> <200304022101.40921.kiza@gmx.net> <3E8B36A2.8030801@canada.com>
In-Reply-To: <3E8B36A2.8030801@canada.com>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_io0i+Vp1ZXTbYzl";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304022237.54304.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_io0i+Vp1ZXTbYzl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Wednesday 02 April 2003 21:14, Nehal wrote:
> yes, that's the one! its in grow_buffers ... there are 3 BUG() 's in
> this function, but my guess he is getting the same BUG()
>
> hmm, he didnt specify his cd-rom drive... but could it be
> part of the problem?

It was me who posted this previous message. :)

I don't think it is drive dependent. But it may have something to do with S=
CSI=20
since it works for you with IDE and oopses with SCSI. I just reproduced the=
=20
oops with a
hdc: HL-DT-ST RW/DVD GCC-4120B, ATAPI CD/DVD-ROM drive
IDE drive running via ide-scsi. Same oops again, see below. Yes I know with=
=20
NVdriver, but the oops is the same with and without. Now the disc isn't=20
mounted, the drive door is locked and 'eject /dev/cdrom' gives

eject: CDROMEJECT ioctl failed for `/dev/scsi/host1/bus0/target0/lun0/cd':=
=20
Device or resource busy



kernel BUG at buffer.c:2497!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0136e5e>]    Tainted: P=20
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 000007ff   ebx: 0000000b   ecx: 00000800   edx: c15dd700
esi: 00000002   edi: 00000b02   ebp: 00000000   esp: ccf01dbc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 4975, stackpage=3Dccf01000)
Stack: 00000b02 00000200 00000000 00000001 00004480 c0134fb7 00000b02 00000=
000=20
       00000200 00000b02 d01cac00 00000000 c01351d8 00000b02 00000000 00000=
200=20
       00000000 e1cb45c3 00000b02 00000000 00000200 00000b02 00000001 00000=
000=20
Call Trace:    [<c0134fb7>] [<c01351d8>] [<e1cb45c3>] [<e1cb3839>]=20
[<e1cb4443>]
  [<c01ef6ed>] [<c01380e0>] [<e1cb7fe4>] [<e1cb7fe4>] [<c01382bb>]=20
[<e1cb7fe4>]
  [<c0148059>] [<c0148332>] [<c014817d>] [<c01486b4>] [<c010870b>]
Code: 0f 0b c1 09 00 e2 25 c0 8b 44 24 20 05 00 fe ff ff 3d 00 0e=20


>>EIP; c0136e5e <grow_buffers+3e/110>   <=3D=3D=3D=3D=3D

>>eax; 000007ff Before first symbol
>>ecx; 00000800 Before first symbol
>>edx; c15dd700 <_end+12b4ae4/2051c3e4>
>>edi; 00000b02 Before first symbol
>>esp; ccf01dbc <_end+cbd91a0/2051c3e4>

Trace; c0134fb7 <getblk+27/40>
Trace; c01351d8 <bread+18/70>
Trace; e1cb45c3 <[hfs]hfs_buffer_get+23/80>
Trace; e1cb3839 <[hfs]hfs_part_find+19/170>
Trace; e1cb4443 <[hfs]hfs_read_super+73/190>
Trace; c01ef6ed <media_changed+3d/70>
Trace; c01380e0 <get_sb_bdev+210/280>
Trace; e1cb7fe4 <[hfs]hfs_fs+0/1c>
Trace; e1cb7fe4 <[hfs]hfs_fs+0/1c>
Trace; c01382bb <do_kern_mount+5b/110>
Trace; e1cb7fe4 <[hfs]hfs_fs+0/1c>
Trace; c0148059 <do_add_mount+69/140>
Trace; c0148332 <do_mount+162/180>
Trace; c014817d <copy_mount_options+4d/a0>
Trace; c01486b4 <sys_mount+84/d0>
Trace; c010870b <system_call+33/38>

Code;  c0136e5e <grow_buffers+3e/110>
00000000 <_EIP>:
Code;  c0136e5e <grow_buffers+3e/110>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0136e60 <grow_buffers+40/110>
   2:   c1 09 00                  rorl   $0x0,(%ecx)
Code;  c0136e63 <grow_buffers+43/110>
   5:   e2 25                     loop   2c <_EIP+0x2c> c0136e8a=20
<grow_buffers+6a/110>
Code;  c0136e65 <grow_buffers+45/110>
   7:   c0 8b 44 24 20 05 00      rorb   $0x0,0x5202444(%ebx)
Code;  c0136e6c <grow_buffers+4c/110>
   e:   fe                        (bad) =20
Code;  c0136e6d <grow_buffers+4d/110>
   f:   ff                        (bad) =20
Code;  c0136e6e <grow_buffers+4e/110>
  10:   ff                        (bad) =20
Code;  c0136e6f <grow_buffers+4f/110>
  11:   3d 00 0e 00 00            cmp    $0xe00,%eax


2 warnings issued.  Results may not be reliable.


>
> Nehal
>
> >Hi,
> >
> >is this the same problem as this one?
> >http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D102890250915062&w=3D2
> >
> >Nobody ever answered on that, though.
> >
> >On Wednesday 02 April 2003 12:49, Randy.Dunlap wrote:
> >>First post said Linux 2.4.20... that's good info.
> >>That info has been deleted from subsequent postings.
> >>
> >>Would it make sense for the BUG() message to include a kernel
> >>version number???  I'm wondering since people do omit that data.
> >>
> >>~Randy
> >>
> >>On Wed, 02 Apr 2003 10:15:21 -0800 Nehal <nehal@canada.com> wrote:
> >>| > i have a hybrid cd (both HFS, ISO9660) , i have two CD drives,
> >>| > one IDE CD-Rom (actima 32x), and one SCSI CD-burner (yamaha 6416)
> >>| > on an advansys cfg-510 ISA scsi card
> >>| >
> >>| > when i try to mount on IDE using hfs with:
> >>| >
> >>| >    mount -v -r -t hfs /dev/hdc /cdrom
> >>| >
> >>| > it works fine, yet when i try on scsi with:
> >>| >
> >>| >    mount -v -r -t hfs /dev/scd0 /cdrom
> >>| >
> >>| > i get a "Segmentation fault" error, no more output given,
> >>| > it also locks the drive, and sometimes i can use the
> >>| > 'eject' command to eject it, sometimes i cant and i gotta reboot
> >>| >
> >>| > note: when i try to mount the cd using regular iso9660 fs, it
> >>| > works perfectly on both cd drives,
> >>| > also i have tried 2 hybrid cd's, both times i have trouble mounting
> >>| > hfs on the scsi drive only
> >>| >
> >>| > Nehal
> >>|
> >>| ok i updated firmware of writer from 1.0c to 1.0d with no help,
> >>| but i found when i do 'dmesg' after mounting i get this error:
> >>| =3D=3D=3D=3D=3D=3D=3D=3D
> >>| kernel BUG at buffer.c:2518!
> >>| invalid operand: 0000
> >>| CPU:    0
> >>| EIP:    0010:[<c013c329>]    Not tainted
> >>| EFLAGS: 00013206
> >>| eax: 000007ff   ebx: 00000b00   ecx: 00000800   edx: c11ee640
> >>| esi: 00000b00   edi: 00000200   ebp: 00000b00   esp: c3425db4
> >>| ds: 0018   es: 0018   ss: 0018
> >>| Process mount (pid: 514, stackpage=3Dc3425000)
> >>| Stack: c6d0d760 c3425e48 c0257a59 c7f1c574 00000000 00000b00 00000200
> >>| 00000000
> >>|        c0139f66 00000b00 00000000 00000200 00000000 00000001 c7568400
> >>| 00000000
> >>|        c013a1e0 00000b00 00000000 00000200 00000000 c019280a 00000b00
> >>| 00000000
> >>| Call Trace:    [<c0257a59>] [<c0139f66>] [<c013a1e0>] [<c019280a>]
> >>| [<c019188a>]
> >>|   [<c01925ff>] [<c0285c30>] [<c013cdca>] [<c013e908>] [<c013d64b>]
> >>| [<c013cd3c>]
> >>|   [<c013d9a1>] [<c014fcf3>] [<c0150020>] [<c014fe69>] [<c0150441>]
> >>| [<c01090ff>]
> >>|
> >>| Code: 0f 0b d6 09 9a 2b 33 c0 8d 87 00 fe ff ff 3d 00 0e 00 00 76
> >>|
> >>| root@Nehal:~#
> >>| =3D=3D=3D=3D=3D=3D=3D=3D
> >>| then when i try it again it doesnt give this message, it locks up my
> >>| drive
> >>|
> >>| can someone please help debug this problem,
> >>| thx, Nehal
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> >> in the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>
http://kiza.kcore.de/    <--    homepage
PGP-key      -->    /pgpkey.shtml
http://kiza.kcore.de/journal/

--Boundary-02=_io0i+Vp1ZXTbYzl
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+i0oiOpifZVYdT9IRAgBqAKDwykfLHtSkp5HMx+vG2phBvR/P2wCfT4mM
Haa4WGvKT+0V3CIHOPK0AO4=
=gsNx
-----END PGP SIGNATURE-----

--Boundary-02=_io0i+Vp1ZXTbYzl--

