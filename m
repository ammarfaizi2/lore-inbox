Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUE3LS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUE3LS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUE3LS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:18:26 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:51584 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262605AbUE3LSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:18:24 -0400
Date: Sun, 30 May 2004 13:18:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530111847.GA1377@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 12:39:40PM +0200, Sau Dan Lee wrote:

>     Vojtech> Q1: What would you do if the user has an USB keyboard?
> 
> If he was  raw mode from a  USB keyboard, he should get  the raw data.
> Of course, he should know what he's doing.

The USB communication is not byte-oriented, so that wouldn't work.
Anyway, if we could pass the USB data in some form through the console
in raw mode, this would of course break XFree86, as it wouldn't
understand it.

>     Vojtech> Q2: What application should be looking at the raw data
>     Vojtech> outside the kernel and why?
> 
> What application should be looking at  the raw data from an RS232 port
> outside the kernel and why?

Terminal. Terminals use the data directly. 

Actually it's pretty annoying there isn't a higher level abstraction of
modem than a RS232 port, because when you have a softmodem, the driver
needs to implement a fake RS232 port, including fake RTS/CTS, DSR/DTR
lines, and completely fake AT commands, so that applications that expect
to talk to a RS232 port work with it.

Anyway, the RS232 port is a multi purpose port, where you can attach
many different devices to it. For the keyboard port, there is only one
option, the keyboard. Of course, unless you create a device that can use
it, but in that case you can easily write a kernel driver for it.

> Why do you  leave 'efax' in userspace, letting it read/write raw data
> to/from the modem via the RS232?

Because I draw the line of what is supposed to be in the kernel and what
belongs to userspace on a different place than you. 

>     >> Fortunately this patch (written together with Sau Dan Lee)
>     >> should give _really_ raw mode in 2.6.x too (but it's not
>     >> compatible with the raw mode in 2.4.x):
>     >> 
>     >> http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.5-userdev.20040507.patch
>  
> In a nutshell, I hate to be restricted by YOUR own imaginations of how
> people should hack  the system.

You're not. You're free to hack the kernel drivers. You can do whatever
you wish. But I also have the option to not use your creations in the
input system.

> Raw keyboard  data, for  instance, can be  captured for  analyzing how
> people use the  keyboard and coming up with  a more efficient keyboard
> layout (c.f. Dvorak).  That's already beyond your imaginations.

The raw data not what you want to use there. You want the keystroke
data, and for that you can use the /dev/input/event interface, where you
get them in a sane format (as opposed to the PS/2 rawmode, which can
send up ot 8 bytes for a single keystroke).

Then your statistic analyser will work just fine even on a Sun, Mac, or
with an USB keyboard.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
