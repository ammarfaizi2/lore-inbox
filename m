Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSJAPOk>; Tue, 1 Oct 2002 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261704AbSJAPOk>; Tue, 1 Oct 2002 11:14:40 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:31182 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S261703AbSJAPOO>; Tue, 1 Oct 2002 11:14:14 -0400
Message-Id: <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net>
Date: Tue, 1 Oct 2002 11:32:02 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001151722.A11750@ucw.cz>; from vojtech@suse.cz on Tue, Oct 01, 2002 at 03:17:22PM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop015.verizon.net from [141.150.241.241] at Tue, 1 Oct 2002 10:19:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Oct 01, 2002 at 08:31:05AM -0400, Skip Ford wrote:
> > Vojtech Pavlik wrote:
> > > On Mon, Sep 30, 2002 at 10:40:10AM -0400, Skip Ford wrote:
> > > 
> > > > I can no longer change keycodes since switching to the new input layer.
> > > > Has anyone been able to?
> > > 
> > > I've tested it and it should work. What exactly doesn't work for you?
> > > What are you trying to do?
> > 
> > I'm trying to assign keycodes using the kbd package.  Multimedia keys
> > and some regular keys.  Here is one example.  The key I'm pressing is
> > e05e.
> 
> Ok, the problem is that because the ioctls are no longer i386-centric,
> the layout of the tables has changed.
> 
> What used to be scancode e05e is now scancode 15e, basically all
> scancodes beginning with e0 are now offset by just 100 hex.
> 
> getkeycodes/setkeycodes translates e05e to de, while the table needs 15e.
> 
> Ignore getkeycodes output, except for the 0x58-0x7f the output is not
> correct anymore. (e000-e07f lines show entries for scancodes 0x80-0xff,
> as they always did, though).
> 
> > ~# setkeycodes e05e 89
> 
> Use setkeycodes 15e 89

setkeycodes rejects it.

~# setkeycodes 15e 89
setkeycode: code outside bounds
usage: setkeycode scancode keycode ...
 (where scancode is either xx or e0xx, given in hexadecimal,
  and keycode is given in decimal)

I changed setkeycodes.c to add 256 instead of 128 and bumped up the
bounds checking, but it's still strange.  It now works for e063, but
still doesn't work for e05e.  Many other keys in the same area as 0x5e
don't work.  The only one that does work that I tried is e063.

Will you be releasing an updated kbd package?

> > The same thing happens with every key.
> 
> No, keycodes without e0 should be fine.

Turns out the "regular" keys I referred to really are extended keys.

-- 
Skip
