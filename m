Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRCLKRs>; Mon, 12 Mar 2001 05:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRCLKR3>; Mon, 12 Mar 2001 05:17:29 -0500
Received: from tunis.seriat.fr ([192.70.119.3]:10800 "EHLO tunis.seriat.fr")
	by vger.kernel.org with ESMTP id <S129669AbRCLKRV>;
	Mon, 12 Mar 2001 05:17:21 -0500
Message-ID: <000f01c0aadd$518aa930$6e7746c0@seriat.fr>
From: "Pierre Doritch" <doritch@seriat.fr>
To: <linux-kernel@vger.kernel.org>
Subject: kernel crash with 2.4.2
Date: Mon, 12 Mar 2001 11:15:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hy,

I post a kernel crash in this adress last week. (see
pierre.doritch@caramail.com  it's me!)
Now that i had the crash another times, i used the program ksymoops to trace
the problem.
I use a 2.4.2 Linux kernel on a i586 (Pentium 133Mhz)



Here is the /var/log/syslog trace:

Mar 10 04:40:02 palerme kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar 10 04:40:02 palerme kernel: *pde = 00000000
Mar 11 04:40:02 palerme kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar 11 04:40:02 palerme kernel: *pde = 00000000
Mar 12 04:40:02 palerme kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar 12 04:40:02 palerme kernel: *pde = 00000000


I use a Slackware Linux distribution. With Slackware the crontab execute the
command
updatedb each day at 4:40 am.


I used this command to generate the ksymoops output :
dmesg > dmesg_output; ksymoops < dmesg_output

There is no modules in the kernel.

Hope it will be helpfull.

Pierre



ksymoops 2.3.7 on i586 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Intel Pentium with F0 0F bug - workaround enabled.
Uhhuh. NMI received. Dazed and confused, but trying to continue
Uhhuh. NMI received for unknown reason 35.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013f084
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f084>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: c11cac30   ebx: ffffffe8   ecx: 0000000e   edx: c11c0000
esi: 3af9f1c1   edi: c58d3f68   ebp: 00000000   esp: c58d3f04
ds: 0018   es: 0018   ss: 0018
Process find (pid: 6064, stackpage=c58d3000)
Stack: 3af9f1c1 00000000 c58d3f68 c1cc800b c11cac30 c1cc8000 3af9f1c1
0000000b
       c0137000 c0cbf8c0 c58d3f68 3af9f1c1 c01377f8 c0cbf8c0 c58d3f68
00000000
       c1cc8000 00000000 c58d3fa4 bffff4e0 c58d2000 c0136e20 c58d2000
00000008
Call Trace: [<c0137000>] [<c01377f8>] [<c0136e20>] [<c0137e34>] [<c0134aee>]
[<c012d1cf>] [<c0108e13>]
Code: 8b 6d 00 8b 74 24 18 39 73 48 75 78 8b 74 24 24 39 73 0c 75

>>EIP; c013f084 <d_lookup+60/fc>   <=====
Trace; c0137000 <cached_lookup+10/54>
Trace; c01377f8 <path_walk+5b4/83c>
Trace; c0136e20 <getname+5c/a0>
Trace; c0137e34 <__user_walk+3c/58>
Trace; c0134aee <sys_newlstat+16/74>
Trace; c012d1cf <sys_close+43/54>
Trace; c0108e13 <system_call+33/40>
Code;  c013f084 <d_lookup+60/fc>
00000000 <_EIP>:
Code;  c013f084 <d_lookup+60/fc>   <=====
   0:   8b 6d 00                  movl   0x0(%ebp),%ebp   <=====
Code;  c013f087 <d_lookup+63/fc>
   3:   8b 74 24 18               movl   0x18(%esp,1),%esi
Code;  c013f08b <d_lookup+67/fc>
   7:   39 73 48                  cmpl   %esi,0x48(%ebx)
Code;  c013f08e <d_lookup+6a/fc>
   a:   75 78                     jne    84 <_EIP+0x84> c013f108
<d_lookup+e4/fc>
Code;  c013f090 <d_lookup+6c/fc>
   c:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c013f094 <d_lookup+70/fc>
  10:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c013f097 <d_lookup+73/fc>
  13:   75 00                     jne    15 <_EIP+0x15> c013f099
<d_lookup+75/fc>

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013f084
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f084>]
EFLAGS: 00010203
eax: c11cac30   ebx: ffffffe8   ecx: 0000000e   edx: c11c0000
esi: 3af9f1c1   edi: c1cb9f68   ebp: 00000000   esp: c1cb9f04
ds: 0018   es: 0018   ss: 0018
Process find (pid: 6844, stackpage=c1cb9000)
Stack: 3af9f1c1 00000000 c1cb9f68 c371400b c11cac30 c3714000 3af9f1c1
0000000b
       c0137000 c0cbf8c0 c1cb9f68 3af9f1c1 c01377f8 c0cbf8c0 c1cb9f68
00000000
       c3714000 00000000 c1cb9fa4 bffff4e0 c1cb8000 c0136e20 c1cb8000
00000008
Call Trace: [<c0137000>] [<c01377f8>] [<c0136e20>] [<c0137e34>] [<c0134aee>]
[<c012d1cf>] [<c0108e13>]
Code: 8b 6d 00 8b 74 24 18 39 73 48 75 78 8b 74 24 24 39 73 0c 75

>>EIP; c013f084 <d_lookup+60/fc>   <=====
Trace; c0137000 <cached_lookup+10/54>
Trace; c01377f8 <path_walk+5b4/83c>
Trace; c0136e20 <getname+5c/a0>
Trace; c0137e34 <__user_walk+3c/58>
Trace; c0134aee <sys_newlstat+16/74>
Trace; c012d1cf <sys_close+43/54>
Trace; c0108e13 <system_call+33/40>
Code;  c013f084 <d_lookup+60/fc>
00000000 <_EIP>:
Code;  c013f084 <d_lookup+60/fc>   <=====
   0:   8b 6d 00                  movl   0x0(%ebp),%ebp   <=====
Code;  c013f087 <d_lookup+63/fc>
   3:   8b 74 24 18               movl   0x18(%esp,1),%esi
Code;  c013f08b <d_lookup+67/fc>
   7:   39 73 48                  cmpl   %esi,0x48(%ebx)
Code;  c013f08e <d_lookup+6a/fc>
   a:   75 78                     jne    84 <_EIP+0x84> c013f108
<d_lookup+e4/fc>
Code;  c013f090 <d_lookup+6c/fc>
   c:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c013f094 <d_lookup+70/fc>
  10:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c013f097 <d_lookup+73/fc>
  13:   75 00                     jne    15 <_EIP+0x15> c013f099
<d_lookup+75/fc>

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013f084
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f084>]
EFLAGS: 00010203
eax: c11cac30   ebx: ffffffe8   ecx: 0000000e   edx: c11c0000
esi: 3af9f1c1   edi: c1cb9f68   ebp: 00000000   esp: c1cb9f04
ds: 0018   es: 0018   ss: 0018
Process find (pid: 7624, stackpage=c1cb9000)
Stack: 3af9f1c1 00000000 c1cb9f68 c1de000b c11cac30 c1de0000 3af9f1c1
0000000b
       c0137000 c0cbf8c0 c1cb9f68 3af9f1c1 c01377f8 c0cbf8c0 c1cb9f68
00000000
       c1de0000 00000000 c1cb9fa4 bffff4e0 c1cb8000 c0136e20 c1cb8000
00000008
Call Trace: [<c0137000>] [<c01377f8>] [<c0136e20>] [<c0137e34>] [<c0134aee>]
[<c012d1cf>] [<c0108e13>]
Code: 8b 6d 00 8b 74 24 18 39 73 48 75 78 8b 74 24 24 39 73 0c 75

>>EIP; c013f084 <d_lookup+60/fc>   <=====
Trace; c0137000 <cached_lookup+10/54>
Trace; c01377f8 <path_walk+5b4/83c>
Trace; c0136e20 <getname+5c/a0>
Trace; c0137e34 <__user_walk+3c/58>
Trace; c0134aee <sys_newlstat+16/74>
Trace; c012d1cf <sys_close+43/54>
Trace; c0108e13 <system_call+33/40>
Code;  c013f084 <d_lookup+60/fc>
00000000 <_EIP>:
Code;  c013f084 <d_lookup+60/fc>   <=====
   0:   8b 6d 00                  movl   0x0(%ebp),%ebp   <=====
Code;  c013f087 <d_lookup+63/fc>
   3:   8b 74 24 18               movl   0x18(%esp,1),%esi
Code;  c013f08b <d_lookup+67/fc>
   7:   39 73 48                  cmpl   %esi,0x48(%ebx)
Code;  c013f08e <d_lookup+6a/fc>
   a:   75 78                     jne    84 <_EIP+0x84> c013f108
<d_lookup+e4/fc>
Code;  c013f090 <d_lookup+6c/fc>
   c:   8b 74 24 24               movl   0x24(%esp,1),%esi
Code;  c013f094 <d_lookup+70/fc>
  10:   39 73 0c                  cmpl   %esi,0xc(%ebx)
Code;  c013f097 <d_lookup+73/fc>
  13:   75 00                     jne    15 <_EIP+0x15> c013f099
<d_lookup+75/fc>


2 warnings issued.  Results may not be reliable.


