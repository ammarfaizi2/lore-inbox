Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbUBBJfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUBBJfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:35:31 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:55424 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265687AbUBBJfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:35:24 -0500
Date: Mon, 2 Feb 2004 10:35:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202093543.GG548@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201141516.A28045@pclin040.win.tue.nl> <20040201135001.GA1804@ucw.cz> <20040201161452.A28063@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201161452.A28063@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 04:14:52PM +0100, Andries Brouwer wrote:

> > One more question: Will kbdrate work properly (use ioctls) when compiled
> > on a 2.6 kernels?
> 
> kbdrate first tries the KDKBDREP ioctl, then the KIOCSRATE ioctl,
> and if both fail it will try to write to /dev/port.

Could you disable accessing /dev/port if running on a 2.6 kernel?

If the controller is in MUX mode it can disturb it rather badly. It's
wrong anyway, because if the user has an USB keyboard, and in the case
of a legacyless system it'll even try to access nonexisting hardware. 

The problem is that when you're in X, and root, the ioctls will fail,
but /dev/port will still work, and cause trouble.

I'd even vote in favor of ditching the /dev/port code completely,
because all reasonable kernels support the ioctls, but that's your call.

----

Btw, what would you think about having the setkeycodes and kbdrate (and
possibly some other tools, too) take an optional argument of
/dev/input/event#, and then use the EVIOCSKEYCODE ioctl and EV_REP write
to set the scancodes and repeat on that single device? It'd be very
useful if one has more than one keyboard in the system.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
