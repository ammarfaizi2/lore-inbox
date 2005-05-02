Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVEBTSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVEBTSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEBTSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:18:42 -0400
Received: from alpha.polcom.net ([217.79.151.115]:16788 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261720AbVEBTSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:18:38 -0400
Date: Mon, 2 May 2005 21:18:35 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to flush data to disk reliably?
In-Reply-To: <1115056355.10370.37.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0505022057070.11701@alpha.polcom.net>
References: <Pine.LNX.4.62.0505021503470.11701@alpha.polcom.net>
 <1115056355.10370.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your fast response!

On Mon, 2 May 2005, Alan Cox wrote:
>> I am asking how to flush the data from these logs to disk. I know of
>> several methods:
>> 1. open with O_SYNC,
>> 2. sync(2),
>> 3. fsync,
>> 4. fdatasync,
>> 5. msync (if they are mmaped).
>>
>> Which of these are best and most reliable for (a/b) and for (IDE/SCSI)?
>
> For scsi the combination of O_SYNC and ext3 or fsync and ext3 should be
> reliable. fdatasync doesn't write back all the metadata so depending on
> the use may not be sufficient. FAT based fs's I believe you need a
> current kernel for full O_SYNC behaviour.

What about other filesystems? Does anybody know anwser for Reiserfs3, 
Reiser4, JFS, XFS and any other popular server filesystems? I assume that 
if log file is some block device (like partition) both O_SYNC and fsync 
will work? What about ext2? What about some strange RAID/DM/NBD 
configurations? (I do not know in advance what our customers will use so I 
need portable method.)


>> What are differences between them?
>
> See the manual pages and/or standard.

I already saw them. But I am asking about current implementation status on 
Linux. For example does fsync differ from fdatasync if file is block 
device? Does O_SYNC always equal "write; fsync" for all not read only 
operations? Is it faster because only one syscall is executed?

Also flushing should be slow (for example 50 flushes/s) because disk seeks 
are slow. So if I need say 200 reliable writes to log per second may I put 
4 independent disks into the server and use them as 4 independent log 
files? But fsync operation blocks. Is there any "submit flush request and 
get some info when done" command or should I use 4 threads / processes?


Thanks in advance,

Grzegorz Kulewski

