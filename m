Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbQKFNN5>; Mon, 6 Nov 2000 08:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQKFNNr>; Mon, 6 Nov 2000 08:13:47 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:26610 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129134AbQKFNNb>;
	Mon, 6 Nov 2000 08:13:31 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A069CA8.5BB5FF20@mandrakesoft.com> 
In-Reply-To: <3A069CA8.5BB5FF20@mandrakesoft.com>  <3A0698A8.8D00E9C1@mandrakesoft.com> <3A0693E9.B4677F4E@mandrakesoft.com> <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> <28752.973510632@redhat.com> <29788.973511264@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 13:12:13 +0000
Message-ID: <7013.973516333@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
> > The sound card allows itself to be unloaded when the pass-through
> > mixer levels are non-zero. This is reasonable iff ...

> I don't think that is reasonable. 

You don't think that it's reasonable for the sound card to allow itself to 
be unloaded when the pass-through mixer levels are non-zero? 

So you're suggesting that we should prevent the sound drivers from being 
unloaded at all in that situation?

That would also solve the problem, at the cost of still keeping the sound 
module in unpagable RAM all the time.

jgarzik@mandrakesoft.com said:
> The first thing most drivers do is reset the hardware.   That
> inevitably leads to some sort of blip, when it comes to sound drivers.

A _momentary_ blip on certain hardware is acceptable if it's unavoidable.
Changing the levels and leaving them wrong for seconds before a user-space 
post-install script fixes them is not acceptable.

jgarzik@mandrakesoft.com said:
> You are depending on the hardware to keep its state -between- driver
> unload and driver reload.  That seems inherently unstable to me. 

No we're not. After the kerneld code was removed, I hacked up something to
do that, but it was a suboptimal solution and wasn't reliable on all
hardware. As I said, persistent storage is the better solution.

With persistent storage, the sound driver is free to reset and initialise
the sound card hardware upon reload - it's just that it can initialise it to
the levels which the user had previously set, rather than to the compiled-in
default levels (which are preferably zero). 

Initialising the levels to a default and expecting a user-space app to fix it
later is not good enough.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
