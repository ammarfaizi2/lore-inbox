Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbUCEQix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbUCEQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:38:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6669
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262640AbUCEQiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:38:52 -0500
Date: Fri, 5 Mar 2004 17:39:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305163933.GG4922@dualathlon.random>
References: <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <p73ad2v47ik.fsf@brahms.suse.de> <20040305162319.GA16835@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305162319.GA16835@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 05:23:19PM +0100, Ingo Molnar wrote:
> what do you mean by delayed?

if the timer softirq doesn't run and wall_jiffies doesn't increase, we
won't be able to account for it, so time() will return a time in the
past, it will potentially go backwards precisely 1/HZ seconds every tick
that isn't executing the timer softirq. I tend to agree for a 1sec
resultion that's not a big deal though if you run:

	gettimeofday()
	time()

gettimeofday may say the time of the day is 17:39:10 and time may tell
17:39:09
