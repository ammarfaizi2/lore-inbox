Return-Path: <linux-kernel-owner+w=401wt.eu-S1750967AbWLLIEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWLLIEr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 03:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWLLIEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 03:04:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:20894 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbWLLIEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 03:04:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lZV36SRow4WhQdtjzC2D/emnVa4tfLzJ6Y66ayQx6+2/lUNcdTqIWjVulBSQ0qglisSpAbg1bq3p/Ot7lJ61BOenLFsdQhrOb3AGQ+rJhEGgubYd7BAk9Kt5TSkL8iH9ke1irBQttORYXTileNRf+uyeb2DraMQ619VCEjMOrto=
Message-ID: <d9def9db0612120004r45fa1b1dx270a2e9e5be57246@mail.gmail.com>
Date: Tue, 12 Dec 2006 09:04:44 +0100
From: "Markus Rechberger" <mrechberger@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Yenta Cardbus allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a PCMCIA Hybrid TV tuner, but when I plug it in it fails to
allocate resources for the 3rd PCI function.
I already searched with google and someone implemented an otion

parm:           override_bios:yenta ignore bios resource allocation (uint

in yenta_socket, though this doesn't seem to work out with that device.

Any idea how that problem can be solved?

So here are some logs

lspci:
0000:03:00.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI
Video and Audio Decoder (rev 05)
        Subsystem: Yuan Yuan Enterprise Co., Ltd.: Unknown device 1788
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (5000ns min, 13750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 36000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:00.1 Multimedia controller: Conexant CX23880/1/2/3 PCI Video
and Audio Decoder [Audio Port] (rev 05)
        Subsystem: Yuan Yuan Enterprise Co., Ltd.: Unknown device 1788
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 37000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:00.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video
and Audio Decoder [MPEG Port] (rev 05)
        Subsystem: Yuan Yuan Enterprise Co., Ltd.: Unknown device 1788
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccdff : Video ROM
000cd000-000ce7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1dedffff : System RAM
  00100000-002ada17 : Kernel code
  002ada18-0037ebc7 : Kernel data
1dee0000-1deebfff : ACPI Tables
1deec000-1defffff : ACPI Non-volatile Storage
1df00000-1fffffff : reserved
30000000-33ffffff : PCI Bus #02
  30000000-31ffffff : PCI CardBus #03
  32000000-33ffffff : PCI CardBus #07
34000000-340003ff : 0000:00:1f.1
36000000-37ffffff : PCI CardBus #03
  36000000-36ffffff : 0000:03:00.0
    36000000-36ffffff : cx88[0]
  37000000-37ffffff : 0000:03:00.1
    37000000-37ffffff : cx88[0]
38000000-39ffffff : PCI CardBus #07
e0000000-e007ffff : 0000:00:02.0
e0080000-e00fffff : 0000:00:02.1
e0100000-e01003ff : 0000:00:1d.7
  e0100000-e01003ff : ehci_hcd
e0100800-e01008ff : 0000:00:1f.5
  e0100800-e01008ff : Intel 82801DB-ICH4
e0100c00-e0100dff : 0000:00:1f.5
  e0100c00-e0100dff : Intel 82801DB-ICH4
e0200000-e07fffff : PCI Bus #02
  e0200000-e0203fff : 0000:02:07.0
  e0204000-e0205fff : 0000:02:02.0
    e0204000-e0205fff : b44
  e0206000-e0206fff : 0000:02:04.0
    e0206000-e0206fff : ipw2100
  e0207000-e0207fff : 0000:02:06.0
    e0207000-e0207fff : yenta_socket
  e0208000-e0208fff : 0000:02:06.1
    e0208000-e0208fff : yenta_socket
  e0209000-e02097ff : 0000:02:07.0
    e0209000-e02097ff : ohci1394
  e0260000-e0260fff : pcmcia_socket1
e8000000-efffffff : 0000:00:02.0
f0000000-f7ffffff : 0000:00:02.1
fec10000-fec1ffff : reserved
ff800000-ffbfffff : reserved
fffffc00-ffffffff : reserved



dmesg:
Yenta: CardBus bridge found at 0000:02:06.0 [1025:0035]
Yenta O2: res at 0x94/0xD4: 00/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000820
Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe07fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
Yenta: CardBus bridge found at 0000:02:06.1 [1025:0035]
Yenta: ISA IRQ mask 0x00b8, PCI irq 10
Socket status: 30000410
Yenta: Raising subordinate bus# of parent bus (#02) from #06 to #0a
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
cs: IO port probe 0x3000-0x3fff: clean.
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe07fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
pccard: CardBus card inserted into slot 0
PCI: Failed to allocate mem resource #0:1000000@38000000 for 0000:03:00.2


thanks,
Markus
