Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWGDX5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWGDX5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 19:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWGDX5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 19:57:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55724 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932357AbWGDX5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 19:57:36 -0400
Date: Wed, 5 Jul 2006 01:57:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>, vojtech@suse.cz
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060704235717.GD11872@elf.ucw.cz>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <20060704162346.GE9447@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704162346.GE9447@khazad-dum.debian.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Just use input infrastructure and be done with that? You can do
> > parking from userspace.
> 
> The command to execute the freeze (and for how long) can certaily come from
> userspace, and the logic behind that command can be an userspace
> high-priority task, yes (that's how it is done in HDAPS anyway).  However,
> to implement the disk head unload you need kernel code (you need to freeze
> the IO queues for a while too, not just unload the heads).

Okay, yes, this part is needed. It is useful for more than
accelerometers...


> Anyway, the input infrastructure is good to emulate a mouse/joystick, but we
> probably want to support the following generic data channels:
> 
> 1. Absolute acceleration output stream (either in hardware units, or
>    normalized to G or mG if at all possible) for X, Y, Z.  Does the input
>    infrastructure work well for reporting absolute numbers in a reasonably
>    constant rate?
>    
>    This is what HD head unload policy daemons want to know, and the stream
>    usually needs to offer datapoints somewhere between 20Hz and 100Hz
>    without excessive jitter to be useful for more advanced filtering (like
>    masking-off periodic movement such as the one caused by train tracks).
> 
> 2. As easy-to-use as possible joystick and mouse emulation (for toys and 
>    gaming), which probably means auto-calibrating ones when possible
>    and thus making them unsuitable channels for (1) above.

Well, I'd just provide 1. Providing 2 seems like task for some
userspace filtering library.

> 3. Control of accelerometer parameters:
>    3a. Report of accelerometer type (hdaps, ams, etc) and other metadata
>        (name, location, what it is measuring (system accel, hd-bay 
>        accel...))

Well, if your system is accelerating at different speed than hd-bay,
then your machine is either _way_ too big, or you are in bad trouble.

Ask Dmitry or vojtech, I believe input can provide such metadata. (I
left most of the quoted text so that vojtech can reply easily).

								Pavel

>    3b. Accelerometer polling frequency
>    3c. Enable/disable joystick and mouse emulation control
>    etc.
> 
> And, of course, userspace must be able to easily find the accelerometer
> outputs and diferentiate them from other joystick/mouse interfaces.  This is
> a task for udev, I suppose.
> 
> It is also very helpful to be able to know when something is using any of
> the accelerometer output channels, so as to shut it down (or stop talking to
> it) when it is uneeded.  I don't know about AMS, but talking to HDAPS when
> you don't need to does waste enough system resources and power to actually
> justify implementing this.
> 
> If we cannot detect automatically when userspace is paying attention to the
> accelerometer through the input layer, then that means we will need the
> enable/disable functionality already provided by the device model through
> sysfs.
> 
> > Only piece of puzzle missing is marking that input device as "this
> > accelerometer actually watches the whole device".
> 
> Well, it is very important to be able to easily find all data and channels
> pertaining for a given accelerometer, and the accelerometer metadata should
> indeed give userspace an idea of WHAT it is measuring the acceleration of
> :-)
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
