Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbWJLQL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWJLQL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWJLQL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:11:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49351 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932663AbWJLQL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:11:57 -0400
Subject: Re: Keyboard Stuttering
From: Lee Revell <rlrevell@joe-job.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       David Gerber <dg-lkml@zapek.com>
In-Reply-To: <1160504714.4973.6.camel@localhost>
References: <200610061218.36883.dg-lkml@zapek.com>
	 <d120d5000610101009h49904afeq61b8e7f5dab79346@mail.gmail.com>
	 <1160504714.4973.6.camel@localhost>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 12:12:44 -0400
Message-Id: <1160669564.24931.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 11:25 -0700, john stultz wrote:
> On Tue, 2006-10-10 at 13:09 -0400, Dmitry Torokhov wrote:
> > > Same problem here. Intel Core 2 Duo with 2.6.19-rc1 x86_64 SMP. Happens on
> > > 2.6.17 too. I use 'noapic' as a workaround but that disables one of the CPU
> > > core of course.
> > >
> > > I cannot reproduce the problem within the console nor gdm. Only on the X
> > > desktop.
> > >
> > 
> > John,
> > 
> > It looks like the only clocksource available on David's box is
> > "jiffies" although the processor shows that it supporst tsc and PM
> > timer is enabled and I think that this is what causes keyboard
> > stuttering in X. See http://bugzilla.kernel.org/show_bug.cgi?id=7291.
> > I believe clocksources is your turf, could you please take a look at
> > this.
> 
> Sure thing. I followed up in the bug, but I don't think the clocksource
> code is involved. x86_64 hasn't converted to GENERIC_TIME, so jiffies is
> what we use to increment xtime, but the TSC, ACPI PM, or HPET is used
> for gettimeofday, etc. 
> 
> I suspect C3 idling is the culprit, since noapic works around the issue.

Wait, does this mean that Intel's x86-64 implementation has the same
buggy TSC as AMD's?

Lee

