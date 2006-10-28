Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWJ1UQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWJ1UQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWJ1UQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:16:50 -0400
Received: from 1wt.eu ([62.212.114.60]:18436 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964814AbWJ1UQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:16:50 -0400
Date: Sat, 28 Oct 2006 22:16:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: thockin@hockin.org
Cc: Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028201628.GC1603@1wt.eu>
References: <1161969308.27225.120.camel@mindpipe> <1162006081.27225.257.camel@mindpipe> <20061028052837.GC1709@1wt.eu> <200610281137.22451.ak@suse.de> <20061028191515.GA1603@1wt.eu> <20061028191800.GA20701@hockin.org> <20061028193217.GD1709@1wt.eu> <20061028194245.GA24083@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028194245.GA24083@hockin.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 12:42:45PM -0700, thockin@hockin.org wrote:
> On Sat, Oct 28, 2006 at 09:32:18PM +0200, Willy Tarreau wrote:
> > > Was the problem that they were not synced at poweron or that they would
> > > drift due to power-states?
> > 
> > They resynced at power up, but would constantly drift. I don't even know
> > if it was caused by power states. When the machine was loaded, a single
> > task moving across the cores could see its time jump back and forth 
> > several times a second by an offset sometimes close to +2/-2s.
> 
> That sounds like C1, to me.

OK.

> > > Did you try running with idle=poll, to avoid ever entering C1 state (hlt)?
> > 
> > Yes, I remember trying such things. I also tried 'nohlt', completely
> > disabling power management, including ACPI, etc... I also tried vanilla
> > kernels as well as severely patched ones, but the problem remained the
> > same in all circumstances, that only 'notsc' could solve.
> 
> That's exceedingly strange.  On my dual-socket dual-core, I can get
> roughly synced TSCs (no appreciable drift) by just using idle=poll.

As I said in another mail, I thought I won by running several busy loops
in parallel to the load, which prevented the system from either halting
or slowing down. But it was OK for a few minutes only and started going
mad again.

> If that did not work for you, I'd really want to poke at the system more.

The machine was returned to the supplier and for other reasons, we switched
to a different maker for the about 20 machines (and all single-core). I've
read somewhere that there's already a second version of the sun x2100, I
don't know if it still exhibits the problem. Maybe at least they've fixed
the BIOS to report the HPET.

> > BTW, I've just found a remain of dmesg capture after boot in case you'd
> > like to look for anything in it.
> 
> A dmesg won't be that useful, I'd actually have to poke at the system.

OK. I don't know if anyone there has one at hand, as I don't have it
anymore.

Regards,
Willy

