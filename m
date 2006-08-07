Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWHGLHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWHGLHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 07:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWHGLHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 07:07:51 -0400
Received: from styx.suse.cz ([82.119.242.94]:19088 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751188AbWHGLHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 07:07:50 -0400
Date: Mon, 7 Aug 2006 13:07:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807110748.GL27757@suse.cz>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608062243.45129.dtor@insightbb.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 10:43:44PM -0400, Dmitry Torokhov wrote:
> On Saturday 05 August 2006 23:16, Andi Kleen wrote:
> > This whole thing is broken, e.g. on a preemptive kernel when the
> > code can switch CPUs 
> 
> Would not preempt_disable fix that?
> 
> > Dmitry, I would suggest to convert it over to do_gettimeofday and remove
> > all the architecture ifdefs.
> > 
> > Or maybe just remove it completely.  Who cares about the speed of a gameport 
> > anyways? And why can't they measure it in user space? 
> 
> Analog driver uses it to adjust timing. Vojtech should have more background
> on that..
 
The gameport speed is used by digital-over-gameport joystick drivers to
keep track of time based on the number of inb()s done to the gameport. 

We can't use anything slower than rdtsc there, and since rdtsc isn't
always available, the count of inb()s is the best approximation.

The speed can't easily be measured in userspace - you need to make sure
IRQs, DMA and other stuff doesn't interfere with the measurement, which
needs to be rather exact. AND, you need it for the kernel to work, so it
doesn't make sense to move it to an userspace tool that the kernel would
have to call.

The analog joystick driver does even more timing magic to get precise
readings from the port, where the value read depends on the time for a
bit on the port to change from 0 to 1.

I agree that gameports are mostly dead today, but people are still using
them.

-- 
Vojtech Pavlik
Director SuSE Labs
