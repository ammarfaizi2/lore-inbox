Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTHOK6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTHOK6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:58:12 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6794 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262093AbTHOK6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:58:11 -0400
Date: Fri, 15 Aug 2003 12:58:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815105802.GA14836@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815094604.B2784@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 09:46:04AM +0200, Andries Brouwer wrote:

> >  I have a notebook (Dell Latitude D800) which has some keys (actual
> >  fn+something combinations) that generate Down events but no Up events
> >  (clever, isn't it).
> > 
> >  This makes those keys unusable with 2.6.0 as it is because the input
> >  layer insists on there being up events.  Once it sees a down, it will
> >  ignore any future down events until it sees an up event.  It will
> >  also auto-repeat the key until some other key is pressed.  On the
> >  whole, not very useful for these keys.
> > 
> >  After some thought, the simplest way I could think of to fix it was
> >  to have a bitmap of keys that don't generate up events themselves.
> 
> I think we should go for a much simpler fix: only enable the timer-induced
> repeat when the user asks for that (say, by boot parameter).
> The keyboard already knows which keys repeat and which don't.

That won't solve it - the key, while not repeating would be still
considered 'down' by the kernel and any more pressing of the key
wouldn't do anything.

> If we forget about the kernel-invented repetition, we solve, I suppose,
> the problems of those people who see impossibly fast repeat, and
> also your problem.

Only for those with PS/2 keyboards. We still need the kernel repeat for
all other kinds of keyboards. And the impossibly fast repeat problem
actually needs solving elsewhere - it's a bad interaction betwen ACPI
and kernel timer, and that'll cause more trouble than just fast repeat.

> Your solution, which involves an ioctl, would force changes to user space.
> Too inconvenient.

My proposed solution is to do an input_report_key(pressed) immediately
followed by input_report_key(released) for these keys straight in
atkbd.c. Possibly based on some flag in the scancode->keycode table for
that scancode.

> [By the way, I am a collector of data on strange keyboards - could you
> on a 2.4 system use showkey -s and tell me about the combinations
> without Up events? - aeb@cwi.nl]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
