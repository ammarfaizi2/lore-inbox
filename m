Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760644AbWLFOdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760644AbWLFOdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760646AbWLFOdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:33:23 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47492 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760657AbWLFOdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:33:22 -0500
Date: Wed, 6 Dec 2006 15:33:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061206131155.GA8558@elte.hu>
Message-ID: <Pine.LNX.4.64.0612061422190.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home>
 <20061205203013.7073cb38.akpm@osdl.org> <1165393929.24604.222.camel@localhost.localdomain>
 <Pine.LNX.4.64.0612061334230.1867@scrub.home> <20061206131155.GA8558@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Ingo Molnar wrote:

> * Roman Zippel <zippel@linux-m68k.org> wrote:
> 
> > On Wed, 6 Dec 2006, Thomas Gleixner wrote:
> > 
> > > If I understand it correctly, Roman wants clockevents to be usable 
> > > for other things aside hrtimer/dyntick, i.e. let other code request 
> > > unused timer event hardware for special purposes. I thought about 
> > > that in the originally but I stayed away from it, as there are no 
> > > users at the moment and I wanted to avoid the usual "who needs that" 
> > > comment.
> > 
> > Nonsense, [...]
> 
> why do you call Thomas' observation nonsense?

What's the point of this question? Your answer is/was in the "[...]" part.

> Fact: there is no current 
> user of such a facility. What we implemented, high-res timers and 
> dynticks does not need such a facility.

Fact: there _are_ users which need a timer facility (e.g. the scheduler).

> we wholeheartedly agree that such a facility 'would be nice', and 'could 
> be used by existing kernel code' but we didnt want to chew too much at a 
> time.

Maybe the existing code should have been cleaned up first? Unfortunately 
the dynticks feature seems to more appealing than clean code...

> > [...] one obvious user would be the scheduler, [...]
> 
> But cleaning up the scheduler tick was not our purpose with high-res 
> timers nor with dynticks. One of your previous complaints was that the 
> patches are too intrusive to be trusted. Now they are too simple?

Would you please stop these personal attacks?

> We'll clean up the scheduler tick and profiling too, but not now.

Since this is very important code, it would be rather useful to know 
what's coming and to get to an agreement about the general direction this 
code is taking. This code has to cover a wide range of applications, where 
as you guys are rather focused on realtime applications, which is ok, but 
we need to _carefully_ rethink how time is managed within the kernel, 
instead of randomly poking around in the kernel.

> > [...] the current scheduler tick emulation is rather ugly [...]
> 
> i disagree with you and it's pretty low-impact anyway. There's still 
> quite many HZ/tick assumptions all around the time code (NTP being one 
> example), we'll deal with those via other patches.

Why do you pick on the NTP code? That's actually one of the places where 
assumptions about HZ are largely gone. NTP state is updated incrementally 
and this won't change, but the update frequency can now be easily 
disconnected from HZ.

bye, Roman
