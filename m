Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbRGSLXx>; Thu, 19 Jul 2001 07:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbRGSLXo>; Thu, 19 Jul 2001 07:23:44 -0400
Received: from icebox.org ([205.198.11.50]:40456 "EHLO snowman.icebox.org")
	by vger.kernel.org with ESMTP id <S267537AbRGSLXk>;
	Thu, 19 Jul 2001 07:23:40 -0400
Message-ID: <026101c11045$455ec0b0$0b64a8c0@mimer.no>
From: "Ole Gjerde" <gjerdelist@icebox.org>
To: linux-kernel@vger.kernel.org
Subject: Adaptec 2100S and 2.4.7-pre8(and 2.4.6-ac5)  i2o driver
Date: Thu, 19 Jul 2001 13:23:40 +0200
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
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,
I've been trying to get this Adaptec 2100S RAID card to work.  It works fine
with the adaptec patch(the dpt_i2o driver), but I would really like to get
it to work with the stock i2o driver.  According to the messages I've seen
so far this should work without any problems.

However, when the kernel boots, it scans the bus, finds the card and starts
the initializing and then it oopses.

Kernel: 2.4.7-pre8 and 2.4.6-ac5

Hardware:
Intel STL2 MB
Dual P3 1GHz
512 MB ram
Adaptec 2100S in a RAID5 (~36G)
network: eepro100 on MB and 3com 3c905B

All drivers builtin(modules disabled).  And all partition + swap on the RAID
device.

Last message on console before oops:
i2o_scsi: Attempting to reset the bus.

Here is the ksymoops'ed oops(NOTE: This was hand copied, but I think it's
right :)  (oops is from 2.4.7-pre8):

ksymoops 2.4.0 on i686 2.4.2-2.DPT.1smp.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.7-pre8 (specified)

Unable to handle kernel paging request at virtual address: a0815200
c01cdf89
Oops: 0002
CPU:  0
EIP:  0010:[<c01cdf89>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00040001   ebx: 00015200   ecx: c18dbc80   edx: e0815200
esi: 00000008   edi: c18fa000   ebp: c198d600   esp: c027be98
ds: 0018   es: 0018   ss:0018
Process swapper (Pid: 0, stackpage=c027b000)
Stack: 00000000 00000000 c019f8d8 c198d600 00000001 c198d600 00000bb8
00000000 00000001
c019f43b c198d600 00000001 c0245840 00000002 00000000 00070000 c18a1400
c18fa000 00000027 1fe6cf00
dfe6cf00 c198d600 00000019 c01cd576
Call Trace: [<c019f8d8>] [<c019f43b>] [<c01cd576>] [<c01c7c0d>] [<c01087fe>]
[<c0108a04>] [<c0105220>]
[<c0105200>] [<c0106f34>] [<c0105220>] [<c0105220>] [<c010524c>]
[<c01052d2>] [<c0105000>]
Code: 89 82 00 00 00 c0 89 f0 0d 00 10 00 27 89 82 04 00 00 c0 a1

>>EIP; c01cdf89 <i2o_scsi_reset+39/80>   <=====
Trace; c019f8d8 <scsi_reset+f8/330>
Trace; c019f43b <scsi_old_done+4ab/640>
Trace; c01cd576 <i2o_scsi_reply+296/2b0>
Trace; c01c7c0d <i2o_run_queue+2d/70>
Trace; c01087fe <handle_IRQ_event+5e/90>
Trace; c0108a04 <do_IRQ+a4/f0>
Trace; c0105220 <default_idle+0/40>
Trace; c0105200 <disable_hlt+0/10>
Trace; c0106f34 <ret_from_intr+0/7>
Trace; c0105220 <default_idle+0/40>
Trace; c0105220 <default_idle+0/40>
Trace; c010524c <default_idle+2c/40>
Trace; c01052d2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  c01cdf89 <i2o_scsi_reset+39/80>
00000000 <_EIP>:
Code;  c01cdf89 <i2o_scsi_reset+39/80>   <=====
   0:   89 82 00 00 00 c0         mov    %eax,0xc0000000(%edx)   <=====
Code;  c01cdf8f <i2o_scsi_reset+3f/80>
   6:   89 f0                     mov    %esi,%eax
Code;  c01cdf91 <i2o_scsi_reset+41/80>
   8:   0d 00 10 00 27            or     $0x27001000,%eax
Code;  c01cdf96 <i2o_scsi_reset+46/80>
   d:   89 82 04 00 00 c0         mov    %eax,0xc0000004(%edx)
Code;  c01cdf9c <i2o_scsi_reset+4c/80>
  13:   a1 00 00 00 00            mov    0x0,%eax


scripts/ver_linux output:
Linux av-senteret.mimer.no 2.4.2-2.DPT.1smp #1 SMP Tue Jul 10 15:29:47 EDT
2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         3c59x eepro100 ipchains aic7xxx dpt_i2o sd_mod
scsi_mod

If anyone need anything else, just let me know!

Thanks,
Ole Gjerde


