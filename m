Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWIGQ3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWIGQ3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWIGQ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:29:52 -0400
Received: from brick.kernel.dk ([62.242.22.158]:55314 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932258AbWIGQ3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:29:51 -0400
Date: Thu, 7 Sep 2006 18:33:13 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/21] block: elevator selection and pinning
Message-ID: <20060907163313.GK18333@kernel.dk>
References: <20060906131630.793619000@chello.nl> <20060906133954.673752000@chello.nl> <20060906134642.GC14565@kernel.dk> <1157644889.17799.35.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157644889.17799.35.camel@lappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07 2006, Peter Zijlstra wrote:
> On Wed, 2006-09-06 at 15:46 +0200, Jens Axboe wrote:
> > On Wed, Sep 06 2006, Peter Zijlstra wrote:
> > > Provide an block queue init function that allows to set an elevator. And a 
> > > function to pin the current elevator.
> > > 
> > > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > > Signed-off-by: Daniel Phillips <phillips@google.com>
> > > CC: Jens Axboe <axboe@suse.de>
> > > CC: Pavel Machek <pavel@ucw.cz>
> > 
> > Generally I don't think this is the right approach, as what you really
> > want to do is let the driver say "I want intelligent scheduling" or not.
> > The type of scheduler is policy that is left with the user, not the
> > driver.
> 
> True, and the only sane value here is NOOP, any other policy would not
> be a good value. With this in mind would you rather prefer a 'boolean'
> argument suggesting we use NOOP over the default scheduler?

Nope, I don't think it's the right thing to do. Either we want to pass a
type down or a profile of some sort.

For the work you are doing here, just forget about it. It's not like
it's a critical piece, just list in the README (or wherever) that noop
is a good choice and leave it at that.

> Would you agree that this hint on intelligent scheduling could be used
> to set the initial policy, the user can always override when he
> disagrees.
> 
> These network block devices like NBD, iSCSI and AoE often talk to
> virtual disks, any attempt to be smart is a waste of time.

I think you'll find the runtime overhead of them is pretty close and
hard to measure in most setups, it's things like the queue idling and
anticipation that AS/CFQ might do that will potentially decrease your io
performance. deadline and noop would be equally good choices.

So you don't want to pass down hints on "use noop", you really want to
tell the block layer that you have no seek penalty for instance. And a
range of other parameters.

-- 
Jens Axboe

