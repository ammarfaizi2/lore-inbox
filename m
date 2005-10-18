Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVJRFN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVJRFN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 01:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVJRFN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 01:13:26 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:27765 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932330AbVJRFNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 01:13:25 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Date: Tue, 18 Oct 2005 00:13:17 -0500
User-Agent: KMail/1.8.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       Greg KH <gregkh@suse.de>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       Adam Belay <ambx1@neo.rr.com>
References: <20051013020844.GA31732@kroah.com> <20051014121423.GA21209@vrfy.org> <20051017100223.GB10522@ucw.cz>
In-Reply-To: <20051017100223.GB10522@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510180013.19024.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 05:02, Vojtech Pavlik wrote:
> On Fri, Oct 14, 2005 at 02:14:23PM +0200, Kay Sievers wrote:
> 
> > Sorry, my previous drawing wasn't correct for the input devices.
> > 
> > Here is a new picture of the:
> >   - all classes are unique and flat and will stay the same,
> >     even when the hierarchy of the devices changes
> >   - all hierarchy is _only_ in /sys/devices
> >   - virtual and physical devices are both in /sys/devices
> > proposal.
> 
> I like the layout.
> 
> I'm not completely sure whether mouse0 and event0 are the same class,
> because they have different APIs and protocols. And I believe that class
> is exactly that - a collection of devices where you can use the same API
> to access them. A possibility would be to do it like this:
> 
> > /sys
> > |-- class
> > |   |-- mouse
> > |   |   |-- mice -> ../../devices/mice
> > |   |   |-- mouse0 -> ../../devices/platform/i8042/serio0/input0/mouse0
> > |   |---event
> > |   |   `-- event0 -> ../../devices/platform/i8042/serio0/input0/event0
> > |   |-- input
> > |   |   `-- input0 -> ../../devices/platform/i8042/serio0/input0
> > |   `-- tty
> > |       `-- console -> ../../devices/console
> 
> It might be too much work to create a new class in each of the
> handlers, it'd be similar to harddrives and partititions having
> different classes.
>

This illustrates the problem I have with flat classification: "event" is way
too generic name and "input_event", "input_mouse", etc. is way too ugly.
"input/event", "input/mouse" is much better IMO.

-- 
Dmitry
