Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTIUOtS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 10:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTIUOtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 10:49:18 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:54034 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262418AbTIUOtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 10:49:16 -0400
Date: Sun, 21 Sep 2003 16:49:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030921164914.C11315@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz> <20030921143934.A11315@pclin040.win.tue.nl> <20030921124817.GA19820@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030921124817.GA19820@ucw.cz>; from vojtech@suse.cz on Sun, Sep 21, 2003 at 02:48:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 02:48:17PM +0200, Vojtech Pavlik wrote:

> > So, instead of requiring new ioctls and new loadkeys etc
> > I would prefer to make NR_KEYS 256, if possible.
> > So the question is: why did you require 512?
> 
> Excerpt from input.h:

> #define KEY_TEEN                0x19e
> #define KEY_TWEN                0x19f
> #define KEY_DEL_EOL             0x1c0
> #define KEY_DEL_EOS             0x1c1
> 
> So far the last defined key is KEY_DEL_LINE, with a code of 0x1c3.
> That's above 256. If there are other places that require less than 256,
> well, then those will need to be fixed or we're heading for trouble.

Hmm. The kernel assumes today that keycodes have 8 bits:

In drivers/char/keyboard.c emulate_raw() tries to invent
the codes that the keyboard probably sent and resulted in a given
keycode. It starts out
	if (keycode > 255)
		return -1;

In drivers/input/keyboards/atkbd.c we have tables that convert
scancodes to keycodes. The declaration is
	static unsigned char atkbd_set2_keycode[512];
the unsigned char means that no keycodes larger than 255 can be returned.

It really seems a pity to have to add new ioctls, and to have to release
a new version of the kbd package, and to waste a lot of kernel space,
while essentially nobody needs the resulting functionality.


Andries



