Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275947AbTHOMne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275948AbTHOMnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:43:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16780 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S275947AbTHOMnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:43:24 -0400
Date: Fri, 15 Aug 2003 14:43:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815124318.GA15478@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815123641.GA7204@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:36:41PM +0200, Andries Brouwer wrote:
> On Fri, Aug 15, 2003 at 12:58:02PM +0200, Vojtech Pavlik wrote:
> 
> > > >  I have a notebook (Dell Latitude D800) which has some keys (actual
> > > >  fn+something combinations) that generate Down events but no Up events
> > > >  (clever, isn't it).
> > > >  This makes those keys unusable with 2.6.0 as it is
> 
> > > I think we should go for the simple fix: only enable the timer-induced
> > > repeat when the user asks for that (say, by boot parameter).
> > > The keyboard already knows which keys repeat and which don't.
> 
> > That won't solve it - the key, while not repeating would be still
> > considered 'down' by the kernel and any more pressing of the key
> > wouldn't do anything.
> 
> Yes, it would still be considered down. But that does not imply
> that pressing it doesnt do anything. It is up to the driver
> to discard key presses, and I think it shouldnt.
> (Unless of course the user asks for that behaviour - it may be required
> on some broken laptops.)
> 
> Just the simple: a keypress generates an interrupt and we see a keystroke.
> 
> Use a kernel timer only when we know or the user tells us that it is needed.
> Not in the default situation.

I'm not very fond of making special exception for the (hopefully soon to
be doing) PS/2 genre of keyboards. For USB for example you don't get an
interrupt and a scancode per keypress. You get the current keyboard
state. So I prefer to keep the keyboard state in the kernel, too, since
that is a model that fits more devices. Also not just keyboards.

> > My proposed solution is to do an input_report_key(pressed) immediately
> > followed by input_report_key(released) for these keys straight in
> > atkbd.c. Possibly based on some flag in the scancode->keycode table for
> > that scancode.
> 
> But that would require users to report on precisely which keys are affected
> and would give complications where I suppose 2.4 did not have any.
> This is the way towards an ever more complicated keyboard driver.
> Not what you would want.

I definitely want one single driver being more complicated than the core
getting more complicated.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
