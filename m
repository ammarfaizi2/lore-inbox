Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVBBTz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVBBTz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVBBTz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:55:26 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:16005 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262622AbVBBTy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:54:59 -0500
Date: Wed, 2 Feb 2005 20:55:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202195512.GA3852@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <20050202102033.GA2420@ucw.cz> <20050202085628.49f809a0@localhost.localdomain> <20050202170727.GA2731@ucw.cz> <20050202095851.27321bcf@localhost.localdomain> <20050202191135.GA3189@ucw.cz> <20050202113929.0bff00e9@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202113929.0bff00e9@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 11:39:29AM -0800, Pete Zaitcev wrote:
> On Wed, 2 Feb 2005 20:11:35 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > It's different hardware. While the ALPS pad delivers X axis in the range
> > of 0 to 1000, the Synaptics pad will give X axis values from approx 1500
> > to approx 5500. This is four times the resolution - the size of the pad
> > is mostly the same.
> 
> > We need to divide by 2 for ALPS and by 8 for Synaptics, and that's
> > basically all we need to do. But we must not do that by checking the pad
> > manufacturer, because when a third pad type comes in (Say Logitech
> > TouchPad 3), we shouldn't need to modify mousedev.c
> 
> What you say is valid. I see now that this is what had to be addressed by
> this statement:
>   size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];
> 
> Removing that was my mistake and I wish I had a different pad for testing.
> I'll do some measurements here and return something of that nature into
> the patched code and give it a try.

OK.

> But I still think that using yres here is wrong. It may be a fine idea,
> but adding another divisor here ruined the precision of small movements.
> This was my problem. Trying to line up two windows was hugely frustrating
> with 2.6.11-rc2 & Peter's patches. But also, it was unnecessary to use yres,
> because the reach or maximum moving distance is to be accomplished with
> ballistics, not scaling.

I agree. If one wants full precision even at the ballistic speeds of
movement (and Synaptics can do that simply by not dividing the values),
one can use the special X driver.

No need to be overclever in mousedev.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
