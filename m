Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130491AbRCIMeS>; Fri, 9 Mar 2001 07:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRCIMd7>; Fri, 9 Mar 2001 07:33:59 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:56335
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S130491AbRCIMdy>; Fri, 9 Mar 2001 07:33:54 -0500
Date: Fri, 9 Mar 2001 07:43:25 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre2 es1371 crash on alpha
Message-ID: <20010309074325.B3513@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another problem.

lspci -vvx for this device:
00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Ensoniq: Unknown device 1371
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 12 min, 128 max, 32 set
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 9400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2+ PME-
                Status: D3 PME-Enable- DSel=0 DScale=0 PME-
00: 74 12 71 13 05 00 10 04 08 00 01 04 00 20 00 00
10: 01 94 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 71 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 16 01 0c 80


Dmesg:
es1371: version v0.27 time 20:48:53 Mar  6 2001
Unable to handle kernel paging request at virtual address fffffffc00269da8
modprobe(205): Oops 1
pc = [<fffffc00003cca64>]  ra = [<fffffffc00260930>]  ps = 0000
v0 = 0000000000000033  t0 = fffffc00004a8380  t1 = fffffc00004a8370
t2 = fffffffc00269da8  t3 = fffffc00004b66a0  t4 = 0000000000000001
t5 = fffffc00004ecde8  t6 = 0000000000000000  t7 = fffffc0006328000
s0 = fffffffc00258000  s1 = fffffffc002612f0  s2 = 0000000000000000
s3 = fffffc00004a8370  s4 = 00000000000000c0  s5 = 0000000120154940
s6 = 0000000000000006
a0 = fffffffc002612f0  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 00000000000000a0  a5 = ffffffffffffffff
t8 = 0000000000000004  t9 = fffffc00004b69f8  t10= fffffc00004b64d0
t11= 0000000000003fff  pv = fffffc00003cca20  at = fffffc00004b7850
gp = fffffc00004b5530  sp = fffffc000632bdb8
Trace:3245ec 310aa0 3109f8 
Code: 47e2040c b53e0008 a4610008 b5410008 b42a0000 b46a0008 <b5430000> a5220000

Decoded Oops:
ksymoops 2.3.4 on alpha 2.4.3-pre2.  Options used
     -v /243p2 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.3-pre2/ (default)
     -m /boot/System.map-2.4.3-pre2 (default)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address fffffffc00269da8
modprobe(205): Oops 1
pc = [<fffffc00003cca64>]  ra = [<fffffffc00260930>]  ps = 0000
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000033  t0 = fffffc00004a8380  t1 = fffffc00004a8370
t2 = fffffffc00269da8  t3 = fffffc00004b66a0  t4 = 0000000000000001
t5 = fffffc00004ecde8  t6 = 0000000000000000  t7 = fffffc0006328000
s0 = fffffffc00258000  s1 = fffffffc002612f0  s2 = 0000000000000000
s3 = fffffc00004a8370  s4 = 00000000000000c0  s5 = 0000000120154940
s6 = 0000000000000006
a0 = fffffffc002612f0  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 00000000000000a0  a5 = ffffffffffffffff
t8 = 0000000000000004  t9 = fffffc00004b69f8  t10= fffffc00004b64d0
t11= 0000000000003fff  pv = fffffc00003cca20  at = fffffc00004b7850
gp = fffffc00004b5530  sp = fffffc000632bdb8
Code: 47e2040c b53e0008 a4610008 b5410008 b42a0000 b46a0008 <b5430000> a5220000

>>PC;  fffffc00003cca64 <pci_register_driver+44/c0>   <=====
Code;  fffffc00003cca4c <pci_register_driver+2c/c0>
0000000000000000 <_PC>:
Code;  fffffc00003cca4c <pci_register_driver+2c/c0>
   0:   0c 04 e2 47       mov  t1,s3
Code;  fffffc00003cca50 <pci_register_driver+30/c0>
   4:   08 00 3e b5       stq  s0,8(sp)
Code;  fffffc00003cca54 <pci_register_driver+34/c0>
   8:   08 00 61 a4       ldq  t2,8(t0)
Code;  fffffc00003cca58 <pci_register_driver+38/c0>
   c:   08 00 41 b5       stq  s1,8(t0)
Code;  fffffc00003cca5c <pci_register_driver+3c/c0>
  10:   00 00 2a b4       stq  t0,0(s1)
Code;  fffffc00003cca60 <pci_register_driver+40/c0>
  14:   08 00 6a b4       stq  t2,8(s1)
Code;  fffffc00003cca64 <pci_register_driver+44/c0>   <=====
  18:   00 00 43 b5       stq  s1,0(t2)   <=====
Code;  fffffc00003cca68 <pci_register_driver+48/c0>
  1c:   00 00 22 a5       ldq  s0,0(t1)


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
