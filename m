Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbUCRSAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUCRSAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:00:15 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62084
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262823AbUCRSAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:00:11 -0500
Date: Thu, 18 Mar 2004 19:00:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@ximian.com>
Cc: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318180059.GC2536@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <1079632130.6043.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079632130.6043.6.camel@localhost>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:48:50PM -0500, Robert Love wrote:
> On Thu, 2004-03-18 at 09:51, Andrea Arcangeli wrote:
> 
> > the counter is definitely not optimized away, see:
> 
> This is because of work Dave Miller and Ingo did - irq count, softirq
> count, and lock count (when PREEMPT=y) are unified into preempt_count. 
> 
> So it is intended.
> 
> The unification makes things cleaner and simpler, using one value in
> place of three and one interface and concept in place of many others. 
> It also gives us a single simple thing to check for an overall notion of
> "atomicity", which is what makes debugging so nice.

You're right, I didn't notice the other counters disappeared.  Those
counter existed anyways w/o preempt too, so it would been superflous
with preempt=y to do the accounting in two places. So this is zerocost
with preempt=n and I was wrong claiming superflous preempt leftovers.
