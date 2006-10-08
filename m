Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWJHGu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWJHGu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWJHGu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:50:58 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:32449 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750835AbWJHGu6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:50:58 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sun, 8 Oct 2006 08:51:40 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610071916.27315.oliver@neukum.org> <200610071703.24599.david-b@pacbell.net>
In-Reply-To: <200610071703.24599.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610080851.40568.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Oktober 2006 02:03 schrieb David Brownell:
> > A simple timeout solution has drawbacks.
> 
> Plus lots of advantages, including the not-to-be-underrated simplicity.

That simplicity means setting up timers in kernel space and determining when
a device is "active". You only simplify the interface.

> > - there's no guarantee the user wants wakeup (think laptop on crowded table)
> 
> In which case the /sys/devices/.../power/wakeup flag can be
> marked as disabled.  No wakeup ... but of course, no power
> savings either.  (One can still unplug the mouse...)

I can have suspend without wakeup. It just means that I need to
hit a key to make X notice me again.

> > - you want to suspend immediately when you blank the screen (or switch to
> > a text console)
> 
> Unrelated to USB or any other specific subsystem; the system

That is exactly the point.

> suspends by "echo mem > /sys/power/state" regardless.  (That is,
> once the bugs in ACPI, and sometimes drivers, get fixed.)

What allows you to assume that I want to suspend the whole system?
That power/latency tradeoff is not a policy to be set in kernel.

> > - you want to consider all devices' activity. I am not pleased if my mouse
> > becomes less responsive just because I used only the keyboard for a
> > few minutes. Coordinating this inside the driver is hard as some input
> > devices might well be not usb (eg. bluetooth mouse, usb tablet)
> 
> The reasons X11 becomes unresponsive have very little to do with USB
> or autosuspend; happens all the time with PS2 mice, trackpads, etc.
> Again, those issues are unrelated to USB, or to the API you said you
> wanted to see.

I did not speak about X11. I can keep X pretty busy with keyboard and
touchpad. Nevertheless my mouse has no business going to sleep even
if I don't move it and it is the only usb device.
