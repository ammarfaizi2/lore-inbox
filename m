Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTHUBgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTHUBgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:36:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42626 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262372AbTHUBgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:36:38 -0400
Date: Thu, 21 Aug 2003 02:36:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821013629.GA25278@mail.jlokier.co.uk>
References: <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl> <20030821000302.GC24970@mail.jlokier.co.uk> <20030821023345.A3204@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821023345.A3204@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> There are many more problems with your synthesized events.
> Look at your "repeat delay + a bit more". Can you specify how much
> "a bit more" is?
> 
> In times of heavy disk activity we lose interrupts.
> Indeed, if I copy a CD image or untar a kernel tree
> my keyboard and mouse are dead for several seconds.
> 
> There is no guaranteed "a bit more" within which we will see a
> keyboard event.

I think we can safely arrange that if the timer expires, we can be
sure to check the 8042 for an event before synthesising one.

> If the only events that are seen are actual events, and on rare
> occasions we miss an event, that is not so bad. We just hit that
> key again. But if we synthesize events, then a missed key up
> causes autorepeat.

You've mixed the question synthetic UP with software autorepeat.  They
are unrelated, and othogonal.

If you use software autorepeat, you have that problem of runaway
events _anyway_, nothing to do with UP.  And if you don't use software
autorepeat, UP doesn't create a problem.

In fact, the synthetic UP is quite helpful if you miss real events.
For programs which, say, grab the keyboard focus until the user lets
go of a particular key, it is good that the program is eventually sent
an UP.  Otherwise it won't give up the focus at all.  Similarly, in a
game which does something as long as the player holds a key down,
missing the real event results in the game assuming the key is
perpetually held down.

> In fact I see unwanted autorepeat - maybe once a day
> suddenly a single keystroke causes three to five identical
characters to appear - but I am not sure what mechanism causes this.

Faulty laptop keyboards.  I get it too, with 2.4 and 2.5 kernels.
It's not autorepeat, it's an instant burst of events.
Possibly bad debouncing.

-- Jamie
