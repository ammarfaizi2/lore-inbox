Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbTJITYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTJITYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:24:13 -0400
Received: from intra.cyclades.com ([64.186.161.6]:36263 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262405AbTJITYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:24:07 -0400
Date: Thu, 9 Oct 2003 16:22:34 -0300 (BRT)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org, <mm-mailinglist@madness.at>
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
In-Reply-To: <3F82E7F2.5060804@madness.at>
Message-ID: <Pine.LNX.4.44.0310080957400.29933-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bart, 

Do you have any idea ? 

Wild guess: Disable APIC? 

On Tue, 7 Oct 2003, Stefan Kaltenbrunner wrote:

> Hello!
> 
> we have a bunch of IBM x305 here which are entrylevel 1HE servers based 
> on a Serverworks CSB5 chipset.
> One of those has 2 120GB IDE disks in a software RAID1 and the main 
> userspace-application is a heavly (mostly insert/update) used 
> postgresql-database. The database generates a lot of sustained 
> IO-traffic and after some minutes (depends on the load - sometimes it 
> even works for one or two hours) the kernel generates the following 
> messages(2.4.22 and 2.6.0-test6 behave almost identically - 
> error-messages are from 2.6.0-test6):
> 
> 
> hdc: dma_timer_expiry: dma status == 0x20
> hdc: DMA timeout retry
> hdc: timeout waiting for DMA
> hdc: status timeout: status=0xd0 { Busy }
> 
> hdc: drive not ready for command
> ide1: reset: success
> hdc: dma_timer_expiry: dma status == 0x20
> hdc: DMA timeout retry
> hdc: timeout waiting for DMA
> hdc: status timeout: status=0xd0 { Busy }
> 
> hdc: drive not ready for command
> ide1: reset: success
> hdc: dma_timer_expiry: dma status == 0x20
> hdc: DMA timeout retry
> hdc: timeout waiting for DMA
> hdc: status timeout: status=0xd0 { Busy }
> 
> hdc: drive not ready for command
> ide1: reset: success
> hdc: dma_timer_expiry: dma status == 0x20
> hdc: DMA timeout retry
> hdc: timeout waiting for DMA
> hdc: status timeout: status=0xd0 { Busy }
> 
> hdc: drive not ready for command
> ide1: reset: success
> hda: dma_timer_expiry: dma status == 0x60
> hda: DMA timeout retry
> hda: timeout waiting for DMA
> hda: status timeout: status=0xd0 { Busy }
> 
> hdb: DMA disabled
> hda: drive not ready for command
> ide0: reset: success
> blk: queue dfdee200, I/O limit 4095Mb (mask 0xffffffff)
> hda: dma_timer_expiry: dma status == 0x20
> hda: DMA timeout retry
> hda: timeout waiting for DMA
> hda: status timeout: status=0xd0 { Busy }
> 
> hda: drive not ready for command
> ide0: reset: success
> hda: dma_timer_expiry: dma status == 0x20
> hda: DMA timeout retry
> hda: timeout waiting for DMA
> hda: status timeout: status=0xd0 { Busy }
> 
> hda: drive not ready for command
> ide0: reset: success
> 
> 
> after one of this events DMA on one of the disks (either hdc or hda) 
> gets disabled and the maschine is heavily overloaded and the database 
> cannot keep up any more with the incoming load of database-updates.
> It's also worth mentioning that the kernel reports a "DMA disabled" only 
> for hdb which is the internal cd-drive and completely unused.
> 
> I do know that Serverworks IDE has been flaky (especially with the CSB4) 
> in the past but I thought this had been fixed in newer chipset-revisions 
> - is there anything I can do to solve this problem?
> 
> dmesg of the machine in question can be found at 
> http://www.kaltenbrunner.cc/files/dmesg.txt
> 
> 
> 
> many thanks
> 
> Stefan Kaltenbrunner
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 




