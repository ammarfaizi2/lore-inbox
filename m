Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBHTEw>; Thu, 8 Feb 2001 14:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBHTEm>; Thu, 8 Feb 2001 14:04:42 -0500
Received: from montreal.eicon.com ([192.219.17.120]:44808 "EHLO
	mtl_exchange.eicon.com") by vger.kernel.org with ESMTP
	id <S129030AbRBHTE2>; Thu, 8 Feb 2001 14:04:28 -0500
Message-ID: <D8E12241B029D411A3A300805FE6A2B90103F69B@montreal.eicon.com>
From: Carlo Pagano <Carlo.Pagano@trisignal.com>
To: linux-kernel@vger.kernel.org
Subject: question regarding OOPS in 2.2.16
Date: Thu, 8 Feb 2001 14:05:44 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1460.8)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was trying out a modem on RedHat 7 running kernel 2.2.16 and when trying
to upload a file via ftp I get an OOPS. 
I am using pppd version 2.4.0 on a Pentium III 450 with 128MB of RAM.

Here is the output of kysymoops:

[root@cpagano_redhat7 cpagano]# ksymoops oops.feb8.txt -m /boot/System.map
ksymoops 2.3.4 on i686 2.2.16-22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.16-22/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01114d2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000018   ebx: c0234000   ecx: 000003fd   edx: c76ee000
esi: 00000000   edi: 00000d95   ebp: c0235ce4   esp: c0235cd0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c0235000)
Stack: c7ff62ad 00000d95 c883c20a c622b780 c7ff6000 c7235900 c8867ac3
c7ff6000
       000000d9 00000001 c7ff6000 00000075 c883be97 c6522000 00000000
c7ff62ad
       00000064 c7ff6000 c6754800 c622b780 c883bdb4 c7ff6000 00000021
c883e023
Call Trace: [<c883c20a>] [<c8867ac3>] [<c883be97>] [<c883bdb4>] [<c883e023>]
[<c
883e68f>] [<c0153ee5>]
       [<c014fa29>] [<c0163ce9>] [<c0163ff1>] [<c016a8d1>] [<c014df94>]
[<c016ad
       [<c016eb9b>] [<c016ed0a>] [<c016efa3>] [<c016174f>] [<c0161aad>]
[<c010ad
       [<c011143d>] [<c01087e1>] [<c01087e9>] [<c0106000>] [<c0108804>]
[<c0109f
       [<c0106000>] [<c0100175>]
Code: c7 05 00 00 00 00 00 00 00 00 8d 65 e8 5b 5e 5f 89 ec 5d c3

>>EIP; c01114d2 <schedule+26a/280>   <=====
Trace; c883c20a <[ppp]ppp_async_encode+2c2/304>
Trace; c8867ac3 <[nls_cp437].data.end+1c6c/6e1a9>
Trace; c883be97 <[ppp]ppp_tty_push+d3/184>
Trace; c883bdb4 <[ppp]ppp_async_send+70/80>
Trace; c883e023 <[ppp]ppp_send_frame+257/280>
Code;  c01114d2 <schedule+26a/280>
00000000 <_EIP>:
Code;  c01114d2 <schedule+26a/280>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c01114d9 <schedule+271/280>
   7:   00 00 00 
Code;  c01114dc <schedule+274/280>
   a:   8d 65 e8                  lea    0xffffffe8(%ebp),%esp
Code;  c01114df <schedule+277/280>
   d:   5b                        pop    %ebx
Code;  c01114e0 <schedule+278/280>
   e:   5e                        pop    %esi
Code;  c01114e1 <schedule+279/280>
   f:   5f                        pop    %edi
Code;  c01114e2 <schedule+27a/280>
  10:   89 ec                     mov    %ebp,%esp
Code;  c01114e4 <schedule+27c/280>
  12:   5d                        pop    %ebp
Code;  c01114e5 <schedule+27d/280>
  13:   c3                        ret    

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing


Thanks in advance,

Carlo Pagano
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
