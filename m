Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbULJQI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbULJQI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbULJQFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:05:47 -0500
Received: from wylie.me.uk ([82.68.155.89]:33223 "EHLO mail.wylie.me.uk")
	by vger.kernel.org with ESMTP id S261750AbULJQE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:04:59 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16825.51489.430624.918561@devnull.wylie.me.uk>
Date: Fri, 10 Dec 2004 16:04:49 +0000
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: "EC" <wingman@waika9.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
In-Reply-To: <16824.8109.697757.673632@devnull.wylie.me.uk>
References: <16824.8109.697757.673632@devnull.wylie.me.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004 09:49:33 +0000, "Alan J. Wylie" <alan@wylie.me.uk> said:

> See also: <http://lkml.org/lkml/2004/12/3/68>

> With 2.4.27 patched with

> <http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.27-rc3-libata1.patch.bz2>

> the system works. I have not been able to make it work with any
> later 2.4 kernel

> Motherboard: Supermicro X6DA8-G2

Changing the BIOS settings from the default:
With BIOS setting  "Native Mode Operation: [Auto]"
 to:
With BIOS setting  "Native Mode Operation: [Both]"

results in the system working OK with the later kernel.

There is still an issue, however with trying to use two drives and
software RAID. With both drives, or with one drive pulled, the system
boots OK. If the other drive (Channel 3 Master) is pulled, however,
the system fails to boot, after producing the following error messages
- both 2.4.29-pre1-bk5 and 2.6.9 kernels produce very similar messages.

With BIOS setting  "Native Mode Operation: [Both]"

ACPI:PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0x1C00 ctl 0x18F6 bmdma 0x18E0 irq 18
ata2: SATA max UDMA/133 cmd 0x18F8 ctl 0x18F2 bmdma 0x18E8 irq 18
ata1: SATA port has no device.
scsi0: ata_piix
ATA abnormal status 0x7F on port 0x18FF
scsi1: ata_piix

With BIOS setting  "Native Mode Operation: [Auto]"

ACPI:PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18E0 irq 14
ata1: SATA port has no device.
scsi0: ata_piix
Using anticpatory io scheduler
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18E8 irq 15
ata2: SATA port has no device.
scsi1: ata_piix

-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
