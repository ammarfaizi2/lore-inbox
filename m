Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265260AbUENLpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUENLpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUENLo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:44:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5076 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265262AbUENLo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:44:56 -0400
Date: Fri, 14 May 2004 16:48:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Raghavan <raghav@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com, torvalds@osdl.org,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040514111759.GL4002@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <20040508201259.GA6383@in.ibm.com> <20041006125824.GE2004@in.ibm.com> <20040511132205.4b55292a.akpm@osdl.org> <20040514103322.GA6474@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514103322.GA6474@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 04:03:23PM +0530, Raghavan wrote:
> 
> Environment - 2-way P4 Xeon 2.4MHz SMP box with 4.5GB RAM.
> Tests were run for 10 iterations to calculate the milliseconds/iteration
> and then mean and deviation were calculated.

I think it is microseconds/iteration. Lesser the better.

> Kernel version              Mean              Standard Deviation
> ---------------             ----              ------------------
> 
> 2.6.6-rc3(baseline)         10578             221
> 
> 2.6.6                       10280             110

So alignment changes helped.

> 
> 2.6.6-bk                    10862             30

Hash function changes regressed.


> 2.6.6-mm1                   10626             36

dentry size change patchset helps.

> To find out if the huge performance dip between the 2.6.6
> and 2.6.6-bk is because of the hash changes, I removed the hash patch
> from 2.6.6-bk and applied it to 2.6.6.
> 
> 2.6.6-bk with old hash      10685             34
> 
> 2.6.6 with new hash         10496             125
> 
> Looks like the new hashing function has brought down the performance.
> Also some code outside dcache.c and inode.c seems to have pushed down
> the performance in 2.6.6-bk.

OK, I am confused. These numbers show that the new hash function
is better. It contradicts your conclusion. And why are you 
comparing 2.6.6-bk+old has with 2.6.6+new hash ?  Why not 
2.6.6-bk vs. 2.6.6-bk-with-old-hash ? 

Thanks
Dipankar

