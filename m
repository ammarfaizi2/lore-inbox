Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbVIAM4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVIAM4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVIAM4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:56:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43140 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965095AbVIAM4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:56:06 -0400
Date: Thu, 1 Sep 2005 14:55:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: akpm@osdl.org, joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: RE: FW: [RFC] A more general timeout specification
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A042B057C@orsmsx407>
Message-ID: <Pine.LNX.4.61.0509011410490.3728@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B057C@orsmsx407>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Sep 2005, Perez-Gonzalez, Inaky wrote:

> >You still didn't explain what's the point in choosing different clock
> >sources for a _timeout_.
> 
> The same reasons that compel to have CLOCK_REALTIME or 
> CLOCK_MONOTONIC, for example. Or the need to time out on a
> high resolution clock. 
> 
> A certain application might have a need for a 10ms timeout, 
> but another one might have it on 100us--modern CPUs make that
> more than possible. The precission of your time source permeates
> to the precission of your timeout.

Please give me a realistic and non-broken example.
We can add lots of stuff to the kernel, because it _might_ be needed, but 
we (usually) don't if it hurts the general case, just adds bloat and 
userspace can achieve the same thing via different means.

> [of course, now at the end it is still kernel time, but the 
> ongoing revamp work on timers will change some of that, one
> way or another].

That doesn't mean it has to be exported via every single kernel API, which 
allows to specify a time.

> >You didn't answer my other question, let's assume we add such a timeout
> >structure, what's wrong with converting it to kernel time (which would
> >automatically validate it).
> 
> And again, that's what at the end this API is doing, convering it to 
> kernel time. 

No, it's not doing this at the validation point.

> Give it a more "human" specification (timespec) and gets the job done.
> No need to care on how long a jiffy is today in this system, no need
> to replicate endlessly the conversion code, which happens to be
> non-trivial (for the absolute time case--but still way more trivial 
> than userspace asking the kernel for the time, computing a relative 
> shift and dealing with the skews that preemption at a Murphy moment 
> could cause). 
> 
> It is mostly the same as schedule_timeout(), but it takes the sleep
> time in a more general format. As every other API, it is designed so 
> that the caller doesn't need to care or know about the gory details 
> on how it has to be converted.

Sorry, but I don't get what you're talking about. What has the user space 
concept of time to do with how the kernel finally handles a timeout?
More specifically why does the first require a new API in the kernel to 
deal with all kinds of timeouts?

bye, Roman
