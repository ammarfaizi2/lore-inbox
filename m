Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132210AbRADTLm>; Thu, 4 Jan 2001 14:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRADTLc>; Thu, 4 Jan 2001 14:11:32 -0500
Received: from picard.csihq.com ([204.17.222.1]:51726 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S131730AbRADTLP>;
	Thu, 4 Jan 2001 14:11:15 -0500
Message-ID: <082901c07682$0e726d20$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Oops on 2.4.0-prerelease-ac5
Date: Thu, 4 Jan 2001 14:10:52 -0500
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

2.4.0-prerelease-ac5
Happens during boot right after the RAID checksumming speed is calculated
I don't have CONFIG_HIGHMEM
This is booting from floppy to a RAID5 system:
md3 : active raid5 sdc1[2] sdb1[1] sda1[0] 97691008 blocks level 5, 32k
chunk, algorithm 0 [3/3] [UUU]

Compiler is:
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release) with libio from
current gcc cvs (as of 4 Jan) to overcome indstream.cc compile problems with
new glibc-2.2

invalid operand: 0000
CPU: 0
EIP: 0010:[<c020aadd>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c1897f58 ebx: dff6ef40 ecx: 0000000f edx: 8005003b
esi: dff6c000 edi: 00000000 ebp: 00000001 esp: c1897f50
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=c1897000)
Stack: 00000000 0000085c 00000001 c02e9da4 c032b363 c0116c87 000b220f
0000085b
       0000077b 00000005 00000286 00000001 c032b363 00000020 c020bcf2
c02cb22e
       c02cb227 000002d9 c020bc82 00000f40 dff6c000 dff6ef40 dff6c000
dff6ef40
Call Trace: [<c0116c87>] [<c020bcf2>] [<c02cb22e>] [<c02cb227>] [<c020bc82>]
[<c020bd7b>] [<c0107029>]
        [<c01074f8>]
Code: 0f 11 00 0f 11 48 10 0f 11 50 20 0f 11 58 30 0f 18 4e 00 0f

>>EIP; c020aadd <raid5_end_read_request+101/228>   <=====
Trace; c0116c87 <inter_module_unregister+7/b0>
Trace; c020bcf2 <handle_stripe+676/e74>
Trace; c02cb22e <RCSid+914e/91c4>
Trace; c02cb227 <RCSid+9147/91c4>
Trace; c020bc82 <handle_stripe+606/e74>
Trace; c020bd7b <handle_stripe+6ff/e74>
Trace; c0107029 <init+29/1b0>
Trace; c01074f8 <kernel_thread+2c/30>
Code;  c020aadd <raid5_end_read_request+101/228>
00000000 <_EIP>:
Code;  c020aadd <raid5_end_read_request+101/228>   <=====
   0:   0f 11 00                  movups %xmm0,(%eax)   <=====
Code;  c020aae0 <raid5_end_read_request+104/228>
   3:   0f 11 48 10               movups %xmm1,0x10(%eax)
Code;  c020aae4 <raid5_end_read_request+108/228>
   7:   0f 11 50 20               movups %xmm2,0x20(%eax)
Code;  c020aae8 <raid5_end_read_request+10c/228>
   b:   0f 11 58 30               movups %xmm3,0x30(%eax)
Code;  c020aaec <raid5_end_read_request+110/228>
   f:   0f 18 4e 00               prefetcht0 0x0(%esi)
Code;  c020aaf0 <raid5_end_read_request+114/228>
  13:   0f 00 00                  sldt   (%eax)

Kernel panic: Attempted to kill init!


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
