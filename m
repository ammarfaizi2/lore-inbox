Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269962AbRHXGqu>; Fri, 24 Aug 2001 02:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRHXGqk>; Fri, 24 Aug 2001 02:46:40 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:15634 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S269962AbRHXGqb>; Fri, 24 Aug 2001 02:46:31 -0400
Date: Fri, 24 Aug 2001 08:49:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Brad Chapman <kakadu_croc@yahoo.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: brlock_is_locked()?
Message-ID: <20010824084931.D4064@suse.de>
In-Reply-To: <20010822.120051.25423285.davem@redhat.com> <20010822190820.57208.qmail@web10904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010822190820.57208.qmail@web10904.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22 2001, Brad Chapman wrote:
> >    (I checked the brlock code and didn't find any schedule()s; there's
> >     probably a reason for that).
> > 
> > Ummm, this is SMP 101, you can't sleep with a lock held.
> > The global kernel lock is special in this regard, but all
> > other SMP locking primitives may not sleep.
> 
> 	Grrr....I read Rusty's Unreliable Guide to Kernel Locking (twice) and
> still didn't remember that. Guess you have to schedule() yourself.

Errr, like Dave said, _you cannot sleep while holding a lock_. It's not
just that the locking primitives themselves don't sleep, you must not
call schedule() (or any other function that may block/sleep) while
holding a lock. _That's_ SMP 101 :-)

-- 
Jens Axboe

