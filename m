Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293161AbSB1K31>; Thu, 28 Feb 2002 05:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293253AbSB1K1M>; Thu, 28 Feb 2002 05:27:12 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:51212 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S293252AbSB1KZa>;
	Thu, 28 Feb 2002 05:25:30 -0500
Date: Thu, 28 Feb 2002 11:25:16 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] sys_newlstat / free_block / NMI WATCHDOG LOCKUP 
Message-ID: <20020228102515.GA18057@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
in the row of more luck capturing deadlocks on a bunch of SMP machines
this morning one of them died. Dual PIII, Serverworks chipset, ICP
Vortex GDT6523RS, 1GB Ram (No Highmem)

The deadlocks happen on these machines for 2.2 and 2.4 and come
occasionally on all machine having a bit more i/o load.

The machine had moderate load - The last "vmstat 5" lines were (Captured
on serial console)

 2  1  0  13068   4544  67988 537060  15   0  2534   102 1887  9126  64 28 =
  8
 4  0  1  13068   4380  68024 536576   0   0  2612   102 1905  9542  67 24 =
  9
 1  0  1  13068   5356  68068 536312   0   0  2522    48 1930  8742  61 30 =
  9
 5  0  0  13068   4568  68096 536804   0   0  2713    46 1981  8726  63 29 =
  7
 5  0  0  13068   4404  68156 536784   0   0  2565    26 1925  9388  66 26 =
  8


Kernel 2.4.16 - No patches. Three oopses in a row - The last is a
NMI Watchdog detectet LOCKUP.


ksymoops 2.3.4 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 32fb3814
c0138924
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0138924>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 32fb37e0   ebx: 00000000   ecx: c3ae1000   edx: d9d3c560
esi: c990dfa4   edi: 080737f9   ebp: bfffb920   esp: c990df9c
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 16004, stackpage=3Dc990d000)
Stack: c990c000 bfffd998 d9d3c560 c1e0e320 00002000 c990c000 c990c000 00000=
008=20
       00000001 c0106d63 080737f9 bfffb8e0 080737f9 bfffd998 080737f9 bfffb=
920=20
       0000006b c010002b 0000002b 0000006b 400a540d 00000023 00000202 bfffb=
8c4=20
Call Trace: [<c0106d63>]=20
Code: 8b 40 34 85 c0 74 0a 52 ff d0 89 c3 83 c4 04 eb 02 31 db 85=20

>>EIP; c0138924 <sys_newlstat+30/70>   <=3D=3D=3D=3D=3D
Trace; c0106d63 <system_call+2f/34>
Code;  c0138924 <sys_newlstat+30/70>
00000000 <_EIP>:
Code;  c0138924 <sys_newlstat+30/70>   <=3D=3D=3D=3D=3D
   0:   8b 40 34                  mov    0x34(%eax),%eax   <=3D=3D=3D=3D=3D
Code;  c0138927 <sys_newlstat+33/70>
   3:   85 c0                     test   %eax,%eax
Code;  c0138929 <sys_newlstat+35/70>
   5:   74 0a                     je     11 <_EIP+0x11> c0138935 <sys_newls=
tat+41/70>
Code;  c013892b <sys_newlstat+37/70>
   7:   52                        push   %edx
Code;  c013892c <sys_newlstat+38/70>
   8:   ff d0                     call   *%eax
Code;  c013892e <sys_newlstat+3a/70>
   a:   89 c3                     mov    %eax,%ebx
Code;  c0138930 <sys_newlstat+3c/70>
   c:   83 c4 04                  add    $0x4,%esp
Code;  c0138933 <sys_newlstat+3f/70>
   f:   eb 02                     jmp    13 <_EIP+0x13> c0138937 <sys_newls=
tat+43/70>
Code;  c0138935 <sys_newlstat+41/70>
  11:   31 db                     xor    %ebx,%ebx
Code;  c0138937 <sys_newlstat+43/70>
  13:   85 00                     test   %eax,(%eax)


1 warning issued.  Results may not be reliable.



ksymoops 2.3.4 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

<1>Unable to handle kernel paging request at virtual address 14b29e1c
c012aa7e
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012aa7e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 07aca781   ebx: ed99297c   ecx: f6000000   edx: 00000019
esi: c1e0b060   edi: 0000004e   ebp: f7ee7ec0   esp: f7ee5f10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=3Df7ee5000)
Stack: f7ee7c00 f6000620 00000282 00008507 00000286 f594f039 c1e0b068 c1e0b=
070=20
       c1000000 ffffff14 c012ae30 c1e0b060 f7ee7e00 0000007e d18b07a0 c8b25=
140=20
       e72bb620 f6000620 c014335e f6000620 0000001a 000001d0 00000020 00000=
006=20
Call Trace: [<c012ae30>] [<c014335e>] [<c0143663>] 2  0  1  13196   4660  6=
8212 536876   0   0  2106    72 1588  8257  59  27  15
 [<c012c1b2>] [<c012c1ec>]=20
   [<c012c283>] [<c012c2de>] [<c012c3ed>] [<c0105594>]=20
Code: 89 5c 81 18 89 41 14 8b 41 10 8d 50 ff 89 51 10 83 f8 01 75=20

>>EIP; c012aa7e <free_block+6e/dc>   <=3D=3D=3D=3D=3D
Trace; c012ae30 <kfree+68/90>
Trace; c014335e <prune_dcache+10a/160>
Trace; c0143663 <shrink_dcache_memory+1b/30>
Trace; c012c1b2 <shrink_caches+66/7c>
Trace; c012c1ec <try_to_free_pages+24/44>
Trace; c012c283 <kswapd_balance_pgdat+43/8c>
Trace; c012c2de <kswapd_balance+12/28>
Trace; c012c3ed <kswapd+99/bc>
Trace; c0105594 <kernel_thread+28/38>
Code;  c012aa7e <free_block+6e/dc>
00000000 <_EIP>:
Code;  c012aa7e <free_block+6e/dc>   <=3D=3D=3D=3D=3D
   0:   89 5c 81 18               mov    %ebx,0x18(%ecx,%eax,4)   <=3D=3D=
=3D=3D=3D
Code;  c012aa82 <free_block+72/dc>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012aa85 <free_block+75/dc>
   7:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c012aa88 <free_block+78/dc>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c012aa8b <free_block+7b/dc>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c012aa8e <free_block+7e/dc>
  10:   83 f8 01                  cmp    $0x1,%eax
Code;  c012aa91 <free_block+81/dc>
  13:   75 00                     jne    15 <_EIP+0x15> c012aa93 <free_bloc=
k+83/dc>


1 warning issued.  Results may not be reliable.




ksymoops 2.3.4 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

 NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c01f186c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000086
eax: c1e0b164   ebx: c1e0b060   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c0363e04
ds: 0018   es: 0018   ss: 0018
Process change_connid_2 (pid: 23608, stackpage=3Dc0363000)
Stack: 00000020 000001d2 00000020 00000006 c023a120 f7e5d600 f7ee8000 c1e0b=
164=20
       c02b49a8 00000000 c0363e30 c0363e30 c0362000 00000000 00000009 00000=
000=20
       00000000 00000000 c012c168 00000006 000001d2 c0238408 c0238408 c0238=
408=20
Call Trace: [<c012c168>] [<c012c1ec>] [<c012ca3c>] [<c012cc5c>] [<c012c9e2>=
]=20
   [<c01231dd>] [<c0123883>] [<c0112643>] [<c01124c8>] [<c0131e27>] [<c0131=
e8f>]=20
   [<c0106e4c>]=20
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c01f186c <stext_lock+180c/71b9>   <=3D=3D=3D=3D=3D
Trace; c012c168 <shrink_caches+1c/7c>
Trace; c012c1ec <try_to_free_pages+24/44>
Trace; c012ca3c <balance_classzone+58/170>
Trace; c012cc5c <__alloc_pages+108/168>
Trace; c012c9e2 <_alloc_pages+16/18>
Trace; c01231dd <do_wp_page+91/188>
Trace; c0123883 <handle_mm_fault+8b/bc>
Trace; c0112643 <do_page_fault+17b/4b8>
Trace; c01124c8 <do_page_fault+0/4b8>
Trace; c0131e27 <filp_close+9b/a4>
Trace; c0131e8f <sys_close+5f/74>
Trace; c0106e4c <error_code+34/3c>


2 warnings issued.  Results may not be reliable.



Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fgWLUaz2rXW+gJcRAg7vAJ9R9rcJblwKjN0vhNtwUCNaH4QLFQCgunrg
vI9f0OzMlIGikpjiDaZJMWM=
=+bTw
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
