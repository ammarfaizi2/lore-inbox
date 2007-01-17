Return-Path: <linux-kernel-owner+w=401wt.eu-S1751468AbXAQXsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbXAQXsY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 18:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAQXsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 18:48:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27024 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbXAQXsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 18:48:23 -0500
X-Greylist: delayed 1226 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 18:48:23 EST
Date: Thu, 18 Jan 2007 10:46:53 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH: 2.6.20-rc4-mm1] JFS: Avoid deadlock introduced by  explicit  I/O plugging
Message-ID: <20070117234653.GI3508@kernel.dk>
References: <1169074549.10560.10.camel@kleikamp.austin.ibm.com> <20070117231847.GH3508@kernel.dk> <1169077157.10560.16.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169077157.10560.16.camel@kleikamp.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17 2007, Dave Kleikamp wrote:
> On Thu, 2007-01-18 at 10:18 +1100, Jens Axboe wrote:
> 
> > Can you try io_schedule() and verify that things just work?
> 
> I actually did do that in the first place, but wondered if it was the
> right thing to introduce the accounting changes that came with that.
> I'll change it back to io_schedule() and test it again, just to make
> sure.

It appears to be the correct change to me - you really are waiting for
IO resources (otherwise it would not hang with the plug change), so
doing an inc/dec of iowait around the schedule should be done.

> If that's the right fix, I can push it directly since it won't have any
> dependencies on your patches.

Perfect!

-- 
Jens Axboe

