Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTISFFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTISFFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:05:54 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:1938 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261311AbTISFFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:05:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Osterlund <petero2@telia.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Broken synaptics mouse..
Date: Fri, 19 Sep 2003 00:05:42 -0500
User-Agent: KMail/1.5.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
In-Reply-To: <Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309190005.43342.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 September 2003 06:43 pm, Peter Osterlund wrote:
> On Thu, 11 Sep 2003, Linus Torvalds wrote:
> > Actually, I think I've changed my mind.
> >
> > How hard would it be to have the "event" driver _notice_ when somebody is
> > trying to use it?
> >
> > In particular, what about something that
> >  - just keeps the touchpad in "ps/2 compatibility mode" by default
> >  - moves to absolute mode only if somebody actually uses the
> >    /dev/input/event0 thing for it (and that would obviously disable the
> >    ps/2 mode).
> >
> > That sounds like the simpler setup, especially since the touchpad does a
> > pretty good job of PS/2 emulation on its own..
>
> What do you think about the following patch? This patch makes the touchpad
> stay in compatibility mode until user space explicitly asks for absolute
> mode by sending a SYN_CONFIG event with value != 0 to the synaptics event
> device.
>

This makes Synaptics lie about half of it's properties as it still reports 
EV_REL after switching to absolute mode. Also, reporting that Synaptics 
supports EV_TRIGGER will possibly confuse software as only joysticks (so far)
have it. I think this is wrong. Device should report only what it actually
has so userspace could reliable detect devices. 

We also can't just emulate relative events as everything is multiplexed into
/dev/input/mice and I can see many people using Synaptics via 
/dev/input/eventX and everything else via /dev/input/mice as it nicely handles
hot plugging (at least I use it this way).

Can't we just have compile option for Synaptics stating that new drivers are
needed and give links in help? By the time distributions pick up 2.6 they
will also package correct driver/GPM.

Dmitry
