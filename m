Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUBPW6p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUBPW6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:58:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:40097 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266011AbUBPW6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:58:23 -0500
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402161420390.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
	 <1076904084.12300.189.camel@gaston>
	 <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
	 <1076968236.3648.42.camel@gaston>
	 <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
	 <1076969892.3649.66.camel@gaston>
	 <Pine.LNX.4.58.0402161420390.30742@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076972267.3649.81.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 09:57:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't see that anybody else can possibly care. In fact, I doubt even 
> vgacon actually cares. It's just a regular unblank, but with the 
> information that we came from graphics mode. I think it would be cleaner 
> to add a new parameter to the "con_blank()" function, which would also 
> cause compiler warnings for non-converted consoles, which is good.
> 
That's what I was talking about: what drivers should I convert :) On
PPC, I don't build things like vgacon etc... Anyway, patch coming soon.

Note that a mode_switch separate from blank would have made sense
too some way...

> Right now we encode multiple things into the one existing "blank"
> parameter, which is just confusing. We have
> 
>    -1: /* enter graphics mode (just save whatever state we need to save, 
>           possibly clear state to be polite) */

And make sure accel engine is idle...

>     0: /* regular unblank (restore screen contents, enable backlight) */
>     1: /* regular blank */
>     2..x: VESA blank type x-1.
> 
> and I'd suggest that the new case would be the "regular unblank", but with 
> the new parameter saying that we're coming from graphics mode. For 
> example, I don't think the vgacon_blank() function would change at _all_ 
> (except for the new parameter that it would just ignore).
>
> As far as I can tell, fbcon is the _only_ thing that wouldn't ignore the 
> new information, exactly because fbcon might want to reset things like the 
> graphics engine.

Yup.

Ben.


