Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUHQAtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUHQAtA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUHQAs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:48:59 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:47261 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S268057AbUHQAsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:48:38 -0400
Date: Tue, 17 Aug 2004 01:48:13 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
In-Reply-To: <4113A684.8050302@pobox.com>
Message-ID: <Pine.LNX.4.60.0408170133430.78577@fogarty.jakma.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
 <1091795565.16307.14.camel@localhost.localdomain> <4113A684.8050302@pobox.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Fri, 6 Aug 2004, Jeff Garzik wrote:

> libata does not (yet) retry cable errors, for example.  Paul, don't 
> automatically assume the disk is bad, try swapping cables.

FWIW:

- running dd in a while loop reading 1024k of data at a time from 
about 1000 odd blocks before/after the block number mentioned in the 
error messages did not cause any further errors

however:

- when I tried to add the disk (well partition, spanning from 2GB to 
end of disk at 160GB) back into its RAID-5 array, it errored out 
every time when resyncing the array, but only when reaching somewhere 
close to the end of the resync.

(unfortunately, I couldnt get the error messages, it caused all 
further IO to the RAID-5 to die too and effectively hang the box - i 
think due to the MD layer not being at all happy with a disk failling 
while resyncing, indeed, MD was not happy with state of play after 
reboot and wouldnt bring the array back.[1])

- Rogier Wolff reported to me in private mail that in his experience, 
WD disks going 'slow' is a WD quirk and an imminent sign of failure 
of WD disks.

And indeed, the disk did die completely last friday.. it's now been 
replaced.

How much would it take to get SMART reporting working with libata 
btw? I'd be very interested in this and helping out if possible.

> 	Jeff

1. NB: It would be nice if the Linux RAID superblock had per-drive 
UUIDs in addition to the global array UUID. I hotadded the disk to 
the array without first hotremoving it, and MD was rather confused by 
the presence of '/dev/sda' twice, as a failed disk and as a spare. 
Also, the failure of /dev/sda caused /dev/sdb and /dev/sdc to be 
renamed, after reboot to /dev/sda and /dev/sdb, which further 
confused matters. A per-component UUID might help MD discriminate and 
prevent addition of disks which are already in array and also help it 
recognise that the failed /dev/sda3 in the superblock is not the same 
as the current (renamed due to discovery after disk failure), 
/dev/sda3 existing on the system..

It took a lot of touching of wood, checking and rechecking of 
/etc/raidtab vs lsraid and mdadm -E before doing mkraid 
--dangerous-no-resync .... to rewrite the superblock and get the 
array running again despite my mistake and the 
not-very-friendly-to-fat-fingers properties of md.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
If only God would give me some clear sign!  Like making a large deposit
in my name at a Swiss Bank.
- Woody Allen
