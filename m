Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKFIAg>; Mon, 6 Nov 2000 03:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129036AbQKFIA0>; Mon, 6 Nov 2000 03:00:26 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:36102 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129034AbQKFIAS>; Mon, 6 Nov 2000 03:00:18 -0500
Date: Mon, 6 Nov 2000 08:00:05 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <3A0661A1.668BD8CB@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011060752250.15143-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Jeff Garzik wrote:

> David Woodhouse wrote:
> > The desired mixer levels should be available to the module at the time of
> > initialisation.
> 
> For drivers built into the kernel that gets messy.  The command line is
> only so long.  Sounds messy for modules too.  Further (responding to
> your other e-mail), few probably care about having the mixer containing
> default, not custom, values for 10 seconds between driver init and aumix
> execution from initscripts...

I don't mean this to happen on boot. As you say, that gets messy. The
first time a module is loaded after booting, the levels can be all zeroed. 

I'm more interested in the case where the module is loaded for the second
time:

User loads a mixer to set the 'line' level to something sensible so he can
listen to the radio, which is routed through the sound card to his amp.

User closes mixer program. Module is unloaded. Levels remain the same -
all is well.

Some time later, something tries to 'beep' via /dev/audio. Module is
reloaded, the feed the user was listening to is interrupted.

Actually, the way it happened to me was that it was five in the morning, I
was in halls of residence, and suddenly I was playing the radio at full
volume :)

After fixing the sb16 driver to use the existing persistent storage, and
watching that facility disappear from the module support shortly
thereafter, I just decided not to autoload the sound modules.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
