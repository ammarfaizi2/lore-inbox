Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280871AbRKLRLP>; Mon, 12 Nov 2001 12:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280852AbRKLRLF>; Mon, 12 Nov 2001 12:11:05 -0500
Received: from ns.suse.de ([213.95.15.193]:24582 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280873AbRKLRK4>;
	Mon, 12 Nov 2001 12:10:56 -0500
Date: Mon, 12 Nov 2001 18:10:52 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, mathijs@knoware.nl,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011112181052.A23397@suse.de>
In-Reply-To: <20011110152845.8328F231A4@brand.mmohlmann.demon.nl> <20011110173751.C1381@athlon.random> <20011112021142.O1381@athlon.random> <20011112.000305.45744181.davem@redhat.com> <20011112150452.S1381@athlon.random> <20011112152044.V1381@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011112152044.V1381@athlon.random>; from andrea@suse.de on Mon, Nov 12, 2001 at 03:20:44PM +0100
Organization: SuSE GmbH, Nuernberg, Germany
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, Andrea Arcangeli wrote:

> On Mon, Nov 12, 2001 at 03:04:52PM +0100, Andrea Arcangeli wrote:
> > On Mon, Nov 12, 2001 at 12:03:05AM -0800, David S. Miller wrote:
> > >    From: Andrea Arcangeli <andrea@suse.de>
> > >    Date: Mon, 12 Nov 2001 02:11:42 +0100
> > > 
> > >    I'm just guessing: the scheduler isn't yet functional when
> > >    spawn_ksoftirqd is called.
> > > 
> > > The scheduler is fully functional, this isn't what is going wrong.
> > 
> > check ret_from_fork path, sparc32 scheduler is broken and this is why it
> > deadlocks at boot, it has nothing to do with the softirq code, softirq
> > code is innocent and it only get bitten by the sparc32 bug.
> 
> real fix looks like this (no idea what PSR_PIL means so not sure if this
> really works on UP but certainly the sched_yield breakage is fixed now
> and it won't deadlock in the softirq code any longer):

A kernel with Andrea patch boots (after renaming all remaining
ret_from_smpfork to ret_from_fork) on one critical machine from me.
I will test the other this evening.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE GmbH            Deutschherrenstr. 15-19       D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B
