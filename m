Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268007AbRGVRiw>; Sun, 22 Jul 2001 13:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268006AbRGVRim>; Sun, 22 Jul 2001 13:38:42 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:44992 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S268011AbRGVRia>; Sun, 22 Jul 2001 13:38:30 -0400
Date: Sun, 22 Jul 2001 12:49:18 -0500
From: Andrew Friedley <saai@swbell.net>
Subject: pppoe patch in 2.4.7 results - still problem
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <000901c112d6$a1a30000$0200a8c0@loki>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In response to the pppoe patch to try to fix panics with pppoe and smp:
When running napster/napigator from a windows machine on my LAN, the router
running 2.4.7 still panics.  It has not been long enough to tell if the
"random" panics have been fixed for sure, but so far, so good - 1 day, 4
hour uptime right now.  Here is a paste of a napster-induced panic with
kernel 2.4.7 followed by the ksymoops output.

Unable to handle kernel paging request at virtual address 00002e
c8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d6fc3>]
EFLAGS: 00010202
eax: c6987de0   ebx: 00002ec8   ecx: 00000000   edx: 00002ec8
esi: c51b96e0   edi: c605a060   ebp: 00000060   esp: c0297db8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0297000)
Stack: ff6d22e0 c01d706b c51b96e0 ff6d22e0 c51b96e0 c01d7653 c51b96e0
c12ad800
       c51b96e0 0000000e c51b96e0 ffffffe6 c01da0f7 c51b96e0 00000020
00000004
       c5235d40 0000000e c01ddfed c51b96e0 00000001 00000000 c51b96e0
c01e7ea0
Call Trace: [<c01d706b>] [<c01d7653>] [<c01da0f7>] [<c01ddfed>] [<c01e7ea0>]
[<c01e7f60>] [<c01df228>]
       [<c01e5450>] [<c01e7e83>] [<c01e7ea0>] [<c01e54aa>] [<c01df228>]
[<c01e05dc>] [<c01e53e4>] [<c01e5450>]
       [<c01e4488>] [<c01e462a>] [<c01e4488>] [<c01df228>] [<c01e42c7>]
[<c01e4488>] [<c01da8ce>] [<c0116c8a>]
       [<c0108680>] [<c0105180>] [<c0106d40>] [<c0105180>] [<c01051ac>]
[<c0105212>] [<c0105000>]

Code: 8b 1b 8b 42 70 83 f8 01 74 0b f0 ff 4a 70 0f 94 c0 84 c0 74
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Unable to handle kernel paging request at virtual address 00002e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d6fc3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c6987de0   ebx: 00002ec8   ecx: 00000000   edx: 00002ec8
esi: c51b96e0   edi: c605a060   ebp: 00000060   esp: c0297db8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0297000)
Stack: ff6d22e0 c01d706b c51b96e0 ff6d22e0 c51b96e0 c01d7653 c51b96e0
c12ad800
       c51b96e0 0000000e c51b96e0 ffffffe6 c01da0f7 c51b96e0 00000020
00000004
       c5235d40 0000000e c01ddfed c51b96e0 00000001 00000000 c51b96e0
c01e7ea0
Call Trace: [<c01d706b>] [<c01d7653>] [<c01da0f7>] [<c01ddfed>] [<c01e7ea0>]
[<c
01e7f60>] [<c01df228>]
       [<c01e5450>] [<c01e7e83>] [<c01e7ea0>] [<c01e54aa>] [<c01df228>]
[<c01e05
       [<c01e4488>] [<c01e462a>] [<c01e4488>] [<c01df228>] [<c01e42c7>]
[<c01e44
       [<c0108680>] [<c0105180>] [<c0106d40>] [<c0105180>] [<c01051ac>]
[<c01052
Code: 8b 1b 8b 42 70 83 f8 01 74 0b f0 ff 4a 70 0f 94 c0 84 c0 74

>>EIP; c01d6fc3 <skb_copy_bits+47/1e8>   <=====
Trace; c01d706b <skb_copy_bits+ef/1e8>
Trace; c01d7653 <skb_copy_and_csum_dev+7b/cc>
Trace; c01da0f7 <dev_change_flags+67/f8>
Trace; c01ddfed <nf_iterate+41/84>
Trace; c01e7ea0 <ip_setsockopt+d4/944>
Code;  c01d6fc3 <skb_copy_bits+47/1e8>
00000000 <_EIP>:
Code;  c01d6fc3 <skb_copy_bits+47/1e8>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01d6fc5 <skb_copy_bits+49/1e8>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c01d6fc8 <skb_copy_bits+4c/1e8>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c01d6fcb <skb_copy_bits+4f/1e8>
   8:   74 0b                     je     15 <_EIP+0x15> c01d6fd8
<skb_copy_bits+5c/1e8>
Code;  c01d6fcd <skb_copy_bits+51/1e8>
   a:   f0 ff 4a 70               lock decl 0x70(%edx)
Code;  c01d6fd1 <skb_copy_bits+55/1e8>
   e:   0f 94 c0                  sete   %al
Code;  c01d6fd4 <skb_copy_bits+58/1e8>
  11:   84 c0                     test   %al,%al
Code;  c01d6fd6 <skb_copy_bits+5a/1e8>
  13:   74 00                     je     15 <_EIP+0x15> c01d6fd8
<skb_copy_bits+5c/1e8>

Kernel panic: Aiee, killing interrupt handler!




