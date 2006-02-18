Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWBRPzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWBRPzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 10:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWBRPzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 10:55:00 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:36283
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750794AbWBRPy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 10:54:59 -0500
Message-ID: <43F74352.1040907@ed-soft.at>
Date: Sat, 18 Feb 2006 16:54:58 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Brian Hall <brihall@pcisys.net>, linux-kernel@vger.kernel.org,
       shemminger@osdl.org
Subject: Re: Help: DGE-560T not recognized by Linux
References: <20060217222720.a08a2bc1.brihall@pcisys.net>	<20060217222428.3cf33f25.akpm@osdl.org>	<20060218003622.30a2b501.brihall@pcisys.net> <20060217234841.5f2030ec.akpm@osdl.org>
In-Reply-To: <20060217234841.5f2030ec.akpm@osdl.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hitting here the same problem on the Intel iMac.

Here are some infos :

lspci -n :
02:00.0 0200: 11ab:4362 (rev 22)

lspci -vv:
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E
Gigabit Ethernet Controller (rev 22)
        Subsystem: Marvell Technology Group Ltd. Marvell RDK-8053
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 88200000 (64-bit, non-prefetchable) [size=16K]
        Region 2: I/O ports at 1000 [size=256]
        Expansion ROM at 1ff00000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                Device: Latency L0s unlimited, L1 unlimited
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 2048 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
                Link: Latency L0s <256ns, L1 unlimited
                Link: ASPM Disabled RCB 128 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x1

Infos from dmesg :

ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 0000:02:00.0: can't access PCI config space
ACPI: PCI interrupt for device 0000:02:00.0 disabled
sky2: probe of 0000:02:00.0 failed with error -22

If i can provide more infos let me know.

cu

Edgar

Andrew Morton wrote:
> Brian Hall <brihall@pcisys.net> wrote:
>> Using sk98lin this "almost" worked- brought the line up, got a
>>  gigabit connection light on my switch, but trying to assign an IP to
>>  the interface results in a kernel panic. Not good...
> 
> As Randy says, sky2 looks like your best bet.
> 
>>  I see that the sky2 driver in 2.6.16rc4 lists my card, but for some
>>  reason it fails to access the card, maybe because I have an ULi chipset?
>>
>>  Feb 17 23:18:46 syrinx sky2 0000:02:00.0: can't access PCI config space
> 
> Looks like something died way down in the PCI bus config space read/write
> operations.  I don't know what would cause that.  You could perhaps play
> with `pci=conf1', `pci=conf2', etc as per
> Documentation/kernel-parameters.txt.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

