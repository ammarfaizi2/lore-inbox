Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273303AbRIUKnq>; Fri, 21 Sep 2001 06:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273294AbRIUKng>; Fri, 21 Sep 2001 06:43:36 -0400
Received: from ns.ithnet.com ([217.64.64.10]:6672 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273269AbRIUKn3>;
	Fri, 21 Sep 2001 06:43:29 -0400
Date: Fri, 21 Sep 2001 12:43:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010921124338.4e31a635.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com>
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com>
	<Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 23:16:55 -0400 (EDT) Bill Davidsen <davidsen@tmr.com>
wrote:

> On Sun, 16 Sep 2001, Stephan von Krawczynski wrote:
> 
> 
> > Thinking again about it, I guess I would prefer a FIFO-list of allocated
pages.
> > This would allow to "know" the age simply by its position in the list. You
> > wouldn't need a timestamp then, and even better it works equally well for
> > systems with high vm load and low, because you do not deal with absolute
time
> > comparisons, but relative.
> > That sounds pretty good for me. 
> 
> The problem is that when many things effect the optimal ratio of text,
> data, buffer and free space a solution which doesn't measure all the
> important factors will produce sub-optimal results. Your proposal is
> simple and elegant, but I think it's too simple to produce good results.
> See my reply to Linus' comments.

Sorry to followup to the same post again, but I just read across another thread
where people discuss heavily about aging up by 3 and down by 1 or vice versa is
considered to be better or worse. The real problem behind this is that they are
trying to bring some order in the pages by the age. Unfortunately this cannot
really work out well, because you will _always_ end up with few or a lot of
pages with the same age, which does not help you all that much in a situation
where you need to know who is the _best one_ that is to be dropped next. In
this drawing situation you have nothing to rely on but the age and some rough
guesses (or even worse: performance issues, _not_ to walk the whole tree to
find the best fitting page). This _solely_ comes from the fact that you have no
steady rising order in page->age ordering (is this correct english for this
mathematical term?). You _cannot_ know from the current function. So it must be
considered _bad_. On the other hand a list is always ordered and therefore does
not have this problem.
Shit, if I only were able to implement that. Can anybody help me to proove my
point?

Regards,
Stephan

