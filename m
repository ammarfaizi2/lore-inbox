Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUDEOyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUDEOyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:54:08 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:57872 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262772AbUDEOyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:54:05 -0400
Message-ID: <407177DF.2040202@techsource.com>
Date: Mon, 05 Apr 2004 11:14:39 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Consistently slower 3ware RAID performance under 2.6.4
References: <406D89B8.4090308@techsource.com> <20040402154718.43f16ea9.akpm@osdl.org>
In-Reply-To: <20040402154718.43f16ea9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

> 
> You cannot compare 2.4 and 2.6 kernel write performance with `dd', because
> the kernels are tuned differently.  2.6 kernels are tuned to leave less
> dirty pages in memory than a 2.4 kernel.  Hence when your dd has finished,
> 40% of memory will be dirty (needing writeout) under 2.6, but this figure
> is 60% on 2.4.
> 
> So the 2.6 kernel does more writeout during the dd run and less writeout
> after dd has finished.  The 2.4 kernel does less writeout during the dd run
> and more writeout after dd has finished.
> 
> To compare IO performance you'll need to set 2.6's /proc/sys/vm/dirty_ratio
> to 60 and /proc/sys/vm/dirty_async_ratio to 30.  Or use write-and-fsync
> from http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz with
> the `-f' option.
> 
> I don't know why the read bandwidth appears to be lower.  Try increasing
> the readahead with `blockdev --setra'?


That's odd.  I've tried different mem= kernel parameters with no change 
in throughput under 2.4.  That is, 1G vs. 128M vs. 32M all perform the 
same under 2.4 when doing dd to a block device.  On the other hand, 
available RAM makes a HUGE difference when doing dd to a _file_system_.

I haven't tried that under 2.6 yet.

Anyhow, I chose a 1GB test run so as diminish cache effects and file 
system overhead.  Is my logic flawed here?

Thanks.

