Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277302AbRJEDyv>; Thu, 4 Oct 2001 23:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277303AbRJEDym>; Thu, 4 Oct 2001 23:54:42 -0400
Received: from mccammon.ucsd.edu ([132.239.16.211]:25267 "EHLO
	mccammon.ucsd.edu") by vger.kernel.org with ESMTP
	id <S277302AbRJEDyd>; Thu, 4 Oct 2001 23:54:33 -0400
Date: Thu, 4 Oct 2001 20:55:25 -0700 (PDT)
From: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
X-X-Sender: <apodtele@chemcca18.ucsd.edu>
To: Rob Landley <landley@trommello.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
In-Reply-To: <01100418021503.02393@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0110042025440.1042-100000@chemcca18.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Rob Landley wrote:

> On Thursday 04 October 2001 20:03, Alexei Podtelezhnikov wrote:
> > Hi guys,
> >
> > I've already expressed my concern about using srand(1) in private e-mails.
> > I think it's unscientific to use one particular random sequence. Since
> > no one checked if that matters, I changed srand(1) to srand(time(NULL))
> > and I'm posting my results. I don't do testing of Alan or Linus's kernels,
> > but use recent Red Hat kernel. I think I've shown that it does matter.
> 
> One advantage of srand(1) is that it has a chance of being repeatable.  You 
> don't WANT a truly random sequence, you want a sequence that simulates a 
> reproducable work load.  That's why it makes sense to initialize the random 
> number generator with a known seed, so we can do it again after applying a 
> patch and see what kind of difference it made.

I agree with this. All I was trying to show is that srand(1) makes it ONE 
VERY PARTICULAR LOAD. Optimizing for this load doesn't make sense at all 
because it is so particular. Optimizing for lower average make more sense. 
That is what you would call TYPE of load. And the average is reproducible 
statistically.

> There's nothing wrong with using different seed values for srand, but testing 
> different VMs with different seed values has the possibility of being apples 
> to oranges.
> 

Again, the averages and deviations are reproducible for each particular VM 
algorithm, and provide a good comparison on this type of load. They are 
the fruits.

Speaking of deviations, I was very surprised to see such a significant 
deviation. I think we want it to be smaller. That is what we would call 
predictability of a VM scheme. We need this quality, e.g. for predicting 
the imminent OOM when possible. It would be interesting to compare these 
too for Rik's and Andrea's schemes.

Lastly, I think this sort of simple tests can be adjusted to mimic some 
certain interesting loads by cooking non-random sequences. This is 
different from srand(1), because those sequences can make sense. That's 
were the test becomes deterministic rather than statistical, and qsort() 
becomes irrelevant too.  

Alexei

