Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293016AbSCEMV4>; Tue, 5 Mar 2002 07:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292996AbSCEMVr>; Tue, 5 Mar 2002 07:21:47 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:42880 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S292972AbSCEMVa>;
	Tue, 5 Mar 2002 07:21:30 -0500
Message-ID: <003501c1c440$394b6d00$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csi.cc>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
        "raid" <linux-raid@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Linux-2.4.19-pre2-ac2 Oops
Date: Tue, 5 Mar 2002 07:21:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running Linux-2.4.16 but was getting oopses resyncing my 2TB array
(alreay emailed to this list).

So...upgraded to Linux-2.4.19-pre2-ac2 and it now oopses in a new place:

Unable to handle kernel paging request at virtual address 9b78003c
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01a06fa>] Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 001007
eax: 00331a4f  ebx: f79ea617  ecx: 00000018  edx: 00331a50
esi: 00000000  edi: f79ea617  ebp: 9b780000  esp: f6e87c48
ds: 0018  es: 0018  ss: 0018
Process raid5d (pid: 235, stackpage=f6e87000)
Stack: f79ea617 00000000 f79ea618 00000202 00000000 c01a734c f79ea617
f79ea600
       00000000 f79ea618 00000202 00000296 f7b611c0 f79ea600 00000282
c01a69cb
       f79ea618 f79ea600 00000000 00000008 f7952800 c01a6bba f79ea618
00000000
Call Trace: [<c01a734c>] [<c01a69cb>] [<c01a6bba>] [<c01a6e02>] [<c01bd43a
>]
            [<c01a1027>] [<c01a0ee6>] [<c011b760>] [<c011b64d>] [<c011b3ef>]
[<c01087ed>]
            [<c010a928>] [<f8820fd6>] [<f8821d0c>] [<f882510c>] [<f88262e1>]
[<f88269c7>]
            [<c01c8d45>] [<c0105624>]
Code: 8b 55 3c ff 05 a8 f9 32 c0 81 c2 c8 00 00 00 83 7d 38 00 74

>>EIP; c01a06fa <scsi_dispatch_cmd+46/28c>   <=====
Trace; c01a734c <scsi_request_fn+2f8/33c>
Trace; c01a69cb <scsi_queue_next_request+47/110>
Trace; c01a6bba <__scsi_end_request+126/130>
Trace; c01a6e02 <scsi_io_completion+166/378>
Trace; c01a1027 <scsi_finish_command+a7/b0>
Trace; c01a0ee6 <scsi_bottom_half_handler+c2/d8>
Trace; c011b760 <bh_action+4c/8c>
Trace; c011b64d <tasklet_hi_action+61/90>
Trace; c011b3ef <do_softirq+6f/cc>
Trace; c01087ed <do_IRQ+dd/ec>
Trace; c010a928 <call_do_IRQ+5/d>
Trace; f8820fd6 <[xor]xor_sse_4+36/334>
Trace; f8821d0c <[xor]xor_block+70/94>
Trace; f882510c <[raid5]compute_block+c8/e4>
Trace; f88262e1 <[raid5]handle_stripe+ce5/f88>
Trace; f88269c7 <[raid5]raid5d+127/154>
Trace; c01c8d45 <md_thread+145/1a8>
Trace; c0105624 <kernel_thread+28/38>
Code;  c01a06fa <scsi_dispatch_cmd+46/28c>
00000000 <_EIP>:
Code;  c01a06fa <scsi_dispatch_cmd+46/28c>   <=====
   0:   8b 55 3c                  mov    0x3c(%ebp),%edx   <=====
Code;  c01a06fd <scsi_dispatch_cmd+49/28c>
   3:   ff 05 a8 f9 32 c0         incl   0xc032f9a8
Code;  c01a0703 <scsi_dispatch_cmd+4f/28c>
   9:   81 c2 c8 00 00 00         add    $0xc8,%edx
Code;  c01a0709 <scsi_dispatch_cmd+55/28c>
   f:   83 7d 38 00               cmpl   $0x0,0x38(%ebp)
Code;  c01a070d <scsi_dispatch_cmd+59/28c>
  13:   74 00                     je     15 <_EIP+0x15> c01a070f
<scsi_dispatch_cmd+5b/28c>


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

