Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVIANsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVIANsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbVIANsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:48:47 -0400
Received: from users.ccur.com ([208.248.32.211]:15033 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S965107AbVIANsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:48:46 -0400
Date: Thu, 1 Sep 2005 09:48:02 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
Message-ID: <20050901134802.GA1753@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <F989B1573A3A644BAB3920FBECA4D25A042B03A8@orsmsx407> <Pine.LNX.4.61.0509011104160.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509011104160.3728@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 11:19:51AM +0200, Roman Zippel wrote:

> You still didn't explain what's the point in choosing
> different clock sources for a _timeout_.

Well, if CLOCK_REALTIME is set forward by a minute,
timers & timeout specified against that clock will expire
a minute earlier than expected.  That doesn't happen with
CLOCK_MONOTONIC.  Applications should have the ability
to select what they want to happen in this case (ie,
whether the timeout/timer has to happen at a particular
wall-clock time, say 2pm, or if the interval aspects of
the timer/timeout are more important).  Applications
get this if they have the ability to specify the clock
their timer or timeout is specified against.

Also ..... (I am going off the deep end here) .....

The purpose of CLOCK_REALTIME is to track wall clock time.
That means it can be speed up, slowed down, or even be
force-fed a new time to make it match.

The purpose of CLOCK_MONOTONIC is to provide an even,
unchanging progression of advancing time. That is, any two
intervals on this time-line of the same measured length
actually represent, as close as possible, the same length
of time.

CLOCK_MONOTONIC should get adjustments only to bring its
frequency back into line (but currently gets more than this
in Linux).  CLOCK_REALTIME should and does get adjustments
for frequency and then gets further, temporary speedups
or slowdown to bring its absolute value back into line.

Note that there is no need for the two clocks to track each
other in any way, as Linux currently goes to lengths to do.

I know Linux does not implement the above definition
of CLOCK_MONOTONIC; however, I would like an interface
where when, if the day comes time is properly handled,
applications can take advantage of it.

Joe
