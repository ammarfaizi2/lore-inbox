Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262999AbTCSMZH>; Wed, 19 Mar 2003 07:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTCSMXX>; Wed, 19 Mar 2003 07:23:23 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:394 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP
	id <S263012AbTCSMVK>; Wed, 19 Mar 2003 07:21:10 -0500
Date: Wed, 19 Mar 2003 12:32:06 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Cc: samp@soton.ac.uk, hugo@soton.ac.uk
Subject: BUG at page_alloc.c:119 - 2.4.20-ac2
Message-ID: <20030319123206.GA12270@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org, samp@soton.ac.uk, hugo@soton.ac.uk
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir eternal.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   As subject, decoded BUG below.

   Given the time that this occurred, the machine was probably doing
the daily cleaning for postgres. It was almost certainly without
significant load at the time (it's not really a production machine).
It appears still to be running without any problems.

   I can supply other information on request.

   Hugo.

ksymoops 2.4.5 on i586 2.4.20-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-ac1/ (default)
     -m /boot/System.map-2.4.20-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar 19 04:02:03 kamalkhan kernel: kernel BUG at page_alloc.c:119!
Mar 19 04:02:03 kamalkhan kernel: invalid operand: 0000
Mar 19 04:02:03 kamalkhan kernel: CPU:    0
Mar 19 04:02:03 kamalkhan kernel: EIP:    0010:[__free_pages_ok+200/876]    Not tainted
Mar 19 04:02:03 kamalkhan kernel: EFLAGS: 00010286
Mar 19 04:02:03 kamalkhan kernel: eax: 01000010   ebx: c1164a70   ecx: c1164a8c   edx: c130eee0
Mar 19 04:02:03 kamalkhan kernel: esi: 00000000   edi: 40530000   ebp: 00004000   esp: c636fee0
Mar 19 04:02:03 kamalkhan kernel: ds: 0018   es: 0018   ss: 0018
Mar 19 04:02:03 kamalkhan kernel: Process modprobe (pid: 13682, stackpage=c636f000)
Mar 19 04:02:03 kamalkhan kernel: Stack: c1164a70 00003000 40530000 00004000 40111290 00000282 c1164a70 00000000 
Mar 19 04:02:03 kamalkhan kernel:        40530000 00004000 c012eda5 c1ac5c00 cf0d6f10 c012a9db c012ae2b c1164a70 
Mar 19 04:02:03 kamalkhan kernel:        c011ea20 c1164a70 cf4074cc c011ee4d 06dbd067 cf0cbba0 c1a70bc0 00004000 
Mar 19 04:02:03 kamalkhan kernel: Call Trace:    [pte_chain_free+49/60] [__free_pages+19/20] [free_page_and_swap_cache+51/56] [__free_pte+64/72] [zap_page_range+441/628]
Mar 19 04:02:03 kamalkhan kernel: Code: 0f 0b 77 00 82 83 1e c0 8b 43 18 24 eb 89 43 18 c6 43 24 05 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 01000010 Before first symbol
>>ebx; c1164a70 <_end+edfc1c/105c21ac>
>>ecx; c1164a8c <_end+edfc38/105c21ac>
>>edx; c130eee0 <_end+108a08c/105c21ac>
>>edi; 40530000 Before first symbol
>>ebp; 00004000 Before first symbol
>>esp; c636fee0 <_end+60eb08c/105c21ac>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   77 00                     ja     4 <_EIP+0x4> 00000004 Before first symbol
Code;  00000004 Before first symbol
   4:   82                        (bad)  
Code;  00000005 Before first symbol
   5:   83 1e c0                  sbbl   $0xffffffc0,(%esi)
Code;  00000008 Before first symbol
   8:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  0000000b Before first symbol
   b:   24 eb                     and    $0xeb,%al
Code;  0000000d Before first symbol
   d:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  00000010 Before first symbol
  10:   c6 43 24 05               movb   $0x5,0x24(%ebx)


1 warning issued.  Results may not be reliable.


-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
              --- The future isn't what it used to be. ---               

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+eGNGssJ7whwzWGARAgtrAKCnfB3awMOOrkke9fpNfroe8lyKNwCfWoLW
QcmlHJJslVMPBRliWLYasaM=
=67Ls
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
