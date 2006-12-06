Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935379AbWLFPXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935379AbWLFPXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935138AbWLFPXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:23:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38590 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934996AbWLFPXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:23:36 -0500
Date: Wed, 6 Dec 2006 16:22:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061206152244.GA24613@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home> <20061205203013.7073cb38.akpm@osdl.org> <1165393929.24604.222.camel@localhost.localdomain> <Pine.LNX.4.64.0612061334230.1867@scrub.home> <20061206131155.GA8558@elte.hu> <Pine.LNX.4.64.0612061422190.1867@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061422190.1867@scrub.home>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > > If I understand it correctly, Roman wants clockevents to be usable 
> > > > for other things aside hrtimer/dyntick, i.e. let other code request 
> > > > unused timer event hardware for special purposes. I thought about 
> > > > that in the originally but I stayed away from it, as there are no 
> > > > users at the moment and I wanted to avoid the usual "who needs that" 
> > > > comment.
> > > 
> > > Nonsense, [...]
> > 
> > why do you call Thomas' observation nonsense?
> 
> What's the point of this question? [...]

the point of my question was what it said: to ask you why you called 
Thomas' pretty fair observation 'nonsense'.

> [...] Your answer is/was in the "[...]" part.

meaning:

> > > [...] one obvious user would be the scheduler, [...]

but that is not a refutation of what Thomas said, at all. You say that 
the scheduler /could/ use such a facility. What Thomas said was that 
/there are no current users of such a facility/. It is a really simple 
(and unconditionally true) observation from Thomas. Yes, we could change 
other kernel code not directly related to high-res timers, but we chose 
not to.

[ The word 'nonsense' is in general a negative descriptor and implies 
  that what Thomas said was 'obviously false' - while in reality what we
  have is /at most/ a difference in opinion. I.e. even if our opinion 
  differs you shouldnt call his opinion "nonsense", unless you are 
  willing to prove that it's false - which you didnt do so far. I claim 
  that what Thomas said is /unconditionally true/, and i can prove it: 
  it is unconditionally true that such a new facility is not needed
  by our code, and that no other kernel code is using it at the moment -
  because the facility does not exist yet. If you misunderstood what 
  Thomas said then please point that out, or prove that his claims are 
  untrue - thanks. ]

> > Fact: there is no current user of such a facility. What we 
> > implemented, high-res timers and dynticks does not need such a 
> > facility.
> 
> Fact: there _are_ users which need a timer facility (e.g. the 
> scheduler).

this is something we are not contesting at all: that a new timer 
facility /could/ be used by /other/ kernel code, which does /not/ use it 
right now.

our point is simple: the code we add does not in itself necessiate the 
new facility, hence we didnt add it. We didnt want to impact other 
kernel code, just yet. We repeat: we agree (in theory) with such a 
facility, but we wanted to do it separately.

> > we wholeheartedly agree that such a facility 'would be nice', and 
> > 'could be used by existing kernel code' but we didnt want to chew 
> > too much at a time.
> 
> Maybe the existing code should have been cleaned up first? 

yes, we'll do that, and we have a good track record doing such cleanups. 

> Unfortunately the dynticks feature seems to more appealing than clean 
> code...

i think this accusation against us is very unfair.

> > > [...] one obvious user would be the scheduler, [...]
> > 
> > But cleaning up the scheduler tick was not our purpose with high-res 
> > timers nor with dynticks. One of your previous complaints was that the 
> > patches are too intrusive to be trusted. Now they are too simple?
> 
> Would you please stop these personal attacks?

please point it out which portion of the above two sentences you 
consider a personal attack - or if you cannot, please retract your 
baseless accusation.

Fact: you did complain in the past about the complexity and/or 
intrusiveness of our high-res timers patches - we've been working on 
getting high-res timers upstream for more than a year now.

Fact: you did complain about unused facilities in past patches of ours, 
and your feedback caused us significant extra work to remove those 
facilities, just to reintroduce them later again.

(i can provide URLs and Message-IDs for these facts)

this time around we chose the minimalistic approach, we didnt add 
anything that is not immediately needed, and we didnt want to increase 
intrusiveness by "cleaning up" other code and changing it over to the 
new facilities.

It cannot be had both ways: either we stay simpler and less intrusive, 
or we go more generic but more intrusive.

	Ingo
