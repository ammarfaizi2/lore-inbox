Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWECJKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWECJKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWECJKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:10:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:44233 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965016AbWECJKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:10:35 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200605030940.20409.ak@suse.de>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer>
	 <200605030940.20409.ak@suse.de>
Content-Type: text/plain
Date: Wed, 03 May 2006 11:11:01 +0200
Message-Id: <1146647462.7440.12.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 09:40 +0200, Andi Kleen wrote:
> On Wednesday 03 May 2006 09:09, Mike Galbraith wrote:
> 
> > Given that most people are going to end up using the pm_timer anyway, I
> > don't see the point of even having a sched_clock().  If it's jiffy
> > resolution, it's useless.  If it's wildly inaccurate (as it is in the
> > SMP case, monotonicity issues aside) it's more than useless.
> 
> For sched_clock TSC is always used and it's fine - sched_clock
> doesn't require the guarantees that make TSC often useless otherwise

Regrettable, that's not true.

no command line

now: 4294742814000000  X:6906->timestamp: 4294742813000000
now: 4294743815000000  konqueror:7409->timestamp: 4294743814000000
now: 4294744816000000  kicker:7352->timestamp: 4294744815000000
now: 4294745817000000  konsole:7363->timestamp: 4294745815000000
now: 4294746818000000  konqueror:7409->timestamp: 4294746817000000
now: 4294747819000000  kmix:7388->timestamp: 4294747818000000
now: 4294748820000000  kmix:7388->timestamp: 4294748818000000
now: 4294749821000000  konsole:7363->timestamp: 4294749820000000

command line clock=tsc

now: 124079605551  gconfd-2:7372->timestamp: 124079563934
now: 125079899394  swapper:0->timestamp: 125077929715
now: 126080194639  swapper:0->timestamp: 126077228724
now: 127080489088  swapper:0->timestamp: 127077510347
now: 128080784525  swapper:0->timestamp: 128080615408
now: 129081079685  swapper:0->timestamp: 129080104338
now: 130081375553  evolution:7440->timestamp: 130080376731

If the (expletive deleted) pm timer is enabled in your .config (it is
enabled by default and shall forever remain enabled for all who don't
know the incantation to make pm timer option appear in acpi menu) it is
used unless specifically overridden, which defeats the original purpose
for ever having a high resolution sched_clock().

	-Mike

