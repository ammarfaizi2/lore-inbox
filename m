Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbUKISvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbUKISvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUKISvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:51:11 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:8066 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261616AbUKISvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:51:04 -0500
Date: Tue, 9 Nov 2004 19:51:03 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Patrick Mau <mau@oscar.ping.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Workaround for wrapping loadaverage
Message-ID: <20041109185103.GE29661@mail.13thfloor.at>
Mail-Followup-To: Patrick Mau <mau@oscar.ping.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041108001932.GA16641@oscar.prima.de> <20041108012707.1e141772.akpm@osdl.org> <20041108102553.GA31980@oscar.prima.de> <20041108155051.53c11fff.akpm@osdl.org> <20041109004335.GA1822@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004335.GA1822@oscar.prima.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 01:43:35AM +0100, Patrick Mau wrote:
> On Mon, Nov 08, 2004 at 03:50:51PM -0800, Andrew Morton wrote:
> > 
> > (PLease don't remove people from Cc:.  Just do reply-to-all).
> 
> Hi Andrew,
> 
> sorry, I usually remove people from CC if they're subscribed.
> 
> > Patrick Mau <mau@oscar.ping.de> wrote:
> > >
> > > If you would use 236, 252 and 255 the last to load calculations would
> > > get optimized into register shifts during calculation. The precision
> > > would be bad, but I personally don't mind loosing the fraction.
> > 
> > What would be the impact on the precision if we were to use 8 bits of
> > fraction?
> 
> I didn't have time to check again, but I think I ended up with a load of 0.97
> using one runnable process because of rounding errors.
> 
> > An upper limit of 1024 tasks sounds a bit squeezy.  Even 8192 is a bit
> > uncomfortable.  Maybe we should just reimplement the whole thing, perhaps
> > in terms of tuples of 32-bit values: 32 bits each side of the binary point?
> 
> We re-calculate the load every 5 seconds. I think it would be OK to
> use more bits/registers, it's not that frequently called.

hmm ...

	do_timer() -> update_times() -> calc_load()

so not exactly every 5 seconds ...

but I agree that a higher resolution would be a good
idea ... also doing the calculation when the number
of running/uninterruptible processes has changed would
be a good idea ...

(I implemented something similar for linux-vserver, 
 if there is interest, I could adapt it for mainline)

> It's 1:30 AM and I had a rough working day, maybe I'll prepare a little patch
> tomorrow. I think that 8192 _runnable_ processes seems a bit unusual, but we
> also account for uninterruptable processes. Maybe there was some swap/IO
> storm that triggered the initial overflow, I'll have to check that first.

best,
Herbert

> Best regards,
> Patrick
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
