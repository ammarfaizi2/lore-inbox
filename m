Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUAWTyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUAWTyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:54:35 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:56205 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266669AbUAWTyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:54:33 -0500
Date: Fri, 23 Jan 2004 20:54:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: keyboard and USB problems (Re: 2.6.2-rc1-mm2)
Message-ID: <20040123195439.GA7878@ucw.cz>
References: <20040123013740.58a6c1f9.akpm@osdl.org> <20040123160152.GA18073@ss1000.ms.mff.cuni.cz> <20040123161946.GA6934@ucw.cz> <1074886056.12447.36.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074886056.12447.36.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:27:41AM -0800, john stultz wrote:
> On Fri, 2004-01-23 at 08:19, Vojtech Pavlik wrote:
> > On Fri, Jan 23, 2004 at 05:01:52PM +0100, Rudo Thomas wrote: 
> > > BogoMIPS is figured out to be 8.19 (this was already reported by another user),
> > 
> > ... this the root cause of the following problems.
> > 
> > > and i8042.c complaints with this:
> > > i8042.c: Can't write CTR while closing AUX.
> > 
> > ... bogomips is used in udelay() and that's used for waiting. If
> > bogomips is measured lower than real, the wait takes shorter and the
> > hardware doesn't do what it should in that short time.
> 
> Well, loops_per_jiffy is actually being measured correctly as we're
> using the acpi pm timesource to time udelay(). However there is a loss
> of resolution using the slower time source, so udelay(1) might take
> longer then 1 us. 

Longer udelay shouldn't cause trouble. Shorter one definitely would.

> If that is going to cause problems, then we'll need to pull out the
> use-pmtmr-for-delay_pmtmr patch. I guess our only option is then to use
> the TSC for delay_pmtrm() (as a loop based delay fails in other cases).
> I'll write that up and send it your way, Andrew. 

I've seen the PM timer breaking the mouse operation rather badly in the
past, the lost-sync check was triggering for many people when the PM
timer was used. This implies time inacurracy in the range of 0.5
seconds. Could that happen somehow?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
