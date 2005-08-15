Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVHOSkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVHOSkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVHOSkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:40:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13696 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964874AbVHOSkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:40:22 -0400
Date: Mon, 15 Aug 2005 11:40:13 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: xfs-masters@oss.sgi.com, sfrench@samba.org, sct@redhat.com,
       okir@monad.swb.de.sgi.com, trond.myklebust@fys.uio.no,
       reiserfs-dev@namesys.com, urban@teststation.com, nathans@sgi.com,
       akpm@osdl.org, samba-technical@lists.samba.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       samba@samba.org, linux-xfs@oss.sgi.com
Subject: Re: [xfs-masters] [-mm PATCH 2/32] fs: fix-up schedule_timeout() usage
Message-ID: <20050815184013.GJ2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com> <20050815180804.GE2854@us.ibm.com> <20050815181752.GA23701@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815181752.GA23701@lst.de>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.2005 [20:17:52 +0200], Christoph Hellwig wrote:
> On Mon, Aug 15, 2005 at 11:08:04AM -0700, Nishanth Aravamudan wrote:
> > Description: Use schedule_timeout_{,un}interruptible() instead of
> > set_current_state()/schedule_timeout() to reduce kernel size. Also use
> > helper functions to convert between human time units and jiffies rather
> > than constant HZ division to avoid rounding errors.
> 
> The XFS changes are still wrong for the same rason as last time,
> we actually do want the daemons to do work if they're woken earlier
> using wake_up_process.

Hrm, I got dropped from the Cc list...? No worries, I'm subscribed in
two places :)

I think your reference to "last time" is the KJ patches which probably
used msleep{,_interruptible}() instead of schedule_timeout(). This
patchset, in contrast, should result in *no* functional changes (beyond
some more precisie conversions, where appropriate).
schedule_timeout_interruptible(some_value), for instance is nothing more than:

	set_current_state(TASK_INTERRUPTIBLE);
	schedule_timeout(some_value);

Just in the form of a combine function call. No loops like msleep() &
co.

Is the patch still a problem?

Thanks,
Nish
