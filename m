Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291246AbSBGT4o>; Thu, 7 Feb 2002 14:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSBGT4e>; Thu, 7 Feb 2002 14:56:34 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:37393 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291246AbSBGT4b>;
	Thu, 7 Feb 2002 14:56:31 -0500
Date: Thu, 7 Feb 2002 12:56:01 -0700
From: yodaiken@fsmlabs.com
To: Martin Wirth <Martin.Wirth@dlr.de>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@transmet.com,
        mingo@elte.hu, rml@tech9.net, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207125601.A21354@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C629F91.2869CB1F@dlr.de>; from Martin.Wirth@dlr.de on Thu, Feb 07, 2002 at 04:38:57PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 04:38:57PM +0100, Martin Wirth wrote:
> This is a request for comment on a new locking primitive
> called a combilock.
> 
> The goal of this development is:
> 
> 1. To allow for a better SMP scalability of semaphores used as Mutex
> 2. As a replacement for long held spinlocks in an preemptible kernel
> 
> The new lock uses a combination of a spinlock and a (mutex-)semaphore.
> You can lock it for short-term issues in a spin-lock mode:
> 
>         combi_spin_lock(struct combilock *x)
>         combi_spin_unlock(struct combilock *x)
> 
> and for longer lasting tasks in a sleeping mode by:
> 
>         combi_mutex_lock(struct combilock *x)
>         combi_mutex_unlock(struct combilock *x)
> 
> If a spin_lock request is blocked by a mutex_lock call, the spin_lock
> attempt also sleeps i.e. behaves like a semaphore.

So what's the difference between combi_spin and combi_mutex?
combi_spin becomes
	if not mutex locked, spin
	else sleep
Bizzare

The entire concept is revolting.

