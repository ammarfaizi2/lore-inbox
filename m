Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUJNPwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUJNPwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUJNPwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 11:52:11 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:13952 "EHLO
	beast.stev.org") by vger.kernel.org with ESMTP id S266352AbUJNPvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 11:51:19 -0400
Date: Thu, 14 Oct 2004 17:23:49 +0100 (BST)
From: James Stevenson <james@stev.org>
To: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>
cc: kernelnewbies@nl.linux.org
Subject: ATA/133 Problems with multiple cards
Message-ID: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

i seem to have run into an annoying problem with a machine which has
3 promise ata/133 card the PDC20269 type.

So far i have figured out the following
all cards work fine when tested by themselves.

All card work fine when tested with 1 other promise card in the machine.

Any card will fail during boot (the card furthest down the pci bus)
with the following eorros. (though the drives do report the correct drives 
they are plugged into)

hdm: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, UDMA(133)
hdo: attached ide-disk driver.
hdo: host protected area => 1
hdo: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, UDMA(133)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host2/bus0/target0/lun0: p1
 /dev/ide/host2/bus1/target0/lun0: p1
 /dev/ide/host2/bus1/target1/lun0: p1
 /dev/ide/host4/bus0/target0/lun0: unknown parition table
 /dev/ide/host4/bus1/target0/lun0: p1
 /dev/ide/host6/bus0/target0/lun0:
hdm: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdm: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdm: dma_timer_expiry: dma status == 0x21
hdm: error waiting for DMA
hdm: dma timeout retry: status=0x51 { DriveReady SeekComplete Error }
hdm: dma timeout retry: error=0x84 { DriveStatusError BadCRC }
blk: queue c03ac5f8, I/O limit 4095Mb (mask 0xffffffff)
 unknown partition table

the errors continue for the other drive on the same controller.
booting the kernel with the option ide=nodma will allow it to
boot with no errors and function normally but without dma.

When i manually turn on dma on each drive it works fine and returns
no errors / produces no errors.

The only problem with this is that 2 of the 3 cards fucntion normally
the 3rd card run with dma disabled.

This is being run under 2.4.27.

Does anyone have an explenation of why this can happen ?

thanks
	James



