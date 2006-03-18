Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWCRQRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWCRQRr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCRQRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:17:47 -0500
Received: from ddsl-216-196-193-58.fuse.net ([216.196.193.58]:53946 "EHLO
	sarsen.nerdgod.com") by vger.kernel.org with ESMTP id S1751341AbWCRQRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:17:46 -0500
Message-ID: <441C32AA.7060208@societasilluminati.org>
Date: Sat, 18 Mar 2006 11:17:46 -0500
From: Ian Young <lkml@societasilluminati.org>
Reply-To: lkml@societasilluminati.org
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: libata/sata errors on ich[?]/maxtor
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having the same sorts of problems on similar hardware. I've not 
found a way to reliably reproduce the error-- it seems to just happen 
once a week, during periods of relative inactivity. On my system, the 2 
drives are a seagate ST3300831AS and a Maxtor 6V300F0.

Mar 12 15:15:24 sarsen kernel: ata1: command 0x35 timeout, stat 0xd0 
host_stat 0x61
Mar 12 15:15:24 sarsen kernel: ata1: translated ATA stat/err 0xd0/00 to 
SCSI SK/ASC/ASCQ 0xb/47/00
Mar 12 15:15:24 sarsen kernel: ata1: status=0xd0 { Busy }
Mar 12 15:15:24 sarsen kernel: sd 0:0:1:0: SCSI error: return code = 
0x8000002
Mar 12 15:15:24 sarsen kernel: sdb: Current: sense key: Aborted Command
Mar 12 15:15:24 sarsen kernel:     Additional sense: Scsi parity error
Mar 12 15:15:24 sarsen kernel: end_request: I/O error, dev sdb, sector 
586099263
[drive is kicked from RAID-1 array]
Mar 12 15:15:24 sarsen kernel: ATA: abnormal status 0xD0 on port 0x1F7

Later, smartd errors out (predictably) as well.

The odd part is that I can reboot the box, the drive comes back on-line, 
and the array re-syncs as if nothing happens (and for the curious, 
checksumming all the files against a clean backup revealed no 
corruption). The error doesn't pop up on re-sync.

Maxtor's own diagnostic tool marks the drive as okay, all the SMART 
statistics seem to be fine, and mkfs.ext3 -cc completed without error as 
a stand-alone drive.

I have also, as Samuel did, move the jumper to the SATA150 setting. The 
most recent time I received the error, I also switched the block 
addressing mode in the BIOS from "auto" to "large" in a sort of voodoo 
maneuver suggested by someone who had experienced errors with this line 
of drives on an Nforce4 board. ...which brings up the point that the 
6VxxxF0 drives have problems on nforce4 chipsets, and maxtor provides 
new firmware for them if you request it, though I don't know more about 
it than that, and haven't called to see if the firmware is available. 
(link: http://www.ngohq.com/home.php?page=articles&go=read&arc_id=59)

I'm running Fedora Core 4's kernel:  2.6.15-1.1833_FC4 #1 Wed Mar 1 
23:41:37 EST 2006 i686 i686 i386 GNU/Linux
with ata_piix as the libata driver.
Also, my `lshw` results: http://www.societasilluminati.org/hinv.html
(though as of the latest error, when I switched to "large" disk access, 
I also left the drive in slot 0, so future listings will show it as 
/dev/sda)






