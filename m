Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUCEQ6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUCEQ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:58:20 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41489
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262652AbUCEQ6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:58:15 -0500
Date: Fri, 5 Mar 2004 17:58:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, peter@mysql.com, akpm@osdl.org, riel@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305165850.GI4922@dualathlon.random>
References: <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <p73ad2v47ik.fsf@brahms.suse.de> <20040305162319.GA16835@elte.hu> <20040310142125.6f448d28.ak@suse.de> <20040305164902.GA17745@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305164902.GA17745@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 05:49:02PM +0100, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > > [...] Only drawback is that if a timer tick is delayed for too long it
> > > > won't fix that, but I guess that's reasonable for a 1s resolution.
> > > 
> > > what do you mean by delayed?
> > 
> > Normal gettimeofday can "fix" lost timer ticks because it computes the
> > true offset to the last timer interrupt using the TSC or other means.
> > xtime is always the last tick without any correction. If it got
> > delayed too much the result will be out of date.
> 
> yeah - i doubt the softirq delay is a real issue.

Do you think it's more likely the irq is lost? I think it's more likely
the softirq takes more than 1msec than the irq is lost. If softirq takes
more than 1msec we don't necessairly need to fix that, the timer code is
designed to handle that case properly and the softirq is the place where
to do the bulk of the work, if irq is lost we definitely need to fix
that.

Anyways either ways time may go backwards w.r.t. gettimeofday.

I'm not saying it's a real issue though.
