Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271507AbRHUEBZ>; Tue, 21 Aug 2001 00:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271515AbRHUEBP>; Tue, 21 Aug 2001 00:01:15 -0400
Received: from quattro.sventech.com ([205.252.248.110]:8971 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S271507AbRHUEBL>; Tue, 21 Aug 2001 00:01:11 -0400
Date: Tue, 21 Aug 2001 00:01:26 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, t.sailer@alumni.ethz.ch
Subject: Re: Patch for bizzare oops in USB
Message-ID: <20010821000125.A28638@sventech.com>
In-Reply-To: <20010818013101.A7058@devserv.devel.redhat.com> <3B80FBA9.556B7B2B@scs.ch> <20010820174448.A1299@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010820174448.A1299@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Aug 20, 2001 at 05:44:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001, Pete Zaitcev <zaitcev@redhat.com> wrote:
> A prolifiration of subtly different versions of basic primitives
> is not an answer either. But wait, here's a better fix. The
> root of the evil is that the waiting thread accesses urb->status
> before a callback happened, which is unsafe.
> 
> BTW, I took a liberty to clean the thing up a bit. It looked as
> if the author of that fragment was not sure of what he was doing,
> and the style was quite dirty. I think a number of wrongs for
> such a small fragment was astonishing.
> 
>  - "status" was an errno in the begining, then 5 lines down
>    it's bool (== timeout), then it turns into system style once again.
>  - Wasted pointer to wait head
>  - Unused void *stuff.
>  - typedef without _t and unprefixed type name in global header.
>  - Urban legend of test for waitqueue_active() before wakeup.
>    This is one half wrong because so many people do it,
>    anyone has an idea why? Half a point deducted.
>  - Confused and redundant checking for -EINPROGRESS
>    (even if it was the cause of oops)
> 
> And the last one ...
>  - THE GOD DAMN RACE THAT OOPS - that's 10 hacker points down!
>    It only goes to show that replacing interruptible_sleep_on
>    with add_wait_queue/schedule/remove_wait_queue does not make
>    any racy code correct automatically.
> 
> Cheesh, I am surprised _anything_ in Linux kernel works.

So am I. To be honest, there's a bunch of things in the USB code I'm not
entirely happy.

I didn't see many of them until recently, but I guess with experience,
comes wisdom. I had intended to fix many of them in 2.5 when it finally
forks.

I like your patch, but since we have the new completion stuff now, we
should probably use that. I'll make the mod and send off the patch to
Linus when I get back from this business trip.

Thanks.

JE

