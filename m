Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTHYIXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTHYIXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:23:04 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:33218 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261566AbTHYIXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:23:01 -0400
Date: Mon, 25 Aug 2003 10:22:48 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030825082248.GA3341@ucw.cz>
References: <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl> <20030821080145.GA11263@ucw.cz> <20030822022709.A3640@pclin040.win.tue.nl> <20030822073328.GA7473@ucw.cz> <20030825042235.GB20529@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825042235.GB20529@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 05:22:35AM +0100, Jamie Lokier wrote:

> > >   Serge van den Boom reports that his LiteOn MediaTouch Keyboard
> > >   has 18 additional keys: Suspend, Coffee, WWW, Calculator, Xfer,
> > >   Switch window, Close, |<<, >|, [], >>|, Record, Rewind, Menu,
> > >   Eject, Mute, Volume +, and Volume -. Of these, the keys |<<,
> > >   >>|, Volume +, Volume - repeat.  The others do not, except for
> > >   the rather special Switch window key.  Upon press it produces
> > >   the LAlt-down, LShift-down, Tab-down, Tab-up sequence; it
> > >   repeats Tab-down; and upon release it produces the sequence
> > >   Tab-up, LAlt-up, LShift-up.
> > > (Up events are as usual for the other 17 keys.)
> 
> Vojtech Pavlik wrote:
> > The code as is now (with the autorepeat and the forced up if the
> > keyboard itself doesn't start repeating) won't have any problems with
> > this keyboard.
> 
> That works well for typing, but if someone tries to use these keys in
> an action game, they will disappointed with the forced-up code - the
> game will see the key pressed and released, even when the user holds
> the key down for a long time.

Indeed. Are you expecting a game to be able to use the WWW or Calculator
keys for anything useful?

> Unfortunately, not doing the forced-up thing causes much worse
> problems, with the keys which started this thread.
> 
> There is only one solution which works well that I can see: do the
> forced-up thing by default, but as soon as you see a real UP event
> from a key, disabled forced-up _for that key_ in future.

Won't work. There are keyboards that forget to send a key up event
sometimes. They usually send it, but from time to time they don't.
We need to cover these keyboards, too. It's actually the main reason for
the whole forced up thingy.

> That gives perfect results for typing, and after the first press of a
> key it is perfect for games too.

I'll give you a kernel/module option to disable the forced up effect if
you have a perfect keyboard. You can then also enable the untranslated
mode and set 3. But the default will be translated set 2 with forced
keyups if a key is not repeating.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
