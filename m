Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUFUXaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUFUXaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUFUXad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 19:30:33 -0400
Received: from fmr12.intel.com ([134.134.136.15]:59300 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S266493AbUFUXaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 19:30:19 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: Geoff Levand <geoffrey.levand@am.sony.com>,
       Mark Gross <mgross@linux.jf.intel.com>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Date: Mon, 21 Jun 2004 16:29:05 -0700
User-Agent: KMail/1.5.4
Cc: ganzinger@mvista.com, George Anzinger <george@mvista.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <40C7BE29.9010600@am.sony.com> <200406140828.08924.mgross@linux.intel.com> <40D7662A.2030006@am.sony.com>
In-Reply-To: <40D7662A.2030006@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406211629.05122.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 June 2004 15:50, Geoff Levand wrote:
> Mark Gross wrote:
> > On Friday 11 June 2004 15:33, George Anzinger wrote:
> >>I have been thinking of a major rewrite which would leave this code
> >> alone, but would introduce an additional list and, of course, overhead
> >> for high-res timers. This will take some time and be sub optimal, so I
> >> wonder if it is needed.
> >
> > What would your goal for the major rewrite be?
> > Redesign the implementation?
> > Clean up / re-factor the current design?
> > Add features?
> >
> > I've been wondering lately if a significant restructuring of the
> > implementation could be done.  Something bottom's up that enabled
> > changing / using different time bases without rebooting and coexisted
> > nicely with HPET.
> >
> > Something along the lines of;
> > * abstracting the time base's, calibration and computation of the next
> > interrupt time into a polymorphic interface along with the implementation
> > of a few of your time bases (ACPI, TSC) as a stand allown patch.
> > * implement yet another polymorphic interface for the interrupt source
> > used by the patch, along with a few interrupt sources (PIT, APIC, HPET
> > <-- new ) * Implement a simple RTC-like charactor driver using the above
> > for testing and integration.
> > * Finally a patch to integrate the first 3 with the POSIX timers code.
> >
> > What do you think?
> >
> >
> > --mgross
>
> Mark,
>
> Generally I agree with your ideas on what needs fixing up, but I'm
> concerned that the run-time binding of this kind of design would have
> too much overhead for time-critical code paths.  Do you think it is
> useful to have run-time selection of the time base and interrupt source?
>    In my work we have a known fixed hardware configuration that has
> limited timers, so I don't really see a need for runtime configuration
> there.
>

Runtime selection of time base's and interrupt sources for an HRT 
implementation may not be too useful in practice.  It sure would make testing 
and comparing different HRT configuration combonations easier.

I may have function pointers on the brain WRT this patch.  But, to get an 
implementation that exports a common abstraction across architectures, WRT 
time bases and interrupt sources, I don't see any other way than using the 
function pointers in a common structure.  It shouldn't matter much if it 
oppens up a feature that no one cares about (runtime selection on time base / 
interrupt source).

--mgross

