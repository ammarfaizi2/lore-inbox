Return-Path: <linux-kernel-owner+w=401wt.eu-S1751093AbXACTSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXACTSH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbXACTSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:18:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43763 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbXACTSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:18:04 -0500
Subject: Re: [RFC][PATCH] use cycle_t instead of u64 in struct
	time_interpolator
From: john stultz <johnstul@us.ibm.com>
To: Helge Deller <deller@gmx.de>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
In-Reply-To: <200701031936.36423.deller@gmx.de>
References: <200701022233.25697.deller@gmx.de>
	 <Pine.LNX.4.64.0701030942160.7909@schroedinger.engr.sgi.com>
	 <200701031936.36423.deller@gmx.de>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 11:17:59 -0800
Message-Id: <1167851879.5937.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 19:36 +0100, Helge Deller wrote:
> On Wed Jan 3 2007, Christoph Lameter wrote:
> > On Tue, 2 Jan 2007, Helge Deller wrote:
> >
> > > As far as I could see, this patch does not change anything for the
> > > existing architectures which use this framework (IA64 and SPARC64),
> > > since "cycles_t" is defined there as unsigned 64bit-integer anyway
> > > (which then makes this patch a no-change for them).
> >
> > The 64bit nature of some entities was so far necessary to get the
> > proper accuracy of interpolation. Maybe it can be made to work with 32 bit
> > entities. The macro GET_TI_SECS must work correctly and the less bits are
> > specified in shift the less self-tuning accuracy you will get.
> 
> Yes, it was easily possible to make it 32bit-ready without loosing the accuracy.
> 
> Nevertheless, in the meantime John Stultz pointed me to the CONFIG_GENERIC_TIME framework,  and I implemented it that way:
> http://git.parisc-linux.org/?p=linux-2.6.git;a=commit;h=b6de83b58b8b07f057deacdef8a95b6c32d1c4e6

This looks pretty good, although setting the rating to 200 for a
clocksource you don't want to use seems a bit high (there's a rough
rating scale in clocksource.h). Zero is probably what you want to use
there.

> http://git.parisc-linux.org/?p=linux-2.6.git;a=commit;h=f70a979c843e4610edfb2a316648fe8ae8718f69

This looks to be correct, although as the clocksource infrastructure
evolves it looks like we'll be removing the update_callback code in the
future. So this is fine for now, but will probably need a reevaluation
at some point.

Also to avoid jumping between clocksources, I'd keep the initial
disqualification that occurs before you register the clocksource
(otherwise it will be used for one tick, then be disqualified and you're
back to jiffies).

thanks
-john

