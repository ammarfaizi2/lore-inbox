Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281250AbRKLEyk>; Sun, 11 Nov 2001 23:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281246AbRKLEya>; Sun, 11 Nov 2001 23:54:30 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:35342 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281245AbRKLEyQ>;
	Sun, 11 Nov 2001 23:54:16 -0500
Date: Sun, 11 Nov 2001 20:54:11 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: hogsberg@users.sourceforge.net, jamesg@filanet.com,
        Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
Message-ID: <20011111205411.B30782@lucon.org>
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au>; from akpm@zip.com.au on Sun, Nov 11, 2001 at 05:37:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 05:37:21PM -0800, Andrew Morton wrote:
> 
> With the appended patch I can confirm that the driver happily runs
> `dbench 40' for half an hour on dual x86.   Even when you kick the

Thanks a lot.

> disk onto the floor (sorry, HJ).

That is a good stress test.

> 
> The games which scsi_old_done() plays with spinlocks and interrupt
> enabling are really foul.  If someone calls it with interrupts disabled
> (sbp2 does this) then scsi_old_done() will enable interrupts for you.
> If, for example, you call scsi_old_done() under spin_lock_irqsave(), 
> the reenabling of interrupts will expose you to deadlocks.  Perhaps
> scsi_old_done() should just use spin_unlock()/spin_lock()?
> 
> I tried enabling SBP2_USE_REAL_SPINLOCKS in sbp2.c and that appears to
> work just fine, although I haven't left that change in place here.
> 
> You don't actually _need_ SMP hardware to test SMP code, BTW.  You
> can just build an SMP kernel and run that on a uniprocessor box.
> This will still catch a wide range of bugs - it certainly detects
> the lockup which was occurring because of the scsi_old_done() thing.
> 
> Incidentally, it would be nice to be able to get this driver working
> properly when linked into the kernel - it makes debugging much easier :)
> 

I guess I can try that. The only main issue will be the order of
initialization.



H.J.
