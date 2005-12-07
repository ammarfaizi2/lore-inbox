Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVLGRxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVLGRxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVLGRxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:53:40 -0500
Received: from ns1.suse.de ([195.135.220.2]:5837 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751474AbVLGRxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:53:39 -0500
Date: Wed, 7 Dec 2005 18:53:38 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris McDermott <lcm@us.ibm.com>,
       Andi Kleen <ak@suse.de>, vojtech@suse.cz
Subject: Re: [RFC][PATCH] x86_64:  Fix collision between pmtimer and pit/hpet timekeeping
Message-ID: <20051207175338.GB11190@wotan.suse.de>
References: <1133931639.10613.39.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133931639.10613.39.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 09:00:39PM -0800, john stultz wrote:
> Hello,
> 	I thought I had caught all the problems when the no-legacy HPET support
> landed close to the time that the ACPI PM timer support landed, but
> apparently not. :(
> 
> On systems that do not support the HPET legacy functions (basically the
> IBM x460, but there could be others), in time_init() we accidentally
> fall into a PM timer conditional and set the vxtime_hz value to the PM
> timer's frequency. We then use this value with the HPET for timekeeping.
> 
> This patch (which mimics the behavior in time_init_gtod) corrects the
> collision.
> 
> Andi, any objections or suggestions for a better way?

Ok. I will apply it.

But I never quite got why you fall back to the PIT on these systems
anyways - if LEGSUP is not set it just means that the HPET interrupt
cannot be routed to irq 0, right? It should be quite easy to change
the timer code to accept timer interrupts on other irqs. 

You just need to allocate the other interrupt and possibly coordinate
that with the hpet char driver (or rather move the code for that
from there to time.c). I think implementing that would be a better
solution.

-Andi
