Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSGROpn>; Thu, 18 Jul 2002 10:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318119AbSGROpn>; Thu, 18 Jul 2002 10:45:43 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:30087 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318116AbSGROpm>; Thu, 18 Jul 2002 10:45:42 -0400
Date: Thu, 18 Jul 2002 16:48:38 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020718144838.GC2326@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020717140804.B12529@ucw.cz> <20020717132459.GF14581@tahoe.alcove-fr> <20020717154448.A19761@ucw.cz> <20020717135823.GG14581@tahoe.alcove-fr> <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz> <20020717153336.GK14581@tahoe.alcove-fr> <20020718144130.GB2326@tahoe.alcove-fr> <20020718164536.A30363@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718164536.A30363@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 04:45:36PM +0200, Vojtech Pavlik wrote:

> On Thu, Jul 18, 2002 at 04:41:30PM +0200, Stelian Pop wrote:
> > On Wed, Jul 17, 2002 at 05:33:36PM +0200, Stelian Pop wrote:
> > 
> > > The i8042 version used is the one you send me, plus the #if 0 surrounding
> > > the aux probe code.
> > > 
> > > Result: keyboard works, mouse still doesn't.
> > [...]
> > 
> > Ok, I've hacked a bit on the input drivers (trying to look at the
> > differences between the pc_keyb.c and the new initialisation sequences),
> > with some limited success.
> > 
> > What I found out is that the mouse is not responding to any of
> > the commands in psmouse.c:psmouse_probe. However, if I comment out
> > the 'return -1' statements from this function, the mouse will
> > be recognised as a default PS/2 mouse. 
> > 
> > Later, in psmouse_initialise, the PSMOUSE_CMD_ENABLE will fail too
> > (no response from the mouse). But since the error is not propagated
> > to serio the device remains registered.
> > 
> > And later, the mouse will get enabled somehow and will function
> > perfectly. I didn't succed in finding out what exactly enables it,
> > even if I strongly suspect some interraction between the keyboard
> > enable and aux port enable... 
> > 
> > Any further idea ?
> 
> Yes. Can you try, with i8042 debugging enabled, after the kernel boots,
> moving the mouse? I suspect the data will appear in the log ...

Maybe I wasn't very clear, but if I disable the 'return -1', the mouse
will work, and the debugging data is like in:
	...
	i8042.c: 08 <- i8042 (interrupt, aux, 12) [627526]
	i8042.c: 03 <- i8042 (interrupt, aux, 12) [627527]
	i8042.c: 00 <- i8042 (interrupt, aux, 12) [627528]
	...

If I do not disable the 'return -1', the mouse will not be found at
all, and moving it will get no messages in the logs...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
