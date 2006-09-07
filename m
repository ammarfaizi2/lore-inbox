Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWIGQCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWIGQCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWIGQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:02:12 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:20891 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S932241AbWIGQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:02:08 -0400
Subject: Re: [PATCH 10/21] block: elevator selection and pinning
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20060906134642.GC14565@kernel.dk>
References: <20060906131630.793619000@chello.nl> >
	 <20060906133954.673752000@chello.nl>  <20060906134642.GC14565@kernel.dk>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 18:01:29 +0200
Message-Id: <1157644889.17799.35.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 15:46 +0200, Jens Axboe wrote:
> On Wed, Sep 06 2006, Peter Zijlstra wrote:
> > Provide an block queue init function that allows to set an elevator. And a 
> > function to pin the current elevator.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Signed-off-by: Daniel Phillips <phillips@google.com>
> > CC: Jens Axboe <axboe@suse.de>
> > CC: Pavel Machek <pavel@ucw.cz>
> 
> Generally I don't think this is the right approach, as what you really
> want to do is let the driver say "I want intelligent scheduling" or not.
> The type of scheduler is policy that is left with the user, not the
> driver.

True, and the only sane value here is NOOP, any other policy would not
be a good value. With this in mind would you rather prefer a 'boolean'
argument suggesting we use NOOP over the default scheduler?

(The whole switch API was done so I could reset the policy from the
iSCSI side of things without changing the regular SCSI code - however
even that doesn't seem to work out, mnc suggested to do it in userspace,
so that API can go too)

Would you agree that this hint on intelligent scheduling could be used
to set the initial policy, the user can always override when he
disagrees.

These network block devices like NBD, iSCSI and AoE often talk to
virtual disks, any attempt to be smart is a waste of time.

> And this patch seems to do two things, and you don't explain what the
> pinning is useful for at all.

It was a hack, and its gone now.

