Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWHQGW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWHQGW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWHQGW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:22:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750911AbWHQGW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:22:58 -0400
Date: Wed, 16 Aug 2006 23:22:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060816232253.169e8957.akpm@osdl.org>
In-Reply-To: <17635.59821.21444.287979@cse.unsw.edu.au>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<17635.59821.21444.287979@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 13:59:41 +1000
Neil Brown <neilb@suse.de> wrote:

> > CFQ used to have 1024 requests and we did have problems with excessive
> > numbers of writeback pages.  I fixed that in 2.6.early, but that seems to
> > have got lost as well.
> > 
> 
> What would you say constitutes "excessive"?  Is there any sense in
> which some absolute number is excessive (as it takes too long to scan
> some list) or is it just a percent-of-memory thing?

Excessive = 100% of memory dirty or under writeback against a single disk
on a 512MB machine.  Perhaps that problem just got forgotten about when CFQ
went from 1024 requests down to 128.  (That 128 was actually
64-available-for-read+64-available-for-write, so it's really 64 requests).

> > 
> > Something like that - it'll be relatively simple.
> 
> Unfortunately I think it is also relatively simple to get it badly
> wrong:-)  Make one workload fast, and another slower.
> 

I think it's unlikely in this case.  As long as we keep the queues
reasonably full, the disks will be running flat-out and merging will be as
good as we're going to get.

One thing one does have to watch out for is the many-disks scenario: do
concurrent dd's onto 12 disks and make sure that none of their LEDs go
out.  This is actually surprisingly hard to do, but it would be very hard
to do worse than 2.4.x ;)
