Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRAXRJY>; Wed, 24 Jan 2001 12:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRAXRJO>; Wed, 24 Jan 2001 12:09:14 -0500
Received: from picard.csihq.com ([204.17.222.1]:60289 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S130516AbRAXRI6>;
	Wed, 24 Jan 2001 12:08:58 -0500
Message-ID: <058301c08628$564b4080$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        "raid" <linux-raid@vger.rutgers.edu>
Subject: RAID1 resync oops on 2.4.0.ac11 (was ac10)
Date: Wed, 24 Jan 2001 12:08:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ac10 oopsed but now ac11 oopses in a new place at the end of a RAID1 resync
operation when I tried to "more /proc/mdstat"

Unable to handle kernel NULL pointer dereference at virtual address 00000038
printing EIP:
c01ba0f
Oops: 0000
CPU: 0
EIP: 0010:[<c01ba0af>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000 ebx: f7b4504c ecx: 00000000 edx: 00000002
esi: c32691a0 edi: ffffffff ebp: f7a65300 esp: f7a6ded8
ds: 0018 es: 0018 ss: 0018
Process mdrecoveryd (pid: 7, stackpage=f7a6d000)
Stack: f7bb75d8 f7bb7580 f7a65000 f7a60fb0 00000286 00000001 f7a65280
f7a65000
       f7b45028 f7b45000 00000001 00000000 f7a6dfb0 f7a6df3c 00000000
f7a6df3c
       f7bb75ec 00000000 09009e0a 00000000 01388ac0 c017176e 00000000
c028e680
Call Trace: [<c017176e>] [<c01c051b>] [<c01bf40aq>] [<c01074c4>]
Code: 8b 41 38 89 46 38 89 51 38 8d 7c 24 30 89 ee fc b9 20 00 00

>>EIP; c01ba0af <status_resync+4f/224>   <=====
Trace; c017176e <vt_console_print+2c2/2d8>
Trace; c01c051b <netif_rx+df/f0>
Code;  c01ba0af <status_resync+4f/224>
00000000 <_EIP>:
Code;  c01ba0af <status_resync+4f/224>   <=====
   0:   8b 41 38                  mov    0x38(%ecx),%eax   <=====
Code;  c01ba0b2 <status_resync+52/224>
   3:   89 46 38                  mov    %eax,0x38(%esi)
Code;  c01ba0b5 <status_resync+55/224>
   6:   89 51 38                  mov    %edx,0x38(%ecx)
Code;  c01ba0b8 <status_resync+58/224>
   9:   8d 7c 24 30               lea    0x30(%esp,1),%edi
Code;  c01ba0bc <status_resync+5c/224>
   d:   89 ee                     mov    %ebp,%esi
Code;  c01ba0be <status_resync+5e/224>
   f:   fc                        cld
Code;  c01ba0bf <status_resync+5f/224>
  10:   b9 20 00 00 00            mov    $0x20,%ecx


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
