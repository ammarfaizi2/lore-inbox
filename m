Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQLAWdz>; Fri, 1 Dec 2000 17:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbQLAWdq>; Fri, 1 Dec 2000 17:33:46 -0500
Received: from acl.lanl.gov ([128.165.147.1]:63527 "EHLO acl.lanl.gov")
	by vger.kernel.org with ESMTP id <S129535AbQLAWdj>;
	Fri, 1 Dec 2000 17:33:39 -0500
Date: Fri, 1 Dec 2000 15:03:12 -0700 (MST)
From: Ronald G Minnich <rminnich@lanl.gov>
To: linuxbios@lanl.gov, linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 scsi failure in linuxbios, L440GX
Message-ID: <Pine.LNX.4.21.0012011438380.26420-100000@mini.acl.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the oops. This is an AIC7xxx controller. This is a non-SMP kernel,
and there is only one processor installed in the machine. The value in eax
sure looks weird too me, esp. given that the failing instruction involves
a ld from (%eax)

This is a va2200 node, and this same kernel has booted fine under the
standard bios (darn!). This hardware seems to be working. 

Any ideas on what this could be would sure help. Is there something I
could have configured wrong? or is SCSI without SCSI bios a lost cause (I
hope not). Anything I should start looking for?


Oops: 0000
CPU:    0
EIP:    0010:[<c01785ea>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 368dc3c9   ebx: 00000001   ecx: 45c710ec   edx: cfef3808
esi: cfeef02c   edi: cfef3078   ebp: 00000013   esp: c0205f0c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0205000)
Stack: cfef3078 cfef3078 c0205fac 00000013 cfef3078 368dc3c9 d0802091
c0178a0b 
       cfef3078 cfef3078 00000286 c0205fac c011cd67 00000002 c0178c78
00000013 
       cfef3078 c0205fac c147c400 04000001 00000013 c0205fac c010be2d
00000013 
Call Trace: [<d0802091>] [<c0178a0b>] [<c011cd67>] [<c0178c78>]
[<c010be2d>] [<        [<c0108fa0>] [<c010ac58>] [<c0108fa0>] [<c0108fa0>]
[<c0100018>] [<c0108        [<c0100192>] 
Code: 8a 58 50 c0 e3 03 0a 58 48 f6 c5 10 0f 84 c4 00 00 00 57 e8 

>>EIP; c01785ea <aic7xxx_handle_command_completion_intr+132/47c>   <=====
Trace; d0802091 <END_OF_CODE+105cbf31/????>
Trace; c0178a0b <aic7xxx_isr+d7/30c>
Trace; c011cd67 <timer_bh+27/258>
Trace; c0178c78 <do_aic7xxx_isr+38/90>
Trace; c010be2d <handle_IRQ_event+31/5c>
Code;  c01785ea <aic7xxx_handle_command_completion_intr+132/47c>
00000000 <_EIP>:
Code;  c01785ea <aic7xxx_handle_command_completion_intr+132/47c>   <=====
   0:   8a 58 50                  mov    0x50(%eax),%bl   <=====
Code;  c01785ed <aic7xxx_handle_command_completion_intr+135/47c>
   3:   c0 e3 03                  shl    $0x3,%bl
Code;  c01785f0 <aic7xxx_handle_command_completion_intr+138/47c>
   6:   0a 58 48                  or     0x48(%eax),%bl
Code;  c01785f3 <aic7xxx_handle_command_completion_intr+13b/47c>
   9:   f6 c5 10                  test   $0x10,%ch
Code;  c01785f6 <aic7xxx_handle_command_completion_intr+13e/47c>
   c:   0f 84 c4 00 00 00         je     d6 <_EIP+0xd6> c01786c0
<aic7xxx_handle_command_completion_intr+208/47c>
Code;  c01785fc <aic7xxx_handle_command_completion_intr+144/47c>
  12:   57                        push   %edi
Code;  c01785fd <aic7xxx_handle_command_completion_intr+145/47c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0178602
<aic7xxx_handle_command_completion_intr+14a/47c>

------

thanks

ron

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
