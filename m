Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQJZURU>; Thu, 26 Oct 2000 16:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129497AbQJZURL>; Thu, 26 Oct 2000 16:17:11 -0400
Received: from styx.suse.cz ([195.70.145.226]:61176 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129251AbQJZURA>;
	Thu, 26 Oct 2000 16:17:00 -0400
Date: Thu, 26 Oct 2000 22:16:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001026221640.A703@suse.cz>
In-Reply-To: <20001026190309.A372@suse.cz> <Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com> <20001026200220.A492@suse.cz> <878zrbl5v9.fsf@alph.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <878zrbl5v9.fsf@alph.dyndns.org>; from yoann@mandrakesoft.com on Thu, Oct 26, 2000 at 10:11:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 10:11:54PM +0200, Yoann Vandoorselaere wrote:

> > > > > ../drivers/block/ide.c, line 162, on version 2.2.17 does bad things
> > > > > to the timer. It writes 0 to the control-word for timer 0. This
> > > > > does the following:
> > > [Snipped...]
> > > >  
> > > > Well, at least on 2.4.0-test9, the above timing code is #ifed to
> > > > DISK_RECOVERY_TIME > 0, which in turn is #defined to 0 in
> > > > include/linux/ide.h.
> > > > 
> > > > So this is not our problem here. Anyway I guess it's time to hunt for
> > > > i8259 accesses in the kernel that lack the necessary spinlock, even when
> > > > they're not probably the cause of the problem we see here.
> > > 
> > > Okay, good.
> > 
> > Ok, here is a list of places within the kernel that access the PIT
> > timer, plus the method of locking (i386 arch only):
> 
> [...]
> 
> Ok, I just tested if the problem was always present without
> the IDE subsystem...
> 
> The answer is it is not... so it isn't an IDE problem.

Uh, guess too many negations. You wanted to say that the problem was
present even when you disabled the IDE subsystem, right?

So now it seems that possibly enough PCI traffic / busmastering traffic
can cause the problem ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
