Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291305AbSAaVHW>; Thu, 31 Jan 2002 16:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291307AbSAaVHM>; Thu, 31 Jan 2002 16:07:12 -0500
Received: from nrg.org ([216.101.165.106]:62004 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S291305AbSAaVHA>;
	Thu, 31 Jan 2002 16:07:00 -0500
Date: Thu, 31 Jan 2002 13:06:53 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Martin Wirth <Martin.Wirth@dlr.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <3C596533.488F1470@dlr.de>
Message-ID: <Pine.LNX.4.40.0201311246110.22668-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Martin Wirth wrote:
> A further note: Although the combilock shares some advantages with a
> spin-lock (no unnecessary scheduling for short time locking) it may
> behave like a semaphore on entry also if you call combi_spin_lock.
> For example
>
>        spin_lock(&slock);
>        combi_spin_lock(&clock);
>
> is a BUG because combi_spin_lock may sleep while holding slock!
>
> Would be nice if there were some comments.

Nice work!  This could turn out to be a useful tool for those of us
working on reliable low-latency kernels.  I certainly agree that it is a
much better solution than adaptive spinlocks (which dynamically decide
when to sleep) as the kernel programmer should always know whether a
spinlock or a sleep lock is more appropriate.

Unfortunately, as you point out, it's not as useful as it may first
appear in the short term, because last time I looked into the problem of
long-held spinlocks they were all nested under other spinlocks and/or
the BKL.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

