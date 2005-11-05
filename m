Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVKEJGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVKEJGW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 04:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVKEJGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 04:06:21 -0500
Received: from mail.avalus.com ([195.82.114.197]:52635 "EHLO shed.alex.org.uk")
	by vger.kernel.org with ESMTP id S1751290AbVKEJGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 04:06:20 -0500
Date: Sat, 05 Nov 2005 09:06:08 +0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: adam radford <aradford@gmail.com>,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last
 third of inode tables
Message-ID: <98C5049497A78ECC77D350B7@[192.168.100.25]>
In-Reply-To: <b1bc6a000511021459h1a2f5089q3b37b56460b7799d@mail.gmail.com>
References: <BEDEA151E8B1D6CEDD295442@192.168.100.25>
 <b1bc6a000511021459h1a2f5089q3b37b56460b7799d@mail.gmail.com>
X-Mailer: Mulberry/4.0.4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam,

>> All seems to go well until I try and do mke2fs. This appears to work,
>> and tries to write the inode tables. However, at (about) 3400 inodes
>> (of 11176), it slows to a crawl, writing one table every 10 seconds.
>> strace shows it is still running, and no errors are being reported.
>> However, it seems very sick.
>
> Do you have cache turned on or off?  If it's off, try turning it on.

On. I started again (deleted the units etc.) which I'd done before.
I am not sure quite what I did different this time. Now I get 270Mb/s
on dbench, 100Mb/s (approx) on a solid contiguous write (dd), which
is well into the field of uninspiring but not as daft as 7Mb/s. I had
rather expected that h/w RAID 5 would give me faster reads, and only
slightly degraded writes, compared to a single disk of the same type
plugged into the motherboard SATA.

However, dbench puts the (dual opteron 275) machine into 99% system
state. Is that normal? Surely it should be in i/o wait.

I /think/ what had happened is this: When I press F8 to exit the
BIOS, it did not initialize the array (this is in accordance with the
manual, it being deferred). Despite leaving the machine idle in the O/S
for 2 days, it didn't start initializing the array. Running the mkfs
started the initialization (would that make sense)? The second time
I ran mkfs, I may have already (somehow) triggered it to start earlier.

I shall try and work out some soak test I can run on it this w/e.

--
Alex Bligh
