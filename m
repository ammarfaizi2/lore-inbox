Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290881AbSBLJ7J>; Tue, 12 Feb 2002 04:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290891AbSBLJ7A>; Tue, 12 Feb 2002 04:59:00 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:7942 "HELO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with SMTP
	id <S290881AbSBLJ6q>; Tue, 12 Feb 2002 04:58:46 -0500
Date: Tue, 12 Feb 2002 10:58:44 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Semaphore behavior
Message-ID: <20020212105844.A22247@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <F327LiHdlQgdYXSVvR0000174b6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F327LiHdlQgdYXSVvR0000174b6@hotmail.com>; from balbir_soni@hotmail.com on Mon, Feb 11, 2002 at 04:22:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wanted to clarify my understanding of the behavior of semaphores
> on the i386 architecture, as I understand it.
> 
> 1. I grab a semaphore and I am open to accepting signals
>    (down_interruptible)
> 2. I am interrupted by a user process using ctrl-C or some other
>    method of signal delivery.
> 3. After this point, I cannot grab *ANY* semaphore using
>    (down_interruptible), since the semaphore implementation checks for
>    pending signals and if there are signals pending, it does not
>    grant me the semaphore.
> 
> So, the only option I have after (2) to use down_interruptible again
> is
> 
> a. Flush the signal.
> b. Handle the signal.
> 
> Please cc your replies to me
> 
> Is my assessment correct?

You are right, AFAIK. You should do down_interruptible if you expect it may
take long to get the semaphore. If you are interrupted, you should return
to userland (with ERESTARTSYS or EINTR error) to have the signal handled.
The trouble is, that when you return ERESTARTSYS, the syscall may, but need not
to be restarted. And unfortunately you can never tell the restarted syscall from
a new invocation.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
