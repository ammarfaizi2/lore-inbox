Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132428AbRDMXy3>; Fri, 13 Apr 2001 19:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132429AbRDMXyT>; Fri, 13 Apr 2001 19:54:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:37389 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132428AbRDMXyC>; Fri, 13 Apr 2001 19:54:02 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
Date: 13 Apr 2001 16:53:41 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9b83i5$ha7$1@cesium.transmeta.com>
In-Reply-To: <20010413150219.A440@napalm.go.cz> <20010414002120.A15596@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010414002120.A15596@win.tue.nl> of
linux.dev.kernel, you write:
> On Fri, Apr 13, 2001 at 03:02:19PM +0200, Jan Dvorak wrote:
> 
> > i recently met with a new (Unisys) keyboard, which have (among 'normal'
> > windows keys) 3 more keys on top of arrows, labeled by pictures as
> > halfsun, halfmoon, and power switch. Following patch adds 'support' for them
> 
> > +#define E0_MSPOWER	128
> > +#define E0_MSHALFMOON	129
> > +#define E0_MSHALFSUN	130
> 
> No, these codes cannot be larger than 127 today.
> You can use the utility setkeycodes to assign keycodes to these keys.
> 
> [One of the things for 2.5 is 15- or 31-bit keycodes.
> The 7-bits we have today do no longer suffice. I have a 132-key keyboard.]
> 

By the way, it's for things like this that I suggested using a keycode
which can be algorithmically mapped from scan codes once we go to a
larger keycode space.  For example, if your key generates E0 63, it
would *always* have keycode 0x00E3 (227).  For PC keyboards, I believe
the following mapping algorithm should work onto a 15-bit keycode
space (all numbers in hex):

	xx	   -> 00xx
	E0 xx	   -> 00xx | 0080
	E1 xx yy   -> yyxx

(I can't remember which one of the E1 bytes that has the make/break
bit, it should obviously go at the top.)

This assumes that there isn't a null byte form of E1, in which case it
really can't be made to fit, but I don't think so.

This means you don't have to configure two levels (scancodes ->
keycodes and keycodes -> keymap); since currently the keycodes are
keyboard-specific anyway there is no benefit to the two levels.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
