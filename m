Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbUBAVyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUBAVyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:54:46 -0500
Received: from 217-124-43-80.dialup.nuria.telefonica-data.net ([217.124.43.80]:20865
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S265507AbUBAVym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:54:42 -0500
Date: Sun, 1 Feb 2004 22:54:38 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ (ir-kbd-gpio.ko)
Message-ID: <20040201215438.GA8937@localhost>
Mail-Followup-To: kraxel@bytesex.org, linux-kernel@vger.kernel.org
References: <20040201100644.GA2201@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201100644.GA2201@ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 01 February 2004, at 11:06:44 +0100,
Vojtech Pavlik wrote:

> Common problems and solutions with 2.6 input drivers:
> Problem:
> ~~~~~~~~
> I've read through the whole file, and it did not help me at all!
> 
The following is not a problem, but a question I have been unable to
answer by myself. Is with respect to the recent addition of "input layer
based support for infrared remote controls", mainly for use with TV
tuner cards based on bttv.

Gerd Knorr did the patch that was integrated into mainstream as
ChangeSet 1.1474.131.296, and I was trying to use the new standard
driver instead of the ported one from 2.4.x, which I got from LIRC
mailinglists, and has been working OK with 2.5.x and 2.6.x.

If I load the new kernel modules ir_kbd_gpio and ir_common I get in the logs:
ir-kbd-gpio: bttv IR (card=41) detected at pci-0000:00:0b.0/ir0

And from /proc/bus/input/devices:
I: Bus=0001 Vendor=1461 Product=0001 Version=0001
N: Name="bttv IR (card=41)"
P: Phys=pci-0000:00:0b.0/ir0
H: Handlers=kbd event3 
B: EV=100003 
B: KEY=c304 80100040 0 0 30000 0 2008000 80 1 9e0000 7bb80 0 0 

So everything seems to be detected OK. But when I start lircd 0.6.6-7,
it seems to come up fine, but as soon as any application tries to get
keypresses from /dev/lirc the daemon exists, because of:
could not open /dev/lirc

So it seems the new kernel driver for TV capture card based remote
controls doesn't use /dev/lirc as the place to "send" events from which
applications read them.

I have downloaded LIRC from CVS (0.7.0pre1), tried to compile it with little 
overall success, and started "lircd --device=/dev/lircd --nodaemon".
Next I started "irw" to show "keypresses" on the screen, and the daemon
doesn't complain, but nothing seems to be received neither.

So the question is, is something unusual needed to make the remote work
with the recently added ir-kbd-gpio.ko ?.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.2-bk3)
