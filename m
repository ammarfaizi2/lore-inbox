Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbTISLxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 07:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTISLxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 07:53:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:29583 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261518AbTISLxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 07:53:50 -0400
Date: Fri, 19 Sep 2003 13:48:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Broken synaptics mouse..
Message-ID: <20030919114806.GD784@ucw.cz>
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org> <Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 01:43:11AM +0200, Peter Osterlund wrote:
> On Thu, 11 Sep 2003, Linus Torvalds wrote:
> 
> > Actually, I think I've changed my mind.
> > 
> > How hard would it be to have the "event" driver _notice_ when somebody is 
> > trying to use it?
> > 
> > In particular, what about something that
> >  - just keeps the touchpad in "ps/2 compatibility mode" by default
> >  - moves to absolute mode only if somebody actually uses the 
> >    /dev/input/event0 thing for it (and that would obviously disable the 
> >    ps/2 mode).
> > 
> > That sounds like the simpler setup, especially since the touchpad does a 
> > pretty good job of PS/2 emulation on its own..
> 
> What do you think about the following patch? This patch makes the touchpad
> stay in compatibility mode until user space explicitly asks for absolute
> mode by sending a SYN_CONFIG event with value != 0 to the synaptics event
> device.
> 
> I think this patch will apply on top of Vojtech's private tree, but I have
> lost track of what patches he said he has applied. Anyway, the whole patch
> series (14 patches) is available here:
> 
> http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test5-bk5/v1/
> 
> I dropped the "synaptics_optional" patch, because there should not be any
> need for the config option now that we have backwards compatibility by
> default.

The patch is nice and small, but I'm still not sure if we really want
input devices to have different modes, changing 'under hands' when one
process switches the mode while another is having the device open.
Things will then break.

I'd really prefer to contain the ugliness in mousedev.c, which then
could be removed completely in 2.8 or so, when XFree and GPM is already
well adapted to the event interface.

>  linux-petero/drivers/input/mouse/psmouse-base.c |    2 
>  linux-petero/drivers/input/mouse/psmouse.h      |    1 
>  linux-petero/drivers/input/mouse/synaptics.c    |   62 ++++++++++++++++++++++--
>  linux-petero/drivers/input/mouse/synaptics.h    |    4 +
>  4 files changed, 63 insertions(+), 6 deletions(-)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
