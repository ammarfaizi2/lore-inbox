Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265650AbTFNI3W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTFNI3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:29:21 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:54195 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265650AbTFNI3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:29:14 -0400
Date: Sat, 14 Jun 2003 10:42:55 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: Peter Osterlund <petero2@telia.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030614104255.A12208@ucw.cz>
References: <20030614000810.A10851@ucw.cz> <Pine.LNX.4.40.0306140028350.27605-100000@shannon.math.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0306140028350.27605-100000@shannon.math.ku.dk>; from pebl@math.ku.dk on Sat, Jun 14, 2003 at 12:55:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 12:55:32AM +0200, Peter Berg Larsen wrote:
> 
> On Sat, 14 Jun 2003, Vojtech Pavlik wrote:
> 
> > > What do we call these things? ABS_FINGER_WIDTH and ABS_NR_FINGERS
> > > maybe?
> 
> > Could work. Or as James Simmons suggested ABS_AREA.
> 
> ABS_NR_FINGERS and ABS_AREA ? I find ABS_FINGER_WIDTH to more telling.

I'm now considering a yet different approach that's more along the lines
how digitizers (tablets) are handled:

BTN_TOOL_FINGER
BTN_TOOL_DOUBLETAP
BTN_TOOL_TRIPLETAP

for telling what the user used to point ... and

ABS_AREA or ABS_WIDTH or ABS_TOOL_WIDTH

to tell how the touched area is large. 

> The important part is that the driver must know when there is added or
> removed a finger as touchpads sends the avarage positions of the fingers.
> Adding or removing a finger moves the mouse if the driver does nothing.
> 
> There are other questions, if the API is to be used by a general user
> touchpad driver.

I hope it could, but not many touchpad drivers report all the stuff they
know like the Synaptics ones. Most do all the processing straight
within the pad processor.

> Is there a way to communicate the resolution of the x,y
> and z coordinates to the user driver? 

Not at the moment. We could add physical range values it if it becomes
needed, though. From this the userspace portion of the driver can
compute the resolution.

> (not only min/max). How do I tell
> that the y coordinate is reversed (gliderpointer) ?

The direction of the coordinates is defined to be constant in the API,
so you should reverse it in the driver if you detect a pad with a
reversed Y coordinate.
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
