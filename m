Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSFFBhC>; Wed, 5 Jun 2002 21:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSFFBhB>; Wed, 5 Jun 2002 21:37:01 -0400
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:42763 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S316668AbSFFBg7>; Wed, 5 Jun 2002 21:36:59 -0400
From: glynis@butterfly.hjsoft.com
Date: Wed, 5 Jun 2002 21:36:54 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.20: smbfs oops in smb_readpage
Message-ID: <20020606013654.GA32609@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

reading a file from an smbfs causes this oops, then the smbfs won't
unmount.
traversing the filesystem is fine, but reading data is not.  first 2=20
oopses are  from autofs-mounted shares (nt4), and the last is a
hand-mounted fs (smbd on localhost).  i don't suspect that matters
much, though.

this looks like the exact same problem reported against 2.5.19 in
`PROBLEM: Kernel 2.5.19 oops when copying files from SMBFS fs to'.

thanks.

ver_linux:
---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux density 2.5.20 #7 Wed Jun 5 19:02:22 EDT 2002 i686 unknown
=20
Gnu C                  gcc (GCC) 3.1.1 20020531 (Debian prerelease) Copyrig=
ht (C) 2002 Free Software Foundation, Inc. This is free software; see the s=
ource for copying conditions. There is NO warranty; not even for MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         smbfs af_packet autofs4 serial_cs 3c574_cs ds yenta_=
socket pcmcia_core uhci-hcd usbcore nls_iso8859-1 nls_cp437 serial snd-pcm-=
oss snd-mixer-oss snd-maestro3 snd-pcm snd-timer snd-ac97-codec snd soundco=
re apm
---
ksymoops 2.4.5 on i686 2.5.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.20/ (default)
     -m /boot/System.map-2.5.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x280-0x287 0x378-0x37f 0x4d0-0x=
4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 00000008
ccae8013
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<ccae8013>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c114feb8   ecx: c114feb8   edx: c1150590
esi: 00000000   edi: c88a7238   ebp: 00000001   esp: c9dabe44
ds: 0018   es: 0018   ss: 0018
Stack: c114feb8 00000000 c114feb8 00000000 c013bed4 00000000 c114feb8 00000=
000=20
       00000001 00000001 c88a7238 c9daa000 c013bfb0 c88a7238 c9dabe90 00000=
001=20
       c9daa000 00000001 00000000 c9dabe90 c9dabe90 00000010 00000000 00000=
000=20
Call Trace: [<c013bed4>] [<c013bfb0>] [<c013c096>] [<c012d9bd>] [<c012dee0>=
]=20
   [<c012e028>] [<c012dee0>] [<ccae8307>] [<c013ee6e>] [<c013efde>] [<c0107=
3ff>]=20
Code: 8b 40 08 ff 43 10 89 5c 24 04 89 04 24 e8 7b fe ff ff 31 d2=20


>>EIP; ccae8013 <[smbfs]smb_readpage+13/40>   <=3D=3D=3D=3D=3D

>>ebx; c114feb8 <_end+e502d4/c5e241c>
>>ecx; c114feb8 <_end+e502d4/c5e241c>
>>edx; c1150590 <_end+e509ac/c5e241c>
>>edi; c88a7238 <_end+85a7654/c5e241c>
>>esp; c9dabe44 <_end+9aac260/c5e241c>

Trace; c013bed4 <read_pages+84/a0>
Trace; c013bfb0 <do_page_cache_readahead+c0/140>
Trace; c013c096 <page_cache_readahead+66/130>
Trace; c012d9bd <do_generic_file_read+bd/390>
Trace; c012dee0 <file_read_actor+0/a0>
Trace; c012e028 <generic_file_read+a8/160>
Trace; c012dee0 <file_read_actor+0/a0>
Trace; ccae8307 <[smbfs]smb_file_read+77/80>
Trace; c013ee6e <vfs_read+ae/f0>
Trace; c013efde <sys_read+3e/60>
Trace; c01073ff <syscall_call+7/b>

Code;  ccae8013 <[smbfs]smb_readpage+13/40>
00000000 <_EIP>:
Code;  ccae8013 <[smbfs]smb_readpage+13/40>   <=3D=3D=3D=3D=3D
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=3D=3D=3D=3D=3D
Code;  ccae8016 <[smbfs]smb_readpage+16/40>
   3:   ff 43 10                  incl   0x10(%ebx)
Code;  ccae8019 <[smbfs]smb_readpage+19/40>
   6:   89 5c 24 04               mov    %ebx,0x4(%esp,1)
Code;  ccae801d <[smbfs]smb_readpage+1d/40>
   a:   89 04 24                  mov    %eax,(%esp,1)
Code;  ccae8020 <[smbfs]smb_readpage+20/40>
   d:   e8 7b fe ff ff            call   fffffe8d <_EIP+0xfffffe8d> ccae7ea=
0 <[smbfs]smb_readpage_sync+0/160>
Code;  ccae8025 <[smbfs]smb_readpage+25/40>
  12:   31 d2                     xor    %edx,%edx

Unable to handle kernel NULL pointer dereference at virtual address 00000008
ccae8013
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<ccae8013>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: c10e2910   ecx: c10e2910   edx: c10e294c
esi: 00000000   edi: c66f3638   ebp: 00000010   esp: c664de44
ds: 0018   es: 0018   ss: 0018
Stack: c10e2910 00000000 c10e2910 00000000 c013bed4 00000000 c10e2910 00000=
000=20
       0000000f 00000010 c66f3638 c664c000 c013bfb0 c66f3638 c664de90 00000=
010=20
       c664c000 00000010 000000b3 c10e5874 c10e28ec 00000010 00000000 00000=
000=20
Call Trace: [<c013bed4>] [<c013bfb0>] [<c013c096>] [<c012d9bd>] [<c012dee0>=
]=20
   [<c012e028>] [<c012dee0>] [<ccae8307>] [<c013ee6e>] [<c013efde>] [<c0107=
3ff>]=20
Code: 8b 40 08 ff 43 10 89 5c 24 04 89 04 24 e8 7b fe ff ff 31 d2=20


>>EIP; ccae8013 <[smbfs]smb_readpage+13/40>   <=3D=3D=3D=3D=3D

>>ebx; c10e2910 <_end+de2d2c/c5e241c>
>>ecx; c10e2910 <_end+de2d2c/c5e241c>
>>edx; c10e294c <_end+de2d68/c5e241c>
>>edi; c66f3638 <_end+63f3a54/c5e241c>
>>esp; c664de44 <_end+634e260/c5e241c>

Trace; c013bed4 <read_pages+84/a0>
Trace; c013bfb0 <do_page_cache_readahead+c0/140>
Trace; c013c096 <page_cache_readahead+66/130>
Trace; c012d9bd <do_generic_file_read+bd/390>
Trace; c012dee0 <file_read_actor+0/a0>
Trace; c012e028 <generic_file_read+a8/160>
Trace; c012dee0 <file_read_actor+0/a0>
Trace; ccae8307 <[smbfs]smb_file_read+77/80>
Trace; c013ee6e <vfs_read+ae/f0>
Trace; c013efde <sys_read+3e/60>
Trace; c01073ff <syscall_call+7/b>

Code;  ccae8013 <[smbfs]smb_readpage+13/40>
00000000 <_EIP>:
Code;  ccae8013 <[smbfs]smb_readpage+13/40>   <=3D=3D=3D=3D=3D
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=3D=3D=3D=3D=3D
Code;  ccae8016 <[smbfs]smb_readpage+16/40>
   3:   ff 43 10                  incl   0x10(%ebx)
Code;  ccae8019 <[smbfs]smb_readpage+19/40>
   6:   89 5c 24 04               mov    %ebx,0x4(%esp,1)
Code;  ccae801d <[smbfs]smb_readpage+1d/40>
   a:   89 04 24                  mov    %eax,(%esp,1)
Code;  ccae8020 <[smbfs]smb_readpage+20/40>
   d:   e8 7b fe ff ff            call   fffffe8d <_EIP+0xfffffe8d> ccae7ea=
0 <[smbfs]smb_readpage_sync+0/160>
Code;  ccae8025 <[smbfs]smb_readpage+25/40>
  12:   31 d2                     xor    %edx,%edx

Unable to handle kernel NULL pointer dereference at virtual address 00000008
ccae8013
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<ccae8013>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: c11a2850   ecx: c11a2850   edx: c1049b8c
esi: 00000000   edi: c66f3138   ebp: 00000002   esp: c78a5e44
ds: 0018   es: 0018   ss: 0018
Stack: c11a2850 00000000 c11a2850 00000000 c013bed4 00000000 c11a2850 00000=
000=20
       00000002 00000002 c66f3138 c78a4000 c013bfb0 c66f3138 c78a5e90 00000=
002=20
       c78a4000 00000002 00000001 c110c1a8 c110c1a8 00000010 00000000 00000=
000=20
Call Trace: [<c013bed4>] [<c013bfb0>] [<c013c096>] [<c012d9bd>] [<c012dee0>=
]=20
   [<c012e028>] [<c012dee0>] [<ccae8307>] [<c013ee6e>] [<c013efde>] [<c0107=
3ff>]=20
Code: 8b 40 08 ff 43 10 89 5c 24 04 89 04 24 e8 7b fe ff ff 31 d2=20


>>EIP; ccae8013 <[smbfs]smb_readpage+13/40>   <=3D=3D=3D=3D=3D

>>ebx; c11a2850 <_end+ea2c6c/c5e241c>
>>ecx; c11a2850 <_end+ea2c6c/c5e241c>
>>edx; c1049b8c <_end+d49fa8/c5e241c>
>>edi; c66f3138 <_end+63f3554/c5e241c>
>>esp; c78a5e44 <_end+75a6260/c5e241c>

Trace; c013bed4 <read_pages+84/a0>
Trace; c013bfb0 <do_page_cache_readahead+c0/140>
Trace; c013c096 <page_cache_readahead+66/130>
Trace; c012d9bd <do_generic_file_read+bd/390>
Trace; c012dee0 <file_read_actor+0/a0>
Trace; c012e028 <generic_file_read+a8/160>
Trace; c012dee0 <file_read_actor+0/a0>
Trace; ccae8307 <[smbfs]smb_file_read+77/80>
Trace; c013ee6e <vfs_read+ae/f0>
Trace; c013efde <sys_read+3e/60>
Trace; c01073ff <syscall_call+7/b>

Code;  ccae8013 <[smbfs]smb_readpage+13/40>
00000000 <_EIP>:
Code;  ccae8013 <[smbfs]smb_readpage+13/40>   <=3D=3D=3D=3D=3D
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=3D=3D=3D=3D=3D
Code;  ccae8016 <[smbfs]smb_readpage+16/40>
   3:   ff 43 10                  incl   0x10(%ebx)
Code;  ccae8019 <[smbfs]smb_readpage+19/40>
   6:   89 5c 24 04               mov    %ebx,0x4(%esp,1)
Code;  ccae801d <[smbfs]smb_readpage+1d/40>
   a:   89 04 24                  mov    %eax,(%esp,1)
Code;  ccae8020 <[smbfs]smb_readpage+20/40>
   d:   e8 7b fe ff ff            call   fffffe8d <_EIP+0xfffffe8d> ccae7ea=
0 <[smbfs]smb_readpage_sync+0/160>
Code;  ccae8025 <[smbfs]smb_readpage+25/40>
  12:   31 d2                     xor    %edx,%edx


1 warning issued.  Results may not be reliable.
---
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8/ry1CGPRljI8080RAg47AJ0XlJWT9CVspsgRzuGrUbfMshWydACfR0+4
ahX6AQOFphlr5qK8c4SQ43A=
=EkT8
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
