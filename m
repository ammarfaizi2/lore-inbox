Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319567AbSIHE11>; Sun, 8 Sep 2002 00:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319568AbSIHE11>; Sun, 8 Sep 2002 00:27:27 -0400
Received: from waste.org ([209.173.204.2]:42213 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319567AbSIHE10>;
	Sun, 8 Sep 2002 00:27:26 -0400
Date: Sat, 7 Sep 2002 23:31:52 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Cc: Tommi Kyntola <kynde@ts.ray.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020908043152.GA28642@waste.org>
References: <20020820172215.GE19225@waste.org> <Pine.LNX.4.44.0209072344550.21724-100000@redshift.mimosa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209072344550.21724-100000@redshift.mimosa.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2002 at 11:51:47PM -0400, D. Hugh Redelmeier wrote:
> | From: Oliver Xymoron <oxymoron@waste.org>
> | Date: Tue, 20 Aug 2002 12:22:16 -0500
> 
> | On Tue, Aug 20, 2002 at 07:19:26PM +0300, Tommi Kyntola wrote:
> 
> | >  Does strict gamma assumption 
> | > really lead to so strict figures as you showed in your patch :
> | > static int benford[16]={0,0,0,1,2,3,4,5,5,6,7,7,8,9,9,10};
> | > 
> | > Numbers below 0..7, don't have a single bit of entropy?
> | 
> | They have fractional bits of entropy.

Turns out that the analysis that lead to the above numbers was subtly
flawed. Together with Arvend Bayer, I've come up with a new analysis
where the "effect" falls off surprisingly rapidly. In the end, an
n-bit number will have n-2 bits of entropy. I throw off a third bit
just to be safe.
 
> If entropy is added in such small amounts, should the entropy counter
> be denominated in, say, 1/4 bits?

If entropy were truly scarce, we could do that. For folks who are
getting starved, my current patch set has a tunable called trust_pct,
which effectively lets you mix in untrusted entropy in hundredths of a
bit.

> Would this allow the entropy estimate to safely grow significantly
> faster? Are the estimates accurate enough to justify such precision?

We'd need to be able to do a non-integer log2 to do much better.
That's putting too much faith in the model, which is just some
handwaving that keyboard and mouse interrupts, etc., ought to follow
the magical "distribution of distributions". Fortunately, you can vary
quite a bit from that distribution into various gamma forms and the
like and still fall within a bit or so of the presumed entropy, which
is why I've added another bit of safety margin.

I'll repost my patches as soon as I take a swing at the /dev/random vs
/dev/urandom pool business.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
