Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129273AbRBKN3p>; Sun, 11 Feb 2001 08:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129360AbRBKN3f>; Sun, 11 Feb 2001 08:29:35 -0500
Received: from gatekeeper.gozer.weebeastie.net ([61.8.7.91]:49157 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129273AbRBKN3P>; Sun, 11 Feb 2001 08:29:15 -0500
Date: Sun, 11 Feb 2001 22:40:33 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: eepro100 + 2.2.18 + laptop problems
Message-ID: <20010211224033.G352@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a minipci card in my laptop. It's purpose in life is to be
a modem and ethernet card, with the ethernet side being an eepro100.
lspci -vv gives me the following:

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 09)
        Subsystem: Intel Corporation: Unknown device 2411
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8002000 (32-bit, non-prefetchable)
        Region 1: I/O ports at 1400
        Region 2: Memory at e8020000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

00:0d.1 Serial controller: Xircom: Unknown device 00d3 (prog-if 02 [16550])
        Subsystem: Intel Corporation: Unknown device 2411
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1470
        Region 1: Memory at e8003000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

The modem side is not really in use as it doesn't look like a normal
modem *sob* 8(. Anyhow, rarely at bootup but more often when I unsuspend
(from disk now-a-days) I get the following:

Feb 11 22:30:18 theirongiant kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Feb 11 22:30:18 theirongiant kernel: eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Feb 11 22:30:18 theirongiant kernel: eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
Feb 11 22:30:18 theirongiant kernel: eth0: Intel PCI EtherExpress Pro100 82557, 00:10:A4:0E:7F:EC, IRQ 10.
Feb 11 22:30:18 theirongiant kernel:   Board assembly 000695-001, Physical connectors present: RJ45
Feb 11 22:30:18 theirongiant kernel:   Primary interface chip i82555 PHY #1.
Feb 11 22:30:18 theirongiant kernel:   General self-test: passed.
Feb 11 22:30:18 theirongiant kernel:   Serial sub-system self-test: passed.
Feb 11 22:30:18 theirongiant kernel:   Internal registers self-test: passed.
Feb 11 22:30:18 theirongiant kernel:   ROM checksum self-test: passed (0xdbd8681d).
Feb 11 22:30:18 theirongiant kernel:   Receiver lock-up workaround activated.
Feb 11 22:30:18 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
Feb 11 22:30:18 theirongiant kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!
Feb 11 22:30:18 theirongiant kernel: eepro100: cmd_wait for(0xffffff90) timedout with(0xffffff90)!
Feb 11 22:30:31 theirongiant last message repeated 12 times
Feb 11 22:30:31 theirongiant kernel: eth0: 0 multicast blocks dropped.
Feb 11 22:30:34 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
Feb 11 22:30:34 theirongiant kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!
Feb 11 22:30:34 theirongiant kernel: eepro100: cmd_wait for(0xffffff90) timedout with(0xffffff90)!
Feb 11 22:30:49 theirongiant last message repeated 12 times
Feb 11 22:30:49 theirongiant kernel: eth0: 0 multicast blocks dropped.
Feb 11 22:30:52 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
Feb 11 22:30:52 theirongiant kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!
Feb 11 22:30:52 theirongiant kernel: eepro100: cmd_wait for(0xffffff90) timedout with(0xffffff90)!
Feb 11 22:30:56 theirongiant last message repeated 7 times
Feb 11 22:30:56 theirongiant kernel: eth0: 0 multicast blocks dropped.

The only way to get it out of this, without a reboot is to drop eth0
and then bring it back up, but, like this time, that doesn't always
work and it takes a few goes at it.

The driver itself is compiled as a module and the interface is dropped and
the module unloaded when the laptop is being suspended and then the module
is loaded back in and the interface brought back up. This is because the
driver doesn't realise that the card has been turned off and it needs
reinitialisation (which is what the reloading of the module does I presume).

This also happened with 2.2.19pre7 and 2.2.18preX. I don't know if it 
happens with 2.4.x as I haven't used it long enough. The ps/2 driver
seems broken (at least in 2.4.0) which is another issue I have to take up
in a seperate email.

Anyhow, can anyone help? If you need more info just holler.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
