Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270460AbTGPLyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270487AbTGPLyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:54:18 -0400
Received: from CPE-144-137-15-28.vic.bigpond.net.au ([144.137.15.28]:59545
	"EHLO lnk.wurley.net") by vger.kernel.org with ESMTP
	id S270460AbTGPLyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:54:07 -0400
From: "Deon George" <kernel@wurley.net>
To: linux-kernel@vger.kernel.org
Subject: please help - kernel OOPS
Date: Wed, 16 Jul 2003 22:08:56 +1000
Message-Id: <20030716120856.M31641@wurley.net>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 203.213.4.110 (deon@wurley.net)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day

I have been trying some mini-ITX v8000 systems and can get a kernel oops quite 
easily - most times it is to do with making file systems (reiserfs or ext2/3) or 
copying via the network (using rsync). Sometimes it happens when the box is 
booting, and other times it has gone for serveral days before it happened.

I have captured two oops - one when I used mke2fs and one for mkreiserfs (since it 
oops quite frequently when I make a file system). Does this mean anything to 
anybody?

(I've used the standard RH 7.3 kernel 2.4.18-3 and the updated RH 7.3 kernel 
2.4.20-18.7 - both have the same problems)

(Also, I've changed hardware - I've tried 2 motherboards, different memory, 
different disks and all the same results - Oops).

Please CC me if you know what it is - its driving me nuts!

This one is mke2fs:
[root@redback root]# cat /tmp/a|ksymoops -v /boot/vmlinux-2.4.18-3 -
m /boot/System.map-2.4.18-3 -o /lib/modules/2.4.18-3 -LK
ksymoops 2.4.4 on i686 2.4.18-WS.  Options used
     -v /boot/vmlinux-2.4.18-3 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.18-3 (specified)
     -m /boot/System.map-2.4.18-3 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address cbd3c040
c012c8b5
*pde = 00030063
Oops: 0002
CPU:    0
EIP:    0010:[<c012c8b5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000090   ebx: 000000c0   ecx: 0bd3c000   edx: cbd3c030
esi: c132d270   edi: 00000030   ebp: 00000020   esp: cd519d28
ds: 0018   es: 0018   ss: 0018
Process mke2fs (pid: 90, stackpage=cd519000)
Stack: 00000003 cbd3c000 cf5ee4f0 00000080 00000000 00000000 c132d270 00000246
       c132d278 c132d270 c012cb8c c132d270 00000020 c011afc3 00000046 00000000
       00000000 00002000 cd519d9c cd519dac cd358a00 c0134525 00000068 00000020
Call Trace: [<c012cb8c>] kmalloc [kernel] 0xf0
[<c011afc3>] do_softirq [kernel] 0x47
[<c0134525>] mempool_alloc [kernel] 0x49
[<d0816dad>] lvm_push_callback [lvm-mod] 0x1d
[<d0816d2d>] lvm_map [lvm-mod] 0x3d5
[<c011e6ef>] timer_bh [kernel] 0x20b
[<c011afc3>] do_softirq [kernel] 0x47
[<c010992c>] do_IRQ [kernel] 0x90
[<d0816e71>] lvm_make_request_fn [lvm-mod] 0xd
[<c0182581>] generic_make_request [kernel] 0x109
[<c01825e2>] submit_bh [kernel] 0x52
[<c0136dc1>] write_locked_buffers [kernel] 0x1d
[<c0136e75>] write_some_buffers [kernel] 0xa9
[<c0136eda>] write_unlocked_buffers [kernel] 0x12
[<c011e508>] timer_bh [kernel] 0x24
[<c0136feb>] sync_buffers [kernel] 0xf
[<c013b553>] __block_fsync [kernel] 0x1f
[<c01371dc>] sys_fsync [kernel] 0x54
[<c01085f7>] system_call [kernel] 0x33
Code: c7 42 10 00 00 00 00 89 5a 08 8b 44 24 04 01 d8 89 42 0c 89

>>EIP; c012c8b5 <kmem_cache_grow+ed/204>   <=====
Trace; c012cb8c <kmalloc+f0/114>
Trace; c011afc3 <do_softirq+47/8c>
Trace; c0134525 <mempool_alloc+49/134>
Trace; d0816dad <END_OF_CODE+104b2795/????>
Trace; d0816d2d <END_OF_CODE+104b2715/????>
Trace; c011e6ef <timer_bh+20b/244>
Trace; c011afc3 <do_softirq+47/8c>
Trace; c010992c <do_IRQ+90/9c>
Trace; d0816e71 <END_OF_CODE+104b2859/????>
Trace; c0182581 <generic_make_request+109/118>
Trace; c01825e2 <submit_bh+52/6c>
Trace; c0136dc1 <write_locked_buffers+1d/28>
Trace; c0136e75 <write_some_buffers+a9/fc>
Trace; c0136eda <write_unlocked_buffers+12/34>
Trace; c011e508 <timer_bh+24/244>
Trace; c0136feb <sync_buffers+f/40>
Trace; c013b553 <__block_fsync+1f/48>
Trace; c01371dc <sys_fsync+54/94>
Trace; c01085f7 <system_call+33/38>
Code;  c012c8b5 <kmem_cache_grow+ed/204>
00000000 <_EIP>:
Code;  c012c8b5 <kmem_cache_grow+ed/204>   <=====
   0:   c7 42 10 00 00 00 00      movl   $0x0,0x10(%edx)   <=====
Code;  c012c8bc <kmem_cache_grow+f4/204>
   7:   89 5a 08                  mov    %ebx,0x8(%edx)
Code;  c012c8bf <kmem_cache_grow+f7/204>
   a:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  c012c8c3 <kmem_cache_grow+fb/204>
   e:   01 d8                     add    %ebx,%eax
Code;  c012c8c5 <kmem_cache_grow+fd/204>
  10:   89 42 0c                  mov    %eax,0xc(%edx)
Code;  c012c8c8 <kmem_cache_grow+100/204>
  13:   89 00                     mov    %eax,(%eax)

This one is mkreiserfs
[root@redback root]# cat /tmp/b|ksymoops -v /boot/vmlinux-2.4.18-3 -
m /boot/System.map-2.4.18-3 -o /lib/modules/2.4.18-3 -LK
ksymoops 2.4.4 on i686 2.4.18-WS.  Options used
     -v /boot/vmlinux-2.4.18-3 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.18-3 (specified)
     -m /boot/System.map-2.4.18-3 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address cbd3c000
c02187d1
*pde = 00030063
Oops: 0002
CPU:    0
EIP:    0010:[<c02187d1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cbd3c000   ecx: 00001000   edx: 00000000
esi: 08064d50   edi: cbd3c000   ebp: c126703c   esp: cd519f20
ds: 0018   es: 0018   ss: 0018
Process mkreiserfs (pid: 51, stackpage=cd519000)
Stack: 00000000 00001000 cd519f54 00001000 00000001 00000000 00001000 00000000
       00000000 01239000 00000000 cd129a10 cd129ac4 00000000 c016a578 00000001
       c011e508 00000001 00330440 00000000 cf57d270 ffffffea 00001000 c0136085
Call Trace: [<c016a578>] write_chan [kernel] 0x0
[<c011e508>] timer_bh [kernel] 0x24
[<c0136085>] sys_write [kernel] 0x95
[<c010992c>] do_IRQ [kernel] 0x90
[<c01085f7>] system_call [kernel] 0x33
Code: f3 aa 58 59 e9 e4 19 f1 ff b8 f2 ff ff ff 30 d2 e9 d8 a8 f1

>>EIP; c02187d1 <zlib_inflate_flush+10a9/2d6c>   <=====
Trace; c016a578 <write_chan+0/1e0>
Trace; c011e508 <timer_bh+24/244>
Trace; c0136085 <sys_write+95/f4>
Trace; c010992c <do_IRQ+90/9c>
Trace; c01085f7 <system_call+33/38>
Code;  c02187d1 <zlib_inflate_flush+10a9/2d6c>
00000000 <_EIP>:
Code;  c02187d1 <zlib_inflate_flush+10a9/2d6c>   <=====
   0:   f3 aa                     repz stos %al,%es:(%edi)   <=====
Code;  c02187d3 <zlib_inflate_flush+10ab/2d6c>
   2:   58                        pop    %eax
Code;  c02187d4 <zlib_inflate_flush+10ac/2d6c>
   3:   59                        pop    %ecx
Code;  c02187d5 <zlib_inflate_flush+10ad/2d6c>
   4:   e9 e4 19 f1 ff            jmp    fff119ed <_EIP+0xfff119ed> c012a1be 
<generic_file_write+4d6/768>
Code;  c02187da <zlib_inflate_flush+10b2/2d6c>
   9:   b8 f2 ff ff ff            mov    $0xfffffff2,%eax
Code;  c02187df <zlib_inflate_flush+10b7/2d6c>
   e:   30 d2                     xor    %dl,%dl
Code;  c02187e1 <zlib_inflate_flush+10b9/2d6c>
  10:   e9 d8 a8 f1 00            jmp    f1a8ed <_EIP+0xf1a8ed> c11330be 
<END_OF_CODE+dceaa6/????>

...deon
Wurley Solutions
---
 _--_|\   | Deon George
/      \  | 
\_.--.*/  | 
      v   | This email coming to you from the 'burbs of Melbourne,
Australia.

