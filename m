Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWAMSGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWAMSGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbWAMSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:06:41 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:54228 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1422770AbWAMSGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:06:40 -0500
Date: Fri, 13 Jan 2006 10:16:31 -0800
From: thockin@hockin.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060113181631.GA15366@hockin.org>
References: <1137104260.2370.85.camel@mindpipe> <20060113180620.GA14382@hockin.org> <1137175117.15108.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137175117.15108.18.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 12:58:36PM -0500, Lee Revell wrote:
> > If your BIOS has an ACPI "HPET" table, then the kernel can use the HPET
> > timer instead.  It doesn't solve the problem for apps or other kernel bits
> > that use rdtsc directly, but there are other fixes for that floating
> > around which will hopefully get consideration when they're mature.
> 
> The apps can be converted to use clock_gettime(), but that does not help
> if the kernel can't keep reasonable time on these machines. 

Some apps/users need higher resolution and lower overhead that only rdtsc
can offer currently.

> But if we just use "clock=pmtmr" by default on these machines the TSC is
> not a problem right?

I never tried it with pmtimer, we had HPET available.  Empirically TSC did
not work (and we had a simple test case to show how bad it could get).
HPET made that go away for users of gettimeofday().

We're exploring rdtsc-compatible solutions.
