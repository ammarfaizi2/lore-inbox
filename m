Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293036AbSCEAIb>; Mon, 4 Mar 2002 19:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293034AbSCEAI0>; Mon, 4 Mar 2002 19:08:26 -0500
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:17143 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S293033AbSCEAIO>; Mon, 4 Mar 2002 19:08:14 -0500
Message-ID: <011601c1c3d9$d7c954e0$ac542341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>
Subject: Oopses in 2.4.16
Date: Mon, 4 Mar 2002 19:08:12 -0500
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

Linux-2.4.16

Trying to install a new 2TB raid5 setup and have gotten several oopses
during resync.

Was able to run this setup without synchronizing for a day.  Then added the
spare drive and during resync:

Oops: 0002
CPU: 0
EIP: 0010:[<f8885c1>] Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
eax: e3c7007c ebx: e3c7d328 ecx: e3939d54 edx: 00000082
esi: 00000002 edi: 00000000 ebp: f7affdd8 esp: f7affdc0
ds: 0018 es: 0018 ss: 0018
Stack: e39adfe0 24000001 f7bb1800 00000082 e2f06158 f7affe44 00000010
c0108414
       00000010 e3c7007c f7affe28 c02f0d40 c02c6a00 00000010 f7affe20
c0108606
       00000010 f7affe28 e39adfe0 000000b2 e34dd000 ffffffff 00000000
e39adfe0
Call Trace: [<c0a08414>] [<c0108606>] [<c010a618>] [<f88248c9>] [<f88267ee>]
            [<c01bc2a1>] [<c01bc5c4>] [<c01bb5ac>] [<c0105594>]
Code: d3 bb eb 7d b1 19 65 93 d3 bb eb 7d b1 19 65 93 d3 bb eb 7d

>>EIP; 0f8885c1 Before first symbol   <=====
Trace; c0a08414 <_end+6e4140/384f8d2c>
Trace; c0108606 <do_IRQ+a6/ec>
Trace; c010a618 <call_do_IRQ+5/d>
Trace; f88248c9 <[raid5]get_active_stripe+52d/538>
Trace; f88267ee <[raid5]raid5_sync_request+46/f4>
Trace; c01bc2a1 <md_do_sync+265/490>
Trace; c01bc5c4 <md_do_recovery+f8/25c>
Trace; c01bb5ac <md_thread+14c/1b0>
Trace; c0105594 <kernel_thread+28/38>
Code;  0f8885c1 Before first symbol
00000000 <_EIP>:
Code;  0f8885c1 Before first symbol   <=====
   0:   d3 bb eb 7d b1 19         sarl   %cl,0x19b17deb(%ebx)   <=====
Code;  0f8885c7 Before first symbol
   6:   65                        gs
Code;  0f8885c8 Before first symbol
   7:   93                        xchg   %eax,%ebx
Code;  0f8885c9 Before first symbol
   8:   d3 bb eb 7d b1 19         sarl   %cl,0x19b17deb(%ebx)
Code;  0f8885cf Before first symbol
   e:   65                        gs
Code;  0f8885d0 Before first symbol
   f:   93                        xchg   %eax,%ebx
Code;  0f8885d1 Before first symbol
  10:   d3 bb eb 7d 00 00         sarl   %cl,0x7deb(%ebx)

<0>Kernel panic:


Then we tried it again...3 resyncs were going on (since the system rudely
died) and the filesystems had been NFS exported while resyncing....
Mar  4 15:38:27 yeti kernel: invalid operand: 0000
Mar  4 15:38:27 yeti kernel: CPU:    0
Mar  4 15:38:27 yeti kernel: EIP:    0010:[__make_request+125/1572]
Tainted: P
Mar  4 15:38:27 yeti kernel: EFLAGS: 00010246
Mar  4 15:38:27 yeti kernel: eax: 00002000   ebx: 00000871   ecx: c0301000
edx: 00000000
Mar  4 15:38:27 yeti kernel: esi: e3257ea0   edi: 00000000   ebp: 00000000
esp: e3969e28
Mar  4 15:38:27 yeti kernel: ds: 0018   es: 0018   ss: 0018
Mar  4 15:38:27 yeti kernel: Process raid5d (pid: 172, stackpage=e3969000)
Mar  4 15:38:27 yeti kernel: Stack: 00000871 e3257ea0 00000000 0a9147fc
f7b621d0 00002000 f7b625d8 f7b29540
Mar  4 15:38:27 yeti kernel:        f7b621d0 00000400 00000000 00000000
00000000 f7b29540 c018022c f7b625b8
Mar  4 15:38:27 yeti kernel:        00000000 e3257ea0 0000001c 000000c4
e3288800 00000002 f8826547 00000000
Mar  4 15:38:27 yeti kernel: Call Trace: [generic_make_request+280/296]
[nfs:__insmod_nfs_O/lib/modules/2.4.16/kernel/fs/nfs/nfs.o_M
3C04+-273081/96] [add_blkdev_randomness+66/76]
[nfs:__insmod_nfs_O/lib/modules/2.4.16/kernel/fs/nfs/nfs.o_M3C04+-271930/96]
[md_thre
ad+332/432]
Mar  4 15:38:27 yeti kernel: Code: 0f 0b 56 57 e8 3e 17 fb ff 89 c6 0f b6 46
15 0f b7 4e 14 83
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   56                        push   %esi
Code;  00000003 Before first symbol
   3:   57                        push   %edi
Code;  00000004 Before first symbol
   4:   e8 3e 17 fb ff            call   fffb1747 <_EIP+0xfffb1747> fffb1747
<END_OF_CODE+76d8b28/????>
Code;  00000009 Before first symbol
   9:   89 c6                     mov    %eax,%esi
Code;  0000000b Before first symbol
   b:   0f b6 46 15               movzbl 0x15(%esi),%eax
Code;  0000000f Before first symbol
   f:   0f b7 4e 14               movzwl 0x14(%esi),%ecx
Code;  00000013 Before first symbol
  13:   83 00 00                  addl   $0x0,(%eax)



