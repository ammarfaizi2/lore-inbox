Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUAIOaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUAIOaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:30:09 -0500
Received: from dp.samba.org ([66.70.73.150]:51096 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261890AbUAIOaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:30:03 -0500
Date: Sat, 10 Jan 2004 01:25:45 +1100
From: Anton Blanchard <anton@samba.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Limit hash table size
Message-ID: <20040109142544.GA23038@krispykreme>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Last time I checked, the tcp ehash table is taking a whooping (insane!)
> 2GB on one of our large machine.  dentry and inode hash tables also take
> considerable amount of memory.
> 
> This patch just enforces all the hash tables to have a max order of 10,
> which limits them down to 16MB each on ia64.  People can clean up other
> part of table size calculation.  But minimally, this patch doesn't
> change any hash sizes already in use on x86.

By limiting it by order you are crippling ppc64 compared to ia64 :)
Perhaps we should limit it by size instead.

Have you done any analysis of hash depths of large memory machines? We
had some extremely deep pagecache hashchains in 2.4 on a 64GB machine.
While the radix tree should fix that, whos to say we cant get into a
similar situation with the dcache?

Check out how deep some of the inode hash chains are here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0105.html

That was on a 64GB box from memory. Switch to the current high end,
say 512GB and those chains could become a real dogs breakfast,
especially if we limit the hashtable to 4MB.

Anton
