Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUI3A4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUI3A4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUI3A4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:56:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:31942 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266892AbUI3A4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:56:10 -0400
Date: Wed, 29 Sep 2004 20:46:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: OSDL aio-stress results on latest kernels show buffered random
 read issue
Message-Id: <20040929204628.0ffdf10e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0409291621170.4332-100000@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.33.0409291621170.4332-100000@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judith Lebzelter <judith@osdl.org> wrote:
>
> Hello;
> 
> I am running aio-stress on the most recent kernels and have
> found that on linux-2.6.8, 2.6.9-rc2 and 2.6.9-rc2-mm4 the
> performance of buffered random reads is poor compared to the
> buffered random writes:
> 
>                2.6.8      2.6.9-rc2     2.6.9-rc2-mm4
>              --------------------------------------------
> random write 35.66 MB/s   34.80 MB/s    29.89 MB/s
> random read   7.69 MB/s    7.50 MB/s     7.68 MB/s
> 
> ** 2CPU hosts with striped Megaraid. 1G RAM. 4G File.
> 
> 
> This shows up on our 4CPU host as well. (striped AACRAID.4G
> RAM. 8G File):
>              2.6.9-rc2     2.6.9-rc2-mm4   2.6.9-rc2-mm1
>              -------------------------------------------
> random write 31.36 MB/s     18.92 MB/s      18.97 MB/s
> random read  11.13 MB/s      9.74 MB/s      11.05 MB/s
> 
> 
> There seems to be an issue with the reads.  Usually, reads
> should be at least as fast as writes of the same type.
> 
> Also, there seems to be a substantial drop-off in the performance
> of AIO buffered-random writes in the mm kernels. (14% on 2CPU,
> 40% on 4CPU)
> 

Well one would expect writes to be much faster than reads because writes
usually do not involve performing physical I/O, and when pagecache
writeback finally happens it has vastly more data to work with and hence
can schedule I/O more efficiently.

Unless you are using O_SYNC or fsync(), in which case ignore the above.

The regression within random write performance is unexpected.  Can you
please provide a URL to the current version of the test tool, and a
description of how you are invoking it?  What sort of I/O system, what
filesystem, etc.

Thanks.
