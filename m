Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269794AbTGOWK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbTGOWK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:10:29 -0400
Received: from maild.telia.com ([194.22.190.101]:33226 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S269794AbTGOWKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:10:05 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Synaptics driver makes touchpad unusable
References: <200307151244.53276.gallir@uib.es> <m2znjgj5zs.fsf@telia.com>
	<200307151753.59165.gallir@uib.es>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jul 2003 23:33:04 +0200
In-Reply-To: <200307151753.59165.gallir@uib.es>
Message-ID: <m2brvvh3vz.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> writes:

> On Tuesday 15 July 2003 15:04, Peter Osterlund shaped the electrons to shout:
> > Ricardo Galli <gallir@uib.es> writes:
> > > The new synaptics driver doesn't work with Dell Latitude Touchpad, it
> > > doesn't work any /dev/input/event?|mouse? and /dev/psaux neither (altough
> > > the same configuration worked at least until 2.5.70).
> > >
> > > I tried with gpm and the X's synaptics driver from
> > > http://w1.894.telia.com/~u89404340/touchpad/index.html (as indicated in
> > > the kernel documentation) and none worked, although "cat <
> > > /dev/input/event0" showed garbage every time I touched the touchpad (no
> > > pun intended) iff evdev was loaded.
> > >
> > > $ dmesg
> > > ...
> > > mice: PS/2 mouse device common for all mice
> > > i8042.c: Detected active multiplexing controller, rev 1.1.
> > > serio: i8042 AUX0 port at 0x60,0x64 irq 12
> > > serio: i8042 AUX1 port at 0x60,0x64 irq 12
> > > serio: i8042 AUX2 port at 0x60,0x64 irq 12
> > > synaptics reset failed
> > > synaptics reset failed
> > > synaptics reset failed
> >
> > You probably need this patch.
> >
> > --- linux/drivers/input/mouse.resume/psmouse-base.c	Sat Jul  5 23:39:14
> > 2003 +++ linux/drivers/input/mouse/psmouse-base.c	Sun Jul  6 00:23:17 2003
> > @@ -201,7 +201,7 @@
> 
> 
> Tried it, but still doesn't work. X server says cannot query/intialize de 
> device as before:

Does it help to make the timeout even longer? (15 seconds for example)
Does it help to disable the reset sequence altogether, like this?

diff -u -r -N linux-2.6.0-test1/drivers/input/mouse/synaptics.c linux-tmp/drivers/input/mouse/synaptics.c
--- linux-2.6.0-test1/drivers/input/mouse/synaptics.c	Sat Jul 12 00:17:19 2003
+++ linux-tmp/drivers/input/mouse/synaptics.c	Tue Jul 15 23:31:01 2003
@@ -81,6 +81,8 @@
 {
 	unsigned char r[2];
 
+	return 0;
+
 	if (psmouse_command(psmouse, r, PSMOUSE_CMD_RESET_BAT))
 		return -1;
 	if (r[0] == 0xAA && r[1] == 0x00)

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
