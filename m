Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRB1SZG>; Wed, 28 Feb 2001 13:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRB1SY5>; Wed, 28 Feb 2001 13:24:57 -0500
Received: from cr793392-a.pr1.on.wave.home.com ([24.112.97.56]:1028 "EHLO
	prophit.maincube.net") by vger.kernel.org with ESMTP
	id <S129165AbRB1SYu>; Wed, 28 Feb 2001 13:24:50 -0500
From: "David Priban" <david2@maincube.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: i2o & Promise SuperTrak100
Date: Wed, 28 Feb 2001 13:26:20 -0500
Message-ID: <MPBBILLJAONHMANIJOPDOEFNFMAA.david2@maincube.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E14Xnz8-0003rQ-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Kernel panic: Aiee, killing interrupt handler !
> > In interrupt handler - not syncing
>
> Run it through ksymoops and I might be able to guess what went wrong.
>
> In theory however i2o is a standard and all i2o works alike. In
> practice i2o
> is a pseudo standard and nobody seems to interpret the spec the
> same way, the
> implementations all tend to have bugs and the hardware sometimes does too.
>
Alan,
This is what ksymoops gave me. One thing I didn't mention before:
kernel panics when I hit Ctrl-Alt-Del after it hangs telling me this:

>>Loading I2O core - (c) Copyright 1999 Read Hat Software
>>i2o: Checking for PCI I2O controllers...
>>PCI: Found IRQ5 for device 00:0a.1
>>i2o: I2O Controller on bus 0 at 81
>>i2o: PCI I2O controller at 0xE3000000 size=4194304
>>i2o/iop0: Installed at IRQ5
>>i2o: 1 I2O controller found and installed
>>Activating I2O controllers...
>>This may take few minutes if you have many devices
>>i2o/iop0: Reset rejected, trying to clear
>>i2o/iop0: LCT has 6 entries
>>i2o/iop0: Configuration dialog desired.
>>Target ID 0.
>>	Vendor:	Wind River Sys.
>>	Device:	IxWorks
>>	Rev:	0201
>>	class:	executive
>>	subclass:	0x0001
>>	Flags:	PM
>>Target ID 8.
>>	Vendor:	PROMISE TECH.
>>	Device:	I2O RAID ISM
>>	Rev:	V1.0.0
>>	Class:	Device Driver Module
>>	Subclass:0x0021
>>	Flags:	PM
>>Target ID 9.
>>	Vendor:	PROMISE TECH.
>>	Device:	I2O IDE HDM
>>	Rev:	0.02
>>	Class:	Device Driver Module
>>	Subclass:0x0020
>>	Flags:	PM
>>Target ID 10.
>>	Vendor:	Seagate
>>	Device:	Technology 1275 M
>>	Rev:	1.35
>>	Class:	Block Device
>>	Subclass:0x0000
>>	Flags:	CPM
>>Target ID 14.
>>	Vendor:	PROMISE TECH.
>>	Device:	I2O RAID DEVICE
>>	Rev:	V1.0.0
>>	Class:	Block Device
>>	Subclass:0x0000
>>	Flags:	PM
>>Target ID 15.
>>	Vendor:	WD
>>	Device:	AC31200F
>>	Rev:	14.04E28
>>	Class:	Block Device
>>	Subclass:0x0000
>>	Flags:	CPM
>>I2O Configuration Manager v 0.04
>>        (c) Copyright 1999 Read Hat Software
>>I2O Block Storage OSM v0.9
>>        (c) Copyright 1999, 2000 Read Hat Software.
>>i2o/iop0: No handler for event (0x02000000)
>>i2o_block: Controller 0 TID 14
>>Device Refused Claim! Skipping Installation

That is last line on console. Nothing of this actually make it
to the syslog.

Thanks   David



ksymoops 2.3.7 on i686 2.4.2-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-ac1/ (default)
     -m /boot/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
invalid operand: 0000
CPU:       0
EIP:       0010:[<c01110e4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001b  ebx: c7f99760  ecx: 00000001  edx: c02477c8
esi: 0000c204  edi: c025a000  ebp: c025beac  esp: c025be7c
Process swapper(pid:0, stackpage=c0259000)
Stack: c01fa2ab c01fa416 000002c3 c7f99760 0000c204 c1272af8 00000044
00000082
       00000000 c7f99760 00000000 c01b3bce c1272aa0 c01b3c6c c7f99760
c7f99760
       00000001 00000053 c01b385f c7f99760 c7f99760 c0255640 00000001
c029272a
Call Trace: [<c01b3bce>] [<c01b3c6c>] [<c01b385f>] [<c01b4f44>]
[<c01b4f76>] [<c011b0fe>] [<c011b4bf>] [<c0189a0d>]
[<c0189aa1>] [<c01894f9>] [<c018a49d>] [<c018a50f>]
[<c0109f6d>] [<c010a0ce>] [<c0107120>] [<c0107120>]
[<c0108e00>] [<c0107120>] [<c0107120>] [<c0100018>]
[<c0107143>] [<c01071a9>] [<c0105000>] [<c0100191>]
Code: 0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 55 89 e5 83 ec 10 57 56

>>EIP; c01110e4 <schedule+388/394>   <=====
Trace; c01b3bce <i2o_status_get+52/100>
Trace; c01b3c6c <i2o_status_get+f0/100>
Trace; c01b385f <i2o_quiesce_controller+f/7c>
Trace; c01b4f44 <i2o_reboot_event+28/94>
Trace; c01b4f76 <i2o_reboot_event+5a/94>
Trace; c011b0fe <notifier_call_chain+1e/38>
Trace; c011b4bf <ctrl_alt_del+17/38>
Trace; c0189a0d <boot_it+5/8>
Trace; c0189aa1 <do_spec+31/34>
Trace; c01894f9 <handle_scancode+28d/2c8>
Trace; c018a49d <handle_kbd_event+111/174>
Trace; c018a50f <keyboard_interrupt+f/14>
Trace; c0109f6d <handle_IRQ_event+35/60>
Trace; c010a0ce <do_IRQ+6e/b0>
Trace; c0107120 <default_idle+0/28>
Trace; c0107120 <default_idle+0/28>
Trace; c0108e00 <ret_from_intr+0/20>
Trace; c0107120 <default_idle+0/28>
Trace; c0107120 <default_idle+0/28>
Trace; c0100018 <startup_32+18/139>
Trace; c0107143 <default_idle+23/28>
Trace; c01071a9 <cpu_idle+41/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c01110e4 <schedule+388/394>
00000000 <_EIP>:
Code;  c01110e4 <schedule+388/394>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01110e6 <schedule+38a/394>
   2:   8d 65 dc                  lea    0xffffffdc(%ebp),%esp
Code;  c01110e9 <schedule+38d/394>
   5:   5b                        pop    %ebx
Code;  c01110ea <schedule+38e/394>
   6:   5e                        pop    %esi
Code;  c01110eb <schedule+38f/394>
   7:   5f                        pop    %edi
Code;  c01110ec <schedule+390/394>
   8:   89 ec                     mov    %ebp,%esp
Code;  c01110ee <schedule+392/394>
   a:   5d                        pop    %ebp
Code;  c01110ef <schedule+393/394>
   b:   c3                        ret
Code;  c01110f0 <__wake_up+0/a8>
   c:   55                        push   %ebp
Code;  c01110f1 <__wake_up+1/a8>
   d:   89 e5                     mov    %esp,%ebp
Code;  c01110f3 <__wake_up+3/a8>
   f:   83 ec 10                  sub    $0x10,%esp
Code;  c01110f6 <__wake_up+6/a8>
  12:   57                        push   %edi
Code;  c01110f7 <__wake_up+7/a8>
  13:   56                        push   %esi


2 warnings issued.  Results may not be reliable.

