Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTH3AOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 20:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTH3AOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 20:14:04 -0400
Received: from newmx3.fast.net ([209.92.1.33]:9467 "HELO newmx3.fast.net")
	by vger.kernel.org with SMTP id S262041AbTH3AN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 20:13:57 -0400
Subject: Re: PROBLEM: keyboard shift not registered under fast typing or
	auto-repeat
From: Carl Nygard <cjnygard@fast.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030827125056.A1854@pclin040.win.tue.nl>
References: <1061944729.14320.74.camel@finland>
	 <20030827125056.A1854@pclin040.win.tue.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1062201326.14320.117.camel@finland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 Aug 2003 19:56:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 06:50, Andries Brouwer wrote:
> On Tue, Aug 26, 2003 at 08:38:50PM -0400, Carl Nygard wrote:
> 

Thanks for the pointers.  I was about to argue about what proper
behavior is, between what I see on my desktop 2.4.20 (RH9) and laptop
2.6.0, but then I saw what WinXP does, and some things clicked
irrelevant.  Anyway, thanks for the info...
> 
> > Kernel doesn't register shift state when typing quickly.  Example, 'ls
> > *' shows up as 'ls 8' when typed fast.  Also, holding '-' key down, once
> > it's repeating, shift key makes no difference.
> 
> So, the first part of what you say, when true, would be a bug.
> But a bug difficult to distinguish from a finger coordination error.
> The second part is correct behaviour.

I don't believe any of this is coordination errors.  Shown below is a
log of some debug I added to my kernel (2.6.0-test4).  I put debug stmt
at the very top of input.c, before any possible return; and also in all
the relevant if(...){ ...; return; } blocks in keyboard.c, as well as
one or two general info statements in keyboard.c  (if you need to see
where, I'll post my patch, but I doubt it's necessary)

Here's the log, I did 'tail -f messages' and then typed 'ls <shift>8' in
the window, so it's obvious at what point I'm typing:

Please note the bad version doesn't receive any notice of the shift-down
event, but gets the shift-up event, proving that I really did press
it;)  The good version gets shift-down and shift-up properly.

My question: Is there anywhere else I can look, perhaps the code which
calls input.c::input_event()?  Or is this potentially a hardware problem
(i.e. should I return my laptop, because this is too d*mn annoying)?

Thanks for the help
Regards,
Carl



Typing quickly: 

lAug 29 15:54:34 traveler kernel: input.c: type: 1 code: 38:0x26 value: 1
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
s 8Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 31:0x1f value: 1
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 38:0x26 value: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 31:0x1f value: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 57:0x39 value: 1
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 57:0x39 value: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 9:0x9 value: 1
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 9:0x9 value: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:54:34 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:34 traveler kernel: input.c: type: 1 code: 54:0x36 value: 0
     ## ^--- Shift-up event
Aug 29 15:54:34 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:54:39 traveler kernel: input.c: type: 1 code: 29:0x1d value: 1
Aug 29 15:54:39 traveler kernel: keyboard.c: shift_final: 0
                                                                                                                
typing slower, at least making sure the space <shift> are separated.

lsAug 29 15:55:07 traveler kernel: input.c: type: 1 code: 28:0x1c value: 0
Aug 29 15:55:07 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:07 traveler kernel: keyboard.c: handling keycode: 28 keysym 61953/1 down: 0
Aug 29 15:55:07 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:08 traveler kernel: input.c: type: 1 code: 38:0x26 value: 1
Aug 29 15:55:08 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:08 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:08 traveler kernel: input.c: type: 1 code: 31:0x1f value: 1
Aug 29 15:55:08 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:08 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:08 traveler kernel: input.c: type: 1 code: 38:0x26 value: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:08 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
 *Aug 29 15:55:08 traveler kernel: input.c: type: 1 code: 31:0x1f value: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: raw_mode(1) && type(11) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:08 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:08 traveler kernel: input.c: type: 1 code: 57:0x39 value: 1
Aug 29 15:55:08 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:08 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:08 traveler kernel: input.c: type: 1 code: 57:0x39 value: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:08 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:08 traveler kernel: input.c: type: 1 code: 54:0x36 value: 1
    ## ^---- Shift-down event
Aug 29 15:55:08 traveler kernel: keyboard.c: shift_final: 0
Aug 29 15:55:08 traveler kernel: keyboard.c: handling keycode: 54 keysym 63232/0 down: 1
Aug 29 15:55:08 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:09 traveler kernel: input.c: type: 1 code: 9:0x9 value: 1
Aug 29 15:55:09 traveler kernel: keyboard.c: shift_final: 1
Aug 29 15:55:09 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:09 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:09 traveler kernel: input.c: type: 1 code: 9:0x9 value: 0
Aug 29 15:55:09 traveler kernel: keyboard.c: shift_final: 1
Aug 29 15:55:09 traveler kernel: keyboard.c: raw_mode(1) && type(0) != KT_SPEC(2) && type != KT_SHIFT(7))
Aug 29 15:55:09 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
Aug 29 15:55:09 traveler kernel: input.c: type: 1 code: 54:0x36 value: 0
    ## ^---- Shift-up event
Aug 29 15:55:09 traveler kernel: keyboard.c: shift_final: 1
Aug 29 15:55:09 traveler kernel: keyboard.c: handling keycode: 54 keysym 63232/0 down: 0
Aug 29 15:55:09 traveler kernel: input.c: type: 0 code: 0:0x0 value: 0
                                                                                                                

-- 
Carl Nygard <cjnygard@fast.net>

