Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTLWDPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTLWDPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:15:43 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:50639
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264921AbTLWDPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:15:41 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Tue, 23 Dec 2003 14:15:38 +1100
User-Agent: KMail/1.5.3
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200312231138.21734.kernel@kolivas.org> <200312231342.56724.kernel@kolivas.org> <3FE7AF24.40600@cyberone.com.au>
In-Reply-To: <3FE7AF24.40600@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231415.38611.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 13:57, Nick Piggin wrote:
> Con Kolivas wrote:
> >On Tue, 23 Dec 2003 12:36, Nick Piggin wrote:
> >>Con Kolivas wrote:
> >>>I discussed this with Ingo and that's the sort of thing we thought of.
> >>>Perhaps a relative crossover of 10 dynamic priorities and an absolute
> >>>crossover of 5 static priorities before things got queued together. This
> >>>is really only required for the UP HT case.
> >>
> >>Well I guess it would still be nice for "SMP HT" as well. Hopefully the
> >>code can be generic enough that it would just carry over nicely.
> >
> >I disagree. I can't think of a real world scenario where 2+ physical cpus
> >would benefit from this.
>
> Well its the same problem. A nice -20 process can still lose 40-55% of its
> performance to a nice 19 process, a figure of 10% is probably too high and
> we'd really want it <= 5% like what happens with a single logical
> processor.

I changed my mind just after I sent that mail. 4 physical cores running three 
nice 20 and one nice -20 task gives the nice -20 task only 25% of the total 
cpu and 25% to each of the nice 20 tasks.

> >>It does
> >>have complications though because the load balancer would have to be
> >> taught about it, and those architectures that do hardware priorities
> >> probably don't even want it.
> >
> >Probably the simple relative/absolute will have to suffice. However it
> > still doesn't help the fact that running something cpu bound concurrently
> > at nice 0 with something interactive nice 0 is actually slower if you use
> > a UP HT processor in SMP mode instead of UP.
>
> It will be based on dynamic priorities, possibly with some feedback from
> nice as well, but it probably still won't be perfect and it will probably
> be very complex *cough* hardware priorities *cough* ;)
>
> I might try to fit it into a more general priority balancing system because
> we currently have similar sorts of failings on regular SMP as well.

I'll keep my eyes peeled. Meanwhile I'll use my ugly patch ;-)

Con

