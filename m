Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKFLiD>; Mon, 6 Nov 2000 06:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129277AbQKFLhx>; Mon, 6 Nov 2000 06:37:53 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:35837 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129057AbQKFLhn>;
	Mon, 6 Nov 2000 06:37:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A0693E9.B4677F4E@mandrakesoft.com> 
In-Reply-To: <3A0693E9.B4677F4E@mandrakesoft.com>  <Pine.LNX.4.21.0011060302290.17667-100000@anime.net> <24273.973508761@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 11:37:12 +0000
Message-ID: <28752.973510632@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  * Driver initializes mixer to 100% muted * Userspace app sets desired
> values to /dev/mixer * Userspace app opens /dev/dsp to play sound

> I don't see where any sound can "escape" in this scenario, and it
> doesn't require any module data persistence... 


* User boots kernel
* User loads mixer app
* Sound module is autoloaded, defaults to zero levels. This is fine.
* User sets 'line in' level to appropriate level to listen to radio
* User closes mixer app
* Time passes
* Sound module is unloaded
* User continues to happily listen to radio through sound card
* Time passes
* User is listening intently to something on the radio
* Something wants to beep through /dev/audio
* Sound module is autoloaded again, default to zero levels.
	This time it is _NOT_ fine. User is rightly pissed off :)



It's fine to default to zero levels the first time the sound module is 
loaded after booting. Not on subsequent reloads though. 

A long time ago, I made the sb16 driver use the persistent storage facility 
of kerneld to store mixer levels. I was happy with this right up until 
kerneld disappeared :)

I then made a version which read the current mixer levels back from the 
hardware on initialisation, and didn't reset them. That didn't work on all 
sb16 hardware, but it worked for me (tm). 

Persistent storage is the best way to do it though. It doesn't have to be 
persistent over reboots, just during the lifetime of the kernel.

The inter_module_xxx() stuff would facilitate this quite nicely.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
