Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVDLP7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVDLP7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVDLP4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:56:43 -0400
Received: from styx.suse.cz ([82.119.242.94]:49897 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262344AbVDLPyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:54:18 -0400
Date: Tue, 12 Apr 2005 17:57:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: set keyboard repeat rate: EVIOCGREP and EVIOCSREP
Message-ID: <20050412155724.GA21284@ucw.cz>
References: <4255B43F.80606@us.ibm.com> <425703F3.4050802@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425703F3.4050802@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:21:39PM -0700, Vernon Mauery wrote:
> Vernon Mauery wrote:
> > I was wondering if anyone knows how to change the repeatrate on a
> > USB keyboard with a 2.4 kernel.  The system is a legacy free system
> > (no ps2 port), so kbdrate does nothing.  With evdev loaded, the
> > keyboard and mouse (both USB devices) get registered with the event
> > system and show up as /dev/input/event[01].  I know the event
> > subsystem does software key repeating and was wondering how to
> > change that.

A recent version of kbdrate on a 2.6 kernel should use the 'KDKBDREP'
ioctl(), which should set the repeat rate on all keyboards attached to
the system (both on PS/2 and USB devices, and any others).

It achieves this by sending EV_REP events to all attached keyboard-type
devices.

> > I poked around and found the EVIOCGREP and EVIOCSREP ioctls, but
> > when I tried using them, the ioctl returned invalid parameter.  Upon
> > further investigation, I found that the ioctl definitions (located
> > in the linux/input.h header file) are not used in kernel land.  That
> > would explain why it failed, but that just means I ran into a dead
> > end.  Were those definitions legacy code from 2.2 or is it something
> > that never got implemented, only defined?  I also noticed that the
> > defines are gone in 2.6.  So how _does_ one go about changing the
> > repeat rate on a keyboard input device in 2.4?

I don't think it's possible with USB keyboards on 2.4, the keybdev
module doesn't support repeat rate setting.

> Just in case anyone cares, I spent some more time poking around in the
> event code and it looks like the way to do this seems to be exposed by
> the evdev module. If you write to /dev/input/eventX an input_event
> that contains an event of type EV_REP with either REP_DELAY or
> REP_PERIOD as the code and a value in milliseconds, I think it is
> supposed to set up the software auto repeat for you. But with the
> atkbd driver, you have to turn off hardware auto repeat for this to
> take effect.  

By sending the events, the driver is asked to change the delay/repeat
rate. It should work in the software autorepeat and in the hardware
autorepeat cases.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
