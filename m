Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271113AbTGYFDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 01:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271710AbTGYFDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 01:03:41 -0400
Received: from adsl-67-121-153-186.dsl.pltn13.pacbell.net ([67.121.153.186]:7040
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S271113AbTGYFDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 01:03:38 -0400
Date: Thu, 24 Jul 2003 22:18:47 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org
Subject: [OOPS] 2.4.21-ck3 in schedule
Message-ID: <20030725051847.GA1778@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Con,

Well, something in the scheduler (I presume) has made 2.4.21-ck3 sink
like a rock on my production system:

ksymoops 2.4.8 on i586 2.4.21-ck3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-ck3/ (default)
     -m /boot/System.map-2.4.21-ck3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 363ec88c
c0113c9f
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[schedule+95/960]    Not tainted
EFLAGS: 00010097
eax: 00000001   ebx: 010a5765   ecx: c94f0000   edx: c94f0000
esi: c02b1b00   edi: 363ec858   ebp: c94f1eec   esp: c94f1ed0
ds: 0018   es: 0018   ss: 0018
Process dhcpd3 (pid: 23479, stackpage=3Dc94f1000)
Stack: d09206a0 c94f1f3c d5e9fa2c c94f0000 010a5765 c94f1ef8 cddb09a0 00000=
100=20
       c011ec12 c94f1ef8 c02bac2c d617bef8 010a5765 c94f0000 c011eba0 cddb0=
9a0=20
       00000000 00000008 00000000 00000009 c014300d 00000304 c94f0000 00007=
52a=20
Call Trace:    [schedule_timeout+82/160] [process_timeout+0/32] [do_select+=
237/512] [sys_select+775/1216] [system_call+51/64]
Code: 8b 5f 34 89 f9 83 c1 2c ff 0b 8b 51 04 8b 47 2c 89 50 04 89=20
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; c94f0000 <_end+9214d80/18551de0>
>>edx; c94f0000 <_end+9214d80/18551de0>
>>esi; c02b1b00 <runqueues+0/940>
>>ebp; c94f1eec <_end+9216c6c/18551de0>
>>esp; c94f1ed0 <_end+9216c50/18551de0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 5f 34                  mov    0x34(%edi),%ebx
Code;  00000003 Before first symbol
   3:   89 f9                     mov    %edi,%ecx
Code;  00000005 Before first symbol
   5:   83 c1 2c                  add    $0x2c,%ecx
Code;  00000008 Before first symbol
   8:   ff 0b                     decl   (%ebx)
Code;  0000000a Before first symbol
   a:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  0000000d Before first symbol
   d:   8b 47 2c                  mov    0x2c(%edi),%eax
Code;  00000010 Before first symbol
  10:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

2.4.21-ck1 was fine under nearly the same circumstances. I rebuilt with
a newer -ck when I was configuring my new ADSL bridge to work with Linux
pppoe, but I doubt that's related.

Anyway, it drove my wireless card driver nuts too, probably due to some
busted interrupts. It kept printing a SW TICK STUCK? message. I'll
revert to vanilla for now. :(

-Josh

--=20
Using words to describe magic is like using a screwdriver to cut roast beef.
		-- Tom Robbins

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IL22T2bz5yevw+4RAnskAJ4ig0ZVaWkDoG9e3HK6TrkuFZlu0QCgqL84
CVxxE5Dne6jLEUP6/XKFB+A=
=bVbi
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
