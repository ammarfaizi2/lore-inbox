Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270345AbTHSLu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 07:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTHSLu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 07:50:28 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:38635 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S270345AbTHSLuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 07:50:23 -0400
Date: Tue, 19 Aug 2003 13:50:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030819115014.GA5403@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030818160138.GA31760@ucw.cz> <16194.3240.192318.806260@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16194.3240.192318.806260@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 09:40:24PM +1000, Neil Brown wrote:
> On Monday August 18, vojtech@suse.cz wrote:
> > 
> > How about this patch? It tries to be a bit clever, but hopefully not too
> > much ...
> > 
> 
> Uhmm.. mixed.
> 
> It behaved REALLY strangly until I fixed these typoes:
> 
> > +				mod_timer(&atkbd->timer,
> > +					(test_bit(atkbd->keycode[code], &atkbd->dev.key)
> > +						? HZ/30 : HZ/4) + HZ/100);
> 
> should be
> 
> > +				mod_timer(&atkbd->timer, jiffies + 
> > +					(test_bit(atkbd->keycode[code], atkbd->dev.key)
> > +						? HZ/30 : HZ/4) + HZ/100);

Thanks for spotting that! I originally had "!test_bit" there, and then
removed the ! and forgot to swap the conditional values.

> Then it sort-of worked - my problem keys gave nice up/down
> transitions.

Good to know. I'll test the rest on my keyboards here.

> However the hardware autorepeat and the software autorepeat seemed to
> interfere with each other and auto-repeat was rather erratic.

Yep, you'll need to make the software autorepeat settings longer.
They're HZ/4 and HZ/33 now, and need to be bigger than the in the above
fixed statement.

> More of a problem was that control and shift would auto-repeat, and

This is normal.

> would often appear to be "up" when I was holding them "down", so
> control-X keys strokes were not reliable.

Hmm, this is bad. I thought the code shouldn't be able to cause this (I
tried to make it so), I'll try to fix it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
