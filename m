Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWGBVWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWGBVWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 17:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWGBVWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 17:22:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:48531 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750854AbWGBVWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 17:22:15 -0400
Date: Sun, 2 Jul 2006 23:22:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Carsten Otto <c-otto@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: Huge problem with XFS/iCH7R
In-Reply-To: <20060702195619.GB4098@localhost.halifax.rwth-aachen.de>
Message-ID: <Pine.LNX.4.61.0607022319180.5218@yvahk01.tjqt.qr>
References: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>
 <20060702195619.GB4098@localhost.halifax.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding cc,

>> If I do a soft reset (using Magic Key u, then b) the BIOS does not detect
>> exactly one drive (which is the one shown in the error message I guess).
>> After a hard reset all drives are found, but I have to do a raid resync and
>> xfs_repair (at least, sometimes the raid needs to be tricked into starting).

But at best, RAID5 should give you the safety that you can continue working 
with one disk less and not worry about the filesystem. Sounds like a double 
bug.

>I forgot to add:
>Even after a xfs_repair sometimes another directly following run of
>xfs_check or xfs_repair finds errors.
>Currently I have problems deleting files from lost+found:
>rm: cannot remove directory `lost+found//2171932973': Directory not
>empty

XFS devs: possibly related the ominous 16777216 thing?

>I ran xfs_check only a few hours ago and it did not show any output
>(which is good).

>>Hi there!
>>
>>(System specs below)
>>
>>Short summary:
>>System (with software raid 5, XFS, four disks connected to AHCI
>>controller) crashes very often and loses data.
>>
>>My system crashes every few days, at the moment daily. The message shown
>>is (the drive changes about every time, I do not see a pattern here):
>>---
>>ata4: handling error/timeout
>>ata4: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
>>ata4: status=0x50 { DriveReady SeekComplete }
>>sdd: Current: sense key=0x0
>>	ASC=0x0 ASCQ=0x0
>>Info fid=0x0
>>---
>>Although according to this message only one of four drives failed (in
>>software RAID5) the system does not do anything useful. Hitting enter at
>>the login prompt does cause the password prompt to appear and no service
>>responds.
>>
>>If I do a soft reset (using Magic Key u, then b) the BIOS does not detect
>>exactly one drive (which is the one shown in the error message I guess).
>>After a hard reset all drives are found, but I have to do a raid resync and
>>xfs_repair (at least, sometimes the raid needs to be tricked into starting).
>>
>>This problem occured with all kernels (all vanilla), starting with
>>2.6.16.something up to 2.6.17.2.
>>I checked all four drives with a Maxtor tool, all drives are fine.
>>The temperature is not a problem, all drives are stable at about 35C.
>>I replaced the SATA cables several times.
>>
>>Some images showing the errors on screen are here:
>>http://c-otto.de/fehler/
>>
>>I'd like to know what component causes this problem and how I can solve
>>it.
>>
>>Please tell me if you need further information!
>>
>>System specs:
>>- Intel iCH7R on Foxconn 945P7AA-EKRS2
>>- Pentium D 805 (2.66 GHz, 1MB Cache, Dual Core)
>>- 4x Maxtor 7V300F0 (MaXLine Plus III 300 GB; Sata 2; 16 MB Cache)
>>- 2 GB RAM
>>
>>PS: Please include me in CC as I do not read the whole LKML.



Jan Engelhardt
-- 
