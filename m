Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131061AbRADWKG>; Thu, 4 Jan 2001 17:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRADWJp>; Thu, 4 Jan 2001 17:09:45 -0500
Received: from Cantor.suse.de ([194.112.123.193]:22802 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131039AbRADWJd>;
	Thu, 4 Jan 2001 17:09:33 -0500
Date: Thu, 4 Jan 2001 23:09:30 +0100
From: Andi Kleen <ak@suse.de>
To: Nigel Gamble <nigel@nrg.org>
Cc: Andi Kleen <ak@suse.de>, Daniel Phillips <phillips@innominate.de>,
        ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
Message-ID: <20010104230930.A4219@gruyere.muc.suse.de>
In-Reply-To: <20010104091118.A18973@gruyere.muc.suse.de> <Pine.LNX.4.05.10101041329410.4778-100000@cosmic.nrg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.05.10101041329410.4778-100000@cosmic.nrg.org>; from nigel@nrg.org on Thu, Jan 04, 2001 at 01:39:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 01:39:57PM -0800, Nigel Gamble wrote:
> Experience has shown that adaptive spinlocks are not worth the extra
> overhead (if you mean the type that spin for a short time
> and then decide to sleep).  It is better to use spin_lock_irqsave()
> (which, by definition, disables kernel preemption without the need
> to set a no-preempt flag) to protect regions where the lock is held
> for a maximum of around 100us, and to use a sleeping mutex lock for
> longer regions.  This is what I'm working towards.

What experience ?  Only real-time latency testing or SMP scalability 
testing? 

The case I was thinking about is a heavily contended lock like the
inode semaphore of a file that is used by several threads on several
CPUs in parallel or the mm semaphore of a often faulted shared mm. 

It's not an option to convert them to a spinlock, but often the delays
are short enough that a short spin could make sense. 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
