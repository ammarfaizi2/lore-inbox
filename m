Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbRACQdc>; Wed, 3 Jan 2001 11:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132474AbRACQdX>; Wed, 3 Jan 2001 11:33:23 -0500
Received: from hermes.mixx.net ([212.84.196.2]:21519 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130614AbRACQdF>;
	Wed, 3 Jan 2001 11:33:05 -0500
Message-ID: <3A534C78.55B1355E@innominate.de>
Date: Wed, 03 Jan 2001 16:59:52 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: scheduling problem?
In-Reply-To: <3A533C7D.A9C50DB@innominate.de> <Pine.Linu.4.10.10101031614540.541-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Wed, 3 Jan 2001, Daniel Phillips wrote:
> 
> > Mike Galbraith wrote:
> > > Semaphore timed out during boot, leaving bdflush as zombie.
> >
> > Wait a sec, what do you mean by 'semaphore timed out'?  These should
> > wait patiently forever.
> 
> IKD has a semaphore deadlock detector.

That was my tentative conclusion.

> Any place you take a semaphore
> and have to wait longer than 5 seconds (what I had it set to because
> with trace buffer set to 3000000 entries, it can only cover ~8 seconds
> of disk [slowest] load), it triggers and freezes the trace buffer for
> later use.  It firing under load may not be of interest. (but it firing
> looks to be very closly coupled to observed stalls with virgin source.
> Linus fixes big stall and deadlock detector mostly shuts up.  I fix a
> smaller stall and it shuts up entirely.. for this workload)

But it's entirely legal for a semaphore to wait forever when used in the
way I've used them, a producer/consumer pattern.  You should be able to
run happily (at least as happily as before) with the watchdog disabled.

This begs the question of what to do about the 99.99% of cases where the
watchdog is a good thing to have.  Shouldn't the watchdog just log the
'suspicious' event and continue?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
