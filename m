Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbUL2F0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUL2F0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 00:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUL2F0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 00:26:39 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:13633 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261322AbUL2F0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 00:26:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=umu3N9LnfWKczUx7I3a/CFaR4gp9oFtoZl12/EYp1FROx2AnhheMg++RXFadwlQkWONco2CbzKni3F0wxHur8qoTSJdTZrHEhTBI54NvkTqzDIR/+Qjno/XXrzE1eZ7M6gOPXUIMIy3viPZip3V/RNTlyPVPzn5olIhocPMf1+s=
Message-ID: <9dda349204122821262f71e375@mail.gmail.com>
Date: Wed, 29 Dec 2004 00:26:36 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
Cc: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

This patch works here but the performance is very poor. When i set DMA
and 32bit I/O thru hdparm, performance is comparable to the ITE pseudo
SCSI driver.

I get some errors on dmesg when using hdparm:

IT8212: IDE controller at PCI slot 0000:01:0c.0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 17 (level, high) -> IRQ 17
IT8212: chipset revision 16
IT8212: 100% native mode on irq 17
    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:DMA, hdf:pio
it8212: controller in smart mode.
    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Integrated Technology Express Inc, ATA DISK drive
hde: IT8212 RAID 0 volume(64K stripe).
ide2 at 0x8810-0x8817,0x8c02 on irq 17
Probing IDE interface ide3...
Probing IDE interface ide3...
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hde: max request size: 128KiB
hde: 468883200 sectors (240068 MB), CHS=29186/255/63
hde: cache flushes not supported
hde: hde1

XFS mounting filesystem hde1
Ending clean XFS mount for filesystem: hde1
hde: task_in_intr: status=0xd0 { Busy }

ide: failed opcode was: unknown
ide2: reset: master: error (0x00?)

hdparm
/dev/hde:
 Timing cached reads:   2012 MB in  2.00 seconds = 1005.65 MB/sec
 Timing buffered disk reads:    6 MB in  3.32 seconds =   1.81 MB/sec

hdparm -c1 -d1 -k1
/dev/hde:
 setting 32-bit IO_support flag to 1
 setting using_dma to 1 (on)
 setting keep_settings to 1 (on)
 IO_support   =  1 (32-bit)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
/dev/hde:
 Timing cached reads:   2028 MB in  2.00 seconds = 1013.14 MB/sec
 Timing buffered disk reads:  150 MB in  3.01 seconds =  49.84 MB/sec

Regards,

Paul B.

-- 
FreeBSD the Power to Serve!
