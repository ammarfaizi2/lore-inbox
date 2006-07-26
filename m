Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWGZRZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWGZRZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWGZRZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:25:18 -0400
Received: from alnrmhc11.comcast.net ([206.18.177.51]:36748 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030304AbWGZRZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:25:16 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Andi Kleen <ak@suse.de>
Cc: Neil Horman <nhorman@tuxdriver.com>, a.zummo@towertech.it,
       jg@freedesktop.org, linux-kernel@vger.kernel.org,
       Keith Packard <keithp@keithp.com>
In-Reply-To: <p73bqrc5rbu.fsf@verdi.suse.de>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <p73bqrc5rbu.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: OLPC
Date: Wed, 26 Jul 2006 13:25:09 -0400
Message-Id: <1153934710.8660.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 17:16 +0200, Andi Kleen wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > 	At OLS last week, During Dave Jones Userspace Sucks presentation, Jim
> > Geddys and some of the Xorg guys noted that they would be able to stop using gettimeofday
> > so frequently, if they had some other way to get a millisecond resolution timer
> > in userspace,

I agree with Andi here.

> 
> No, no, it's wrong. They should use gettimeofday and the kernel's job
> is to make it fast enough that they can. 

Exactly.  On modern machines, doing a procedure call to get the time (as
opposed to a system trap) is, I suspect, very tolerable.  And who knows,
maybe a smart compiler inlines the procedure so it optimizes to just a
few instructions.

If behind the scenes there is a mapped page that is used to convey this
information efficiently, that's fine.  

But I don't think it should be the application programmer's
responsibility to know of hackish solutions of mmapping particular
devices on particular OS hardware or software platforms.  That's a
symptom of the disease, rather than a clean solution.

> 
> Or rather they likely shouldn't use gettimeofday, but clock_gettime()
> with CLOCK_MONOTONIC instead to be independent of someone setting the
> clock back.

Turns out we already have code to handle the turn back case, but
monotonically increasing time is generally appreciated ;-).

> 
> Memory mapped counters are generally not flexible enough and there
> are lots of reasons why the kernel might need to do special things
> for time keeping. Don't expose them.

Yup.  I agree entirely. 

> 
> -Andi
-- 
Jim Gettys
One Laptop Per Child


