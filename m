Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267006AbTGGNmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267014AbTGGNmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:42:22 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:54986 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S267006AbTGGNmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:42:12 -0400
Subject: Re: kernel oops
From: Anders Karlsson <anders@trudheim.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1057585054.2743.40.camel@dhcp22.swansea.linux.org.uk>
References: <1057582393.2034.13.camel@tor.trudheim.com>
	 <1057583643.2743.38.camel@dhcp22.swansea.linux.org.uk>
	 <1057584747.2278.17.camel@tor.trudheim.com>
	 <1057585054.2743.40.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-C3DG2J+JCNKpZlRIRqN7"
Organization: Trudheim Technology Limited
Message-Id: <1057586205.2039.3.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 07 Jul 2003 14:56:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C3DG2J+JCNKpZlRIRqN7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-07-07 at 14:37, Alan Cox wrote:
> On Llu, 2003-07-07 at 14:32, Anders Karlsson wrote:
> > The running kernel is 2.4.21-rc7-ac1, I was trying to compile
> > 2.4.22-pre3 with the freeswan patches applied. I can try and
> > compile the plain 2.4.22-pre3 a few times to provoke an oops.
> > The system is presently still running 2.4.21-rc7-ac1.
>=20
> Ah I misunderstood - is the 2.4.21-rc7-ac1 with or without
> freeswan  patches ?

2.4.21-rc7-ac1 only has the CPUFreq patches applied, courtesy of Bill
Nottingham. There is no FreeS/WAN patches applied to it.

I have just run another compile of 2.4.22-pre3, this time nothing else
applied. The oopses is as follows.

ksymoops 2.4.8 on i686 2.4.21-rc7-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc7-ac1/ (default)
     -m /boot/System.map-2.4.21-rc7-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0139296>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 01000072   ebx: c16cbc30   ecx: 000243eb   edx: 00001000
esi: c02f3e70   edi: c02f3e84   ebp: c02f3e70   esp: e42f1e74
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 10269, stackpage=3De42f1000)
Stack: 00001000 00000000 000233eb 00000286 00000000 c02f3e70 c02f3ff4
000001ff=20
       00000000 000001d2 c01394e2 d2de7280 c02f3e70 c02f3ff0 d22f294c
00000000=20
       c10030e0 00104025 d2dd9580 c012e250 c10030e0 00000000 00001000
410f1000=20
Call Trace:    [<c01394e2>] [<c012e250>] [<c012ebf5>] [<c012fb49>]
[<c011a0d4>]
  [<c010ebd0>] [<c0119f94>] [<c0108e78>]
Code: 0f 0b e7 00 f0 39 2b c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20


>>EIP; c0139296 <rmqueue+1f9/21d>   <=3D=3D=3D=3D=3D

>>ebx; c16cbc30 <_end+132396c/3146ad9c>
>>esi; c02f3e70 <contig_page_data+b0/340>
>>edi; c02f3e84 <contig_page_data+c4/340>
>>ebp; c02f3e70 <contig_page_data+b0/340>
>>esp; e42f1e74 <_end+23f49bb0/3146ad9c>

Trace; c01394e2 <__alloc_pages+3f/180>
Trace; c012e250 <do_wp_page+51/25e>
Trace; c012ebf5 <handle_mm_fault+122/124>
Trace; c012fb49 <get_unmapped_area+86/115>
Trace; c011a0d4 <do_page_fault+140/472>
Trace; c010ebd0 <old_mmap+de/11d>
Trace; c0119f94 <do_page_fault+0/472>
Trace; c0108e78 <error_code+34/3c>

Code;  c0139296 <rmqueue+1f9/21d>
00000000 <_EIP>:
Code;  c0139296 <rmqueue+1f9/21d>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0139298 <rmqueue+1fb/21d>
   2:   e7 00                     out    %eax,$0x0
Code;  c013929a <rmqueue+1fd/21d>
   4:   f0 39 2b                  lock cmp %ebp,(%ebx)
Code;  c013929d <rmqueue+200/21d>
   7:   c0 8b 43 18 a9 80 00      rorb   $0x0,0x80a91843(%ebx)
Code;  c01392a4 <rmqueue+207/21d>
   e:   00 00                     add    %al,(%eax)
Code;  c01392a6 <rmqueue+209/21d>
  10:   74 08                     je     1a <_EIP+0x1a>
Code;  c01392a8 <rmqueue+20b/21d>
  12:   0f 0b                     ud2a  =20

 kernel BUG at page_alloc.c:100!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138e47>]    Not tainted
EFLAGS: 00010206
eax: 0100003d   ebx: c16cbcc0   ecx: 000000a3   edx: 00000000
esi: d22f7090   edi: 00000000   ebp: 00000010   esp: e42f1ca8
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 10269, stackpage=3De42f1000)
Stack: c02f3efc c1000020 c16a59b0 c02f3e70 c1030020 00000203 ffffffff
00010e8a=20
       0000f000 d22f7090 00012000 00000010 c012f0a2 c16cbcc0 e42f1cec
c0127315=20
       edb9f134 40415000 ea6e8404 40027000 00000000 c012d83a dce4b680
ea6e8400=20
Call Trace:    [<c012f0a2>] [<c0127315>] [<c012d83a>] [<c01306e2>]
[<c011c692>]
  [<c01215f4>] [<c0109572>] [<c010943b>] [<c01095d9>] [<c0139296>]
[<f1d8e857>]
  [<f1d8db1d>] [<f1da2b06>] [<c0108e78>] [<c0139296>] [<c01394e2>]
[<c012e250>]
  [<c012ebf5>] [<c012fb49>] [<c011a0d4>] [<c010ebd0>] [<c0119f94>]
[<c0108e78>]
Code: 0f 0b 64 00 f0 39 2b c0 8b 53 08 85 d2 74 08 0f 0b 66 00 f0=20


>>EIP; c0138e47 <__free_pages_ok+33/289>   <=3D=3D=3D=3D=3D

>>ebx; c16cbcc0 <_end+13239fc/3146ad9c>
>>esi; d22f7090 <_end+11f4edcc/3146ad9c>
>>esp; e42f1ca8 <_end+23f499e4/3146ad9c>

Trace; c012f0a2 <zap_pte_range+108/13e>
Trace; c0127315 <run_timer_list+137/15e>
Trace; c012d83a <zap_page_range+83/f9>
Trace; c01306e2 <exit_mmap+a5/17a>
Trace; c011c692 <mmput+45/96>
Trace; c01215f4 <do_exit+ca/262>
Trace; c0109572 <do_invalid_op+0/6e>
Trace; c010943b <do_divide_error+0/6e>
Trace; c01095d9 <do_invalid_op+67/6e>
Trace; c0139296 <rmqueue+1f9/21d>
Trace; f1d8e857 <[jbd]__journal_file_buffer+df/23c>
Trace; f1d8db1d <[jbd]journal_dirty_metadata+16f/222>
Trace; f1da2b06 <[ext3]ext3_do_update_inode+168/402>
Trace; c0108e78 <error_code+34/3c>
Trace; c0139296 <rmqueue+1f9/21d>
Trace; c01394e2 <__alloc_pages+3f/180>
Trace; c012e250 <do_wp_page+51/25e>
Trace; c012ebf5 <handle_mm_fault+122/124>
Trace; c012fb49 <get_unmapped_area+86/115>
Trace; c011a0d4 <do_page_fault+140/472>
Trace; c010ebd0 <old_mmap+de/11d>
Trace; c0119f94 <do_page_fault+0/472>
Trace; c0108e78 <error_code+34/3c>

Code;  c0138e47 <__free_pages_ok+33/289>
00000000 <_EIP>:
Code;  c0138e47 <__free_pages_ok+33/289>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0138e49 <__free_pages_ok+35/289>
   2:   64                        fs
Code;  c0138e4a <__free_pages_ok+36/289>
   3:   00 f0                     add    %dh,%al
Code;  c0138e4c <__free_pages_ok+38/289>
   5:   39 2b                     cmp    %ebp,(%ebx)
Code;  c0138e4e <__free_pages_ok+3a/289>
   7:   c0 8b 53 08 85 d2 74      rorb   $0x74,0xd2850853(%ebx)
Code;  c0138e55 <__free_pages_ok+41/289>
   e:   08 0f                     or     %cl,(%edi)
Code;  c0138e57 <__free_pages_ok+43/289>
  10:   0b 66 00                  or     0x0(%esi),%esp
Code;  c0138e5a <__free_pages_ok+46/289>
  13:   f0 00 00                  lock add %al,(%eax)


1 warning issued.  Results may not be reliable.


If there is anything I can do to assist debugging, let me know.

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-C3DG2J+JCNKpZlRIRqN7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA/CXwdLYywqksgYBoRAqu1AKDL5SagwyzQTdahiX9kHl9YJbHXAgCgz8uD
TfCU8KGeISlwqTqsDjrBGak=
=qMUz
-----END PGP SIGNATURE-----

--=-C3DG2J+JCNKpZlRIRqN7--

