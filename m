Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUAGRBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbUAGRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:01:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39595 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265535AbUAGRBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:01:52 -0500
Subject: Re: [2.6.0-mm2] PM timer still has problems
From: john stultz <johnstul@us.ibm.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Karol Kozimor <sziwan@hell.org.pl>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, jw schultz <jw@pegasys.ws>
In-Reply-To: <200401070130.21769.dtor_core@ameritech.net>
References: <20031230204831.GA17344@hell.org.pl>
	 <200401050117.06681.dtor_core@ameritech.net>
	 <1073377877.2752.38.camel@localhost>
	 <200401070130.21769.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1073494873.4322.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Jan 2004 09:01:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-06 at 22:30, Dmitry Torokhov wrote:
> On Tuesday 06 January 2004 03:31 am, john stultz wrote:
> > On Sun, 2004-01-04 at 22:17, Dmitry Torokhov wrote:
> > > I decided to go hpet way and use tsc in ACPI PM timer to do delay
> > > stuff and monotonic clock.
> >
> > I think you have a valid point that as loops_per_jiffy isn't updated,
> > delay_pmtmr() and delay_pit() are broken w/ CPUFREQ.
> >
> > However I don't understand using the TSC for montonic_clock. I have no
> > clue why the HPET folks implemented it that way (likely my fault for
> > not enough documentaiton), but I haven't had the time to try to clean
> > up that code. And really, if your TSC is reliable enough for
> > monotonic_clock, why are you using the pmtmr? :) Unless it specifically
> > is resolving an issue, I'd drop that change.
> 
> I thought (it seems that I was mistaken) that the goal of monotonic_clock
> is to privide high-resolution cheap timestamps that are guaranteed never
> go back as there is no adjustments to the time. The normal clock it supposed
> to be stable and accurate but probably give lower resolution. In case of
> pmtmr vs. TSC seems to have higher resolution and is cheap so it was used.

Indeed never going back in time was an important part of the goal, but
it also is supposed to give the number of nanoseconds that have past
since boot. If the TSC is unsynched or changes frequency then we cannot
provide that. Additionally if the TSC is unsynched, monotonic_clock can
go backwards when using the TSC. 

If someone wants a highres and possibly inconsistent timestamp (somewhat
like sched_clock uses), get_cycles() provides that interface. 

thanks
-john


