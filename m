Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263461AbTCNTRP>; Fri, 14 Mar 2003 14:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263463AbTCNTRP>; Fri, 14 Mar 2003 14:17:15 -0500
Received: from ponyexpress1.seisint.com ([209.243.55.188]:18436 "EHLO
	PONYEXPRESS.Seisint.com") by vger.kernel.org with ESMTP
	id <S263461AbTCNTRK> convert rfc822-to-8bit; Fri, 14 Mar 2003 14:17:10 -0500
Message-ID: <9B50B310A51FB74FA053703945DB7400099D3B3C@ponyexpress.seisint.com>
From: "Villanustre, Flavio" <FVillanustre@seisint.com>
To: linux-kernel@vger.kernel.org
Subject: linux 2.4.20 oops report 642911
Date: Fri, 14 Mar 2003 14:27:09 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got an Oops message in kernel 2.4.20 this morning. The server is a brand
new Pentium III single processor Dell Blade 1655MC server, with 2GB of RAM
and SCSI hard drives. There are two 512 MB swap partitions allocated (one
per hard drive) and mounted.

The application (thorslave) apparently was trying to allocate memory, and
instead of getting some out_of_memory condition, the kernel triggered an
Oops.

The ksymoops results follow.

Can anybody provide some light to it? Is there any known bug in kernel
2.4.20 related to this Oops that got fixed in the 2.4.21pre versions?

Thank you,

Flavio Villanustre


[root@MommaBlade root]# ksymoops -v /usr/src/linux-2.4.20/vmlinux -K -L -O
-m /u
sr/src/linux-2.4.20/System.map < /thor/19_142.txt
ksymoops 2.4.4 on i686 2.4.20.  Options used
     -v /usr/src/linux-2.4.20/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux-2.4.20/System.map (specified)
 
Unable to handle kernel paging request at virtual address 071ac774
c01214fc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01214fc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 071ac774   ebx: f5ac2864   ecx: f5ac2864   edx: 000000c2
esi: 0004212c   edi: 000000c2   ebp: 071ac774   esp: dc33be60
ds: 0018   es: 0018   ss: 0018
Process thorslave (pid: 14960, stackpage=dc33b000)
Stack: c01226dc f5ac2864 000000c2 071ac774 0004212c f5aa63c0 f5ac2864
c1c5c3a0
       c1000020 c011ee53 00000001 00000001 420c2d50 c0122620 f5ac2820
f39f3320
       c011eec1 f39f3320 420c2000 00000000 420c2d50 00000000 f5ac2820
f39f3320
Call Trace:    [<c01226dc>] [<c011ee53>] [<c0122620>] [<c011eec1>]
[<c011f078>]
  [<c011009a>] [<c012206c>] [<c0121f20>] [<c012e6f2>] [<c012e5fc>]
[<c010ff20>]
  [<c0108a04>]
Code: 8b 00 eb 03 8b 40 10 85 c0 74 0a 39 48 08 75 f4 39 50 0c 75
 
>>EIP; c01214fc <__find_get_page+c/30>   <=====
Trace; c01226dc <filemap_nopage+bc/210>
Trace; c011ee53 <do_anonymous_page+d3/f0>
Trace; c0122620 <filemap_nopage+0/210>
Trace; c011eec1 <do_no_page+51/1b0>
Trace; c011f078 <handle_mm_fault+58/c0>
Trace; c011009a <do_page_fault+17a/4ab>
Trace; c012206c <generic_file_read+7c/110>
Trace; c0121f20 <file_read_actor+0/d0>
Trace; c012e6f2 <sys_read+e2/f0>
Trace; c012e5fc <sys_llseek+cc/e0>
Trace; c010ff20 <do_page_fault+0/4ab>
Trace; c0108a04 <error_code+34/3c>
Code;  c01214fc <__find_get_page+c/30>
00000000 <_EIP>:
Code;  c01214fc <__find_get_page+c/30>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c01214fe <__find_get_page+e/30>
   2:   eb 03                     jmp    7 <_EIP+0x7> c0121503
<__find_get_page+
13/30>
Code;  c0121500 <__find_get_page+10/30>
   4:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c0121503 <__find_get_page+13/30>
   7:   85 c0                     test   %eax,%eax
Code;  c0121505 <__find_get_page+15/30>
   9:   74 0a                     je     15 <_EIP+0x15> c0121511
<__find_get_pag
e+21/30>
Code;  c0121507 <__find_get_page+17/30>
   b:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  c012150a <__find_get_page+1a/30>
   e:   75 f4                     jne    4 <_EIP+0x4> c0121500
<__find_get_page+
10/30>
Code;  c012150c <__find_get_page+1c/30>
  10:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  c012150f <__find_get_page+1f/30>
  13:   75 00                     jne    15 <_EIP+0x15> c0121511
<__find_get_pag
e+21/30>
 
 <1>Unable to handle kernel paging request at virtual address 0718ee50
c01214fc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01214fc>]    Not tainted
EFLAGS: 00010292
eax: 0718ee50   ebx: f58ebb64   ecx: f58ebb64   edx: 0000002d
esi: 0004212c   edi: 0000002d   ebp: 0718ee50   esp: f3abfe60
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 128, stackpage=f3abf000)
Stack: c01226dc f58ebb64 0000002d 0718ee50 0004212c f5aa63c0 f58ebb64
f58e5c60
       f2eba620 f3b5b0a0 7fffffff c01dd072 4202d5c4 c0122620 f5ac24a0
f58f1ec0
       c011eec1 f58f1ec0 4202d000 00000000 4202d5c4 00000000 f5ac24a0
f58f1ec0
Call Trace:    [<c01226dc>] [<c01dd072>] [<c0122620>] [<c011eec1>]
[<c011f078>]
  [<c01da5dc>] [<c011009a>] [<c01da7f7>] [<c012e7e2>] [<c0115402>]
[<c010ff20>]
  [<c0108a04>]
Code: 8b 00 eb 03 8b 40 10 85 c0 74 0a 39 48 08 75 f4 39 50 0c 75
 
>>EIP; c01214fc <__find_get_page+c/30>   <=====
Trace; c01226dc <filemap_nopage+bc/210>
Trace; c01dd072 <sock_def_readable+22/50>
Trace; c0122620 <filemap_nopage+0/210>
Trace; c011eec1 <do_no_page+51/1b0>
Trace; c011f078 <handle_mm_fault+58/c0>
Trace; c01da5dc <sock_sendmsg+6c/90>
Trace; c011009a <do_page_fault+17a/4ab>
Trace; c01da7f7 <sock_write+a7/c0>
Trace; c012e7e2 <sys_write+e2/f0>
Trace; c0115402 <sys_time+12/60>
Trace; c010ff20 <do_page_fault+0/4ab>
Trace; c0108a04 <error_code+34/3c>
Code;  c01214fc <__find_get_page+c/30>
00000000 <_EIP>:
Code;  c01214fc <__find_get_page+c/30>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c01214fe <__find_get_page+e/30>
   2:   eb 03                     jmp    7 <_EIP+0x7> c0121503
<__find_get_page+
13/30>
Code;  c0121500 <__find_get_page+10/30>
   4:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c0121503 <__find_get_page+13/30>
   7:   85 c0                     test   %eax,%eax
Code;  c0121505 <__find_get_page+15/30>
   9:   74 0a                     je     15 <_EIP+0x15> c0121511
<__find_get_pag
e+21/30>
Code;  c0121507 <__find_get_page+17/30>
   b:   39 48 08                  cmp   
%ecx,0x8(%eax)                                                              
            
Code;  c012150a <__find_get_page+1a/30>
   e:   75 f4                     jne    4 <_EIP+0x4> c0121500
<__find_get_page+
10/30>
Code;  c012150c <__find_get_page+1c/30>
  10:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  c012150f <__find_get_page+1f/30>
  13:   75 00                     jne    15 <_EIP+0x15> c0121511
<__find_get_pag
e+21/30>
 
