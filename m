Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTETQdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTETQdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:33:14 -0400
Received: from ip252-142.choiceonecom.com ([216.47.252.142]:54539 "EHLO
	explorer.reliacomp.net") by vger.kernel.org with ESMTP
	id S263547AbTETQdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:33:12 -0400
Message-ID: <3ECA58EE.2030106@cendatsys.com>
Date: Tue, 20 May 2003 11:33:50 -0500
From: Edward King <edk@cendatsys.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fix for IDE RAID PDC20268 problem (timeout waiting for DMA)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to get a system running RAID5 with 4 hard drives on a 
promise controller for 2 months and am constantly getting the following 
errors:

hdg: dma_timer_expiry: dma status == 0x21
hde: dma_timer_expiry: dma status == 0x21
hdg: timeout waiting for DMA
PDC202XX: Secondary channel reset
hdg: timeout waiting for DMA
hdg: (__ide_dma_test_irq) called while not waiting
hdg: status error: status = 0x58 { DriveReady SeekComplete DataRequest
}
hdg: drive not ready for command
hde: timeout waiting for DMA
PDC202XX: Primary channel reset
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting



I have tried an HPT680 with the same results, but the raid works fine if 
two of the drives are connected to the onboard controller.

Single PDC or dual, mixed HPT and PDC, single HPT -- all have the same 
problem and it appears only when I put the system under heavy IO load 
(rsync about 180GB).

I swapped motherboards (one with a VIA chipset, one with nVidia) and 
tried all different kernels (2.4.20, 2.4.21-pre everything, 2.5.69, all 
ac patches, etc).

It also does not matter what DMA mode, the problem recurrs and drives 
drop out of DMA.

SOLUTION:

I have recompiled without devfs and running at udma5 (which previously 
would cause a failure in 10 minutes) and have had no messages in the log.

The new problem is with the via-rhine nic's -- " NETDEV WATCHDOG: eth1: 
transmit timed out" and then the nic stops working (still shows with 
ifconfig, still can ping local ip but no traffic goes through).  This is 
occurring from samba traffic as well as rsync -- seems the new weakest 
link.  If anyone has any recommendations, short of getting decent nics :)


