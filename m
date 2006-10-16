Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWJPK73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWJPK73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWJPK73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:59:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:23238 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751498AbWJPK72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:59:28 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: Keyboard Stuttering
Date: Mon, 16 Oct 2006 12:59:02 +0200
User-Agent: KMail/1.9.3
Cc: Lee Revell <rlrevell@joe-job.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       David Gerber <dg-lkml@zapek.com>
References: <200610061218.36883.dg-lkml@zapek.com> <1160669564.24931.37.camel@mindpipe> <1160772309.5457.7.camel@localhost.localdomain>
In-Reply-To: <1160772309.5457.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161259.02191.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 October 2006 22:45, john stultz wrote:
> On Thu, 2006-10-12 at 12:12 -0400, Lee Revell wrote:
> > On Tue, 2006-10-10 at 11:25 -0700, john stultz wrote:
> > > On Tue, 2006-10-10 at 13:09 -0400, Dmitry Torokhov wrote:
> > > > > Same problem here. Intel Core 2 Duo with 2.6.19-rc1 x86_64 SMP. Happens on
> > > > > 2.6.17 too. I use 'noapic' as a workaround but that disables one of the CPU
> > > > > core of course.
> > > > >
> > > > > I cannot reproduce the problem within the console nor gdm. Only on the X
> > > > > desktop.
> > > > >
> > > > 
> > > > It looks like the only clocksource available on David's box is
> > > > "jiffies" although the processor shows that it supporst tsc and PM
> > > > timer is enabled and I think that this is what causes keyboard
> > > > stuttering in X. See http://bugzilla.kernel.org/show_bug.cgi?id=7291.
> > > > I believe clocksources is your turf, could you please take a look at
> > > > this.
> > > 
> > > Sure thing. I followed up in the bug, but I don't think the clocksource
> > > code is involved. x86_64 hasn't converted to GENERIC_TIME, so jiffies is
> > > what we use to increment xtime, but the TSC, ACPI PM, or HPET is used
> > > for gettimeofday, etc. 
> > > 
> > > I suspect C3 idling is the culprit, since noapic works around the issue.
> > 
> > Wait, does this mean that Intel's x86-64 implementation has the same
> > buggy TSC as AMD's?
> 
> Not the same issue, no.. but the TSCs do halt in lower powersaving
> modes, which can cause similar results. The new TSC clocksource code on
> i386 will disqualify itself if those lower powerstates are entered, so
> it should auto detect and fall back. On x86_64, this logic apparently is
> sill needed.

x86-64 has code to not use TSC when there is C3. And special case
code for some big boxes which don't sync the TSC fully.

AFAIK the logic is correct.

There were a few failures, but they were either totally broken BIOS or 
overclocking (some ways of overclocking seem to break the TSC synchronization
on dual die Intel dual core CPUs)

Overclocking is not supported (and those people who want it can use notsc) 
and the broken BIOS cases were all fixed with a BIOS update

-Andi


