Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSDBCCp>; Mon, 1 Apr 2002 21:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312737AbSDBCCg>; Mon, 1 Apr 2002 21:02:36 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:62173 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S312600AbSDBCCZ>; Mon, 1 Apr 2002 21:02:25 -0500
Message-ID: <3CA9110D.8020709@holly.colostate.edu>
Date: Mon, 01 Apr 2002 19:01:49 -0700
From: Eric Hokanson <pceric@holly.colostate.edu>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.9+) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: pceric@holly.colostate.edu
Subject: Oops in ide-scsi caused by VIA82CXXX support
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can get a fully reproducable Oops in all 2.4.x series of kernels I 
have tried so far (2.4.[9,16,17,18,19-pre5]).
I have a Tekram AMD slot 1 motherboard with the VIA 82c686 ide chipset 
and a Memorex ide cd-rw drive.
When ever I compile in VIA82CXXX support and try to mount my cd-rw drive 
the light on the drive will blink a few times and then will give me an 
oops message before it hard locks my system.
If I don't compile in VIA82CXXX support my cd-rw drive works fine (but 
my ide transfer speed is horribly slow).

Here is some information and more is available upon request:

/proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 2).
      Prefetchable 32 bit memory at 0xd8000000 [0xdbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 27).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32. 
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 14).
      IRQ 5.
      Master Capable.  Latency=32. 
      I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 14).
      IRQ 5.
      Master Capable.  Latency=32. 
      I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 32).
      IRQ 9.
...

/proc/scsi/scsi:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Memorex  Model: CRW-1622         Rev: D4.0
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: J.03
  Type:   Direct-Access                    ANSI SCSI revision: 02

My Opps log (hand written because I have no way of capturing the actual 
log, may not be 100% accurate):

Oops: 0002
CPU: 0
EIP: 0010: [<c01e0995>]     Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 66202020 ebx: cdafd000 ecx: c0323004 edx: 00000177
esi: 00000001 edi: cff33c80 ebp: c0323048 esp: c02bff38
ds: 0018 es: 0018 ss: 0018
Process swapper (pid:0, stackpage=c026f000)
Stack: 66202020 c12eb280 c0323048 00000282 c0323004 c01b84b2 c0323048 
c01e0920 cffeff00 04000001 0000000f c02bffac c0109a89 0000000f c12eb280 
c02bffac c02bffac 0000000f c02fccc0 cffeff00 c0109bf8 0000000f c02bffac 
cffeff00
Call Trace: [<c01b8462>] [<c01e0920>] [<c0109a89>] [<c0109bf8>] 
[<c0106c20>] [<c0106c20>] [<c0106c20>] [<c0106c20>] [<c0106c43>] 
[<c0106cc2>] [<c0105000>]
Code: ff 40 18 86 85 f0 00 00 00 ff 70 04 6a 01 e8 f8 fc ff ff 5f

 >>EIP; c01e0995 <idescsi_pc_intr+75/250>   <=====
Trace; c01b8462 <ide_intr+62/110>
Trace; c01e0920 <idescsi_pc_intr+0/250>
Trace; c0109a89 <handle_IRQ_event+39/60>
Trace; c0109bf8 <do_IRQ+68/b0>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c20 <default_idle+0/30>
Trace; c0106c43 <default_idle+23/30>
Trace; c0106cc2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  c01e0995 <idescsi_pc_intr+75/250>
00000000 <_EIP>:
Code;  c01e0995 <idescsi_pc_intr+75/250>   <=====
   0:   ff 40 18                  incl   0x18(%eax)   <=====
Code;  c01e0998 <idescsi_pc_intr+78/250>
   3:   86 85 f0 00 00 00         xchg   %al,0xf0(%ebp)
Code;  c01e099e <idescsi_pc_intr+7e/250>
   9:   ff 70 04                  pushl  0x4(%eax)
Code;  c01e09a1 <idescsi_pc_intr+81/250>
   c:   6a 01                     push   $0x1
Code;  c01e09a3 <idescsi_pc_intr+83/250>
   e:   e8 f8 fc ff ff            call   fffffd0b <_EIP+0xfffffd0b> 
c01e06a0 <idescsi_end_request+0/280>
Code;  c01e09a8 <idescsi_pc_intr+88/250>
  13:   5f                        pop    %edi


1 warning issued.  Results may not be reliable.

Eric Hokanson


