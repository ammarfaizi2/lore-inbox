Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277292AbRJECCz>; Thu, 4 Oct 2001 22:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277297AbRJECCp>; Thu, 4 Oct 2001 22:02:45 -0400
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:20734 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277292AbRJECC1>; Thu, 4 Oct 2001 22:02:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
Date: Thu, 4 Oct 2001 18:02:15 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0110041618450.2582-100000@chemcca18.ucsd.edu>
In-Reply-To: <Pine.LNX.4.33.0110041618450.2582-100000@chemcca18.ucsd.edu>
MIME-Version: 1.0
Message-Id: <01100418021503.02393@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 October 2001 20:03, Alexei Podtelezhnikov wrote:
> Hi guys,
>
> I've already expressed my concern about using srand(1) in private e-mails.
> I think it's unscientific to use one particular random sequence. Since
> no one checked if that matters, I changed srand(1) to srand(time(NULL))
> and I'm posting my results. I don't do testing of Alan or Linus's kernels,
> but use recent Red Hat kernel. I think I've shown that it does matter.

One advantage of srand(1) is that it has a chance of being repeatable.  You 
don't WANT a truly random sequence, you want a sequence that simulates a 
reproducable work load.  That's why it makes sense to initialize the random 
number generator with a known seed, so we can do it again after applying a 
patch and see what kind of difference it made.

If you vary the initialization of the random number generator, your work load 
isn't reproducible.  It's the same TYPE of load, but not the same actual load 
from one run to the next.  If we're talking a 2% improvement expected out of 
a particular tweak, you want to reduce random variation in the test case as 
much as possible that might swamp your change.  (We get enough variation 
already from scheduling and random interrupts flushing cache state and 
such...)

There's nothing wrong with using different seed values for srand, but testing 
different VMs with different seed values has the possibility of being apples 
to oranges.

If you want to run your test in a loop for a while to invoke statistics to
counter the randomness of your tests, you could do that too.  But that's a 
different kind of test.  And one that's not nearly as convenient to run from 
tweak to tweak...

Rob
