Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUDLKQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDLKQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:16:34 -0400
Received: from swszl.szkp.uni-miskolc.hu ([193.6.2.24]:4752 "EHLO
	swszl.szkp.uni-miskolc.hu") by vger.kernel.org with ESMTP
	id S262756AbUDLKQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:16:32 -0400
Date: Mon, 12 Apr 2004 12:16:31 +0200
From: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>
To: linux-kernel@vger.kernel.org
Cc: Kim Holviala <kim@holviala.com>
Subject: Re: 2.6.5 : problem with MS Intellimouse Explorer buttons when using X
Message-ID: <20040412101631.GA22555@swszl.szkp.uni-miskolc.hu>
References: <20040410135327.GA12573@swszl.szkp.uni-miskolc.hu> <200404112216.33308.kim@holviala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200404112216.33308.kim@holviala.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 11, 2004 at 10:16:33PM +0300, Kim Holviala wrote:
> 2.4 and 2.6 handle mouse differently; 2.4 has /dev/psaux which is just a 
> direct channel into the port while 2.6 inteprets all mouse stuff and 
> regenerates a virtual /dev/psaux.

Thanks, I did not know it.
 
> Try modprobing the even device (modprobe evdev) to get /dev/input/event?. Then 
> run hexdump -C /dev/input/event1 (or whatever even device represents your 
> mouse) to see what REALLY happens in the kernel. Don't worry about the first 
> 8 octets, the stuff you want is in the last 8. Might be a good idea to switch 
> to a console so that extra mouse clicks won't do any strange things.

When looking for the evdev modul, I found the event debug (evbug) modul, so I 
used that one instead. It writes event debug info to the kernel log. I loaded 
it, and started pressing the mouse buttons, one after another.

Everything looks OK: there are no superfluous mouse events. This is the
output I got:

Apr 12 11:46:28 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 272, Value: 1
Apr 12 11:46:28 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:28 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 272, Value: 0
Apr 12 11:46:28 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:29 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 273, Value: 1
Apr 12 11:46:29 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:30 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 273, Value: 0
Apr 12 11:46:30 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:32 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 274, Value: 1
Apr 12 11:46:32 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:32 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 274, Value: 0
Apr 12 11:46:32 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:33 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 276, Value: 1
Apr 12 11:46:33 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:34 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 276, Value: 0
Apr 12 11:46:34 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:35 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 275, Value: 1
Apr 12 11:46:35 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0
Apr 12 11:46:36 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 1, Code: 275, Value: 0
Apr 12 11:46:36 tonhal kernel: evbug.c: Event. Dev: isa0060/serio1/input0, Type: 0, Code: 0, Value: 0

So the mouse event regeneration in the kernel seems to be buggy.

> >         Option          "Buttons"               "7"
> >         Option          "ZAxisMapping"          "6 7"
> 
> I use an Explorer at work, don't have the Buttons directive at all and my 
> ZAxMap is "4 5". That way everything works, but the side buttons are missing. 
> That's with 2.6.5 and Gentoo.

Yes. In order to use the mouse buttons on the side, one has to use the
configuration above. Obviously the Z axis is mapped to the wrong buttons 
(and button 4 and 5 are the side buttons..) so buttons should be swapped 
in X with the   xmodmap -e "pointer = 1 2 3 6 7 4 5"   command.


	Gabor
