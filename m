Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTKTGcg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 01:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTKTGcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 01:32:36 -0500
Received: from muncii-fe0.b.astralnet.ro ([194.102.255.69]:12219 "EHLO
	linux.kappa.ro") by vger.kernel.org with ESMTP id S261484AbTKTGcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 01:32:33 -0500
Date: Thu, 20 Nov 2003 08:32:31 +0200
From: Teodor Iacob <Teodor.Iacob@astral.ro>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel E1000 and IDE problems
Message-ID: <20031120063231.GD19239@speedy.b.astralnet.ro>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDCE4@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDCE4@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I put them at first on the same slots.. then I changed the slots to see if the trouble goes away
and got the same results. There are no shared interrupts. At this moment at PCI Device Listing
I get the NICs on irq 10 and 11, the 1st IDE on 14 and VGA on 15 ( the 2nd IDE is disabled )

I disabled DMA on ide ( with hdparm -d 0 /dev/hda ), but now I see after a few hours of traffic
going through this machine errors in logs like hell:
end_request: I/O error, dev 03:02 (hda), sector 16515104
end_request: I/O error, dev 03:02 (hda), sector 16777248
end_request: I/O error, dev 03:03 (hda), sector 524344
end_request: I/O error, dev 03:03 (hda), sector 7864352
end_request: I/O error, dev 03:03 (hda), sector 14155920
end_request: I/O error, dev 03:03 (hda), sector 524320


vmstat 1 shows like this:
 0  0  0      0 343764  38464  35004   0   0     0     0 5901  1025   0  26  74
 0  0  0      0 343756  38472  35004   0   0     0     8 5919   906   0  30  70
 0  0  0      0 343756  38472  35004   0   0     0     0 5712   915   0  30  70
 0  0  1      0 343756  38472  35004   0   0     0     0 5641   929   0  28  72


00:09.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp. PRO/1000 MT Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2c00000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at d000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp. PRO/1000 MT Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2c20000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at d400 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000


Btw.. I don't know what you mean on the same bus segment.

On Wed, Nov 19, 2003 at 07:02:27PM -0800, Feldman, Scott wrote:
> > I recently put up 2 intel network adapters:
> > 00:09.0 Ethernet controller: Intel Corp. 82545EM Gigabit 
> > Ethernet Controller (Copper) (rev 01)
> > 00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit 
> > Ethernet Controller (Copper) (rev 01)
> > 
> > ( I replaced some Intel PRO1000 Desktop which I had before ) and now
> > I get serious problems with the hda disk:
> 
> Did you put the 82545 nics in the same slots where you had the desktop
> nics?
> 
> Are the 82545 nics on the same bus segment as the disk controller?  Are
> there any shared interrupts?  See lcpci -vvv.
> 
> -scott
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
      Teodor Iacob,
Manager Infrastructura Nationala
Astral Telecom Internet
