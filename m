Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTIUMsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 08:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbTIUMsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 08:48:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:53907 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262386AbTIUMsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 08:48:20 -0400
Date: Sun, 21 Sep 2003 14:48:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030921124817.GA19820@ucw.cz>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz> <20030921143934.A11315@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921143934.A11315@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 02:39:34PM +0200, Andries Brouwer wrote:
> On Sun, Sep 21, 2003 at 01:06:29PM +0200, Vojtech Pavlik wrote:
> 
> > There is a slight problem, and that is that NR_KEYS is (KEY_MAX+1) in
> > recent 2.6's and that's 512. And that doesn't fit into a byte. There
> > were some patches floating around to enhance the keymap loading ioctls.
> > They will be needed, along with a new version of loadkeys.
> 
> Yes - a lot of trouble.
> As far as I can see, the space between 256 and 511 is never used.
> 
> More in particular, there are lots of places where the kernel
> seems to assume that only 256 is used.
> 
> So, instead of requiring new ioctls and new loadkeys etc
> I would prefer to make NR_KEYS 256, if possible.
> So the question is: why did you require 512?

Excerpt from input.h:

#define KEY_RESTART             0x198
#define KEY_SLOW                0x199
#define KEY_SHUFFLE             0x19a
#define KEY_BREAK               0x19b
#define KEY_PREVIOUS            0x19c
#define KEY_DIGITS              0x19d
#define KEY_TEEN                0x19e
#define KEY_TWEN                0x19f

#define KEY_DEL_EOL             0x1c0
#define KEY_DEL_EOS             0x1c1
#define KEY_INS_LINE            0x1c2
#define KEY_DEL_LINE            0x1c3

So far the last defined key is KEY_DEL_LINE, with a code of 0x1c3.
That's above 256. If there are other places that require less than 256,
well, then those will need to be fixed or we're heading for trouble.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
