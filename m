Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSJ0SPN>; Sun, 27 Oct 2002 13:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262476AbSJ0SPN>; Sun, 27 Oct 2002 13:15:13 -0500
Received: from mail.scram.de ([195.226.127.117]:19402 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261963AbSJ0SPK>;
	Sun, 27 Oct 2002 13:15:10 -0500
Date: Sun, 27 Oct 2002 19:15:49 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: linux-kernel@vger.kernel.org
Subject: [BUG] ohci-hcd Oops on Alpha 2.5.44
Message-ID: <Pine.LNX.4.44.0210271906400.780-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have an Alpha with a quad OHCI USB PCI Adapter and an USB-RS232
converter connected to it. If i open and close the corresponding tty
(ttyUSB0) twice in a row, the alpha crashes with an Oops in
[ohci-hcd]finish_unlinks(). Otherwise, the device seems to work fine
(until the second close)...

Cheers,
--jochen

# uname -a
Linux ayse 2.5.44 #3 Sat Oct 26 22:04:04 CEST 2002 alpha EV56  GNU/Linux

# cat /proc/bus/usb/devices
T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 1
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 1
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 1
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0711 ProdID=0230 Rev= 1.02
S:  Manufacturer=USB-RS232 Interface Converter
S:  Product=USB Ver1.1 Device
S:  SerialNumber=842062
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=mct_u232
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=2ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 1
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms


drivers/usb/host/ohci-q.c: 01:0a.1 bad entry a8e0a1a0
Unable to handle kernel paging request at virtual address 000000000000000c
swapper(0): Oops 0
pc = [<fffffffc002da62c>]  ra = [<fffffffc002db960>]  ps = 0000    Not
tainted
v0 = fffffff800000016  t0 = 0000000000000000  t1 = fffffc0028e0a1c0
t2 = fffffc0029801028  t3 = fffffc0000629230  t4 = fffffc87a0000000
t5 = fffffc0000571300  t6 = 0000000000000008  t7 = fffffc000054c000
s0 = fffffc0028e120a0  s1 = 0000000000000000  s2 = fffffc0000000000
s3 = fffffc0028e120a8  s4 = fffffc0029801000  s5 = fffffc0028e120d0
s6 = fffffc0028e120d0
a0 = fffffc0029801000  a1 = fffffc0028e0a180  a2 = fffffc000054fed8
a3 = cccccccccccccccd  a4 = fffffc0000627b90  a5 = fffffc000057cf68
t8 = 0000000000000000  t9 = 000000007ab30958  t10= 0000000000000000
t11= 000000000000e155  pv = fffffc000031ec60  at = fffffc000057cf00
gp = fffffffc002e4368  sp = fffffc000054fd78
Trace:fffffc0000315f1c fffffc0000316960 fffffc0000325634 fffffc00003125e0
fffffc0000316fc4 fffffc0000310cf8 fffffc0000312628 fffffc00003125e0
fffffc0000381584 fffffc0000312638 fffffc0000381584 fffffc00003100b4
fffffc000031001c
Code: a59e0060  b7fe0050  c3e00025  40481531  a5710028  a54b0008
<a02a000c> 402035a1
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

>>RA;  fffffffc002db960 <[ohci-hcd]ohci_irq+1a0/240>

>>PC;  fffffffc002da62c <[ohci-hcd]finish_unlinks+cc/320>   <=====

Trace; fffffc0000315f1c <handle_IRQ_event+9c/100>
Trace; fffffc0000316960 <handle_irq+140/200>
Trace; fffffc0000325634 <miata_srm_device_interrupt+34/60>
Trace; fffffc00003125e0 <default_idle+0/20>
Trace; fffffc0000316fc4 <do_entInt+c4/140>
Trace; fffffc0000310cf8 <ret_from_sys_call+0/10>
Trace; fffffc0000312628 <cpu_idle+28/60>
Trace; fffffc00003125e0 <default_idle+0/20>
Trace; fffffc0000381584 <do_select+264/2e0>
Trace; fffffc0000312638 <cpu_idle+38/60>
Trace; fffffc0000381584 <do_select+264/2e0>
Trace; fffffc00003100b4 <rest_init+34/60>
Trace; fffffc000031001c <_text+1c/20>

Code;  fffffffc002da614 <[ohci-hcd]finish_unlinks+b4/320>
0000000000000000 <_PC>:
Code;  fffffffc002da614 <[ohci-hcd]finish_unlinks+b4/320>
   0:   60 00 9e a5       ldq  s3,96(sp)
Code;  fffffffc002da618 <[ohci-hcd]finish_unlinks+b8/320>
   4:   50 00 fe b7       stq  zero,80(sp)
Code;  fffffffc002da61c <[ohci-hcd]finish_unlinks+bc/320>
   8:   25 00 e0 c3       br   a0 <_PC+0xa0> fffffffc002da6b4
<[ohci-hcd]finish_unlinks+154/320>
Code;  fffffffc002da620 <[ohci-hcd]finish_unlinks+c0/320>
   c:   31 15 48 40       subq t1,0x40,a1
Code;  fffffffc002da624 <[ohci-hcd]finish_unlinks+c4/320>
  10:   28 00 71 a5       ldq  s2,40(a1)
Code;  fffffffc002da628 <[ohci-hcd]finish_unlinks+c8/320>
  14:   08 00 4b a5       ldq  s1,8(s2)
Code;  fffffffc002da62c <[ohci-hcd]finish_unlinks+cc/320>   <=====
  18:   0c 00 2a a0       ldl  t0,12(s1)   <=====
Code;  fffffffc002da630 <[ohci-hcd]finish_unlinks+d0/320>
  1c:   a1 35 20 40       cmpeq        t0,0x1,t0

Kernel panic: Aiee, killing interrupt handler!


