Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbQKMRDz>; Mon, 13 Nov 2000 12:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQKMRDp>; Mon, 13 Nov 2000 12:03:45 -0500
Received: from stampace.ca.astro.it ([192.167.8.50]:46256 "EHLO
	stampace.ca.astro.it") by vger.kernel.org with ESMTP
	id <S129577AbQKMRDn>; Mon, 13 Nov 2000 12:03:43 -0500
Date: Mon, 13 Nov 2000 18:03:39 +0100 (CET)
From: Giacomo Mulas <gmulas@ca.astro.it>
To: linux-kernel@vger.kernel.org
cc: gmulas@ca.astro.it
Subject: BUG in 2.4.0-t10
Message-ID: <Pine.LNX.4.21.0011131719590.32616-100000@stampace.ca.astro.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I stumbled across a BUG in the 2.4.0.t10 kernel. It occurs after
some time and after some days of number crunching and disk usage. It is
triggered most frequently by tripwire runs after upgrades, which actually
stress both the disk and the CPU (calculating signatures).

Here is the output of ver_linux:
Linux serverlx 2.4.0-test10 #1 Fri Nov 3 13:52:55 CET 2000 i586 unknown
Kernel modules         2.3.17
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         nfsd soundcore autofs rtc ipt_REJECT iptable_filter
serial isa-pnp usb-ohci usbcore ip_conntrack_ftp ip_conntrack ip_tables
ipx nfs lockd sunrpc de4x5

Here is the relevant snippet of dmesg:
nfs warning: mount version older than kernel
kernel BUG at page_alloc.c:214!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012a0da>]
EFLAGS: 00010286
eax: 00000020   ebx: c1361a04   ecx: c27c0000   edx: c0360160
esi: 00000001   edi: c0270f80   ebp: 00000000   esp: c27c1ed0
ds: 0018   es: 0018   ss: 0018
Process tripwire (pid: 29734, stackpage=c27c1000)
Stack: c02190ea c0219398 000000d6 c0270f58 c0271130 00000002 00000000
0000bbad 
       00000282 00000000 c0270f58 c012a18a 00000000 c0271138 00000000
00000000 
       c012a2cc c027112c 00000000 00000002 00000001 00000000 00000000
c49e19fc 
Call Trace: [<c02190ea>] [<c0219398>] [<c012a18a>] [<c012a2cc>]
[<c01232b3>] [<c0123521>] [<c0123460>] 
       [<c012d925>] [<c010a2f3>] 
Code: 0f 0b 83 c4 0c 90 89 d8 eb 14 47 83 c6 0c 83 ff 09 0f 86 ef 
kernel BUG at page_alloc.c:84!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129bc9>]
EFLAGS: 00010282
eax: 0000001f   ebx: c1361a04   ecx: c15e8000   edx: 00000000
esi: c1361a20   edi: 00005561   ebp: 00000000   esp: c15e9f80
ds: 0018   es: 0018   ss: 0018
Process kflushd (pid: 5, stackpage=c15e9000)
Stack: c02190ea c0219398 00000054 c1361a04 c1361a20 00005561 00000007
00005561 
       00000006 00000000 00000001 c0128d75 c012a4db c0128f3b 00000000
00000001 
       c15e8000 0008e000 00000000 00000000 00000000 00000000 c013127e
00000003 
Call Trace: [<c02190ea>] [<c0219398>] [<c0128d75>] [<c012a4db>]
[<c0128f3b>] [<c013127e>] [<c01089cc>] 
Code: 0f 0b 83 c4 0c 89 f6 89 d8 2b 05 b8 6e 2e c0 69 c0 f1 f0 f0 
kernel BUG at vmscan.c:532!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0128a9d>]
EFLAGS: 00010286
eax: 0000001c   ebx: c1361a20   ecx: cb88c000   edx: c0360160
esi: c1361a04   edi: c1daccdc   ebp: 000001dd   esp: cb88de18
ds: 0018   es: 0018   ss: 0018
Process tripwire (pid: 30247, stackpage=cb88d000)
Stack: c021896a c0218c09 00000214 c0270f58 c0271158 00000001 00000000
c012a178 
       c0270f58 00000000 c0271160 00000000 00000007 c012a2e9 c0271154
00000000 
       00000001 00000001 00000040 00000007 c144c0c0 00000007 00000007
00000001 
Call Trace: [<c021896a>] [<c0218c09>] [<c012a178>] [<c012a2e9>]
[<c012a490>] [<c012722a>] [<c01273c0>] 
       [<c013fca1>] [<c013ff66>] [<c014fd71>] [<c0137083>] [<c0137767>]
[<c0137d4a>] [<c0134bb1>] [<c012d677>] 
       [<c010a2f3>] 
Code: 0f 0b 83 c4 0c 31 c0 0f b3 46 18 8d 4e 28 8d 46 2c 39 46 2c 


And here is the output of ksymoops:

ksymoops 2.3.4 on i586 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map-2.4.0-test10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012a0da>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000020   ebx: c1361a04   ecx: c27c0000   edx: c0360160
esi: 00000001   edi: c0270f80   ebp: 00000000   esp: c27c1ed0
ds: 0018   es: 0018   ss: 0018
Process tripwire (pid: 29734, stackpage=c27c1000)
Stack: c02190ea c0219398 000000d6 c0270f58 c0271130 00000002 00000000 0000bbad 
       00000282 00000000 c0270f58 c012a18a 00000000 c0271138 00000000 00000000 
       c012a2cc c027112c 00000000 00000002 00000001 00000000 00000000 c49e19fc 
Call Trace: [<c02190ea>] [<c0219398>] [<c012a18a>] [<c012a2cc>] [<c01232b3>] [<c0123521>] [<c0123460>] 
       [<c012d925>] [<c010a2f3>] 
Code: 0f 0b 83 c4 0c 90 89 d8 eb 14 47 83 c6 0c 83 ff 09 0f 86 ef 

>>EIP; c012a0da <rmqueue+222/248>   <=====
Trace; c02190ea <tvecs+2a9e/ebdc>
Trace; c0219398 <tvecs+2d4c/ebdc>
Trace; c012a18a <__alloc_pages_limit+8a/ac>
Trace; c012a2cc <__alloc_pages+120/2d0>
Trace; c01232b3 <do_generic_file_read+35b/508>
Trace; c0123521 <generic_file_read+59/74>
Trace; c0123460 <file_read_actor+0/68>
Trace; c012d925 <sys_read+95/cc>
Trace; c010a2f3 <system_call+33/40>
Code;  c012a0da <rmqueue+222/248>
00000000 <_EIP>:
Code;  c012a0da <rmqueue+222/248>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a0dc <rmqueue+224/248>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012a0df <rmqueue+227/248>
   5:   90                        nop    
Code;  c012a0e0 <rmqueue+228/248>
   6:   89 d8                     mov    %ebx,%eax
Code;  c012a0e2 <rmqueue+22a/248>
   8:   eb 14                     jmp    1e <_EIP+0x1e> c012a0f8 <rmqueue+240/248>
Code;  c012a0e4 <rmqueue+22c/248>
   a:   47                        inc    %edi
Code;  c012a0e5 <rmqueue+22d/248>
   b:   83 c6 0c                  add    $0xc,%esi
Code;  c012a0e8 <rmqueue+230/248>
   e:   83 ff 09                  cmp    $0x9,%edi
Code;  c012a0eb <rmqueue+233/248>
  11:   0f 86 ef 00 00 00         jbe    106 <_EIP+0x106> c012a1e0 <__alloc_pages+34/2d0>

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129bc9>]
EFLAGS: 00010282
eax: 0000001f   ebx: c1361a04   ecx: c15e8000   edx: 00000000
esi: c1361a20   edi: 00005561   ebp: 00000000   esp: c15e9f80
ds: 0018   es: 0018   ss: 0018
Process kflushd (pid: 5, stackpage=c15e9000)
Stack: c02190ea c0219398 00000054 c1361a04 c1361a20 00005561 00000007 00005561 
       00000006 00000000 00000001 c0128d75 c012a4db c0128f3b 00000000 00000001 
       c15e8000 0008e000 00000000 00000000 00000000 00000000 c013127e 00000003 
Call Trace: [<c02190ea>] [<c0219398>] [<c0128d75>] [<c012a4db>] [<c0128f3b>] [<c013127e>] [<c01089cc>] 
Code: 0f 0b 83 c4 0c 89 f6 89 d8 2b 05 b8 6e 2e c0 69 c0 f1 f0 f0 

>>EIP; c0129bc9 <__free_pages_ok+49/338>   <=====
Trace; c02190ea <tvecs+2a9e/ebdc>
Trace; c0219398 <tvecs+2d4c/ebdc>
Trace; c0128d75 <page_launder+285/700>
Trace; c012a4db <__free_pages+13/14>
Trace; c0128f3b <page_launder+44b/700>
Trace; c013127e <bdflush+86/10c>
Trace; c01089cc <kernel_thread+28/38>
Code;  c0129bc9 <__free_pages_ok+49/338>
00000000 <_EIP>:
Code;  c0129bc9 <__free_pages_ok+49/338>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129bcb <__free_pages_ok+4b/338>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0129bce <__free_pages_ok+4e/338>
   5:   89 f6                     mov    %esi,%esi
Code;  c0129bd0 <__free_pages_ok+50/338>
   7:   89 d8                     mov    %ebx,%eax
Code;  c0129bd2 <__free_pages_ok+52/338>
   9:   2b 05 b8 6e 2e c0         sub    0xc02e6eb8,%eax
Code;  c0129bd8 <__free_pages_ok+58/338>
   f:   69 c0 f1 f0 f0 00         imul   $0xf0f0f1,%eax,%eax

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0128a9d>]
EFLAGS: 00010286
eax: 0000001c   ebx: c1361a20   ecx: cb88c000   edx: c0360160
esi: c1361a04   edi: c1daccdc   ebp: 000001dd   esp: cb88de18
ds: 0018   es: 0018   ss: 0018
Process tripwire (pid: 30247, stackpage=cb88d000)
Stack: c021896a c0218c09 00000214 c0270f58 c0271158 00000001 00000000 c012a178 
       c0270f58 00000000 c0271160 00000000 00000007 c012a2e9 c0271154 00000000 
       00000001 00000001 00000040 00000007 c144c0c0 00000007 00000007 00000001 
Call Trace: [<c021896a>] [<c0218c09>] [<c012a178>] [<c012a2e9>] [<c012a490>] [<c012722a>] [<c01273c0>] 
       [<c013fca1>] [<c013ff66>] [<c014fd71>] [<c0137083>] [<c0137767>] [<c0137d4a>] [<c0134bb1>] [<c012d677>] 
       [<c010a2f3>] 
Code: 0f 0b 83 c4 0c 31 c0 0f b3 46 18 8d 4e 28 8d 46 2c 39 46 2c 

>>EIP; c0128a9d <reclaim_page+355/3a8>   <=====
Trace; c021896a <tvecs+231e/ebdc>
Trace; c0218c09 <tvecs+25bd/ebdc>
Trace; c012a178 <__alloc_pages_limit+78/ac>
Trace; c012a2e9 <__alloc_pages+13d/2d0>
Trace; c012a490 <__get_free_pages+14/20>
Trace; c012722a <kmem_cache_grow+b6/208>
Trace; c01273c0 <kmem_cache_alloc+44/54>
Trace; c013fca1 <get_new_inode+19/140>
Trace; c013ff66 <iget4+c2/d4>
Trace; c014fd71 <ext2_lookup+59/80>
Trace; c0137083 <real_lookup+4f/bc>
Trace; c0137767 <path_walk+53f/778>
Trace; c0137d4a <__user_walk+3a/54>
Trace; c0134bb1 <sys_newlstat+15/70>
Trace; c012d677 <sys_close+43/54>
Trace; c010a2f3 <system_call+33/40>
Code;  c0128a9d <reclaim_page+355/3a8>
00000000 <_EIP>:
Code;  c0128a9d <reclaim_page+355/3a8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0128a9f <reclaim_page+357/3a8>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0128aa2 <reclaim_page+35a/3a8>
   5:   31 c0                     xor    %eax,%eax
Code;  c0128aa4 <reclaim_page+35c/3a8>
   7:   0f b3 46 18               btr    %eax,0x18(%esi)
Code;  c0128aa8 <reclaim_page+360/3a8>
   b:   8d 4e 28                  lea    0x28(%esi),%ecx
Code;  c0128aab <reclaim_page+363/3a8>
   e:   8d 46 2c                  lea    0x2c(%esi),%eax
Code;  c0128aae <reclaim_page+366/3a8>
  11:   39 46 2c                  cmp    %eax,0x2c(%esi)


1 warning issued.  Results may not be reliable.

I hope I gave enough information to track down the problem. Let me know if
any more information/test are wanted to squash this bug, I will gladly
help. I am a developer, although not a kernel developer.

Thanks in advance

Giacomo Mulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
