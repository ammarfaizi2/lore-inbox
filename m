Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVHOS4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVHOS4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVHOS4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:56:44 -0400
Received: from s243.chello.upc.cz ([62.24.84.243]:41405 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S964901AbVHOS4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:56:44 -0400
Date: Mon, 15 Aug 2005 20:57:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joe Peterson <joe@skyrush.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
Message-ID: <20050815185729.GA1450@ucw.cz>
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz> <4300D845.8070605@skyrush.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4300D845.8070605@skyrush.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 12:00:37PM -0600, Joe Peterson wrote:

> I am using evtouch, but I had read that X itself has an issue with
> devices that are not "always there" and that X does not [yet] seem to be
> designed to handle hotplugging well (for example, device names need to
> be hard-coded in xorg.conf, so a changing device name on plugging will
> not work).

You just need to list all the possible names, as far as I know, which
isn't too bad. And udev takes care of it anyway.

> Perhaps this could be fixed, but it might be a lot more
> involved.  Why was /dev/input/mice created? 

To make 2.6 work with existing applications. It's scheduled to be
removed. I definitely don't want to add more workarounds for X
limitations to the kernel - that only defers fixing X.

> It does correct the issue of unplugging and plugging mice (as well as
> its obvious feature of allowing multiple mice, of course)?  It keeps X
> happy by shielding it from the plugging/unplugging.

Yes. But X really needs to start caring about hotplug. I've heard that
latest builds are moving into that direction (though I didn't try myself
yet).

> If the mixing of event devices is problematic, what about simply the
> idea of a persistent event device that always "exists" to the user of
> the events but will reattach if the HW is plugged/unplugged (the device
> name assigned could be made constant using a udev symlink)?  This could
> solve the problem without mixing all events.  In my case, I have one
> touch screen only (as most people would), so the mixing works in my
> case, of course.

The event device always exists until it's closed. It'll return -ENODEV on
any operation, but is discarded only after the last application closes
it.

What exact change of behavior do you need? If you want the kernel to
match the newly plugged-in device to the existing, open, unattached,
evdev node, well, that's near impossible to do solely in the kernel.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
