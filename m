Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTIYWa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 18:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTIYWa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 18:30:59 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:10718 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261993AbTIYWa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 18:30:57 -0400
Date: Fri, 26 Sep 2003 00:30:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, akpm@osdl.org, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Message-ID: <20030925223032.GA32130@ucw.cz>
References: <10645086121286@twilight.ucw.cz> <200309251323.33416.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309251323.33416.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:23:33PM -0500, Dmitry Torokhov wrote:
> On Thursday 25 September 2003 11:50 am, Vojtech Pavlik wrote:
> > +
> > +	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
> > +	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
> >
> 
> Couple of questions:
> 
> - Why does it use hard-coded values? Different people prefer different 
>   settings.

I just moved them from mousedev.c. 

> - Are userspace drivers supposed to use BTN_TOUCH event to detect whether 
>   the pad is touched or ABS_PRESSURE? If ABS_PRESSURE then BTN_TOUCH is
>   unneeded; otherwise it's not configurable.

A simple userspace program or kernel handler can use BTN_TOUCH, and
it'll trade off configurability for simplicity. BTN_TOUCH will most
likely be present on all touchpads, touchscreens and tablets, too, so it
can be relied on as a generic feature. An advanced one can be
configurable to use ABS_PRESSURE with user defined thresholds.

Another of the reasons is that ABS_PRESSURE is hardware-dependent.
Different device types will need very different thresholds. With the
driver providing the thresholded value, a generic handler (like
mousedev) can work without external configuration.

> - Introducing BTN_TOUCH as far as I can seen does nothing to prevent joydev
>   grabbing either Synaptics or touchscreens... Is there a patch missing?

No. It's a statement you're missing near the beginning of
joydev_connect().

>   Anyway, I still thing that joydev claims are too broad. Next time you add 
>   a non-joystick device you will need to re-examine joydev and it should be
>   other way around - if you add a joystick you need to make sure that joydev
>   grabs it. This way you will catch most problems right away.

It is possible. Maybe it's time now to define what event types each type
of device is supposed to have so that problems like this don't appear.

> BTW, any chance on including pass-through patches? Do you want me to re-diff 
> them?

Hmm, I thought I've merged them in already, but obviously I did not.
Please resend them (rediffed if possible). Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
