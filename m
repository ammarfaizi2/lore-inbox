Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUD1TOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUD1TOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUD1TC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:02:56 -0400
Received: from dns1.vanja.com ([207.44.194.94]:19418 "EHLO dns1.vanja.com")
	by vger.kernel.org with ESMTP id S264935AbUD1Qds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:33:48 -0400
Date: Wed, 28 Apr 2004 18:33:25 +0200
From: Vanja Hrustic <vanja@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: PCI problem with RICOH RL5C475 PCI/PCMCIA adapter, on 2.4.26
Message-Id: <20040428183325.2860bd95.vanja@pobox.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have PCI-PCMCIA adapter (Ricoh RL5C475 based) in a desktop machine.

Initially, I had problems making it work, but managed to get help on
comp.os.linux.portable. Now, most of the cards work okay.

However, I still have one wireless PCMCIA card (Prism GT based) which
doesn't work, and was advised to post the problem here.

Dave (from comp.os.linux.portable) said:

"This part is a tricky one.  It is a bug in the kernel's PCI resource
allocation code.  It tries to allocate CardBus memory resources from
whatever memory ranges happened to be allocated for the bridge device
by the BIOS at power-up time; but in this case, those memory windows
are too small.  There isn't a simple fix for this and I don't have a
good suggestion for what to do about it; you can report it on the
linux-kernel mailing list."

cardmgr starts okay, and when I insert the card, I get:

Apr 23 16:16:52 amber cardmgr[7537]: watching 1 socket
Apr 23 18:16:52 amber kernel: cs: IO port probe 0xc000-0xcfff: clean.
Apr 23 18:16:58 amber kernel: cs: cb_alloc(bus 2): vendor 0x1260, device 0x3890
Apr 23 18:16:58 amber kernel: PCI: Failed to allocate resource 0(e2006000-e2004fff) for 02:00.0
Apr 23 18:16:58 amber kernel: PCI: Enabling device 02:00.0 (0000 -> 0002)
Apr 23 16:16:58 amber cardmgr[7538]: socket 0: CardBus hotplug device
Apr 23 18:16:58 amber /etc/hotplug/pci.agent: Setup prism54 for PCI slot 02:00.0
Apr 23 18:16:58 amber kernel: Loaded prism54 driver, version 1.1
Apr 23 18:16:58 amber kernel: PCI: Unable to reserve mem region #1:fffff000@e2006000 for device 02:00.0
Apr 23 18:16:58 amber kernel: PCI: Unable to reserve mem region #1:fffff000@e2006000 for device 02:00.0
Apr 23 18:16:58 amber kernel: prism54: pci_request_regions failure (rc=-16)
Apr 23 18:16:58 amber insmod: /lib/modules/2.4.26/kernel/drivers/net/wireless/prism54/prism54.o: init_module: No such device
Apr 23 18:16:58 amber insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.      You may find more information in syslog or the output from dmesg
Apr 23 18:16:58 amber insmod: /lib/modules/2.4.26/kernel/drivers/net/wireless/prism54/prism54.o: insmod /lib/modules/2.4.26/kernel/drivers/net/wireless/prism54/prism54.o failed
Apr 23 18:16:58 amber insmod: /lib/modules/2.4.26/kernel/drivers/net/wireless/prism54/prism54.o: insmod prism54 failed
Apr 23 18:16:58 amber /etc/hotplug/pci.agent: ... can't load module prism54
Apr 23 18:16:58 amber /etc/hotplug/pci.agent: missing kernel or user mode driver prism54 

lspci -vvv shows:

...
01:08.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
        Subsystem: CARRY Computer ENG. CO Ltd: Unknown device 0101
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: e2001000-e2002000 (prefetchable)
        Memory window 1: e2003000-e2004000
        I/O window 0: 0000c000-0000c403
        I/O window 1: 0000c800-0000cc03
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

02:00.0 Network controller: Intersil Corporation Intersil ISL3890 [Prism GT/Prism Duette] (rev 01)
        Subsystem: Unknown device 17cf:0014
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: [virtual] Memory at e2006000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
...

Kernel is 2.4.26, running on nForce2 based motherboard. Kernel is compiled
with CONFIG_HIMEM enabled, although same behaviour was with the same
option disabled.

Any help with this is much appreciated. I will provide more details, if
needed.

Thanks.

