Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288645AbSAIRKg>; Wed, 9 Jan 2002 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288781AbSAIRK2>; Wed, 9 Jan 2002 12:10:28 -0500
Received: from dsl-213-023-043-044.arcor-ip.net ([213.23.43.44]:14084 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288787AbSAIRKR>;
	Wed, 9 Jan 2002 12:10:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: arjanv@redhat.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 18:13:58 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000a01c19917$0b567ec0$0501a8c0@psuedogod> <20020109152717.J1543@inspiron.school.suse.de> <3C3C58E0.EB1333F0@redhat.com>
In-Reply-To: <3C3C58E0.EB1333F0@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OMIf-0000AH-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 9, 2002 03:51 pm, Arjan van de Ven wrote:
> Andrea Arcangeli wrote:
> > 
> > On Wed, Jan 09, 2002 at 09:07:55AM -0500, Ed Sweetman wrote:
> > > Ok so the medicine is worse than the disease.   I take it that you only want
> > > some key points made for rescheduling instead of the full preempt patch by
> > > Robert.   That seems logical enough.   The only issue i see is that for the
> > 
> > My ideal is to have the kernel to be as low worst latency as -preempt,
> > but without being preemptive. that's possible to achieve, I don't think
> > we're that far.
> > 
> > mean latency is another matter, but I personally don't mind about mean
> > latency and I much prefer to save cpu cycles instead.
> 
> hear hear!

> The akpm patch is achieving a MUCH better latency than pure -preempt,

Can you please point us at the benchmark results that support your claim?

> and only has 40 
> or so coded preemption points instead of a few hundred (eg every
> spin_unlock).... 

So?  The cost of this is, in theory, a dec and a branch normally not taken.
Robert hasn't coded it that way in the current incarnation, and personally,
I'd rather see the correctness proven before the microoptimizations are
done, but that's where it's going in theory.  Big deal.

On the other hand, I just did a test for myself that pretty well makes up
my mind about this patch.  I'm typing this right now on a 64 Meg laptop with
a slow disk, dma turned off.  On this machine, debian apt-get dist-upgrade
is essentially a DoS - once it gets to unpacking packages and configuring,
for whatever reason, the machine becomes almost ununsable.  Changing windows
for example, can take 10-15 seconds.  Updatedb, while not quite as bad, is
definitely an irritant as far as interactive use goes.

With Robert's patch, the machine is a little sluggish during apt-get, but
quite usable.  This is a *huge* difference.  And during updatedb, well, I
hardly notice it's happening, except for the disk light.

So I like this patch.  What was your complaint again?  If you've got hard
numbers and repeatable benchmarks, please trot them out.

--
Daniel
