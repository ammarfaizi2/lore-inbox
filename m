Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264300AbRFSPgu>; Tue, 19 Jun 2001 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264320AbRFSPgb>; Tue, 19 Jun 2001 11:36:31 -0400
Received: from james.kalifornia.com ([208.179.59.2]:27957 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S264300AbRFSPgO>; Tue, 19 Jun 2001 11:36:14 -0400
Message-ID: <3B2F715A.7040301@blue-labs.org>
Date: Tue, 19 Jun 2001 08:35:54 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010618
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Justin Guyett <justin@soze.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
In-Reply-To: <E15CHtN-0005gC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server on ac12 and it crashes nearly every day, BUG in slab.c:1244.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01261f3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001b   ebx: c13bf768   ecx: c033e160   edx: 0000262a
esi: c9a5e000   edi: 00001000   ebp: 00000246   esp: ca1ddf2c
ds: 0018   es: 0018   ss: 0018
Process proftpd (pid: 27352, stackpage=ca1dd000)
Stack: c02beba5 000004dc c596faa0 00000000 c596fbac c596fb78 00001000 
c9a5e000
       c027c042 00000810 00000007 c596faa0 c35f2b54 ffffffea bffff39c 
00000004
       c0293d2e c596faa0 c35f2b54 00000001 080628b8 c025919b c35f2b54 
00000001
Call Trace: [<c027c042>] [<c0293d2e>] [<c025919b>] [<c0259b8e>] 
[<c0259bf3>]
   [<c0106aa7>]
Code: 0f 0b 83 c4 08 f6 43 11 04 74 55 b8 a5 c2 0f 17 87 46 00 3d

 >>EIP; c01261f3 <kmalloc+123/1bc>   <=====
Trace; c027c042 <tcp_listen_start+5e/144>
Trace; c0293d2e <inet_listen+5a/bc>
Trace; c025919b <sys_listen+37/50>
Trace; c0259b8e <sys_socketcall+32/1bc>
Trace; c0259bf3 <sys_socketcall+97/1bc>
Trace; c0106aa7 <system_call+37/40>
Code;  c01261f3 <kmalloc+123/1bc>
00000000 <_EIP>:
Code;  c01261f3 <kmalloc+123/1bc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01261f5 <kmalloc+125/1bc>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c01261f8 <kmalloc+128/1bc>
   5:   f6 43 11 04               testb  $0x4,0x11(%ebx)
Code;  c01261fc <kmalloc+12c/1bc>
   9:   74 55                     je     60 <_EIP+0x60> c0126253 
<kmalloc+183/1bc>
Code;  c01261fe <kmalloc+12e/1bc>
   b:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
Code;  c0126203 <kmalloc+133/1bc>
  10:   87 46 00                  xchg   %eax,0x0(%esi)
Code;  c0126206 <kmalloc+136/1bc>
  13:   3d 00 00 00 00            cmp    $0x0,%eax


It's the same bug as the previous kernel I tried running, ac8 was it..

-d


Alan Cox wrote:

>>This after only using ac15 for a few hours... I've never seen anything
>>like that with ac13, which I've used for days.
>>
>
>Is ac14 stable for you ?
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


