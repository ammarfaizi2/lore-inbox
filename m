Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbRGKQi7>; Wed, 11 Jul 2001 12:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbRGKQit>; Wed, 11 Jul 2001 12:38:49 -0400
Received: from james.kalifornia.com ([208.179.59.2]:25133 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S267349AbRGKQig>; Wed, 11 Jul 2001 12:38:36 -0400
Message-ID: <3B4C810A.8070500@blue-labs.org>
Date: Wed, 11 Jul 2001 12:38:34 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010710
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at slab.c:1244! (and slab.c:580)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm.  Third time I've reported this, it's happened since the early 2.4 
kernels and I can get at least one every day or so.  The odd thing is 
that the first oops normally happens within a couple hours after boot 
but it may take weeks before another oops will happen.  The oops always 
has a trace similar to below.  The second oops is new to me, it happened 
last night and I haven't seen it before, culled from syslog.

# uname -r
2.4.5-ac15

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0126223>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001b   ebx: c13bf768   ecx: c033e280   edx: 0000285e
esi: cca5d000   edi: 00001000   ebp: 00000246   esp: c9df3de8
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 17971, stackpage=c9df3000)
Stack: c02be985 000004dc ca20e604 c03cffc0 00000007 00000002 00001000 
cca5d000
       c025ad46 00000dbc 00000007 cae69820 00000000 c9df2000 c025a560 
00000d80
       00000007 c9df3e98 00000d66 cae68834 ca6dfe94 c02a909a cae69820 
00000d66
Call Trace: [<c025ad46>] [<c025a560>] [<c02a909a>] [<c0258424>] 
[<c025907e>]
   [<c01109f8>] [<c0110b5b>] [<c01109f8>] [<c0121e49>] [<c02590b5>] 
[<c025980b>]
 
   [<c0107a6d>] [<c0106ac7>]
Code: 0f 0b 83 c4 08 f6 43 11 04 74 55 b8 a5 c2 0f 17 87 46 00 3d

 >>EIP; c0126223 <kmalloc+123/1bc>   <=====
Trace; c025ad46 <alloc_skb+da/18c>
Trace; c025a560 <sock_alloc_send_skb+64/e8>
Trace; c02a909a <unix_stream_sendmsg+102/2ec>
Trace; c0258424 <sock_sendmsg+68/88>
Trace; c025907e <sys_sendto+c6/e4>
Trace; c01109f8 <do_page_fault+0/454>
Trace; c0110b5b <do_page_fault+163/454>
Trace; c01109f8 <do_page_fault+0/454>
Trace; c0121e49 <generic_file_read+61/7c>
Trace; c02590b5 <sys_send+19/20>
Trace; c025980b <sys_socketcall+103/1bc>
Trace; c0107a6d <math_state_restore+19/34>
Trace; c0106ac7 <system_call+37/40>
Code;  c0126223 <kmalloc+123/1bc>
00000000 <_EIP>:
Code;  c0126223 <kmalloc+123/1bc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0126225 <kmalloc+125/1bc>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0126228 <kmalloc+128/1bc>
   5:   f6 43 11 04               testb  $0x4,0x11(%ebx)
Code;  c012622c <kmalloc+12c/1bc>
   9:   74 55                     je     60 <_EIP+0x60> c0126283 
<kmalloc+183/1bc>
Code;  c012622e <kmalloc+12e/1bc>
   b:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
Code;  c0126233 <kmalloc+133/1bc>
  10:   87 46 00                  xchg   %eax,0x0(%esi)
Code;  c0126236 <kmalloc+136/1bc>
  13:   3d 00 00 00 00            cmp    $0x0,%eax

 kernel BUG at slab.c:580!
invalid operand: 0000
CPU:    0
EIP:    0010:[vmfree_area_pages+239/396]
EFLAGS: 00010286
eax: 0000001a   ebx: c13bf768   ecx: c033e280   edx: 00002950
esi: 00000000   edi: 00001000   ebp: c880b44c   esp: cdf67f78
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=cdf67000)
Stack: c02be985 00000244 00000000 00000001 00000000 c13bf768 00001000 
c5a5c000
       c0126965 c13bf768 c880b44c 00000004 0000019b cdf66239 0008e000 
c13bf6ec
       c03ad22c 00000000 00000001 00000001 c01284e8 00000004 cdf66000 
c02bf1b1
Call Trace: [kmalloc+145/448] [page_launder+812/2012] 
[page_launder+903/2012] [flush_thread+8/64]
Code: 0f 0b 83 c4 08 46 3b 73 14 0f 82 1a ff ff ff 8b 45 08 8b 75

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a  
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   46                        inc    %esi
Code;  00000006 Before first symbol
   6:   3b 73 14                  cmp    0x14(%ebx),%esi
Code;  00000009 Before first symbol
   9:   0f 82 1a ff ff ff         jb     ffffff29 <_EIP+0xffffff29> 
ffffff29 <END_OF_CODE+3fc11c55/????>
Code;  0000000f Before first symbol
   f:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  00000012 Before first symbol
  12:   8b 75 00                  mov    0x0(%ebp),%esi


