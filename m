Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTLOQtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTLOQtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:49:46 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:15597 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263772AbTLOQto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:49:44 -0500
Date: Mon, 15 Dec 2003 17:49:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test11 ps2 mouse giving corrupt data?
Message-ID: <20031215164933.GA8676@ucw.cz>
References: <200312121236.38692.andrew@walrond.org> <20031212141521.GA27405@ucw.cz> <3FDA8F5F.1030506@nishanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDA8F5F.1030506@nishanet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 11:02:39PM -0500, Bob wrote:
> Vojtech Pavlik wrote:
> 
> >On Fri, Dec 12, 2003 at 12:36:38PM +0000, Andrew Walrond wrote:
> > 
> >
> >>I have just switched from l2.4 to 2.6 on my thinkpad, and the mouse does 
> >>something wierd when I boot into x (kde)
> >>
> >>startx, then wait for everything to load, then move mouse. Mouse goes 
> >>crazy, menus pop up everywhere as though I were pressing buttons, and 
> >>after about 3 seconds, it all settles down and works perfectly.
> >>   
> >>
> >
> >Most likely X does something nasty to the keyboard controller while it
> >is starting up. The psmouse kernel driver has an autosync feature which
> >can get it out of trouble if you don't move the mouse for two seconds.
> > 
> >
> When did the autosync feature arrive?
> It doesn't work for me(k2.6.11 with
> MSI K7N2 Delta nforce2 mboard
> and k2.6.11 with Shuttle Xpc SK41G
> FX41 mboard with VIA fsb) if ps2
> kvm switch(Belkin) is switched away.

2.5.something.

Now when your Belkin switch resets the mouse, the autosync will not
work, as it only compensates for lost bytes, not a complete protocol
change. Use 'psmouse_noext" on the kernel command line to disable wheel
handling and it'll work OK.

(Automatic mouse reinitialization is on the planned feature list.)

> When sync is lost on my pc's I have to
> reboot. Symptoms are the same, on X or
> text term--any mouse movement triggers
> selects and buttons down but the correct
> events do not occur.
> 
> With a kvm switch k-2.6.? loses psmouse
> sync on the off pc. Rebooting is the only
> solution. I got tired of this and moved the
> mouse(logitech trackman fx) to one pc,
> so the other only has to boot with the
> mouse attached either to kvm or ps2
> port on pc. That's fine until moving the
> mouse back and forth for rebooting
> causes the pc with X running to lose
> sync. Then it can't regain sync.
> 
> -Bob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
