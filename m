Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbTLWCnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTLWCnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:43:49 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:33487
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264894AbTLWCnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:43:01 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Tue, 23 Dec 2003 13:42:56 +1100
User-Agent: KMail/1.5.3
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200312231138.21734.kernel@kolivas.org> <200312231224.49069.kernel@kolivas.org> <3FE79C32.6050104@cyberone.com.au>
In-Reply-To: <3FE79C32.6050104@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231342.56724.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 12:36, Nick Piggin wrote:
> Con Kolivas wrote:
> >On Tue, 23 Dec 2003 12:11, Nick Piggin wrote:
> >>I think this patch is much too ugly to get into such an elegant
> >> scheduler. No fault to you Con because its an ugly problem.
> >
> >You're too kind. No it's ugly because of my code but it works for now.
>
> Well its all the special cases for batch scheduling that I don't like,
> the idea to not run batch tasks on a package running non batch processes
> is sound. I thought the batch scheduling code is Ingo's, but I could
> be mistaken. Anyway...

I realise the special cases suck. Code for one setting in a spot where it 
affects everyone is bad. Regarding the batch scheduling; no that's my special 
flavour coded ugly from the ground up. Ingo's is much smarter than this but 
once again I needed something that works now without too much effort.

>
> >>How about this: if a task is "delta" priority points below a task running
> >>on another sibling, move it to that sibling (so priorities via timeslice
> >>start working). I call it active unbalancing! I might be able to make it
> >>fit if there is interest. Other suggestions?
> >
> >I discussed this with Ingo and that's the sort of thing we thought of.
> > Perhaps a relative crossover of 10 dynamic priorities and an absolute
> > crossover of 5 static priorities before things got queued together. This
> > is really only required for the UP HT case.
>
> Well I guess it would still be nice for "SMP HT" as well. Hopefully the
> code can be generic enough that it would just carry over nicely. 

I disagree. I can't think of a real world scenario where 2+ physical cpus 
would benefit from this.

> It does 
> have complications though because the load balancer would have to be taught
> about it, and those architectures that do hardware priorities probably
> don't even want it.

Probably the simple relative/absolute will have to suffice. However it still 
doesn't help the fact that running something cpu bound concurrently at nice 0 
with something interactive nice 0 is actually slower if you use a UP HT 
processor in SMP mode instead of UP.

Con

