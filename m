Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRHXOLK>; Fri, 24 Aug 2001 10:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271505AbRHXOKv>; Fri, 24 Aug 2001 10:10:51 -0400
Received: from web10905.mail.yahoo.com ([216.136.131.41]:26372 "HELO
	web10905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271578AbRHXOKs>; Fri, 24 Aug 2001 10:10:48 -0400
Message-ID: <20010824141103.16015.qmail@web10905.mail.yahoo.com>
Date: Fri, 24 Aug 2001 07:11:03 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: brlock_is_locked()?
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010824084931.D4064@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jens Axboe <axboe@suse.de> wrote:
> On Wed, Aug 22 2001, Brad Chapman wrote:
> > >    (I checked the brlock code and didn't find any schedule()s; there's
> > >     probably a reason for that).
> > > 
> > > Ummm, this is SMP 101, you can't sleep with a lock held.
> > > The global kernel lock is special in this regard, but all
> > > other SMP locking primitives may not sleep.
> > 
> > 	Grrr....I read Rusty's Unreliable Guide to Kernel Locking (twice) and
> > still didn't remember that. Guess you have to schedule() yourself.
> 
> Errr, like Dave said, _you cannot sleep while holding a lock_. It's not
> just that the locking primitives themselves don't sleep, you must not
> call schedule() (or any other function that may block/sleep) while
> holding a lock. _That's_ SMP 101 :-)
> 
> -- 
> Jens Axboe

Mr. Axboe,

	Sorry, I was unclear in my statement. If we fail to grab the lock, 
_then_ we sleep. If we succeed, we work our butts off, give the lock up,
and then schedule(). No sleeping on the lock job ;-)

Brad 


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
