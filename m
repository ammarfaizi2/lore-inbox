Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULRPQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULRPQI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 10:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbULRPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 10:16:08 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:38027 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261176AbULRPP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 10:15:56 -0500
Message-ID: <41C449AA.7070600@ribosome.natur.cuni.cz>
Date: Sat, 18 Dec 2004 16:15:54 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20041217
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regression: misdetected PCMCIA KW-7004 in 2.4.29-pre2
References: <41C43C0D.9000005@ribosome.natur.cuni.cz>
In-Reply-To: <41C43C0D.9000005@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I tried on another host using System.map from teh test system:

# lspci
0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
0000:02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
0000:02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
0000:02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
0000:04:00.0 USB Controller: Gammagraphx, Inc.: Unknown device 5237 (rev 03)
0000:04:00.1 USB Controller: Gammagraphx, Inc.: Unknown device 5237 (rev 03)
0000:04:00.2 USB Controller: Gammagraphx, Inc.: Unknown device 5237 (rev 03)
0000:04:00.3 USB Controller: Gammagraphx, Inc.: Unknown device 5239 (rev 01)
0000:04:00.4 FireWire (IEEE 1394): Gammagraphx, Inc.: Unknown device 5253
vrapenec root # cat /proc/interrupts 
           CPU0       
  0:      22353          XT-PIC  timer
  1:         12          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:         14          XT-PIC  Ricoh Co Ltd RL5c476 II, usb-uhci
  8:          2          XT-PIC  rtc
  9:          7          XT-PIC  acpi
 11:        328          XT-PIC  ohci1394, Ricoh Co Ltd RL5c476 II (#2), usb-uhci, eth0, ohci1394
 12:        136          XT-PIC  PS/2 Mouse
 14:       4819          XT-PIC  ide0
 15:          7          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
vrapenec root # 


and removing the PCMCIA card gives oops:

# ksymoops --no-vmlinux --no-lsmod --no-ksyms --no-object -m System.map b
ksymoops 2.4.9 on i686 2.6.10-rc3-bk8.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

Oops: 0000
CPU:    0
EIP:    0010:[<c02d8b4b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c0450940   ebx: 00000000   ecx: c02d8b30   edx: f78d4000
esi: 00000000   edi: c04089b1   ebp: c0491ee0   esp: c0491ec8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0491000)
Stack: 00000296 f78d4000 00000296 c045abd8 f78d4000 fe7dff0c c0491ef4 c02c0c76 
       f78d4000 00000001 00000102 c0491f34 c02c92d5 f78d4000 0000003f 00000001 
       00000001 ffffffff ffffffff ffffffff f9930c60 00000004 0000003f f78d4000 
Call Trace:    [<c02c0c76>] [<c02c92d5>] [<c0108768>] [<c0108943>] [<c010ad78>]
  [<c0262e17>] [<c0262d24>] [<c0262d24>] [<c01053c2>] [<c0105000>]
Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 0f 85 


>>EIP; c02d8b4b <dv1394_host_reset+1b/34b>   <=====

>>eax; c0450940 <dummy_driver+0/18>
>>ecx; c02d8b30 <dv1394_host_reset+0/34b>
>>edi; c04089b1 <bl_order+3fce5/588d4>
>>ebp; c0491ee0 <init_task_union+1ee0/2000>
>>esp; c0491ec8 <init_task_union+1ec8/2000>

Trace; c02c0c76 <highlevel_host_reset+46/50>
Trace; c02c92d5 <ohci_irq_handler+305/c10>
Trace; c0108768 <handle_IRQ_event+48/80>
Trace; c0108943 <do_IRQ+83/e0>
Trace; c010ad78 <call_do_IRQ+5/d>
Trace; c0262e17 <acpi_processor_idle+f3/1f0>
Trace; c0262d24 <acpi_processor_idle+0/1f0>
Trace; c0262d24 <acpi_processor_idle+0/1f0>
Trace; c01053c2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Code;  c02d8b4b <dv1394_host_reset+1b/34b>
00000000 <_EIP>:
Code;  c02d8b4b <dv1394_host_reset+1b/34b>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  c02d8b4c <dv1394_host_reset+1c/34b>
   1:   ae                        scas   %es:(%edi),%al
Code;  c02d8b4d <dv1394_host_reset+1d/34b>
   2:   75 08                     jne    c <_EIP+0xc>
Code;  c02d8b4f <dv1394_host_reset+1f/34b>
   4:   84 c0                     test   %al,%al
Code;  c02d8b51 <dv1394_host_reset+21/34b>
   6:   75 f8                     jne    0 <_EIP>
Code;  c02d8b53 <dv1394_host_reset+23/34b>
   8:   31 c0                     xor    %eax,%eax
Code;  c02d8b55 <dv1394_host_reset+25/34b>
   a:   eb 04                     jmp    10 <_EIP+0x10>
Code;  c02d8b57 <dv1394_host_reset+27/34b>
   c:   19 c0                     sbb    %eax,%eax
Code;  c02d8b59 <dv1394_host_reset+29/34b>
   e:   0c 01                     or     $0x1,%al
Code;  c02d8b5b <dv1394_host_reset+2b/34b>
  10:   85 c0                     test   %eax,%eax
Code;  c02d8b5d <dv1394_host_reset+2d/34b>
  12:   0f 85 00 00 00 00         jne    18 <_EIP+0x18>

 <0>Kernel panic: Aiee, killing interrupt handler!
