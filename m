Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270293AbTGSP5M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270377AbTGSP5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 11:57:12 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:61199 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270293AbTGSP5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 11:57:08 -0400
Date: Sat, 19 Jul 2003 18:12:05 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: junkio@cox.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.0-test1 JAP_86 disappeared from atkbd.c
Message-ID: <20030719181205.A3543@pclin040.win.tue.nl>
References: <7vy8yudcec.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7vy8yudcec.fsf@assigned-by-dhcp.cox.net>; from junkio@cox.net on Sat, Jul 19, 2003 at 03:44:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 03:44:11AM -0700, junkio@cox.net wrote:
> In 2.4, Japanese 86/106 keyboards used to be able to generate
> backslash and pipe characters (around ll. 367 in
> linux-2.4.21/drivers/char/pc_keyb.c), but the rewritten AT
> keyboard driver linux-2.6.0-test1/drivers/input/keyboard/atkbd.c
> does not seem to have corresponding support for that key.  As a
> result, the key seems to be dead and I cannot type '|' on such a
> keyboard from Linux console (it works OK in X Window but that is
> expected).
> 
> For your reference, here is some comments in the 2.4 PC keyboard
> driver that I think is relevant.
> 
>         ...
> 	} else if (scancode >= SC_LIM) {
> 	    /* This happens with the FOCUS 9000 keyboard
> 	       Its keys PF1..PF12 are reported to generate
> 	       55 73 77 78 79 7a 7b 7c 74 7e 6d 6f
> 	       Moreover, unless repeated, they do not generate
> 	       key-down events, so we have to zero up_flag below */
> 	    /* Also, Japanese 86/106 keyboards are reported to
> 	       generate 0x73 and 0x7d for \ - and \ | respectively. */
> 	    /* Also, some Brazilian keyboard is reported to produce
> 	       0x73 and 0x7e for \ ? and KP-dot, respectively. */
> 
> 	  *keycode = high_keys[scancode - SC_LIM];
> 
>        ...

Ha - really long ago I wrote that..

Yes, for 2.5 things are much more involved, but I suppose that
all will be well if you add the line

keycode 183 = backslash bar

to your keymap.

Andries

