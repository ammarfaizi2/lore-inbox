Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVANERe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVANERe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVANERe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:17:34 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:64362 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261896AbVANERb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:17:31 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Con Kolivas <kernel@kolivas.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Andrew Morton <akpm@osdl.org>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <41E743F3.3090201@kolivas.org>
References: <200501140351.j0E3pdpe027121@localhost.localdomain>
	 <41E743F3.3090201@kolivas.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 15:16:59 +1100
Message-Id: <1105676219.5402.82.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 15:00 +1100, Con Kolivas wrote:
> Paul Davis wrote:
> >>>its a fine answer, but its the answer to a slightly different
> >>>question. if anyone (maybe us audio freaks, maybe someone else) comes
> >>>up with a reason to want "The Real SCHED_FIFO", the original question
> >>>will have gone unanswered.
> >>
> >>Ah then  you missed something. You can set the max cpu of SCHED_ISO to 
> >>100% and then you have it.
> > 
> > 
> > true, i missed that :) but i also recall you saying you were thinking
> > of having no prioritization within SCHED_ISO ... or am i remembering
> > wrong? 
> 
> Nothing is set in stone.  I wont even look at code until Ingo or Linus 
> rules on this. Ingo has expressed interest in SCHED_ISO on a previous 
> thread with me.
> 

You may have a chicken and egg problem :) I don't think anybody will
rule on this unless there is at least a demand for it. For there to
be a demand for it I think you'd need to come up with a rigorous
specification, wouldn't you? And then implement it even.

Unfortunately this is just how kernel development goes if you're brave
enough to try out new things.

I'm leaning toward the opinion that the entire problem would be better
handled purely with the existing RT scheduling classes, and a good way
to handle the security side of things.

> > also, is it just me, or having to ways to achieve the exact
> > same result seems very un-linux-like ... and if they are not exact
> > same results, how does a regular user get the SCHED_FIFO ones? is the
> > answer just "they don't" ?
> 
> To answer your question, the second of my proposals was to not have a 
> separate scheduling class at all. To let normal users set SCHED_FIFO and 
> SCHED_RR, possibly with all their priorities intact, but for there to be 
> limits placed on their usage of these classes. The reason I suggested 
> not supporting priorities is that proper real time scheduling would 
> entail being able to say "I need x cycles, to complete by y time and I 
> can or cannot be preempted". With these QoS requirements, a whole new 
> scheduling style (EDF) would need to be implemented. Without actually 

This sort of thing is pretty well specialised enough that it doesn't
belong in the kernel scheduler, however. Often it can be satisfied by
userspace managers... but you'd have to be talking about a hard RT
system anyway, which Linux isn't.


http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
