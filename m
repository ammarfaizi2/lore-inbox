Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWCNAjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWCNAjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWCNAjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:39:45 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:58800 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751710AbWCNAjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:39:44 -0500
In-Reply-To: <1142262431.25773.25.camel@localhost.localdomain>
References: <1142262431.25773.25.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <30715A89-26A9-4B93-B17F-33C3F407B1C8@bootc.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Tue, 14 Mar 2006 00:39:29 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Mar 2006, at 15:07, Alan Cox wrote:

> Available from
>
> http://zeniv.linux.org.uk/~alan/IDE/
>
>
> Main changes:
> 	Various drivers moved to use SRST
> 	Probe code now knows about 0xFF return due to missing pulldowns
> 		on cheap controllers
> 	HPT37x masking bug fixed
> 	Try to issue LBA28 commands whenever possible
> 	Above should fix ALi speed problems
> 	VIA ATAPI now works for me
> 	IT8212 prints raid data
> 	Fix IT8212 sector clamping
> 	Report aborted command for unknown errors
> 	Fix HPT371 crash on probe

Alan,

pata_via detects my HP Colorado 5GB again, although I still haven't  
had a chance to test it yet: tapes are on back order. The DVD-RW also  
gets detected and haven't tested yet but I don't doubt it'll work  
since it has worked fine for me since it was detected. I notice the  
driver seems much more verbose now as well.

Here is my bootlog:

[4294688.651000] pata_via 0000:00:0f.1: version 0.1.6
[4294688.651000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] - 
 > GSI 20 (level, low) -> IRQ 177
[4294688.651000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
[4294688.651000] ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma  
0xD000 irq 14
[4294688.802000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294688.802000] t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover  
= 10
[4294688.802000] FIT t.act8b = 10, t.rec8b = 8, t.active = 9,  
t.recover = 9
[4294688.956000] ata5: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000  
85:0218 86:0000 87:4000 88:101f
[4294688.956000] ata5: dev 0 ATAPI, max UDMA/66
[4294688.956000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294688.956000] t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover  
= 10
[4294688.956000] FIT t.act8b = 10, t.rec8b = 8, t.active = 9,  
t.recover = 9
[4294688.956000] via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
[4294688.956000] t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
[4294688.956000] FIT t.act8b = 2, t.rec8b = 0, t.active = 2,  
t.recover = 0
[4294688.956000] via_do_set_mode: Mode=68 ast broken=Y udma=133 mul=4
[4294688.956000] t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
[4294688.956000] FIT t.act8b = 2, t.rec8b = 0, t.active = 2,  
t.recover = 0
[4294688.956000] ata5: dev 0 configured for UDMA/66
[4294688.956000] scsi4 : pata_via
[4294688.968000]   Vendor: PIONEER   Model: DVD-RW  DVR-110D  Rev: 1.39
[4294688.968000]   Type:   CD-ROM                             ANSI  
SCSI revision: 05
[4294689.072000] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2  
cdda tray
[4294689.072000] Uniform CD-ROM driver Revision: 3.20
[4294689.072000] sr 4:0:0:0: Attached scsi CD-ROM sr0
[4294689.072000] sr 4:0:0:0: Attached scsi generic sg4 type 5
[4294689.073000] ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma  
0xD008 irq 15
[4294689.554000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294689.554000] t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover  
= 10
[4294689.554000] FIT t.act8b = 10, t.rec8b = 8, t.active = 9,  
t.recover = 9
[4294689.711000] ata6: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000  
85:0000 86:0000 87:0000 88:0000
[4294689.711000] ata6: dev 0 ATAPI, max MWDMA2
[4294689.711000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294689.711000] t.act8b = 11, t.rec8b = 9, t.active = 10, t.recover  
= 10
[4294689.711000] FIT t.act8b = 10, t.rec8b = 8, t.active = 9,  
t.recover = 9
[4294689.828000] usb 1-1: new low speed USB device using uhci_hcd and  
address 3
[4294689.862000] ata6: PIO error
[4294689.862000] via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
[4294689.862000] t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
[4294689.862000] FIT t.act8b = 2, t.rec8b = 0, t.active = 2,  
t.recover = 0
[4294689.862000] via_do_set_mode: Mode=34 ast broken=Y udma=133 mul=4
[4294689.862000] t.act8b = 3, t.rec8b = 1, t.active = 3, t.recover = 1
[4294689.862000] FIT t.act8b = 2, t.rec8b = 0, t.active = 2,  
t.recover = 0
[4294689.862000] ata6: dev 0 configured for MWDMA2
[4294689.862000] scsi5 : pata_via
[4294689.875000]   Vendor: HP        Model: COLORADO 5GB      Rev: 2.06
[4294689.875000]   Type:   Sequential-Access                  ANSI  
SCSI revision: 02
[4294689.876000] st 5:0:0:0: Attached scsi tape st0<4>st0: try direct  
i/o: yes (alignment 512 B)
[4294689.876000] st 5:0:0:0: Attached scsi generic sg5 type 1

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


