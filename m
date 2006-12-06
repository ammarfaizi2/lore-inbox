Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760298AbWLFI3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760298AbWLFI3C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760299AbWLFI3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:29:01 -0500
Received: from www.osadl.org ([213.239.205.134]:53292 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760298AbWLFI3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:29:00 -0500
Subject: Re: -mm merge plans for 2.6.20
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061205203013.7073cb38.akpm@osdl.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612060348150.1868@scrub.home>
	 <20061205203013.7073cb38.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 09:32:09 +0100
Message-Id: <1165393929.24604.222.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 20:30 -0800, Andrew Morton wrote: 
> I don't have a clue which review comments remain unaddressed - do you recall?
> 
> I never saw an item-by-item accounting of my own (extensive) review
> comments, actually.  And then an avalanche of new stuff got sent and I
> didn't have time to go through it all at the same level of detail.

Arjan did a review of the replacement and I'm in the process to go
through that and Romans comments again. I'll add a complete list of the
review issues and the resolution state. Sorry that this was delayed, but
I was busy regression testing and hunting nasty details in the last
weeks.

> So yeah, I don't have a lot of confidence from that POV either.  But otoh,
> I'm confident that Ingo and Thomas will competently and promptly address
> regressions, so the risk factor isn't too bad.  And changing APIC and
> timekeeping code sure is risky.

Timekeeping is mostly untouched and the APIC change was done to solve
real world issues:

- lapic verification gets stuck for ever
- lapic timer runs too fast

> > In the long term IMO this might need a major rework, the basic problem I 
> > have is that I don't see how this usable beyond dynticks/hrtimer, e.g. how 
> > to dynamically manage multiple timer.
> 
> I'm not sure I understand that.  Are you referring to multiple,
> concurrently-operating hardware clock sources?  <wonders how that could
> work> If so, that's more a clocksource thing than a dynticks/hrtimer thing,
> isn't it?

If I understand it correctly, Roman wants clockevents to be usable for
other things aside hrtimer/dyntick, i.e. let other code request unused
timer event hardware for special purposes. I thought about that in the
originally but I stayed away from it, as there are no users at the
moment and I wanted to avoid the usual "who needs that" comment. Granted
that clockevents is not perfect, but it's rather self contained and has
no user space exposure, so it can be replaced by something better
anytime.

	tglx


