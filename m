Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUCQLby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 06:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUCQLby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 06:31:54 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:1197 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261376AbUCQLbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 06:31:50 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH,RFT] VIA SATA driver update
Date: Wed, 17 Mar 2004 12:36:21 +0100
User-Agent: KMail/1.6.1
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
References: <405828DB.7060005@pobox.com>
In-Reply-To: <405828DB.7060005@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200403171236.21145.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 March 2004 11:30, Jeff Garzik wrote:

> I'm interested in hearing reports if libata's VIA SATA still fails for
> you...

Tested on:
ABIT KV7 VIAKT600 chipset

Kernel 2.6.5-rc1

With no options:

libata version 1.01 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 10
ata2: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 10
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
ata1: thread exiting
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_via

With:
1. acpi=off
2. noapic
3. acpi=off noapic
4. acpi=off noapic iommu=off

Result is always the same:

libata version 1.01 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 11
ata2: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 11
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
ata1: thread exiting
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_via

This is the same behavior I get ever since 2.6.1 when I started testing 2.6 
seried. It also doesn't work under 2.6 with IDE generic support for 
VIA8237SATA (irq timeout, dma timeout)

I works fine with VIA8237SATA generic patch under 2.4.25 though...

