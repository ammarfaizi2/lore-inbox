Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266757AbUBMF4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 00:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUBMF4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 00:56:18 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26893 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266757AbUBMF4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 00:56:16 -0500
Date: Fri, 13 Feb 2004 06:53:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Message-ID: <20040213055350.GG29363@alpha.home.local>
References: <402C0D0F.6090203@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402C0D0F.6090203@techsource.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 06:32:31PM -0500, Timothy Miller wrote:
 
> For writes, iozone found an upper bound of about 10megs/sec, which is 
> abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
> than reads, because once the write is sent, you can forget about it. 
> You don't have to wait around for something to come back, and that 
> latency for reads can hurt performance.  The OS can also buffer writes 
> and reorder them in order to improve efficiency.

It depends on the disk too. Lots of disks (specially IDE) are far slower
on writes than they are on reads.

> The 3ware has this write cache that you can turn on or off.  With it 
> off, it ensures that writes make it to the disks in order.  With it on, 
> it will reorder writes more efficiently.  However, I noticed that the 
> performance only went up to about 16meg/sec with the cache ON.

I don't think that the FS type has much importance once the cache is ON.

> IMPORTANT QUESTION:  Is there any metadata anywhere in the swap 
> partition (when it's not in use) that I need to save before I fill it 
> with zeros?

No, there's nothing to save, but you'll have to rebuild the swap at the
end of your tests : mkswap /dev/sga3
I too often use the swap partition for testing purpose or for temporary
storage ; it's easy to do a swapoff; mke2fs on it :-)

> Also, what do I use as a source for zeros when writing with dd? 
> "/dev/zero"?

yes. but don't try to copy any file from the disk onto this partition,
because head seeks will slow things down.

> What's the command?  How about this:
>     time dd if=/dev/zero of=/dev/sga3 bs=1024 count=1024

do it like this, but use higher values, particularly for bs which is only
1kB here. Using something like bs=65536 and count=4096 will give you a 256 MB
file.

> Will that do it?  Should I use an offset to avoid any kind of header or 
> metadata?

not needed. Just ensure that you write to the right partition, and better
check twice.

Regards
Willy

