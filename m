Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWJ1Tmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWJ1Tmt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWJ1Tmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:42:49 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:221 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932101AbWJ1Tms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:42:48 -0400
Date: Sat, 28 Oct 2006 12:42:45 -0700
From: thockin@hockin.org
To: Willy Tarreau <w@1wt.eu>
Cc: Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028194245.GA24083@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <1162006081.27225.257.camel@mindpipe> <20061028052837.GC1709@1wt.eu> <200610281137.22451.ak@suse.de> <20061028191515.GA1603@1wt.eu> <20061028191800.GA20701@hockin.org> <20061028193217.GD1709@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028193217.GD1709@1wt.eu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 09:32:18PM +0200, Willy Tarreau wrote:
> > Was the problem that they were not synced at poweron or that they would
> > drift due to power-states?
> 
> They resynced at power up, but would constantly drift. I don't even know
> if it was caused by power states. When the machine was loaded, a single
> task moving across the cores could see its time jump back and forth 
> several times a second by an offset sometimes close to +2/-2s.

That sounds like C1, to me.

> > Did you try running with idle=poll, to avoid ever entering C1 state (hlt)?
> 
> Yes, I remember trying such things. I also tried 'nohlt', completely
> disabling power management, including ACPI, etc... I also tried vanilla
> kernels as well as severely patched ones, but the problem remained the
> same in all circumstances, that only 'notsc' could solve.

That's exceedingly strange.  On my dual-socket dual-core, I can get
roughly synced TSCs (no appreciable drift) by just using idle=poll.  If
that did not work for you, I'd really want to poke at the system more.

> BTW, I've just found a remain of dmesg capture after boot in case you'd
> like to look for anything in it.

A dmesg won't be that useful, I'd actually have to poke at the system.
