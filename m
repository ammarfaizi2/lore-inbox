Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTEMUKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTEMUKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:10:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50953 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262285AbTEMUKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:10:40 -0400
Date: Tue, 13 May 2003 16:17:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69 Interrupt Latency
In-Reply-To: <1052840106.2255.24.camel@diemos>
Message-ID: <Pine.LNX.3.96.1030513161327.18019D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2003, Paul Fulghum wrote:

> On Tue, 2003-05-13 at 10:26, Alan Stern wrote:
> 
> > Putting in a sanity check for the global suspend state will be very easy.  
> > But I would like to point out that this "global suspend" does not refer to
> > the entire system, only the USB bus.
> 
> That is a problem then, because the delay can still
> occur during normal system operation.
> 
> > I'm not sure under what
> > circumstances the bus is placed in global suspend; I think it's just when
> > there are no devices attached (or the last remaining device is detached).
> > 
> > However, there have been cases on my own system where turning off the only
> > USB peripheral caused the driver to bounce between suspend_hc() and
> > wakeup_hc() several times without any apparent explanation -- possibly as
> > a result of transient electrical signals on the bus (?).  So perhaps
> > moving that delay out of the ISR isn't such a bad idea.
> 
> Agreed. If this can happen on functional USB controllers
> when no devices are attached, then it is a serious problem.

Instead of trying to guess when to do it, could the sleep be replaced by
setting a flag bit to indicate that a sleep was needed before using the
hardware? Then the sleep could be done when needed but no noise on the USB
bus wouldn't hurt.

1 - there may be many places, I thought of that but didn't look
    since someone will tell me if it's a problem.

2 - if you don't use USB why not just take the driver out?

It would be nice to prevent the problem, of course.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

