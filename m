Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVLGJhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVLGJhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVLGJhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:37:53 -0500
Received: from smtp2.rz.uni-karlsruhe.de ([129.13.185.218]:54678 "EHLO
	smtp2.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S1750732AbVLGJhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:37:52 -0500
Date: Wed, 7 Dec 2005 10:37:47 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.32 Oops in scsi_dispatch_cmd
Message-ID: <20051207093747.GA1154@hek501.hek.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: =?iso-8859-1?Q?Jan_Oberl=E4nder?= <mindriot@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[please Cc:, I'm not on the list!]

I've been receiving Oops repeatedly in scsi_dispatch_cmd, in different
kernels (2.4.{27,31,32}).  At first I thought that a non-free module for
an ATA RAID card was responsible, but in 2.4.32 I've seen it without
using that as well (in a non-tainted kernel).  I can't exactly rule out
that it's a hardware problem, but since it's very repeatable I'm really
not sure.  The box doesn't recover from the Oops, but I was still able
to see the Oops message in /var/log/messages.  See the attached file for
ksymoops output.

The tar process is run from a backup scripts that mounts an IDE drive
partition, writes a backup to it and unmounts it.  It's always been the
tar process behind this crash.  Some system details:

$ uname -a
Linux server 2.4.32 #1 Tue Dec 6 10:55:41 CET 2005 i686 GNU/Linux
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 1197.726
cache size      : 64 KB
 [...]
$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A=
/333]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/=
333 AGP]
0000:00:0d.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 =
Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 =
Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 =
Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B=
/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8=
235/8237 AC97 Audio Controller (rev 50)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] =
(rev 74)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT=
2 Model 64/Model 64 Pro] (rev 15)
$=20

There are no modules loaded.  The IDE HDD is on the VIA controller,
several other disks are behind the Adaptec controller (several of them
on Software RAID).

Maybe you have an idea what's going on (or who to talk to instead)?  I'm
stuck.

Thanks in advance & keep up the good work!

Jan

--=20

+-------------------------------------+
| Jan Oberl=E4nder   <mindriot@gmx.net> |
|         PGP key: 0xC4D910E3         |
+-------------------------------------+

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crash.symoops"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.9 on i686 2.4.32.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.32/ (specified)
     -m /boot/System.map-2.4.32 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod f=
ile?
Dec  7 01:11:46 server kernel: c01cdd9b
Dec  7 01:11:46 server kernel: Oops: 0000
Dec  7 01:11:46 server kernel: CPU:    0
Dec  7 01:11:46 server kernel: EIP:    0010:[scsi_dispatch_cmd+107/544]    =
Not tainted
Dec  7 01:11:46 server kernel: EFLAGS: 00010246
Dec  7 01:11:46 server kernel: eax: 00000000   ebx: c02d7da0   ecx: c13be08=
8   edx: 000000c8
Dec  7 01:11:46 server kernel: esi: c12e5480   edi: cff3edc0   ebp: c13be00=
0   esp: c97b5e58
Dec  7 01:11:46 server kernel: ds: 0018   es: 0018   ss: 0018
Dec  7 01:11:46 server kernel: Process tar (pid: 10731, stackpage=3Dc97b500=
0)
Dec  7 01:11:46 server kernel: Stack: ce072e40 c01ce410 00000018 00000000 c=
02d7da0 c12e5480 c13be110 c13be000=20
Dec  7 01:11:46 server kernel:        c01d4ecf c13be000 00000000 00000000 0=
0000001 00001000 c13be0b8 c12e54bc=20
Dec  7 01:11:46 server kernel:        c02d7da0 cff1edc0 c12e5480 00000296 c=
97b5ec8 c97b5ee8 c12c0338 c01a5259=20
Dec  7 01:11:46 server kernel: Call Trace:    [scsi_done+0/160] [scsi_reque=
st_fn+431/880] [generic_unplug_device+57/64] [__run_task_queue+75/96] [bloc=
k_sync_page+33/48]
Dec  7 01:11:46 server kernel: Code: f6 40 67 04 0f 84 5a 01 00 00 c7 44 24=
 08 30 1c 1d c0 8b 45=20
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c02d7da0 <sd_template+0/48>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 67 04               testb  $0x4,0x67(%eax)
Code;  00000004 Before first symbol
   4:   0f 84 5a 01 00 00         je     164 <_EIP+0x164>
Code;  0000000a Before first symbol
   a:   c7 44 24 08 30 1c 1d      movl   $0xc01d1c30,0x8(%esp)
Code;  00000011 Before first symbol
  11:   c0=20
Code;  00000012 Before first symbol
  12:   8b 45 00                  mov    0x0(%ebp),%eax

Dec  7 01:11:46 server kernel:  <1>Unable to handle kernel NULL pointer der=
eference at virtual address 00000011
Dec  7 01:11:46 server kernel: c0114cd2
Dec  7 01:11:46 server kernel: Oops: 0000
Dec  7 01:11:46 server kernel: CPU:    0
Dec  7 01:11:46 server kernel: EIP:    0010:[__wake_up+146/176]    Not tain=
ted
Dec  7 01:11:46 server kernel: EFLAGS: 00010046
Dec  7 01:11:46 server kernel: eax: 00000000   ebx: c97b5ef8   ecx: c926800=
0   edx: 00000011
Dec  7 01:11:46 server kernel: esi: c116b5c8   edi: c12c0338   ebp: cae05ea=
8   esp: cae05e90
Dec  7 01:11:46 server kernel: ds: 0018   es: 0018   ss: 0018
Dec  7 01:11:46 server kernel: Process sendmail (pid: 10848, stackpage=3Dca=
e05000)
Dec  7 01:11:46 server kernel: Stack: 00000000 00000282 00000003 00000000 c=
116b5c8 08421065 cb06d3b4 c012552f=20
Dec  7 01:11:46 server kernel:        cb5e5000 c4aa1000 c0130534 c11f4378 0=
80edac4 cb0c5740 00000001 cb832d40=20
Dec  7 01:11:46 server kernel:        c0125de2 cb0c5740 cb832d40 080edac4 c=
b06d3b4 08421065 c2770140 cb0c5740=20
Dec  7 01:11:46 server kernel: Call Trace:    [do_wp_page+79/528] [__alloc_=
pages+100/608] [handle_mm_fault+242/256] [do_page_fault+440/1317] [build_mm=
ap_rb+73/96]
Dec  7 01:11:46 server kernel: Code: 8b 02 89 d3 89 c2 0f 0d 00 39 fb 75 91=
 ff 75 ec 9d 83 c4 0c=20


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 02                     mov    (%edx),%eax
Code;  00000002 Before first symbol
   2:   89 d3                     mov    %edx,%ebx
Code;  00000004 Before first symbol
   4:   89 c2                     mov    %eax,%edx
Code;  00000006 Before first symbol
   6:   0f 0d 00                  prefetch (%eax)
Code;  00000009 Before first symbol
   9:   39 fb                     cmp    %edi,%ebx
Code;  0000000b Before first symbol
   b:   75 91                     jne    ffffff9e <_EIP+0xffffff9e>
Code;  0000000d Before first symbol
   d:   ff 75 ec                  pushl  0xffffffec(%ebp)
Code;  00000010 Before first symbol
  10:   9d                        popf  =20
Code;  00000011 Before first symbol
  11:   83 c4 0c                  add    $0xc,%esp

Dec  7 01:11:46 server kernel:  <1>Unable to handle kernel NULL pointer der=
eference at virtual address 00000011

1 warning issued.  Results may not be reliable.

--KsGdsel6WgEHnImy--

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlq1rrN8DZMTZEOMRArPwAKC9+H0DekP0mJ3XezHb1l3d1aK3pACfRms1
nRSesemjjsXNmEh4FvDfZ2w=
=m30v
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
