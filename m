Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVBBT7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVBBT7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVBBTqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:46:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262469AbVBBTlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:41:24 -0500
Date: Wed, 2 Feb 2005 11:39:29 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, zaitcev@redhat.com
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202113929.0bff00e9@localhost.localdomain>
In-Reply-To: <20050202191135.GA3189@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<20050202102033.GA2420@ucw.cz>
	<20050202085628.49f809a0@localhost.localdomain>
	<20050202170727.GA2731@ucw.cz>
	<20050202095851.27321bcf@localhost.localdomain>
	<20050202191135.GA3189@ucw.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 20:11:35 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:

> It's different hardware. While the ALPS pad delivers X axis in the range
> of 0 to 1000, the Synaptics pad will give X axis values from approx 1500
> to approx 5500. This is four times the resolution - the size of the pad
> is mostly the same.

> We need to divide by 2 for ALPS and by 8 for Synaptics, and that's
> basically all we need to do. But we must not do that by checking the pad
> manufacturer, because when a third pad type comes in (Say Logitech
> TouchPad 3), we shouldn't need to modify mousedev.c

What you say is valid. I see now that this is what had to be addressed by
this statement:
  size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];

Removing that was my mistake and I wish I had a different pad for testing.
I'll do some measurements here and return something of that nature into
the patched code and give it a try.

But I still think that using yres here is wrong. It may be a fine idea,
but adding another divisor here ruined the precision of small movements.
This was my problem. Trying to line up two windows was hugely frustrating
with 2.6.11-rc2 & Peter's patches. But also, it was unnecessary to use yres,
because the reach or maximum moving distance is to be accomplished with
ballistics, not scaling.

There's nothing new about the pad being too small, actually. Old Logitech
Genius mouse in 1992 ran out of its green pad easily. The answer was
to accelerate the movement. If you moved quicker, you crossed whole screen.
The good news is that this adjustment is individual for the user and is
easily configurable.

-- Pete
