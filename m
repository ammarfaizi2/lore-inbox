Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVJQKC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVJQKC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 06:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVJQKC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 06:02:26 -0400
Received: from styx.suse.cz ([82.119.242.94]:43948 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932246AbVJQKCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 06:02:25 -0400
Date: Mon, 17 Oct 2005 12:02:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: dtor_core@ameritech.net, Greg KH <gregkh@suse.de>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051017100223.GB10522@ucw.cz>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <20051014121423.GA21209@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014121423.GA21209@vrfy.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 02:14:23PM +0200, Kay Sievers wrote:

> Sorry, my previous drawing wasn't correct for the input devices.
> 
> Here is a new picture of the:
>   - all classes are unique and flat and will stay the same,
>     even when the hierarchy of the devices changes
>   - all hierarchy is _only_ in /sys/devices
>   - virtual and physical devices are both in /sys/devices
> proposal.

I like the layout.

I'm not completely sure whether mouse0 and event0 are the same class,
because they have different APIs and protocols. And I believe that class
is exactly that - a collection of devices where you can use the same API
to access them. A possibility would be to do it like this:

> /sys
> |-- class
> |   |-- mouse
> |   |   |-- mice -> ../../devices/mice
> |   |   |-- mouse0 -> ../../devices/platform/i8042/serio0/input0/mouse0
> |   |---event
> |   |   `-- event0 -> ../../devices/platform/i8042/serio0/input0/event0
> |   |-- input
> |   |   `-- input0 -> ../../devices/platform/i8042/serio0/input0
> |   `-- tty
> |       `-- console -> ../../devices/console

It might be too much work to create a new class in each of the
handlers, it'd be similar to harddrives and partititions having
different classes.

> /sys
> |-- class
> |   |-- input
> |   |   |-- mice -> ../../devices/mice
> |   |   |-- mouse0 -> ../../devices/platform/i8042/serio0/input0/mouse0
> |   |   `-- event0 -> ../../devices/platform/i8042/serio0/input0/event0
> |   |-- input_device
> |   |   `-- input0 -> ../../devices/platform/i8042/serio0/input0
> |
> |-- devices
> |   |-- platform
> |   |   `-- i8042
> |   |       `-- serio0
> |   |            `-- input0
> |   |                 |-- event0
> |   |                 |   `-- dev
> |   |                 |-- mouse0
> |   |                 |   `-- dev
> |   |                 |-- bind_mode
> |   |                 |-- description
> |   |                 |-- id
> |   |                 |   |-- extra
> |   |                 |   |-- id
> |   |                 |   |-- proto
> |   |                 |   `-- type
> |   |                 |-- modalias
> |   |                 |-- protocol
> |   |                 |-- rate
> |   |                 |-- resetafter
> |   |                 `-- resolution
> |   |-- mice
> |   |   `-- dev
 
Having 'mice' at top level is not very nice. It's a logical consequence
of the system, and as such probably correct, though.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
