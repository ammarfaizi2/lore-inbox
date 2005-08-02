Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVHBHRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVHBHRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVHBHR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:17:29 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:40396 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261400AbVHBHRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:17:16 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 2 Aug 2005 00:17:03 -0700
From: Tony Lindgren <tony@atomide.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Message-ID: <20050802071703.GG15903@atomide.com>
References: <200508021443.55429.kernel@kolivas.org> <200508021549.48711.kernel@kolivas.org> <1122961928.5490.10.camel@mindpipe> <200508021556.50450.kernel@kolivas.org> <1122963870.5490.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122963870.5490.17.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com> [050801 23:24]:
> On Tue, 2005-08-02 at 15:56 +1000, Con Kolivas wrote:
> > On Tue, 2 Aug 2005 03:52 pm, Lee Revell wrote:
> > > On Tue, 2005-08-02 at 15:49 +1000, Con Kolivas wrote:
> > > > As a crude data point of idle system running a full kde desktop
> > > > environment on
> > > > powersave with minimal backlight and just chatting on IRC I find it's
> > > > just
> > > > under 10% battery life difference.
> > >
> > > Have you tried the same test but without artsd, or with it configured to
> > > release the sound device after some reasonable time, like 1-2s?
> > 
> > I have it on release after 1 second already.
> 
> Is there any difference in power use between this, and not running artsd
> at all?

Please have the pmstats from http://www.muru.com/linux/dyntick running
in once console with pmstats 5, and then just kill programs to find out
which ones use lots of timers. CPU monitors etc.

You should get X running at about 25HZ, (which is the PIT limit usually)
Higher ticks means means polling somewhere which totally kills any power
savings.

There's still some places in kernel that also do polling as far as I remember:

- AT keyboard if no keyboard connected
- Netfilter code (Unverified)

But this you can verify by booting to single user mode and then running
pmstats 5, and if ticks is not below 25HZ, there's something in the kernel
polling.

Reagrds,

Tony
