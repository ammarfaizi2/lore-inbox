Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317466AbSGYA5l>; Wed, 24 Jul 2002 20:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGYA5l>; Wed, 24 Jul 2002 20:57:41 -0400
Received: from dracula.gtri.gatech.edu ([130.207.193.70]:49578 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP
	id <S317466AbSGYA5j>; Wed, 24 Jul 2002 20:57:39 -0400
Date: Wed, 24 Jul 2002 20:59:15 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.19rc2aa1 in page_cache_read
Message-ID: <20020725005915.GA24308@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was having VM oopsen with 2.4.19rc1aa1, so I upgraded to 2.4.19rc2aa1
to see if things were any better.  Apparently they aren't.

System uptime of about 60 hours.  P3-1G, 512M RAM.  Pretty standard
system.   This time it wasn't postgresql that got whacked, it was scp.

I'm probably going to fall back to 2.4.19rc3 soon.  This is a production
machine, so I can't reboot it that often...  The -aa kernel does
bring a number of benefits (and I'm hoping to not have to pull the bits
I want out; I hate rediffing things..)

Here's the ksymoops dump.  NULL dereference in the middle of
page_cache_read.

ksymoops 2.4.4 on i686 2.4.19-rc2aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc2aa1/ (default)
     -m /boot/System.map-2.4.19-rc2aa1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address
00000017
80126817
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<80126817>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0000000f   ebx: 89b6a728   ecx: 00000011   edx: 973c2000
esi: 00009bc2   edi: 00009c3c   ebp: 9fe95cf4   esp: 973c3eb8
ds: 0018   es: 0018   ss: 0018
Process scp (pid: 5900, stackpage=3D973c3000)
Stack: 96de9ae0 0000007a 00009bc2 96de9ae0 00009b43 80126ed7 0000007f 00000=
080=20
       00027e50 814656c4 00000001 96de9ae0 89b6a728 80127135 00000001 96de9=
ae0=20
       89b6a680 814656c4 00001000 00000001 00000000 00000000 00009b43 89b6a=
680=20
Call Trace: [<80126ed7>] [<80127135>] [<8012772c>] [<80127630>] [<80134056>=
]=20
   [<80113abe>] [<801087a3>]=20
Code: 39 58 08 75 f4 39 78 0c 75 ef 85 c0 75 59 8b 43 2c 31 d2 89=20

>>EIP; 80126817 <page_cache_read+67/e0>   <=3D=3D=3D=3D=3D
Trace; 80126ed7 <generic_file_readahead+127/160>
Trace; 80127135 <__do_generic_file_read+1e5/4b0>
Trace; 8012772c <generic_file_read+8c/180>
Trace; 80127630 <file_read_actor+0/70>
Trace; 80134056 <sys_read+96/f0>
Trace; 80113abe <schedule+1ee/210>
Trace; 801087a3 <system_call+33/38>
Code;  80126817 <page_cache_read+67/e0>
00000000 <_EIP>:
Code;  80126817 <page_cache_read+67/e0>   <=3D=3D=3D=3D=3D
   0:   39 58 08                  cmp    %ebx,0x8(%eax)   <=3D=3D=3D=3D=3D
Code;  8012681a <page_cache_read+6a/e0>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> 8012681=
0 <page_cache_read+60/e0>
Code;  8012681c <page_cache_read+6c/e0>
   5:   39 78 0c                  cmp    %edi,0xc(%eax)
Code;  8012681f <page_cache_read+6f/e0>
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> 8012681=
0 <page_cache_read+60/e0>
Code;  80126821 <page_cache_read+71/e0>
   a:   85 c0                     test   %eax,%eax
Code;  80126823 <page_cache_read+73/e0>
   c:   75 59                     jne    67 <_EIP+0x67> 8012687e <page_cach=
e_read+ce/e0>
Code;  80126825 <page_cache_read+75/e0>
   e:   8b 43 2c                  mov    0x2c(%ebx),%eax
Code;  80126828 <page_cache_read+78/e0>
  11:   31 d2                     xor    %edx,%edx
Code;  8012682a <page_cache_read+7a/e0>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.


 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
I'm not broke, but I'm badly bent.                         ICQ #1318344
Patience comes to those who wait.                         Melbourne, FL

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9P01jPuLgii2759ARAtLRAKCm+YxkI/pG+HMz1rtWpNYgETsliwCdEW4L
tiVQ4EOZPcKW34ci0NJbzVc=
=IVm5
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
