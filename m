Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVKER2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVKER2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVKER2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:28:05 -0500
Received: from [67.137.28.189] ([67.137.28.189]:60289 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1750833AbVKER2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:28:04 -0500
Message-ID: <436CE571.5020801@wolfmountaingroup.com>
Date: Sat, 05 Nov 2005 10:01:37 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: adam radford <aradford@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last third
 of inode tables
References: <BEDEA151E8B1D6CEDD295442@192.168.100.25> <b1bc6a000511021459h1a2f5089q3b37b56460b7799d@mail.gmail.com> <98C5049497A78ECC77D350B7@[192.168.100.25]>
In-Reply-To: <98C5049497A78ECC77D350B7@[192.168.100.25]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:

> Adam,
>
>>> All seems to go well until I try and do mke2fs. This appears to work,
>>> and tries to write the inode tables. However, at (about) 3400 inodes
>>> (of 11176), it slows to a crawl, writing one table every 10 seconds.
>>> strace shows it is still running, and no errors are being reported.
>>> However, it seems very sick.
>>
>>
>> Do you have cache turned on or off? If it's off, try turning it on.
>
>
> On. I started again (deleted the units etc.) which I'd done before.
> I am not sure quite what I did different this time. Now I get 270Mb/s
> on dbench, 100Mb/s (approx) on a solid contiguous write (dd), which
> is well into the field of uninspiring but not as daft as 7Mb/s. I had
> rather expected that h/w RAID 5 would give me faster reads, and only
> slightly degraded writes, compared to a single disk of the same type
> plugged into the motherboard SATA.
>
> However, dbench puts the (dual opteron 275) machine into 99% system
> state. Is that normal? Surely it should be in i/o wait.
>
> I /think/ what had happened is this: When I press F8 to exit the
> BIOS, it did not initialize the array (this is in accordance with the
> manual, it being deferred). Despite leaving the machine idle in the O/S
> for 2 days, it didn't start initializing the array. Running the mkfs
> started the initialization (would that make sense)? The second time
> I ran mkfs, I may have already (somehow) triggered it to start earlier.
>
> I shall try and work out some soak test I can run on it this w/e.


This is what I reported earlier and is the same behavior I am seeing on 
he 9500. I don't think its related
to the firmwae, but something in the driver because I can reproduce it 
on 8000 series controllers as well.
What's common between the two is it's on a 2.6.9 kernel with the 
drivers. Eventually, the init proceeds
and completes, but it's related to the INIT state not getting tripped 
into running.

Jeff

>
> -- 
> Alex Bligh
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>

