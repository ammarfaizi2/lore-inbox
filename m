Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbUBBMYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUBBMYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:24:53 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6277 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265465AbUBBMYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:24:52 -0500
Date: Mon, 2 Feb 2004 13:25:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries.Brouwer@cwi.nl
Cc: aebr@win.tue.nl, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202122510.GA1265@ucw.cz>
References: <UTC200402021134.i12BY0601230.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200402021134.i12BY0601230.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 12:34:00PM +0100, Andries.Brouwer@cwi.nl wrote:

> > Well, I think it's a bad idea to have the userspace tool know about the
> > e0 thing at all. It should be just opaque numbers to it.
> 
> But how is the user to invent these opaque numbers?
> She uses showkey -s to see what scancodes a key produces,
> and then setkeycodes to assign a keycode to them.

That's another problem. showkey -s will show nothing if the keys don't
work in 2.6, and nothing useful for setkeycodes usage if they do.

I'm planning to add a new event type to report the raw scancodes through
the event interface, though I'm still yet not decided about how exactly
to do it and whether to use this to do real raw mode instead of the
simulated one where possible. I don't think the later is a good idea.

> > I don't have a problem with swapping the set3 table, if setkeycodes
> > works reasonably now for scancodes above 128.
> 
> Above 128, yes. Above 256, no.
> The interface is a char - 8 bits only.

Even for scancodes? Well, in that case I'll have to keep the kludge as
it is. Or have setkeycodes use EVIOCSKEYCODE.

> (So, right now, NR_KEYS > 256 is not useful.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
