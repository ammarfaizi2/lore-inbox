Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbUKLHr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUKLHr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 02:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUKLHqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 02:46:08 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:31446 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262487AbUKLHnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 02:43:16 -0500
Date: Thu, 11 Nov 2004 23:43:14 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Willy Tarreau <willy@w.ods.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_PM_TIMER is slow
In-Reply-To: <20041112070611.GA12474@alpha.home.local>
Message-ID: <Pine.LNX.4.61.0411112339100.24919@twinlark.arctic.org>
References: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org>
 <20041112060413.GF783@alpha.home.local> <Pine.LNX.4.61.0411112208180.24919@twinlark.arctic.org>
 <20041112070611.GA12474@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, Willy Tarreau wrote:

> >         /* It has been reported that because of various broken
> >          * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
> >          * source is not latched, so you must read it multiple
> >          * times to insure a safe value is read.
> >          */
> >         do {
> >                 v1 = inl(pmtmr_ioport);
> >                 v2 = inl(pmtmr_ioport);
> >                 v3 = inl(pmtmr_ioport);
> >         } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
> >                         || (v3 > v1 && v3 < v2));
> 
> Just a thought : have you tried to check whether it's the recovery time
> after a read or read itself which takes time ?

each read is ~0.8us ... the loop only runs once.

> I mean, perhaps one read
> would take, say 50 ns, but two back-to-back reads will take 2 us. If
> this is the case, having a separate function with only one read for
> non-broken chipsets will be better because there might be no particular
> reasons to check the counter that often.

yeah for the few chipsets i've looked at i haven't seen the problem the 
loop is defending against yet.  or the problem is pretty rare.

> Other thought : is it possible to memory-map this timer to avoid the slow
> inl() on x86 ?

that's how the even newer HPET works ... but not all systems have HPET.

-dean
