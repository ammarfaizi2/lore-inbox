Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbTGDTtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbTGDTtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:49:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:23168 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266141AbTGDTtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:49:50 -0400
Date: Fri, 4 Jul 2003 17:01:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Chris Mason <mason@suse.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrea Arcangeli <andrea@suse.de>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Status of the IO scheduler fixes for 2.4
In-Reply-To: <1057197726.20903.1011.camel@tiny.suse.com>
Message-ID: <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva> 
 <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
 <1057197726.20903.1011.camel@tiny.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jul 2003, Chris Mason wrote:

> On Wed, 2003-07-02 at 18:28, Marcelo Tosatti wrote:
> > On Wed, 2 Jul 2003, Marcelo Tosatti wrote:
> >
> > >
> > > Hello people,
> > >
> > > What is the status of the IO scheduler fixes for increased fairness for
> > > 2.4 ?
> > >
> > > I haven't had time to read and think about everything you guys discussed,
> > > so a brief summary would be very helpful for me.
> > >
> > > Danke
> >
> > Ah, we all want that the fairness issues to be fixed in 2.4.22, right ?
>
> My current code is attached, it's basically a merge of these 3 patches,
> with modifications based on benchmarks and latency measurements here.
>
> fix_pausing:  From Andrea, it fixes a few corner case races where
> wakeups can be missed in wait_on_buffer, wait_on_page, and
> __get_request_wait.
>
> elevator-low-latency: From Andrea, it keeps the amount of io on a given
> queue to a reasonable number.  This prevents a small number of huge
> requests from introducing large latencies on smaller requests.
>
> q->full: From Nick, it reduces latency in __get_request_wait by making
> sure new io can't come in and steal requests before old waiters are
> served.
>
> Those represent the big 3 areas I believe the latencies are coming
> from.  The q->full patch can hurt throughput badly as the number of
> writers increases (50% of what 2.4.21 gets for 10 or more concurrent
> streaming writers), but it really seems to help desktop workloads here.

Chris,

Would you please separate those tree fixes in separate diffs?

For me it seems low latency and fix-pausing patches should be enough for
"better" IO fairness. I might be wrong about that, though.

Lets try this: Include elevator-low-latency in -pre3 (which I'm trying to
release today), then fix pausing in -pre4. If the IO fairness still doesnt
get somewhat better for general use (well get isolated user reports and
benchmarks for both the two patches), then I might consider the q->full
patch (it has throughtput drawbacks and I prefer avoiding a tunable
there).


Sounds good?
