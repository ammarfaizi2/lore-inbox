Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUCRVL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUCRVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:09:47 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:7300 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262951AbUCRVGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:06:25 -0500
Date: Thu, 18 Mar 2004 22:07:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: akpm@osdl.org, anton@samba.org,
       kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x atkbd.c moaning
Message-ID: <20040318210737.GA4494@ucw.cz>
References: <opr41z9zel4evsfm@smtp.pacific.net.th> <20040318120114.GN28212@krispykreme> <opr42hoctn4evsfm@smtp.pacific.net.th> <opr42nq0a24evsfm@smtp.pacific.net.th> <20040318195819.GB4248@ucw.cz> <opr42ry9kk4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr42ry9kk4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 04:46:11AM +0800, Michael Frank wrote:

> >>The Unknown key release msg is introduced in 2.6.1 with i8042
> >>changesets from 1.33 to 1.35 (likely 1.34 as Anton suggested). Guess i
> >>did not think much of it as it was "smaller" but "blaming xfree"
> >>during boot since 2.6.2 caught my attention.
> >
> >XFree86 was fixed (post 4.4) thanks to this message. kbdrate is also
> >fixed in the current version. With latest XFree86 and latest kbd package
> >you shouldn't be getting this message anymore.
> 
> I appreciate the message when X-old or kbdrate-old is running but not
> during boot right after HD init. Please see dmesg.
> 
> I updated to kbd-1.12-1 Change kdbrate does still create messages.
> Will look for later package. Which version?

Are you running kbdrate on the console?

> >Can you give details on the mouse and the machine? I seem to have missed
> >them.
> 
> Mouse is a noname USB mouse connected via an PS2 Adapter to the PS2 port.
> Dmesg included.

Ok. Does it have a wheel and extra buttons?

> >>The serious issue with the mouse is that it does not recover and stays
> >>out of sync and interprets further movement as random coordinates/button
> >>clicks.
> >
> >Does unloading and reloading the psmouse module help?
> 
> No, once sync lost, unload, load psmouse no use and
> unplug, plug mouse no use too.

Interesting. Since the driver shouldn't be keeping any state, unplugging
and replugging the mouse should be well enough.

> But: unload, remove mouse, plug mouse, load is OK
> except setting for acceleration is too low.
> 
> Looks like psmouse reset no work on 2.6.

I'll take a look at this code path then.

Btw, please try with USB support compiled into the kernel. We might be
seeing yet another incarnation of the "Legacy USB emulation" problem.

>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 > hda4
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> NET: Registered protocol family 2

This indeed looks like it. Why do you specify "nousb" on the kernel
command line?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
