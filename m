Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbTIURwt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTIURwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:52:49 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:47520 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262484AbTIURwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:52:47 -0400
Date: Sun, 21 Sep 2003 19:52:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030921175246.GA21967@ucw.cz>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz> <20030921143934.A11315@pclin040.win.tue.nl> <20030921124817.GA19820@ucw.cz> <20030921164914.C11315@pclin040.win.tue.nl> <20030921170710.GA20856@ucw.cz> <20030921194200.A11423@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921194200.A11423@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 07:42:00PM +0200, Andries Brouwer wrote:

> > > 	static unsigned char atkbd_set2_keycode[512];
> > 
> > We may need to change this to a u16, IF we'll ever need to load a
> > keycode above 256 for an AT keyboard. So far all the keys on AT keyboards
> > are within the 0..255 range. That's of course not true for other,
> > more crazy keyboards.
> > 
> > > It really seems a pity to have to add new ioctls, and to have to release
> > > a new version of the kbd package, and to waste a lot of kernel space,
> > > while essentially nobody needs the resulting functionality.
> >  
> > We could do an audit of the key definitions, document which KEY_* symbol
> > means exactly what (and it'd be a good thing anyway), by that try to
> > remove duplicities and try to stuff everything in 0..255.
> 
> Yes.
> 
> I think that if you remove everything that is not used inside the kernel,
> the rest fits problemless into 0..255.

But that's definitely not a way to go. Since the scancode->keycode maps
are loadable in atkbd.c and a couple other drivers. So, if you change to
'cannot be used' by the kernel, then fine ...

> > We'd lose te potential possibility to map keysyms to buttons, though
> > since that never was used, nobody would cry probably.
> > 
> > However, my experience tells me that whenever some range is tight, and
> > 0..255 is in this case, we will very soon overflow as new weird devices
> > come into market.
> 
> True. In the long run more may be needed. (If we really want to assign
> a different keycode to each possible picture on a key.)

I think it's a good thing to do that. It makes a lot of things simpler.

> I would be happy if we could pass smoothly from old to new - no new
> ioctls for 2.6.0 yet, a kbd package that only changes the NR_KEYS define,
> and later worry about whether we really need lots of keycodes.
> Everything we add will never go away, so we must be slow in adding.

It's not as bad as it seems. Old ioctls can go away, namely if they're
not widely used. But I agree - for 2.6 it probably is wise to try to fit
into 256 keycodes. One has to keep in mind that there might be more in
the future, though.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
