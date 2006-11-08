Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754009AbWKHDXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbWKHDXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 22:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbWKHDXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 22:23:43 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:13625 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1754009AbWKHDXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 22:23:42 -0500
Subject: Re: 2.6.18-rt7: rollover with 32-bit cycles_t
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Kevin Hilman <khilman@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4551348B.6070604@mvista.com>
References: <4551348B.6070604@mvista.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 19:23:41 -0800
Message-Id: <1162956221.20694.13.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 17:36 -0800, Kevin Hilman wrote:
> On ARM, I'm noticing the 'bug' message from check_critical_timing()
> where two calls to get_cycles() are compared and the 2nd is assumed to
> be >= the first.
> 
> This isn't properly handling the case of rollover which occurs
> relatively often with fast hardware clocks and 32-bit cycle counters.
> 
> Is this really a bug?  If the get_cycles() can be assumed to run between
> 0 and (cycles_t)~0, using the right unsigned math could get a proper
> delta even in the rollover case.  Is this a safe assumption?

Seems like the check should really be using something like time_before()
time_after() which takes the rollover into account .. What I don't
understand is why we don't see those on x86 ..

Daniel

