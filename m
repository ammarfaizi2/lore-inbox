Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWGPOWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWGPOWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 10:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWGPOWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 10:22:13 -0400
Received: from in.cluded.net ([195.159.98.120]:37290 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S1750806AbWGPOWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 10:22:13 -0400
Message-ID: <44BA4AAC.1090703@cluded.net>
Date: Sun, 16 Jul 2006 14:18:20 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060307 SeaMonkey/1.5a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Using irqpoll option triggers the NMI Watchdog
References: <44BA3A7F.4050803@cluded.net>
In-Reply-To: <44BA3A7F.4050803@cluded.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel K. wrote:
> The kernel advised me to boot using the irqpoll option.
> (Possibly broken SATA subsystem or equipment, a separate story)
> 
> [...]
> 
> Checking the just released 2.6.18-rc2 kernel, the irqpoll option
> seems to cause the same problem.

What I didn't check, until now, was the underlying problem,
which appear to be fixed, yay :)

Although my problems are solved, I can still test fixes for the
badness that happens when using the irqpoll option, if required.


For the record.

I've been using 2.6.17-1.2145_FC5 for a long time without problems.
Then I added a new Samsung SH-W163A SATA DVD-lettersoup device.

The result:

[*SNIP*]

SCSI subsystem initialized
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 25 (level, low) -> IRQ 185
sata_sil 0000:03:05.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004C80 ctl 0xFFFFC20000004C8A bmdma 0xFFFFC20000004C00 irq 185
ata2: SATA max UDMA/100 cmd 0xFFFFC20000004CC0 ctl 0xFFFFC20000004CCA bmdma 0xFFFFC20000004C08 irq 185
ata3: SATA max UDMA/100 cmd 0xFFFFC20000004E80 ctl 0xFFFFC20000004E8A bmdma 0xFFFFC20000004E00 irq 185
ata4: SATA max UDMA/100 cmd 0xFFFFC20000004EC0 ctl 0xFFFFC20000004ECA bmdma 0xFFFFC20000004E08 irq 185
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ata1: SATA link down (SStatus 0)
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
irq 185: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff802b35e4>{__report_bad_irq+48}
       <ffffffff802b37e2>{note_interrupt+433} <ffffffff802b30fb>{__do_IRQ+189}
       <ffffffff802717fe>{do_IRQ+60} <ffffffff8027021b>{default_idle+0}
       <ffffffff802632aa>{ret_from_intr+0} <EOI> <ffffffff8027021b>{default_idle+0}
       <ffffffff80267b76>{thread_return+0} <ffffffff80270246>{default_idle+43}
       <ffffffff8024cc06>{cpu_idle+151} <ffffffff806c9817>{start_kernel+502}
       <ffffffff806c928a>{_sinittext+650}
handlers:
[<ffffffff8804761d>] (ata_interrupt+0x0/0x15b [libata])
Disabling IRQ #185
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 ATAPI, max UDMA/33
ata4(0): applying bridge limits
md: stopping all md devices.
Restarting system.
.
machine restart

This is fixed for me in 2.6.18-rc2

Using the advise (try booting with the "irqpoll" option)
resulted in NMI Watchdog detecting lockups similar to those
decribed in the parent email.


Daniel K.
