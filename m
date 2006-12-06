Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760583AbWLFNMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760583AbWLFNMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760591AbWLFNMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:12:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47627 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760583AbWLFNMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:12:42 -0500
Date: Wed, 6 Dec 2006 14:11:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061206131155.GA8558@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home> <20061205203013.7073cb38.akpm@osdl.org> <1165393929.24604.222.camel@localhost.localdomain> <Pine.LNX.4.64.0612061334230.1867@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061334230.1867@scrub.home>
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

> On Wed, 6 Dec 2006, Thomas Gleixner wrote:
> 
> > If I understand it correctly, Roman wants clockevents to be usable 
> > for other things aside hrtimer/dyntick, i.e. let other code request 
> > unused timer event hardware for special purposes. I thought about 
> > that in the originally but I stayed away from it, as there are no 
> > users at the moment and I wanted to avoid the usual "who needs that" 
> > comment.
> 
> Nonsense, [...]

why do you call Thomas' observation nonsense? Fact: there is no current 
user of such a facility. What we implemented, high-res timers and 
dynticks does not need such a facility.

we wholeheartedly agree that such a facility 'would be nice', and 'could 
be used by existing kernel code' but we didnt want to chew too much at a 
time.

> [...] one obvious user would be the scheduler, [...]

But cleaning up the scheduler tick was not our purpose with high-res 
timers nor with dynticks. One of your previous complaints was that the 
patches are too intrusive to be trusted. Now they are too simple?

We'll clean up the scheduler tick and profiling too, but not now.

> [...] the current scheduler tick emulation is rather ugly [...]

i disagree with you and it's pretty low-impact anyway. There's still 
quite many HZ/tick assumptions all around the time code (NTP being one 
example), we'll deal with those via other patches.

	Ingo
