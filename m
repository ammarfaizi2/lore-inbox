Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbQKFNkX>; Mon, 6 Nov 2000 08:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129989AbQKFNkO>; Mon, 6 Nov 2000 08:40:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55821 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129982AbQKFNjy>;
	Mon, 6 Nov 2000 08:39:54 -0500
Message-ID: <3A06B45A.E75EC748@mandrakesoft.com>
Date: Mon, 06 Nov 2000 08:38:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <3A069CA8.5BB5FF20@mandrakesoft.com>  <3A0698A8.8D00E9C1@mandrakesoft.com> <3A0693E9.B4677F4E@mandrakesoft.com> <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com> <29788.973511264@redhat.com> <7013.973516333@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> jgarzik@mandrakesoft.com said:
> > > The sound card allows itself to be unloaded when the pass-through
> > > mixer levels are non-zero. This is reasonable iff ...
> 
> > I don't think that is reasonable.
> 
> You don't think that it's reasonable for the sound card to allow itself to
> be unloaded when the pass-through mixer levels are non-zero?
> 
> So you're suggesting that we should prevent the sound drivers from being
> unloaded at all in that situation?

I am thinking about the bigger picture:  You are unloading a driver,
then continuing to use the hardware.  To me, that is an undefined state.


> That would also solve the problem, at the cost of still keeping the sound
> module in unpagable RAM all the time.

Oh, the horror!

[jgarzik@rum linux_2_4]$ ls -l drivers/sound/via82cxxx_audio.o
-rw-r--r--    1 jgarzik  jgarzik     27968 Nov  6 03:28
drivers/sound/via82cxxx_audio.o

So you would rather load everybody's kernel down with mixer level /
module persistence gunk... than simply load a kernel module at boot, and
leave it alone?


> With persistent storage, the sound driver is free to reset and initialise
> the sound card hardware upon reload - it's just that it can initialise it to
> the levels which the user had previously set, rather than to the compiled-in
> default levels (which are preferably zero).
> 
> Initialising the levels to a default and expecting a user-space app to fix it
> later is not good enough.

The one thing that you and I agree on:  It would be nice if the driver
did not init the mixer to a set of defaults, when a preferred set is
available.

However, since simply leaving the driver loaded solves all this mess, it
doesn't seem worth changing drivers to do anything different.

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
