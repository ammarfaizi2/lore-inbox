Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRBINek>; Fri, 9 Feb 2001 08:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRBINea>; Fri, 9 Feb 2001 08:34:30 -0500
Received: from pool002.seabone.net ([195.22.194.162]:5639 "EHLO
	paperino.int-seabone.net") by vger.kernel.org with ESMTP
	id <S129212AbRBINeR>; Fri, 9 Feb 2001 08:34:17 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 oops at boot
Reply-To: Pierfrancesco Caci <p.caci@seabone.net>
From: Pierfrancesco Caci <p.caci@seabone.net>
Date: 09 Feb 2001 14:34:05 +0100
Message-ID: <874ry40ylu.fsf@paperino.int-seabone.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get this kernel panic on an Olivetti netstrada 7200. It happens also
with 2.4.0. With 2.2.18 I can boot normally.

Unable to handle kernel NULL pointer dereference at virtual address 0000003b
c019dcab
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c019dcab>]
EFLAGS: 00010202
eax: ffffffff   ebx: f7fbf000     ecx: 00000000       edx: 0000001f
esi: c1efffb0   edi: f7fbf284     ebp: c1ef8ad4       esp: c1effcc4
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 1, stackpage=c1eff000)
Stack:  0000001f 00000007 f7fbf000 c025c8e5 c025c919 f7fbf000 00000018 00000000
        c1effd2c 00141011 c025c98e c1effd2c 00000018 00000000 c1effd2c c1effd2c
        00000000 00000000 00000000 c025ca4a c1effd2c c1ef8ac0 c0239e94 00000000
Call Trace: [<c0107007>] [<c0107424>]
Code: 0f b6 40 3c 50 68 d6 09 22 c0 8d 83 64 02 00 00 50 e8 53 6d

>>EIP; c019dcab <pci_setup_device+1b/160>   <=====
Trace; c0107007 <init+7/110>
Trace; c0107424 <kernel_thread+28/38>
Code;  c019dcab <pci_setup_device+1b/160>
00000000 <_EIP>:
Code;  c019dcab <pci_setup_device+1b/160>   <=====
   0:   0f b6 40 3c               movzbl 0x3c(%eax),%eax   <=====
Code;  c019dcaf <pci_setup_device+1f/160>
   4:   50                        push   %eax
Code;  c019dcb0 <pci_setup_device+20/160>
   5:   68 d6 09 22 c0            push   $0xc02209d6
Code;  c019dcb5 <pci_setup_device+25/160>
   a:   8d 83 64 02 00 00         lea    0x264(%ebx),%eax
Code;  c019dcbb <pci_setup_device+2b/160>
  10:   50                        push   %eax
Code;  c019dcbc <pci_setup_device+2c/160>
  11:   e8 53 6d 00 00            call   6d69 <_EIP+0x6d69> c01a4a14 <fbcon_scrolldelta+14/2a8>

Kernel panic: Attempted to kill init!


This is what the machine has inside :

00:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 11)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 set
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec00
	Region 1: Memory at df000000 (32-bit, non-prefetchable)
	Expansion ROM at de000000 [disabled]

00:05.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 15)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 set

00:14.0 RAM memory: Intel Corporation 450KX/GX [Orion] - 82453KX/GX Memory controller (rev 05)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Intel Corporation 450KX/GX [Orion] - 82454KX/GX PCI bridge (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 96 set, cache line size 08

00:1a.0 Host bridge: Intel Corporation 450KX/GX [Orion] - 82454KX/GX PCI bridge (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 96 set, cache line size 08

01:00.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
	Subsystem: Adaptec: Unknown device 7880
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 96 set, cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at d400
	Region 1: Memory at dd000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-





-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci |            System Administrator @ seabone.net
 p.caci@seabone.net |     Telecom Italia S.p.A. - International Operations
     Linux paperino 2.4.0 #1 Tue Jan 9 12:10:18 CET 2001 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
