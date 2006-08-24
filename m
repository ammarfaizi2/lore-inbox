Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWHXWQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWHXWQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWHXWQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:16:37 -0400
Received: from homer.mvista.com ([63.81.120.158]:41337 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1422758AbWHXWQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:16:36 -0400
Subject: Re: [RFC] maximum latency tracking infrastructure
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <1156456644.3014.95.camel@laptopd505.fenrus.org>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
	 <1156456349.6951.10.camel@dwalker1.mvista.com>
	 <1156456644.3014.95.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 15:16:35 -0700
Message-Id: <1156457795.6951.18.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 23:57 +0200, Arjan van de Ven wrote:
> > I was just thinking that it might be cleaner to register a structure
> > instead of tracking identifiers to usecs. You might get a speed up on
> > some of the operations, like unregister.
> 
> it makes things a lot more complex for both the user and the
> infrastructure though, and I doubt it's going to be a performance gain;
> you need to walk all registered items anyway to decide the new minimum
> value if you unregister one for example.

Might be time for a priority list (lib/plist.c), but that might be like
swatting a gnat with a sledge hammer.

> > Another thing I was thinking about is that this seems somewhat contrary
> > to the idea of using dynamic tick (assuming it was in mainline) to
> > heuristically pick a power state. Do you have any thoughts on how you
> > would combine the two?
> 
> Actually it's designed in part FOR this case!
> So how that will work (thought experiment, I don't have the code yet)
> 
> In idle, determine the time the next scheduled event is.
> Then given that time go over the C-states and pick the deepest C-state
> that
> 1) satisfies the requested latency
> 2) has a latency that is a small enough fraction of the total time
> 
> (2 is needed to not pick a 1 msec-latency C state for a 1ms idle, that
> won't save you power most likely, so you need to have enough time in
> "real" idle)
> 
> so when you know your latency requirements, you now can pick a DEEPER
> sleepstate than you could before (or at least the right one)... dynticks
> needs this more than anything :)

Sounds pretty good. Since dynamic tick tracks timer events one could
also add a method to track interrupts in general if they are regular
enough to do so. That's just thinking while typing, so it might not be
sane.

Daniel

