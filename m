Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWFQLDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWFQLDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 07:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWFQLDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 07:03:34 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:2376 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751581AbWFQLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 07:03:33 -0400
Subject: Re: statistics infrastructure (in -mm tree) review
From: Martin Peschke <mp3@de.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
In-Reply-To: <200606170851.22197.ak@suse.de>
References: <20060613232131.GA30196@kroah.com>
	 <p73slm8qqe4.fsf@verdi.suse.de> <44909292.2080005@de.ibm.com>
	 <200606170851.22197.ak@suse.de>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 13:03:22 +0200
Message-Id: <1150542202.2924.73.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 08:51 +0200, Andi Kleen wrote:
> > b) Export statistic_add_counter(), statistic_add_histogram() and the like
> >     as part of the programming API (maybe in addition to the flexible
> >     statistic_add()) for those exploiters that definitively can't effort
> >     branching into a function.
> >
> >     Loss in functionality (exploiting kernel code dictates how users see
> > the data), a bit faster than option a).
> 
> (b) if anything.

Yes, I have anticipated this choice. I am looking into this option.

> But do we really need all these weird options anyways? 

Which options?

Assuming you refer to the distinction of counter, histogram, utilisation
indicator etc. ... well, that's what I found when was looking into
existing approaches: counters everywhere, histograms for example in the
s390 DASD driver, some with linear scale, other with logarithmic scale,
counters that only make sense if seen in combination (which made me come
up with this utilisation indicator thing), ...

I have just been trying to find a simple concept to reconcile various
ways of preprocessing statistics data. This is reflected by
struct statistic_discipline.

> For me it seems you're far overdesigning.
> I think your whole approach is about 10x too complicated.

I disagree.
The programing interface is simple.
The modularisation of data processing modes is straight-forward.

I have tried to break down my design into a dozen and a half
assumptions in my other mail.
I am happy to discuss which of them make sense, which of them
might be overkill, which might be deferred, etc.

But please understand that it is hard for me to guess which
10th part of my design is okay for you, if you don't go into details.

A fair share of complexity is caused by performance considerations
(per-cpu data). Which should be fine.
And, in that regard, my code isn't quite as complex yet as
lib/profile.c.

Thanks, Martin

