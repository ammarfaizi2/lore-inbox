Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275960AbTHOMgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275962AbTHOMgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:36:45 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:13070 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S275960AbTHOMgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:36:43 -0400
Date: Fri, 15 Aug 2003 14:36:41 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815123641.GA7204@win.tue.nl>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815105802.GA14836@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 12:58:02PM +0200, Vojtech Pavlik wrote:

> > >  I have a notebook (Dell Latitude D800) which has some keys (actual
> > >  fn+something combinations) that generate Down events but no Up events
> > >  (clever, isn't it).
> > >  This makes those keys unusable with 2.6.0 as it is

> > I think we should go for the simple fix: only enable the timer-induced
> > repeat when the user asks for that (say, by boot parameter).
> > The keyboard already knows which keys repeat and which don't.

> That won't solve it - the key, while not repeating would be still
> considered 'down' by the kernel and any more pressing of the key
> wouldn't do anything.

Yes, it would still be considered down. But that does not imply
that pressing it doesnt do anything. It is up to the driver
to discard key presses, and I think it shouldnt.
(Unless of course the user asks for that behaviour - it may be required
on some broken laptops.)

Just the simple: a keypress generates an interrupt and we see a keystroke.

Use a kernel timer only when we know or the user tells us that it is needed.
Not in the default situation.

> My proposed solution is to do an input_report_key(pressed) immediately
> followed by input_report_key(released) for these keys straight in
> atkbd.c. Possibly based on some flag in the scancode->keycode table for
> that scancode.

But that would require users to report on precisely which keys are affected
and would give complications where I suppose 2.4 did not have any.
This is the way towards an ever more complicated keyboard driver.
Not what you would want.

Andries

