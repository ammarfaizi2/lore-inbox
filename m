Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbQKFOW2>; Mon, 6 Nov 2000 09:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbQKFOWS>; Mon, 6 Nov 2000 09:22:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:27658 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129134AbQKFOWL>; Mon, 6 Nov 2000 09:22:11 -0500
Message-ID: <3A06CB18.570BB38A@evision-ventures.com>
Date: Mon, 06 Nov 2000 16:15:36 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <3A0693E9.B4677F4E@mandrakesoft.com>  <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> jgarzik@mandrakesoft.com said:
> >  * Driver initializes mixer to 100% muted * Userspace app sets desired
> > values to /dev/mixer * Userspace app opens /dev/dsp to play sound
> 
> > I don't see where any sound can "escape" in this scenario, and it
> > doesn't require any module data persistence...
> 
> * User boots kernel
> * User loads mixer app
> * Sound module is autoloaded, defaults to zero levels. This is fine.
> * User sets 'line in' level to appropriate level to listen to radio
> * User closes mixer app
> * Time passes
> * Sound module is unloaded
> * User continues to happily listen to radio through sound card
> * Time passes
> * User is listening intently to something on the radio
> * Something wants to beep through /dev/audio
> * Sound module is autoloaded again, default to zero levels.
>         This time it is _NOT_ fine. User is rightly pissed off :)
> 
> It's fine to default to zero levels the first time the sound module is
> loaded after booting. Not on subsequent reloads though.
> 
> A long time ago, I made the sb16 driver use the persistent storage facility
> of kerneld to store mixer levels. I was happy with this right up until
> kerneld disappeared :)

It was removed for good reasons.

> I then made a version which read the current mixer levels back from the
> hardware on initialisation, and didn't reset them. That didn't work on all
> sb16 hardware, but it worked for me (tm).
> 
> Persistent storage is the best way to do it though. It doesn't have to be
> persistent over reboots, just during the lifetime of the kernel.

No! The best way to do it are just *persistently loaded* modules.
It's THAT simple!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
