Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277265AbRJDXmW>; Thu, 4 Oct 2001 19:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277267AbRJDXmM>; Thu, 4 Oct 2001 19:42:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11224 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277265AbRJDXlw>; Thu, 4 Oct 2001 19:41:52 -0400
Date: Thu, 4 Oct 2001 16:41:02 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com> <9piokt$8v9$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9piokt$8v9$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Oct 04, 2001 at 10:42:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 10:42:37PM +0000, Linus Torvalds wrote:
> Could we try to hit just two? Probably, but it doesn't really matter,
> though: to make the lmbench scheduler benchmark go at full speed, you
> want to limit it to _one_ CPU, which is not sensible in real-life
> situations.

Can you clarify?  I agree that tuning the system for the best LMbench
performance is not a good thing to do!  However, in general on an
8 CPU system with only 2 'active' tasks I would think limiting the
tasks to 2 CPUs would be desirable for cache effects.

I know that running LMbench with 2 active tasks on an 8 CPU system
results in those 2 tasks being 'round-robined' among all 8 CPUs.
Prior analysis leads me to believe the reason for this is due to
IPI latency.  reschedule_idle() chooses the 'best/correct' CPU for
a task to run on, but before schedule() runs on that CPU another
CPU runs schedule() and the result is that the task runs on a
?less desirable? CPU.  The nature of the LMbench scheduler benchmark
makes this occur frequently.  The real question is: how often
does this happen in real-life situations?

-- 
Mike
