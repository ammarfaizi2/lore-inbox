Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWIZW7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWIZW7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWIZW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:59:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57552 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964870AbWIZW7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:59:43 -0400
Subject: Re: 2.6.18 Nasty Lockup
From: john stultz <johnstul@us.ibm.com>
To: Greg Schafer <gschafer@zip.com.au>
Cc: linux-kernel@vger.kernel.org,
       James Puthukattukaran <James.Puthukattukaran@Sun.COM>,
       Michael Obster <lkm@obster.org>,
       =?ISO-8859-1?Q?S=2E=C7a=3F=3Flar?= Onur <caglar@pardus.org.tr>
In-Reply-To: <20060926220245.GA7883@tigers.local>
References: <20060926123640.GA7826@tigers.local>
	 <1159301752.17071.0.camel@localhost>  <20060926220245.GA7883@tigers.local>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 15:58:24 -0700
Message-Id: <1159311504.17071.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 08:02 +1000, Greg Schafer wrote:
> On Tue, Sep 26, 2006 at 01:15:51PM -0700, john stultz wrote:
> > On Tue, 2006-09-26 at 22:36 +1000, Greg Schafer wrote:
> > > This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> > > completely dead machine with only option the reset button. Usually happens
> > > within a couple of minutes of desktop use but is 100% reproducible. Problem
> > > is still there in a fresh checkout of current Linus git tree (post 2.6.18).
> > > 
> > > Dual Athlon-MP 2200's on a Tyan S2466 Tiger MPX. Config attached.
> > > 
> > > I used git-bisect and arrived at the apparent culprit below. Anything else I
> > > should do to gather more info?
> > 
> > Quick test: Does enabling CONFIG_ACPI change the behavior?
> 
> Yes. It doesn't lockup now, at least it hasn't yet. Should I always
> configure with CONFIG_ACPI? I've usually avoided it.

Yea. Dual proc AMD systems tend to not have synced TSCs, so we fall back
to whatever is available. If ACPI is not enabled, that usually means
only the PIT is left (otherwise the ACPI PM or HPET can be used).


> 
> On Tue, Sep 26, 2006 at 11:18:02AM -0700, john stultz wrote:
> > Thanks for narrowing this down. Could you send me full dmesg output?
> 
> Sure, attached (non CONFIG_ACPI case).

Thanks, that confirms the above theory. It seems there is a SMP race w/
the PIT clocksource. Andi was having a similar issue, and I had some
difficulty reproducing it (my dev box is UP) but I'll grab an SMP system
and try a few tests.

Thanks so much again for narrowing this down and providing quick
feedback!
-john


