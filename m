Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVIAPTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVIAPTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbVIAPTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:19:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57477 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030194AbVIAPTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:19:32 -0400
Date: Thu, 1 Sep 2005 17:18:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Joe Korty <joe.korty@ccur.com>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
In-Reply-To: <20050901134802.GA1753@tsunami.ccur.com>
Message-ID: <Pine.LNX.4.61.0509011634200.3728@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B03A8@orsmsx407>
 <Pine.LNX.4.61.0509011104160.3728@scrub.home> <20050901134802.GA1753@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Sep 2005, Joe Korty wrote:

> On Thu, Sep 01, 2005 at 11:19:51AM +0200, Roman Zippel wrote:
> 
> > You still didn't explain what's the point in choosing
> > different clock sources for a _timeout_.
> 
> Well, if CLOCK_REALTIME is set forward by a minute,
> timers & timeout specified against that clock will expire
> a minute earlier than expected.

That just rather suggests that the pthread API is broken as usual.
(No other possible user was mentioned so far.)

>  That doesn't happen with
> CLOCK_MONOTONIC.  Applications should have the ability
> to select what they want to happen in this case (ie,
> whether the timeout/timer has to happen at a particular
> wall-clock time, say 2pm, or if the interval aspects of
> the timer/timeout are more important).  Applications
> get this if they have the ability to specify the clock
> their timer or timeout is specified against.

So setup a timer that goes off at that time and interrupts the operation. 
There is no need to overload the operation itself with an overly complex 
timeout specification.

> The purpose of CLOCK_MONOTONIC is to provide an even,
> unchanging progression of advancing time. That is, any two
> intervals on this time-line of the same measured length
> actually represent, as close as possible, the same length
> of time.
> 
> CLOCK_MONOTONIC should get adjustments only to bring its
> frequency back into line (but currently gets more than this
> in Linux).  CLOCK_REALTIME should and does get adjustments
> for frequency and then gets further, temporary speedups
> or slowdown to bring its absolute value back into line.

That would make a rather useless CLOCK_MONOTONIC. The basic problem is 
that it would be very hard to specify the time without exactly knowing 
it's frequency, the larger the time difference the larger the time skew 
would be compared to CLOCK_REALTIME and without an atomic clock in your 
computer you have no way of knowing which one is "real".
So in practice it's easier to advance CLOCK_MONOTONIC/CLOCK_REALTIME 
equally and only apply time jumps to CLOCK_REALTIME.

bye, Roman
