Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318082AbSGPUbY>; Tue, 16 Jul 2002 16:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSGPUbX>; Tue, 16 Jul 2002 16:31:23 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:60653 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S318082AbSGPUbV>; Tue, 16 Jul 2002 16:31:21 -0400
Date: Tue, 16 Jul 2002 21:34:08 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.4.18 maestro] intermittently repeatable Solid hang..
Message-ID: <20020716213408.A14626@computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I saw this on 2.2.x too, and was much more repeatable there ;-).

Sometimes, my system will solid hang if playing PCM audio
(mp3/realplayer etc) at the same time the console bell
is invoked (Normally through XFree 3.6).

I guess this is somre sort of race but couldn't see anyhting
obvious in the maestro driver by inspection, unless sharing
the irq with the cardbus controller is a clue.. Hmm.

Cardbus handling changed in 2.4 hasn't it.., could this
be spending to long with the irq masked.., 
Interestingly I also saw errorenous PCMCIA ejects under
2.2.x which seem to gone away under 2.4...



lspci -vvv , report these devices (amongst others - rest of Intel chipset PIIX4, inc 
          AGP bridge and USB , and PCI1250 cardbis brigde , cyberblade 9397 video card)

00:09.0 Multimedia audio controller: ESS Technology ES1978 Maestro Audiodrive (rev 10)
	Subsystem: ESS Technology: Unknown device 1978
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 2 min, 24 max, 128 set
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 3000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 set
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=21
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=1


/proc/interrupts ->
        CPU0       
  0:     515873          XT-PIC  timer
  1:      19131          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      45413          XT-PIC  pcnet_cs
  8:          1          XT-PIC  rtc
 10:          0          XT-PIC  ESS Maestro 2E, Texas Instruments PCI1250, Texas Instruments PCI1250 (#2)
 12:       8329          XT-PIC  PS/2 Mouse
 14:     199333          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0



cat /proc/modules -->
Module                  Size  Used by    Not tainted
nfs                    69500   1  (autoclean)
lockd                  46656   1  (autoclean) [nfs]
sunrpc                 58196   1  (autoclean) [nfs lockd]
ide-cd                 26176   1  (autoclean)
cdrom                  27136   0  (autoclean) [ide-cd]
parport_pc             21960   1  (autoclean)
lp                      5952   1  (autoclean)
parport                22944   1  (autoclean) [parport_pc lp]
pcnet_cs               10180   1 
8390                    5888   0  [pcnet_cs]
ds                      6464   2  [pcnet_cs]
yenta_socket            8384   2 
pcmcia_core            38656   0  [pcnet_cs ds yenta_socket]
rtc                     5368   0  (autoclean)
apm                     8892   1 
maestro                25664   1 
soundcore               3556   2  [maestro]
unix                   13316 147  (autoclean)
ide-disk                6592   2  (autoclean)
ide-probe-mod           7968   0  (autoclean)
ide-mod               129420   3  (autoclean) [ide-cd ide-disk ide-probe-mod]
ext3                   56544   1  (autoclean)
jbd                    34968   1  (autoclean) [ext3]


More details of system avail on request etc,..

Hints appreciated while I go off and read the yenta and
maestro (again) sources.


TTFN
-- 
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
