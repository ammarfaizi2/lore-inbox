Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRIQQPV>; Mon, 17 Sep 2001 12:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbRIQQPL>; Mon, 17 Sep 2001 12:15:11 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:50562 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S269645AbRIQQO7>; Mon, 17 Sep 2001 12:14:59 -0400
Date: Mon, 17 Sep 2001 12:14:36 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010917121435.A19884@cs.cmu.edu>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010917003422Z16197-2757+375@humbolt.nl.linux.org> <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com> <20010917011157.A22989@cs.cmu.edu> <20010917122559Z16382-2758+129@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010917122559Z16382-2758+129@humbolt.nl.linux.org>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 02:33:12PM +0200, Daniel Phillips wrote:
> The inactive queues have always had both mapped and unmapped pages on
> them. The reason for unmapping a swap cache page page when putting it

So the following code in refill_inactive_scan only exists in my
imagination?

	    if (page_count(page) <= (page->buffers ? 2 : 1)) {
		    deactivate_page_nolock(page);
		    page_active = 0;
	    } else {
		    page_active = 1;
	    }

We only move pages to the inactive list when they have one reference
from the page cache and one from buffers. Since all mapped pte's also
keep a reference, this means that there cannot be any pte's that point
to this page by the time we decide to deactivate the page.

> any choice.  The point where we place it on the inactive queue is the
> last point where we're able to find its userspace page table entry.

And that is because we only move it after all pte's have been unmapped.

Jan

