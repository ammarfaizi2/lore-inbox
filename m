Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTIACoC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 22:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbTIACoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 22:44:02 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:1433
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262861AbTIACn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 22:43:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ian Kumlien <pomac@vapor.com>, Robert Love <rml@tech9.net>
Subject: Re: [SHED] Questions.
Date: Mon, 1 Sep 2003 12:50:48 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <1062324435.9959.56.camel@big.pomac.com> <1062373274.1313.28.camel@boobies.awol.org> <1062374409.5171.194.camel@big.pomac.com>
In-Reply-To: <1062374409.5171.194.camel@big.pomac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011250.48238.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 10:00, Ian Kumlien wrote:
> On Mon, 2003-09-01 at 01:41, Robert Love wrote:
> > This implies that a high priority, which has exhausted its timeslice,
> > will not be allowed to run again until _all_ other runnable tasks
> > exhaust their timeslice (this ignores the reinsertion into the active
> > array of interactive tasks, but that is an optimization that just
> > complicates this discussion).
>
> So it's penalised by being in the corner for one go? or just pri
> penalised (sounds like it could get a corner from what you wrote... Or
> is it time for bed).

Please read my RFC 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=106178160825835&w=2) which 
has this extensively explained. If this were the case after one timeslice, 
then dragging a window in X at load of say 32 would be impossible; the window 
would move for 0.1 second, stand still for 3.2 seconds then move for another 
0.1 second.

> > > Damn thats a tough cookie, i still think that the priority inversion is
> > > bad. Don't know enough about this to actually provide a solution...
> > > Any one else that has a view point?
> >
> > Priority inversion is bad, but the priority inversion in this case is
> > intended.  Higher priority tasks cannot starve lower ones.  It is a
> > classic Unix philosophy that 'all tasks make some forward progress'
>
> Yes, like the feedback scheduler...

Priority inversion to some extent will exist in any scheduler design that has 
priorities. There are solutions available but they incur a performance 
penalty elsewhere (some people are currently experimenting). The inversion 
problems inherent in my earlier patches are largely gone with the duration 
and severity of inversion being either equal to or smaller than the instances 
that occur in the vanilla scheduler. Nick's approach may work around it 
differently but documentation is hard to find (hint Nick*).

> > > Hummm, the skips in xmms tells me that something is bad..
> > > (esp since it works perfectly on the previus scheduler)
> >
> > A lot of this is just the interactivity estimator making the wrong
> > estimate.
>
> Yes, But... When you come from AmigaOS, and have used Executive...
> things like this is dis concerning. Executive is a scheduler addition
> for amigaos that has many schedulers to choose from. One of which is the
> original feedback scheduler. While a feedback scheduler consumes some
> cpu it still allows you to play mp3's while surfing the net on a 50 mhz
> 68060. Hearing about 500mhz machines that skip is somewhat.. odd.

That's in an attempt to make them as high throughput machines as possible. 
Xmms skipping is basically killed off as a problem in both Nick's and my 
patches. If it still remains it is almost certainly a disk i/o problem (no 
dma) or hitting swap memory.

> Well, there is latency and there is latency. To take the AmigaOS
> example. Voyager, a webbrowser for AmigaOS uses MUI (a fully dynamic gui
> with weighted(prioritized) sections) and renders images. It's responsive
> even on a 40mhz 68040 using Executive with the feedback scheduler.

Multiple processors to do different tasks on amigas kinda helped there...

> 500 mhz is a lot of horsepower when it comes to playing mp3's and
> scheduling.. It feels like something is wrong when i see all these
> discussions but i most certainly don't know enough to even begin to
> understand it. I only tried to show the thing i thought was really wrong
> but you do have a point with the runqueues and timeslices =P

Things are _never ever ever ever_ as simple as they appear on the surface.

Cheers,
Con

