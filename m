Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSBIKyR>; Sat, 9 Feb 2002 05:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288851AbSBIKyI>; Sat, 9 Feb 2002 05:54:08 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:29893 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288850AbSBIKxv>; Sat, 9 Feb 2002 05:53:51 -0500
Message-Id: <200202081922.g18JM147001331@tigger.cs.uni-dortmund.de>
To: Martin Wirth <Martin.Wirth@dlr.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New locking primitive for 2.5 
In-Reply-To: Message from Martin Wirth <Martin.Wirth@dlr.de> 
   of "Thu, 07 Feb 2002 16:38:57 +0100." <3C629F91.2869CB1F@dlr.de> 
Date: Fri, 08 Feb 2002 20:22:01 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wirth <Martin.Wirth@dlr.de> said:
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

Can you sleep if acquired as the spinlock?

Is there any measurable (or at least plausible reason why there should be)
performance improvement? (No, "should make preemptible kernel faster"
doesn't cut it at all for me). Or any hope that it will substantially
simplify kernel programming with _no_ performance degradation by replacing
both semphores and spinlocks?
-- 
Horst von Brand			     http://counter.li.org # 22616
