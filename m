Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbTIURmb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTIURmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:42:31 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:6154 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262472AbTIURm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:42:29 -0400
Date: Sun, 21 Sep 2003 19:42:00 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030921194200.A11423@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz> <20030921143934.A11315@pclin040.win.tue.nl> <20030921124817.GA19820@ucw.cz> <20030921164914.C11315@pclin040.win.tue.nl> <20030921170710.GA20856@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030921170710.GA20856@ucw.cz>; from vojtech@suse.cz on Sun, Sep 21, 2003 at 07:07:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 07:07:10PM +0200, Vojtech Pavlik wrote:

> > 	static unsigned char atkbd_set2_keycode[512];
> 
> We may need to change this to a u16, IF we'll ever need to load a
> keycode above 256 for an AT keyboard. So far all the keys on AT keyboards
> are within the 0..255 range. That's of course not true for other,
> more crazy keyboards.
> 
> > It really seems a pity to have to add new ioctls, and to have to release
> > a new version of the kbd package, and to waste a lot of kernel space,
> > while essentially nobody needs the resulting functionality.
>  
> We could do an audit of the key definitions, document which KEY_* symbol
> means exactly what (and it'd be a good thing anyway), by that try to
> remove duplicities and try to stuff everything in 0..255.

Yes.

I think that if you remove everything that is not used inside the kernel,
the rest fits problemless into 0..255.

> We'd lose te potential possibility to map keysyms to buttons, though
> since that never was used, nobody would cry probably.
> 
> However, my experience tells me that whenever some range is tight, and
> 0..255 is in this case, we will very soon overflow as new weird devices
> come into market.

True. In the long run more may be needed. (If we really want to assign
a different keycode to each possible picture on a key.)

I would be happy if we could pass smoothly from old to new - no new
ioctls for 2.6.0 yet, a kbd package that only changes the NR_KEYS define,
and later worry about whether we really need lots of keycodes.
Everything we add will never go away, so we must be slow in adding.

Andries

