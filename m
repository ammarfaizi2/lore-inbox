Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTISLim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 07:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTISLim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 07:38:42 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:17551 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261515AbTISLil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 07:38:41 -0400
Date: Fri, 19 Sep 2003 13:38:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030919113824.GB784@ucw.cz>
References: <2F284368A@vcnet.vc.cvut.cz> <20030913205244.A3295@pclin040.win.tue.nl> <20030913214047.GF8973@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913214047.GF8973@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 11:40:47PM +0200, Petr Vandrovec wrote:
> On Sat, Sep 13, 2003 at 08:52:44PM +0200, Andries Brouwer wrote:
> > On Fri, Sep 12, 2003 at 08:33:24PM +0200, Petr Vandrovec wrote:
> > 
> > > Andries is already gathering info for this one. This problem (missed
> > > key release) happens to me on all systems I have (Athlon + via, P3 + i440BX,
> > > P4 + 845...), most often when I do alt+right-arrow for walking through
> > > consoles (and for Andries: hitting key stops this, otherwise it 
> > > endlessly switches all VTs around, and while kernel thinks that key
> > > is down, keyboard actually does not generate any IRQs, so keyboard knows
> > > that all keys are released).
> > 
> > OK. It seems to me the two main hypotheses are: (i) problem with timers,
> > (ii) problem with keyboard.
> > 
> > In other words: could you (and/or anybody else who can reproduce this
> > at will) change the #undef DEBUG in i8042.c to #define DEBUG, recreate
> > the problem, and post or mail the resulting file with keystrokes?
> > 
> > [of course: cut away parts corresponding to login sequences etc.]
> > 
> > This will probably allow us to decide whether the missing key release
> > was never sent by the keyboard, or was lost by the kernel.
> 
> Unfortunately I'm at home, while box is at work, so I could only reboot it,
> and confirm that it happened again. Unfortunately I cannot go to the box
> and hit any key to get some more data. But I'll enable this on my workstation,
> and if I'll get some "unexpected keycode" or "keyboard reconnect" errors again,
> I'll have more data in the hand.
> 
> >From log it looks like that switch likes 0x41 a lot: it reports ID 0x41AB,
> it reports current scan set 0x41, and when we enable it, it returns spurious
> 0x41... And the last 0x41 is one which confuses everything.

I've just sent a patch to Linus that should fix this. Please try ...
(either get the patch from LKML or wait for next Linus's release).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
