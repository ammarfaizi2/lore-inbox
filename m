Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUFBPcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUFBPcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUFBPcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:32:33 -0400
Received: from web81307.mail.yahoo.com ([206.190.37.82]:13933 "HELO
	web81307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263199AbUFBPb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:31:28 -0400
Message-ID: <20040602153128.57388.qmail@web81307.mail.yahoo.com>
Date: Wed, 2 Jun 2004 08:31:28 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: SERIO_USERDEV patch for 2.6
To: linux-kernel@vger.kernel.org
Cc: bilotta78@hotpop.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> Dmitry Torokhov wrote:
> > On Tuesday 01 June 2004 05:23 pm, Giuseppe Bilotta wrote:
> > > Dmitry Torokhov wrote:
> > > > echo "rawdev" > /sys/bus/serio/devices/serio0/driver
> > > >
> > > > or something alont these lines. At least that's my grand plan ;)
> > >
> > > I like this kind of idea. Many options should be settable this
> > > way (think for example about Synaptics and ALPS touchpad
> >
> > Yes, exactly, it will allow much more flexible option handling. Still,
> > as far as your examples go:
> >
> > > configurations: whether to use multipointers separately or
> > > together,
> > - userspace task - always persent separate devices and have
application
> >   (GPM or X) multiplex data together.
> 
> Ok, in this case your ALPS patch need a little working ;) (Last
> time I saw it it ORed the touchpad and stick values.)

Yes it needs indeed. I have something here that treats stick as a
mouse on a passthrough port, much like Synaptics driver. It's not
ready for publishing yet though.  

> 
> > > (de)activation of tapping,
> > - may be userspace task - i.e can be done in userspace if device can
> >   report BTN_TOUCH event. If not then kernel has to toggle it.
> 
> > > button remapping etc).
> > - userspace task
> 
> When you say "userspace task", are you saying that the
> filtering out of, say, BTN_TOUCH events should happen at a
> higher level than the kernel driver not reporting them at all?
> Say, in gpm?

Exactly. If you check Peter Osterlund's X driver or my GPM patches
you will see that they get BTN_TOUCH or even ABS_PRESSURE events
and then decide for themselves what should be considered a tap and
what is not. And the logic is not dependent on a particular model
but rather on set of capabilities that device reports.

Kernel task is to convert data from individual devices into unified
representation and userpace task is to do with that data whatever
it wants. X driver does not (should not) care whether a mouse is a
serial or PS/2 or USB. It only wants to know that it reports 2
relative axis motions and has X number of buttons and X number of
wheels.

Now operation of a touchscreen is different from operation of touchpad
which is different from standard mouse and userspace has to distinguish
between these, but that's because they are different classes of input
devices and should be handled [slightly] differently.

--
Dmitry

