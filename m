Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932987AbWJISu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987AbWJISu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932995AbWJISu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:50:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:18327 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932987AbWJISuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:50:55 -0400
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061006185456.261581000@mvista.com>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.261581000@mvista.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 11:50:51 -0700
Message-Id: <1160419851.5458.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> plain text document attachment (clocksource_init_call.patch)
> Since it's likely that this interface would get used during bootup 
> I moved all the clocksource registration into the postcore initcall. 

So this is still somewhat of an open question: While timekeeping_init
runs quite early, and the timekeeping subsystem and its interface is
usable early in the boot process, currently not all the clocksources are
available as early. This is by design, as there may be clocksource
driver modules loaded later on in the boot process, so we don't want to
require it early.

So, the question becomes: Do we want to start using arch specific
clocksources as early as possible, with the potential that we'll replace
it when a better one shows up later? It would allow for finer grained
timekeeping early in boot, which sounds nice, but I'm not sure how great
the real need is for that.

> This also eliminated some clocksource shuffling during bootup.

Actually, I'm not sure I see this. Which shuffling does it avoid? 

I suspect it might actually cause more shuffling, as some clocksources
(well, just the TSC, really.. its such a pain...) are not disqualified
until later because we don't know if the system will enter C3, or change
cpufreq, etc..  By waiting longer, we increase the chance that those
disqualifying actions will occur before we install it.

thanks
-john

