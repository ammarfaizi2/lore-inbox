Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132767AbQKXL0A>; Fri, 24 Nov 2000 06:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132768AbQKXLZu>; Fri, 24 Nov 2000 06:25:50 -0500
Received: from mta4-svc.virgin.net ([194.168.54.145]:65224 "EHLO
        mta4-svc.virgin.net") by vger.kernel.org with ESMTP
        id <S132767AbQKXLZl>; Fri, 24 Nov 2000 06:25:41 -0500
Date: Fri, 24 Nov 2000 10:55:39 +0000
From: Mark Ellis <mark.uzumati@virgin.net>
To: linux-kernel@vger.kernel.org
Subject: OOPS on bringing down ppp
Message-ID: <20001124105539.A18945@ElCapitan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, consistently getting the following when pppd is terminated. Happens
in 2.4.0-test11, fine in 2.4.0-test9, don't know about test10. Same happens
for pppd 2.4.0b4 and 2.4.0, both recompiled for test11. Is this related to
the modutils incompatability (modutils 2.3.19) ? 

CONFIG_PPP and CONFIG_PPP_ASYNC are built in, CONFIG_PPP_DEFLATE and
CONFIG_PPP_BSDCOMP as modules, but oopses whether they are loaded or not.

ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): snd symbol pm_register not found in
/lib/modules/2.4.0-test11/sound/snd.o.  Ignoring
/lib/modules/2.4.0-test11/sound/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in
/lib/modules/2.4.0-test11/sound/snd.o.  Ignoring
/lib/modules/2.4.0-test11/sound/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in
/lib/modules/2.4.0-test11/sound/snd.o.  Ignoring
/lib/modules/2.4.0-test11/sound/snd.o entry
c0114c6c
*pde = 00000000
Oops:  0000
CPU:    0
EIP:    0010:[<c0114c6c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c4bb1544   ebx: c4e72000   ecx: c5fe83a0   edx: 00000000
esi: 00000006   edi: 00000000   ebp: c5fe83a0   esp: c4e73fb8
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 1099, stackpage=c4e73000)
Stack: 00000100 c4e6delc c4e6de4c c5b27e20 c5fe83a0 c11c35c0 c11c35c0
       c11c35c0 c11c35c0 c0114f60 c0225f60 c4e6dedc c4e6dec8 c0108914
       c4e6de4c 00000078 c4e6dedc
Call Trace: [<c0114f60>] [<c0108914>]
Code: 8b 4f 08 39 ca 7d 22 8b 47 14 83 3c 90 00 74 14 89 f0 89 d3

>>EIP; c0114c6c <exec_usermodehelper+29c/368>   <=====
Trace; c0114f60 <exec_helper+14/18>
Trace; c0108914 <kernel_thread+28/38>
Code;  c0114c6c <exec_usermodehelper+29c/368>
00000000 <_EIP>:
Code;  c0114c6c <exec_usermodehelper+29c/368>   <=====
   0:   8b 4f 08                  mov    0x8(%edi),%ecx   <=====
Code;  c0114c6f <exec_usermodehelper+29f/368>
   3:   39 ca                     cmp    %ecx,%edx
Code;  c0114c71 <exec_usermodehelper+2a1/368>
   5:   7d 22                     jge    29 <_EIP+0x29> c0114c95
<exec_usermodehelper+2c5/368>
Code;  c0114c73 <exec_usermodehelper+2a3/368>
   7:   8b 47 14                  mov    0x14(%edi),%eax
Code;  c0114c76 <exec_usermodehelper+2a6/368>
   a:   83 3c 90 00               cmpl   $0x0,(%eax,%edx,4)
Code;  c0114c7a <exec_usermodehelper+2aa/368>
   e:   74 14                     je     24 <_EIP+0x24> c0114c90
<exec_usermodehelper+2c0/368>
Code;  c0114c7c <exec_usermodehelper+2ac/368>
  10:   89 f0                     mov    %esi,%eax
Code;  c0114c7e <exec_usermodehelper+2ae/368>
  12:   89 d3                     mov    %edx,%ebx


3 warnings issued.  Results may not be reliable.


Any ideas ?

Mark


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
