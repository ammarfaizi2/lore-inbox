Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTJGQVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTJGQVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:21:09 -0400
Received: from madness.at ([213.153.61.104]:26887 "EHLO cronos.madness.at")
	by vger.kernel.org with ESMTP id S262440AbTJGQU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:20:58 -0400
Message-ID: <3F82E7F2.5060804@madness.at>
Date: Tue, 07 Oct 2003 18:21:06 +0200
From: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6a) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

we have a bunch of IBM x305 here which are entrylevel 1HE servers based 
on a Serverworks CSB5 chipset.
One of those has 2 120GB IDE disks in a software RAID1 and the main 
userspace-application is a heavly (mostly insert/update) used 
postgresql-database. The database generates a lot of sustained 
IO-traffic and after some minutes (depends on the load - sometimes it 
even works for one or two hours) the kernel generates the following 
messages(2.4.22 and 2.6.0-test6 behave almost identically - 
error-messages are from 2.6.0-test6):


hdc: dma_timer_expiry: dma status == 0x20
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xd0 { Busy }

hdc: drive not ready for command
ide1: reset: success
hdc: dma_timer_expiry: dma status == 0x20
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xd0 { Busy }

hdc: drive not ready for command
ide1: reset: success
hdc: dma_timer_expiry: dma status == 0x20
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xd0 { Busy }

hdc: drive not ready for command
ide1: reset: success
hdc: dma_timer_expiry: dma status == 0x20
hdc: DMA timeout retry
hdc: timeout waiting for DMA
hdc: status timeout: status=0xd0 { Busy }

hdc: drive not ready for command
ide1: reset: success
hda: dma_timer_expiry: dma status == 0x60
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status timeout: status=0xd0 { Busy }

hdb: DMA disabled
hda: drive not ready for command
ide0: reset: success
blk: queue dfdee200, I/O limit 4095Mb (mask 0xffffffff)
hda: dma_timer_expiry: dma status == 0x20
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status timeout: status=0xd0 { Busy }

hda: drive not ready for command
ide0: reset: success
hda: dma_timer_expiry: dma status == 0x20
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status timeout: status=0xd0 { Busy }

hda: drive not ready for command
ide0: reset: success


after one of this events DMA on one of the disks (either hdc or hda) 
gets disabled and the maschine is heavily overloaded and the database 
cannot keep up any more with the incoming load of database-updates.
It's also worth mentioning that the kernel reports a "DMA disabled" only 
for hdb which is the internal cd-drive and completely unused.

I do know that Serverworks IDE has been flaky (especially with the CSB4) 
in the past but I thought this had been fixed in newer chipset-revisions 
- is there anything I can do to solve this problem?

dmesg of the machine in question can be found at 
http://www.kaltenbrunner.cc/files/dmesg.txt



many thanks

Stefan Kaltenbrunner

