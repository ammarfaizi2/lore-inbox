Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbTGEW2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266527AbTGEW2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:28:35 -0400
Received: from maile.telia.com ([194.22.190.16]:39877 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S266526AbTGEW2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:28:31 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Mike Keehan <mike_keehan@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Synaptics driver on HP6100 and 2.5.73
References: <20030626220016.27332.qmail@web12304.mail.yahoo.com>
	<m2brwb9rzi.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Jul 2003 00:41:05 +0200
In-Reply-To: <m2brwb9rzi.fsf@telia.com>
Message-ID: <m2fzlkbnr2.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Mike Keehan <mike_keehan@yahoo.com> writes:
> 
> > The touchpad is recognised OK when the kernel boots,
> > and my usb
> > connected mouse works fine.  But I get the following
> > message in
> > the syslog when I try to use the mousepad or any of
> > the buttons :-
> > 
> >     ... kernel: Synaptics driver lost sync at 1st byte
> > 
> > Relevant /var/log/dmesg content:-
> > 
> >  drivers/usb/core/usb.c: registered new driver hid
> >  drivers/usb/input/hid-core.c: v2.0:USB HID core
> > driver
> >  mice: PS/2 mouse device common for all mice
> >  synaptics reset failed
> >  synaptics reset failed
> >  synaptics reset failed
> 
> The logs from your other mail show that the touchpad is still in
> relative mode (using 3 byte packets) instead of absolute mode (using 6
> byte packets.) I don't know why this happens, but ...

OK, the problem is that the touchpad needs a lot of time to wake up
after a reset command. As we found out in private conversation, 3
seconds is barely enough, so I suggest the following patch to fix the
problem:

--- linux/drivers/input/mouse.resume/psmouse-base.c	Sat Jul  5 23:39:14 2003
+++ linux/drivers/input/mouse/psmouse-base.c	Sun Jul  6 00:23:17 2003
@@ -201,7 +201,7 @@
 	psmouse->cmdcnt = receive;
 
 	if (command == PSMOUSE_CMD_RESET_BAT)
-                timeout = 2000000; /* 2 sec */
+                timeout = 4000000; /* 4 sec */
 
 	if (command & 0xff)
 		if (psmouse_sendbyte(psmouse, command & 0xff))

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
