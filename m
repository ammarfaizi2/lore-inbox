Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbTBEJ3R>; Wed, 5 Feb 2003 04:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267887AbTBEJ3R>; Wed, 5 Feb 2003 04:29:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:43137 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267886AbTBEJ3Q>;
	Wed, 5 Feb 2003 04:29:16 -0500
Date: Wed, 5 Feb 2003 01:39:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: t.baetzler@bringe.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: filesystem access slowing system to a crawl
Message-Id: <20030205013909.6a8c04a3.akpm@digeo.com>
In-Reply-To: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 09:38:45.0591 (UTC) FILETIME=[60B12E70:01C2CCFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi,
> 
> maybe you could help me out with a really weird problem we're having
> with a NFS fileserver for a couple of webservers:
> 
> - Dual Xeon 2.2 GHz
> - 6 GB RAM
> - QLogic FCAL Host adapter with about 5.5 TB on a several RAIDs
> - Debian "woody" w/Kernel 2.4.19
> 
> Running just "find /" (or ls -R or tar on a large directory) locally
> slows the box down to absolute unresponsiveness - it takes minutes
> to just run ps and kill the find process. During that time, kupdated
> and kswapd gobble up all available CPU time. 
> 

Could be that your "low memory" is filled up with inodes.  This would
only happen in these tests if you're using ext2, and there are a *lot*
of directories.

I've prepared a lineup of Andrea's VM patches at

http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.21-pre4/

It would be useful if you could apply 10_inode-highmem-2.patch and
report back.  It applies to 2.4.19 as well, and should work OK there.


