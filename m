Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUAFSeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAFSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:33:49 -0500
Received: from columba1.eur.3com.com ([161.71.171.235]:52354 "EHLO
	columba1.eur.3com.com") by vger.kernel.org with ESMTP
	id S264608AbUAFScb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:32:31 -0500
Message-ID: <3FFAFF39.7090606@jburgess.uklinux.net>
Date: Tue, 06 Jan 2004 18:32:25 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rapha=EBl_Rigo?= <raphael.rigo@inp-net.eu.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.1-rc2] SATA problem.
References: <3FD4C785.4080306@jburgess.uklinux.net> <3FD5E454.2030404@inp-net.eu.org> <3FD60552.5090903@jburgess.uklinux.net> <3FD6094C.5040502@inp-net.eu.org> <3FD60C5D.6010203@jburgess.uklinux.net> <3FD60EC9.8040709@inp-net.eu.org> <3FD614DB.7090207@jburgess.uklinux.net> <3FD61615.30507@inp-net.eu.org> <3FD6197B.1070704@jburgess.uklinux.net> <3FD62990.80708@inp-net.eu.org>
In-Reply-To: <3FD62990.80708@inp-net.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous email, Rigo sent me the following boot log + lspci info 
giving further details of the ICH5 in his setup.

The thing which looked most odd to me was that both controllers appear 
to be configured in native mode on IRQ 18 and for some reason this 
appears to give some trouble. In particular he was seeing an "unhandled 
interrupt" error on IRQ 18.

Enabling the sata_piix driver and disabling the ide_piix code was enough 
to get the machine to boot, but I don't know what the real cause of the 
problem.

Raphaël Rigo wrote in a previous email to me:

> Here are the bootlog (of working boot, ask me if you need the one of 
> the non working one because I must copy it by hand) and lspci -vvv
>
>
> Dec  9 20:41:46 pici kernel: Uniform Multi-Platform E-IDE driver 
> Revision: 7.00alpha2
> Dec  9 20:41:46 pici kernel: ide: Assuming 33MHz system bus speed for 
> PIO modes; override with idebus=xx
> Dec  9 20:41:46 pici kernel: ide2: I/O resource 0x3EE-0x3EE not free.
> Dec  9 20:41:46 pici kernel: ide2: ports already in use, skipping probe
> Dec  9 20:41:46 pici kernel: libata version 0.81 loaded.
> Dec  9 20:41:46 pici kernel: ata_piix version 0.95
> Dec  9 20:41:46 pici kernel: PCI: Setting latency timer of device 
> 0000:00:1f.2 to 64
> Dec  9 20:41:46 pici kernel: ata1: SATA max UDMA/133 cmd 0xEF88 ctl 
> 0xEF86 bmdma 0xEE60 irq 18
> Dec  9 20:41:46 pici kernel: ata2: SATA max UDMA/133 cmd 0xEF68 ctl 
> 0xEF82 bmdma 0xEE68 irq 18
> Dec  9 20:41:46 pici kernel: ata1: SATA port has no device. disabling.
> Dec  9 20:41:46 pici kernel: ata1: thread exiting
> Dec  9 20:41:46 pici kernel: scsi0 : ata_piix
> Dec  9 20:41:46 pici kernel: ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 
> 84:4003 85:7c49 86:3a01 87:4003 88:207f
> Dec  9 20:41:46 pici kernel: ata2: dev 0 ATA, max UDMA/133, 240121728 
> sectors
> Dec  9 20:41:46 pici kernel: ata2: dev 0 configured for UDMA/133
> Dec  9 20:41:46 pici kernel: scsi1 : ata_piix
> Dec  9 20:41:46 pici kernel:   Vendor: ATA       Model: Maxtor 
> 6Y120M0    Rev: 0.81
> Dec  9 20:41:46 pici kernel:   Type:   
> Direct-Access                      ANSI SCSI revision: 05
> Dec  9 20:41:46 pici kernel: SCSI device sda: 240121728 512-byte hdwr 
> sectors (122942 MB)
> Dec  9 20:41:46 pici kernel: SCSI device sda: drive cache: write through
> Dec  9 20:41:46 pici kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 > sda3
> Dec  9 20:41:46 pici kernel: Attached scsi disk sda at scsi1, channel 
> 0, id 0, lun 0
> Dec  9 20:41:46 pici kernel: Attached scsi generic sg0 at scsi1, 
> channel 0, id 0, lun 0,  type 0
>
>
> 00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) 
> (prog-if 8f [Master SecP SecO PriP PriO])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 18
>     Region 0: I/O ports at efe0 [size=8]
>     Region 1: I/O ports at efac [size=4]
>     Region 2: I/O ports at efa0 [size=8]
>     Region 3: I/O ports at efa8 [size=4]
>     Region 4: I/O ports at ef90 [size=16]
>     Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]
>
> 00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02) 
> (prog-if 8f [Master SecP SecO PriP PriO])
>     Subsystem: Asustek Computer, Inc.: Unknown device 80a6
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>     Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 18
>     Region 0: I/O ports at ef88 [size=8]
>     Region 1: I/O ports at ef84 [size=4]
>     Region 2: I/O ports at ef68 [size=8]
>     Region 3: I/O ports at ef80 [size=4]
>     Region 4: I/O ports at ee60 [size=16]
>
    Jon


