Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266446AbUAIJYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 04:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUAIJYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 04:24:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:29647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266445AbUAIJYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 04:24:48 -0500
Date: Fri, 9 Jan 2004 01:25:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Limit hash table size
Message-Id: <20040109012507.12773323.akpm@osdl.org>
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> The issue of exceedingly large hash tables has been discussed on the
>  mailing list a while back, but seems to slip through the cracks.
> 
>  What we found is it's not a problem for x86 (and most other
>  architectures) because __get_free_pages won't be able to get anything
>  beyond order MAX_ORDER-1 (10) which means at most those hash tables are
>  4MB each (assume 4K page size).  However, on ia64, in order to support
>  larger hugeTLB page size, the MAX_ORDER is bumped up to 18, which now
>  means a 2GB upper limits enforced by the page allocator (assume 16K page
>  size).  PPC64 is another example that bumps up MAX_ORDER.
> 
>  Last time I checked, the tcp ehash table is taking a whooping (insane!)
>  2GB on one of our large machine.  dentry and inode hash tables also take
>  considerable amount of memory.
> 
>  This patch just enforces all the hash tables to have a max order of 10,
>  which limits them down to 16MB each on ia64.  People can clean up other
>  part of table size calculation.  But minimally, this patch doesn't
>  change any hash sizes already in use on x86.

Fair enough; it's better than what we had before and Mr Networking is OK
with it ;)  I can't say that I can think of anything smarter.  Thanks.

