Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288828AbSATXHz>; Sun, 20 Jan 2002 18:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288940AbSATXHt>; Sun, 20 Jan 2002 18:07:49 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:29984 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S288828AbSATXH3>; Sun, 20 Jan 2002 18:07:29 -0500
Message-ID: <016401c1a203$024459c0$0801a8c0@Stev.org>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: ide-scsi oops 2.4.17
Date: Sun, 20 Jan 2002 22:37:13 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

 first of all this is the second time this is happened in 2 days
i think i can reproduce it by doing

dd if=/dev/scd1 of=aniso.iso bs=8192k
it seems to happen when the cd drive mis reads from the disc

cd drives its on the 44x
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HP        Model: CD-Writer+ 7200   Rev: 3.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: ATAPI     Model: CD-ROM 44X        Rev: T4C2
  Type:   CD-ROM                             ANSI SCSI revision: 02

let me know if you need any more info.

ksymoops 2.4.1 on i586 2.4.17.  Options used
     -v /home/james/kernel-build/BEAST/vmlinux (specified)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.17/ (default)
     -m /home/james/kernel-build/BEAST/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 23210119
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d6016>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 23210101   ebx: c3c67800   ecx: c0354278   edx: c0330177
esi: 00000001   edi: cbfdf520   ebp: c03543e0   esp: c02e3f24
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02e3000)
Stack: 23210101 c03543e0 c13d1360 00000202 c0354278 c01c1640 c03543e0
c01d5fa0
       c131fb80 04000001 0000000f c02e3f98 c010810a 0000000f c13d1360
c02e3f98
       c02e3f98 0000000f c0328ae0 c131fb80 c010828d 0000000f c02e3f98
c131fb80
Call Trace: [<c01c1640>] [<c01d5fa0>] [<c010810a>] [<c010828d>] [<c01051a0>]
   [<c01051a0>] [<c01051c4>] [<c0105232>] [<c0105000>]
Code: 8b 50 18 42 89 50 18 8b 85 cc 00 00 00 8b 68 04 55 6a 01 e8

>>EIP; c01d6016 <idescsi_pc_intr+76/260>   <=====
Trace; c01c1640 <ide_intr+f0/150>
Trace; c01d5fa0 <idescsi_pc_intr+0/260>
Trace; c010810a <handle_IRQ_event+3a/70>
Trace; c010828d <do_IRQ+6d/b0>
Trace; c01051a0 <default_idle+0/30>
Trace; c01051a0 <default_idle+0/30>
Trace; c01051c4 <default_idle+24/30>
Trace; c0105232 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Code;  c01d6016 <idescsi_pc_intr+76/260>
00000000 <_EIP>:
Code;  c01d6016 <idescsi_pc_intr+76/260>   <=====
   0:   8b 50 18                  mov    0x18(%eax),%edx   <=====
Code;  c01d6019 <idescsi_pc_intr+79/260>
   3:   42                        inc    %edx
Code;  c01d601a <idescsi_pc_intr+7a/260>
   4:   89 50 18                  mov    %edx,0x18(%eax)
Code;  c01d601d <idescsi_pc_intr+7d/260>
   7:   8b 85 cc 00 00 00         mov    0xcc(%ebp),%eax
Code;  c01d6023 <idescsi_pc_intr+83/260>
   d:   8b 68 04                  mov    0x4(%eax),%ebp
Code;  c01d6026 <idescsi_pc_intr+86/260>
  10:   55                        push   %ebp
Code;  c01d6027 <idescsi_pc_intr+87/260>
  11:   6a 01                     push   $0x1
Code;  c01d6029 <idescsi_pc_intr+89/260>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c01d602e
<idescsi_pc_intr+8e/260>

 <0>Kernel panic: Aiee, killing interrupt handler!

    James

-------------------------
Mobile: +44 07779080838
http://www.stev.org
  1:10pm  up 55 min,  2 users,  load average: 0.00, 0.00, 0.00



