Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTLUVkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTLUVkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:40:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:40834 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264137AbTLUVkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:40:06 -0500
Date: Sun, 21 Dec 2003 22:39:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Raul Miller <moth@magenta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with usb duo mouse and keyboard
Message-ID: <20031221213950.GA14664@ucw.cz>
References: <20031221154331.Z28449@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221154331.Z28449@links.magenta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 03:43:31PM -0500, Raul Miller wrote:
> Linux 2.6.0 (and 2.6.0-test11) appears to have a significant problem
> with the mouse of the logitech 700mx duo when it's plugged in using usb.
> 
> The mouse works fine* when plugged in using the ps/2 mouse connector,
> and the keyboard works ok even when plugged in using usb.  However,
> when using usb:
> 
> o   horizontal mouse movement is interpreted as vertical movement 
> o   vertical mouse movement is ignored 
> o   strange things happen with mouse button presses (I didn't bother
>     working with this configuration long enough to figure out the
>     details).
> 
> This occurs under both x and gpm, which is mild evidence that it's
> not a user space problem.
> 
> It might also be worth noting that some of the extra keys on the keyboard
> do odd mouse-like things (like move the mouse's pointer horizontally
> a short distance) when it's a usb keyboard.  However, these keys work
> reasonably normally (or, in two cases**, generate entries in syslog)
> when it's plugged in as a ps/2 keyboard.
> 
> My guess is that the respective usb drivers haven't taken into account
> that both a keyboard and a mouse might appear on the same physical
> connection.  [But I'm still coming up to speed, and haven't yet figured
> out how to confirm/disprove that guess.]

They do take that into account. It's just that the descriptors are maybe
too complex. Could you possibly enable DEBUG in hid-core.c and send me
the output?

> -- 
> Raul Miller
> moth@magenta.com
> 
> 
> * one mouse button is ignored, however it is so awkwardly placed that I
> doubt anyone would want to use it.
> 
> 
> ** the syslog entries from the unsupported keys:
> 
> Dec 21 15:28:07 localhost kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x11d, data 0x11, on isa0060/serio0).
> Dec 21 15:28:07 localhost kernel: atkbd.c: Unknown key released (translated set
> 2, code 0x11d, data 0x91, on isa0060/serio0).
> Dec 21 15:28:10 localhost kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x12c, data 0x14, on isa0060/serio0).
> Dec 21 15:28:10 localhost kernel: atkbd.c: Unknown key released (translated set
> 2, code 0x12c, data 0x94, on isa0060/serio0).
> 
> Perhaps it's also worth noting that most of the other extra keys send two
> byte sequences when pressed (as reported by showkey -s), and showkey -k
> seems to be reporting the extra information as extra key releases, I think
> I've seen something similar on other keyboards, but I don't have one of
> those handy to test on).  If anyone cares, I can document this for them.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
