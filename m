Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbUCRT5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbUCRT5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:57:20 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:22402 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262916AbUCRT5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:57:09 -0500
Date: Thu, 18 Mar 2004 20:58:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: akpm@osdl.org, anton@samba.org,
       kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x atkbd.c moaning
Message-ID: <20040318195819.GB4248@ucw.cz>
References: <opr41z9zel4evsfm@smtp.pacific.net.th> <20040318120114.GN28212@krispykreme> <opr42hoctn4evsfm@smtp.pacific.net.th> <opr42nq0a24evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr42nq0a24evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 03:14:50AM +0800, Michael Frank wrote:
> On Fri, 19 Mar 2004 01:03:38 +0800, Michael Frank <mhf@linuxmail.org> wrote:
> 
> >On Thu, 18 Mar 2004 23:01:14 +1100, Anton Blanchard <anton@samba.org> 
> >wrote:
> >
> >>
> >>>Why is this and should I investigate further?
> >>..
> >>
> >>>mice: PS/2 mouse device common for all mice
> >>>serio: i8042 AUX port at 0x60,0x64 irq 12
> >>>input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> >>>serio: i8042 KBD port at 0x60,0x64 irq 1
> >>>input: AT Translated Set 2 keyboard on isa0060/serio0
> >>>atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> >>>isa0060/serio0).
> >>
> >>Did this happen recently? If so, does backing out the following patch 
> >>help?
> >
> >I think so but later than this changeset 1.34 of 19 December.
> 
> The Unknown key release msg is introduced in 2.6.1 with i8042
> changesets from 1.33 to 1.35 (likely 1.34 as Anton suggested). Guess i
> did not think much of it as it was "smaller" but "blaming xfree"
> during boot since 2.6.2 caught my attention.

XFree86 was fixed (post 4.4) thanks to this message. kbdrate is also
fixed in the current version. With latest XFree86 and latest kbd package
you shouldn't be getting this message anymore.

> >The patch has no effect.
> >
> >Also the mouse screws up after a few hours and becomes unusable.
> 	On 2.6.4
> 
> On 2.6.[012] the mouse does not sync at all (even after power up).
> 
> On 2.4.18-26 mouse never had problems.

Can you give details on the mouse and the machine? I seem to have missed
them.

> >psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, 
> >throwing 1 bytes away.
> >psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, 
> >throwing 3 bytes away.
> 
> Could also be load dependent. Will do more testing on 2.6.4 to reproduce.
> 
> The serious issue with the mouse is that it does not recover and stays
> out of sync and interprets further movement as random coordinates/button 
> clicks.

Does unloading and reloading the psmouse module help?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
