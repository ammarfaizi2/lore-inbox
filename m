Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288452AbSAHVyq>; Tue, 8 Jan 2002 16:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288449AbSAHVyg>; Tue, 8 Jan 2002 16:54:36 -0500
Received: from dsl-213-023-038-231.arcor-ip.net ([213.23.38.231]:27659 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288460AbSAHVyU>;
	Tue, 8 Jan 2002 16:54:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 22:57:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <E16O3L5-0000B8-00@starship.berlin> <1010524653.3225.109.camel@phantasy>
In-Reply-To: <1010524653.3225.109.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16O4FN-0000BI-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 10:17 pm, Robert Love wrote:
> On Tue, 2002-01-08 at 15:59, Daniel Phillips wrote:
> 
> > And while I'm enumerating differences, the preemptable kernel (in this 
> > incarnation) has a slight per-spinlock cost, while the non-preemptable kernel 
> > has the fixed cost of checking for rescheduling, at intervals throughout all 
> > 'interesting' kernel code, essentially all long-running loops.  But by clever 
> > coding it's possible to finesse away almost all the overhead of those loop 
> > checks, so in the end, the non-preemptible low-latency patch has a slight 
> > efficiency advantage here, with emphasis on 'slight'.
> 
> True (re spinlock weight in preemptible kernel) but how is that not
> comparable to explicit scheduling points?  Worse, the preempt-kernel
> typically does its preemption on a branch on return to interrupt
> (similar to user space's preemption).  What better time to check and
> reschedule if needed?

The per-spinlock cost I was refering to is the cost of the inc/dec per 
spinlock.  I guess this cost is small enough as to be hard to measure, but
I have not tried so I don't know.  Curiously, none of the people I've heard
making pronouncements on the overhead of your preempt patch seem to have 
measured it either.

--
Daniel
