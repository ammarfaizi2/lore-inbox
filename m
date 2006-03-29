Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWC2Owg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWC2Owg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWC2Owg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:52:36 -0500
Received: from 4-16-ftth.onsnet.nu ([84.35.16.4]:48644 "EHLO beacon.dhs.org")
	by vger.kernel.org with ESMTP id S1750717AbWC2Owg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:52:36 -0500
Date: Wed, 29 Mar 2006 16:52:23 +0200
From: Jonathan Black <vampjon@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uptime increases during suspend
Message-ID: <20060329145223.GA15636@beacon.dhs.org>
References: <20060325150238.GA9023@beacon.dhs.org> <1143484821.2168.16.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143484821.2168.16.camel@leatherman>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 10:40:20AM -0800, john stultz wrote:
> On Sat, 2006-03-25 at 16:02 +0100, Jonathan Black wrote:
> > The way it is now, one can essentially "cheat": suspend a machine,
> > put it in the cupboard for a couple of weeks, resume it and claim a
> > respectable uptime, because the uptime value only reflects how long
> > ago the system was first booted up, with no regard to how much of
> > that time it has actually been running.
> 
> Well, anyone can hack their kernel to say whatever uptime they want,
> so I'm not to worried about cheating. Are you seeing an actual bug
> here?

Well, of course the uptime value reported by a hacked kernel cannot be
trusted to be accurate or meaningful. My problem is that with the
current behaviour, even the value reported by an *unhacked* kernel
cannot really be trusted, or at least is a lot less meaningful than it
was before, on a machine which uses suspend.
 
> > Would it be possible to get the old behaviour back?
> 
> Why exactly do you want this behavior? Maybe a better explanation
> would help stir this discussion.
> 
> The question about the correct behavior is more relevant with
> virtualization as well. Should the OS's uptime increase even when
> another OS is running on the cpu? What is the proper interface to
> export the OS's cpu time? 
> 
> Right now I'm of the opinion that jiffies should be updated, as real
> time has past and timer events that are queued should expire. 
> 
> However with a good enough reason, we might want to add another
> counter that keeps track of how much time we've been suspended as
> well. 

Others have given some practical examples. I think there are probably
examples to be given of both: things that should behave as if the time
spent suspended has actually passed, and things that should behave as if
it had not. So maybe is a good idea to have both these notions available
somehow. 

My initial point was really only that the value reported as the system's
"uptime" should be the latter kind of counter, as it seems silly to
include time during with the machine is completely powered off.

Greetings,
-- 
jonathaN
