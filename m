Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSCRLpO>; Mon, 18 Mar 2002 06:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310661AbSCRLpJ>; Mon, 18 Mar 2002 06:45:09 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:45526 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310658AbSCRLox>; Mon, 18 Mar 2002 06:44:53 -0500
Date: Mon, 18 Mar 2002 12:44:11 +0100
From: Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Message-Id: <200203181144.g2IBiBS00669@orion.steiner.local>
To: garloff@suse.de, linux-kernel@vger.kernel.org
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
        Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Subject: Re: SCSI-Problem with AM53C974
In-Reply-To: <20020318010538.B14900@gum01m.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.dev.kernel, Kurt Garloff wrote:

>On Sun, Mar 17, 2002 at 11:58:38PM +0100, Matthias Andree wrote:
>> [...]
>> Command timeouts rather look like bus termination problem, plug loose or
>> something like that. Does the problem still occur with all cables
>> unplugged from the DC-2974? 

I've testet another case: first load the AM53C974, it works! So there
should be no loose plug or something like that.

>> Does the problem occur with the DC-2974 in
>> a different computer?

I've foud only one message in a Mandrake forum, where someone
complained about trouble with the AM53C974 and asked if there couldn't
be loaded another driver. But if it's really the same problem, I don't
know.

>As far as I could see there were TWO driver loaded trying to drive the same
>piece of hardware at the same time. You can really expect trouble if this
>happens and you can't take any conclusions about hardware problems.
>
>The problem is of course with the drivers: They should not allow to be
>loaded both for the same device.
>IMHO, The AM53C974 driver should register the ioports and fail
>initialization if it can't grab them, so the conflict would be solved. I'll
>investigate what the most proper solution to avoid such things is and come
>up with a patch.

This is told when loading AM53C974 first:
Mar 18 12:00:40 orion kernel: PCI: Found IRQ 15 for device 00:0a.0
Mar 18 12:00:40 orion kernel: PCI: Sharing IRQ 15 with 00:07.5
Mar 18 12:00:40 orion kernel: scsi0 : AM53/79C974 PCscsi driver rev.
0.5; host I/O address: 0xc000; irq: 15
Mar 18 12:00:40 orion kernel: 
Mar 18 12:00:40 orion kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-40TS
Rev: 1.10
Mar 18 12:00:40 orion kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
Mar 18 12:00:40 orion kernel:   Vendor: FUJITSU   Model: MCE3064SS
Rev: 0030
Mar 18 12:00:40 orion kernel:   Type:   Optical Device
ANSI SCSI revision: 02


After loading the AM53C974 as first driver, I tried to load the tmscsim
again. I run into the same problem as vise versa:


Mar 18 12:02:13 orion kernel: PCI: Found IRQ 15 for device 00:0a.0
Mar 18 12:02:13 orion kernel: PCI: Sharing IRQ 15 with 00:07.5
Mar 18 12:02:13 orion kernel: DC390_init: No EEPROM found! Trying
default settings ...
Mar 18 12:02:13 orion kernel: DC390: Used defaults: AdaptID=7,
SpeedIdx=0 (10.0 MHz), DevMode=0x1f, AdaptMode=0x0f, TaggedCmnds=3
Mar 18 12:02:13 orion kernel: DC390: 1 adapters found
Mar 18 12:02:13 orion kernel: scsi0 : Tekram DC390/AM53C974 V2.0f
2000-12-20
Mar 18 12:02:19 orion kernel: scsi : aborting command due to timeout :
pid 20, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 
Mar 18 12:02:19 orion kernel: DC390: Abort command (pid 20, Device
00-00)
Mar 18 12:02:19 orion kernel: DC390: SRB: Xferred 00000000, Remain
00000000, State 00000040, Phase 05
Mar 18 12:02:19 orion kernel: DC390: AdpaterStatus: 00, SRB Status 00
Mar 18 12:02:19 orion kernel: DC390: Status of last IRQ
(DMA/SC/Int/IRQ): 00000000
Mar 18 12:02:19 orion kernel: DC390: Register dump: SCSI block:
Mar 18 12:02:19 orion kernel: DC390: XferCnt  Cmd Stat IntS IRQS FFIS
Ctl1 Ctl2 Ctl3 Ctl4
Mar 18 12:02:19 orion kernel: DC390:  0000c0   01   00   c0   00   00
17   48   08   84
Mar 18 12:02:19 orion kernel: DC390: Register dump: DMA engine:
Mar 18 12:02:19 orion kernel: DC390: Cmd   STrCnt    SBusA    WrkBC
WrkAC Stat SBusCtrl
Mar 18 12:02:19 orion kernel: DC390:  00 00000100 11569dc0 000000bc
11569e04   00 03080000
Mar 18 12:02:19 orion kernel: DC390: Register dump: PCI Status: 0200
Mar 18 12:02:19 orion kernel: DC390: In case of driver trouble read
linux/drivers/scsi/README.tmscsim
Mar 18 12:02:19 orion kernel: DC390: Abort current command (pid 20, SRB
d7980148)
Mar 18 12:02:19 orion kernel: DC390: Aborted pid 20 with status 3
Mar 18 12:02:25 orion kernel: scsi : aborting command due to timeout :
pid 20, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 
Mar 18 12:02:25 orion kernel: DC390: Abort command (pid 20, Device
00-00)
Mar 18 12:02:25 orion kernel: DC390: SRB: Xferred 00000000, Remain
00000000, State 00000040, Phase 05
Mar 18 12:02:25 orion kernel: DC390: AdpaterStatus: 00, SRB Status 00
Mar 18 12:02:25 orion kernel: DC390: Status of last IRQ
(DMA/SC/Int/IRQ): 00000000
Mar 18 12:02:25 orion kernel: DC390: Register dump: SCSI block:
Mar 18 12:02:25 orion kernel: DC390: XferCnt  Cmd Stat IntS IRQS FFIS
Ctl1 Ctl2 Ctl3 Ctl4
Mar 18 12:02:25 orion kernel: DC390:  0000c0   01   00   c0   00   00
17   48   08   84
Mar 18 12:02:25 orion kernel: DC390: Register dump: DMA engine:
Mar 18 12:02:25 orion kernel: DC390: Cmd   STrCnt    SBusA    WrkBC
WrkAC Stat SBusCtrl
Mar 18 12:02:25 orion kernel: DC390:  00 00000100 11569dc0 000000bc
11569e04   00 03080000
Mar 18 12:02:25 orion kernel: DC390: Register dump: PCI Status: 0200
Mar 18 12:02:25 orion kernel: DC390: In case of driver trouble read
linux/drivers/scsi/README.tmscsim
Mar 18 12:02:25 orion kernel: DC390: Abort current command (pid 20, SRB
d7980148)
Mar 18 12:02:25 orion kernel: DC390: Aborted pid 20 with status 3
Mar 18 12:02:25 orion kernel: SCSI host 0 abort (pid 20) timed out -
resetting
Mar 18 12:02:25 orion kernel: SCSI bus is being reset for host 0
channel 0.
Mar 18 12:02:25 orion kernel: DC390: RESET ... done
Mar 18 12:02:35 orion kernel: scsi : aborting command due to timeout :
pid 21, scsi0, channel 0, id 1, lun 0 Inquiry 00 00 00 ff 
Mar 18 12:02:35 orion kernel: DC390: Abort command (pid 21, Device
01-00)
Mar 18 12:02:35 orion kernel: DC390: SRB: Xferred 00000000, Remain
00000000, State 00000040, Phase 05
Mar 18 12:02:35 orion kernel: DC390: AdpaterStatus: 00, SRB Status 00
Mar 18 12:02:35 orion kernel: DC390: Status of last IRQ
(DMA/SC/Int/IRQ): 00000000
Mar 18 12:02:35 orion kernel: DC390: Register dump: SCSI block:
Mar 18 12:02:35 orion kernel: DC390: XferCnt  Cmd Stat IntS IRQS FFIS
Ctl1 Ctl2 Ctl3 Ctl4
Mar 18 12:02:35 orion kernel: DC390:  0000c0   01   00   c0   00   00
17   48   08   84
Mar 18 12:02:35 orion kernel: DC390: Register dump: DMA engine:
Mar 18 12:02:35 orion kernel: DC390: Cmd   STrCnt    SBusA    WrkBC
WrkAC Stat SBusCtrl
Mar 18 12:02:35 orion kernel: DC390:  00 00000100 11569dc0 000000bc
11569e04   00 03080000
Mar 18 12:02:35 orion kernel: DC390: Register dump: PCI Status: 0200
Mar 18 12:02:35 orion kernel: DC390: In case of driver trouble read
linux/drivers/scsi/README.tmscsim
Mar 18 12:02:35 orion kernel: DC390: Abort current command (pid 21, SRB
d7980148)
Mar 18 12:02:35 orion kernel: DC390: Aborted pid 21 with status 3
Mar 18 12:02:41 orion kernel: scsi : aborting command due to timeout :
pid 21, scsi0, channel 0, id 1, lun 0 Inquiry 00 00 00 ff 
Mar 18 12:02:41 orion kernel: DC390: Abort command (pid 21, Device
01-00)
Mar 18 12:02:41 orion kernel: DC390: SRB: Xferred 00000000, Remain
00000000, State 00000040, Phase 05
Mar 18 12:02:41 orion kernel: DC390: AdpaterStatus: 00, SRB Status 00
Mar 18 12:02:41 orion kernel: DC390: Status of last IRQ
(DMA/SC/Int/IRQ): 00000000
Mar 18 12:02:41 orion kernel: DC390: Register dump: SCSI block:
Mar 18 12:02:41 orion kernel: DC390: XferCnt  Cmd Stat IntS IRQS FFIS
Ctl1 Ctl2 Ctl3 Ctl4
Mar 18 12:02:41 orion kernel: DC390:  0000c0   01   00   c0   00   00
17   48   08   84
Mar 18 12:02:41 orion kernel: DC390: Register dump: DMA engine:
Mar 18 12:02:41 orion kernel: DC390: Cmd   STrCnt    SBusA    WrkBC
WrkAC Stat SBusCtrl
Mar 18 12:02:41 orion kernel: DC390:  00 00000100 11569dc0 000000bc
11569e04   00 03080000
Mar 18 12:02:41 orion kernel: DC390: Register dump: PCI Status: 0200
Mar 18 12:02:41 orion kernel: DC390: In case of driver trouble read
linux/drivers/scsi/README.tmscsim
Mar 18 12:02:41 orion kernel: DC390: Abort current command (pid 21, SRB
d7980148)
Mar 18 12:02:41 orion kernel: DC390: Aborted pid 21 with status 3
Mar 18 12:02:41 orion kernel: SCSI host 0 abort (pid 21) timed out -
resetting
Mar 18 12:02:41 orion kernel: SCSI bus is being reset for host 0
channel 0.
Mar 18 12:02:41 orion kernel: DC390: RESET ... done


But at this point there is a real crash (magic keys still works, but
no chance for only tryig to reboot).

So maybe the tmscsim has the same problem? Or one of the drivers
doesn't care to mark the device as being already served nor to look
if its busy? 


CU
Marion Steiner 
