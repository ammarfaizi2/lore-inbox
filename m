Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129889AbQJZVFo>; Thu, 26 Oct 2000 17:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQJZVFf>; Thu, 26 Oct 2000 17:05:35 -0400
Received: from r109m245.cybercable.tm.fr ([195.132.109.245]:20484 "HELO
	alph.dyndns.org") by vger.kernel.org with SMTP id <S129877AbQJZVFG>;
	Thu, 26 Oct 2000 17:05:06 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
In-Reply-To: <20001026190309.A372@suse.cz>
	<Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com>
	<20001026200220.A492@suse.cz> <878zrbl5v9.fsf@alph.dyndns.org>
	<20001026221640.A703@suse.cz>
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Date: 26 Oct 2000 23:05:04 +0200
In-Reply-To: Vojtech Pavlik's message of "Thu, 26 Oct 2000 22:16:40 +0200"
Message-ID: <873dhjl3en.fsf@alph.dyndns.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Thu, Oct 26, 2000 at 10:11:54PM +0200, Yoann Vandoorselaere wrote:
> 
> > > > > > ../drivers/block/ide.c, line 162, on version 2.2.17 does bad things
> > > > > > to the timer. It writes 0 to the control-word for timer 0. This
> > > > > > does the following:
> > > > [Snipped...]
> > > > >  
> > > > > Well, at least on 2.4.0-test9, the above timing code is #ifed to
> > > > > DISK_RECOVERY_TIME > 0, which in turn is #defined to 0 in
> > > > > include/linux/ide.h.
> > > > > 
> > > > > So this is not our problem here. Anyway I guess it's time to hunt for
> > > > > i8259 accesses in the kernel that lack the necessary spinlock, even when
> > > > > they're not probably the cause of the problem we see here.
> > > > 
> > > > Okay, good.
> > > 
> > > Ok, here is a list of places within the kernel that access the PIT
> > > timer, plus the method of locking (i386 arch only):
> > 
> > [...]
> > 
> > Ok, I just tested if the problem was always present without
> > the IDE subsystem...
> > 
> > The answer is it is not... so it isn't an IDE problem.
> 
> Uh, guess too many negations. You wanted to say that the problem was
> present even when you disabled the IDE subsystem, right?

yop

> 
> So now it seems that possibly enough PCI traffic / busmastering traffic
> can cause the problem ...

yop, I 've done :

make -j10 World 
in the xfree tree and simulateously :

while true; do make dep && make clean && make bzImage; done
in the kernel tree


-- 
		-- Yoann http://www.mandrakesoft.com/~yoann/
   An engineer from NVidia, while asking him to release cards specs said :
	"Actually, we do write our drivers without documentation."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
