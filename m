Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTI3QAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTI3QAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:00:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28129 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261193AbTI3QAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:00:35 -0400
Date: Tue, 30 Sep 2003 18:00:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: multimedia keys not working in 2.6.0-test6
Message-ID: <20030930160033.GC27118@ucw.cz>
References: <20030930154640.GA27057@ucw.cz> <Pine.LNX.4.44.0309301750400.2486-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309301750400.2486-100000@pau.intranet.ct>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 05:52:03PM +0200, Pau Aliagas wrote:
> On Tue, 30 Sep 2003, Vojtech Pavlik wrote:
> 
> > On Tue, Sep 30, 2003 at 04:56:21PM +0200, Andries Brouwer wrote:
> > 
> > > On Tue, Sep 30, 2003 at 01:54:59PM +0200, Pau Aliagas wrote:
> > > 
> > > > These are the messages I get when pressing P1 and P2 in my laptop.
> > > > 
> > > > kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x153, data 0x74, on isa0060/serio0).
> > > > kernel: atkbd.c: Unknown key released (translated set 2, code 0x153, data 0xf4, on isa0060/serio0).
> > > > 
> > > > Email and browser keys report a correct code and I can bind thm to any app 
> > > > using xbindkeys, but with thes two there's no way.
> > > 
> > > These keys produce scancode e0 74. Untranslated e0 53.
> > > Entry 0x153 of atkbd_set2_keycode[] is 0, that is why
> > > the key is called unknown.
> > > 
> > > The normal way of assigning a keycode is by using setkeycodes.
> > > This uses the KDSETKEYCODE ioctl, but it is broken at present.
> > > 
> > > The reason is that it is written to use 0-127 for scancode xx
> > > and 128-255 for scancode pair e0 xx. (Translated set2, of course.)
> > > However, the current kernel untranslates what the keyboard sends
> > > and then uses a scancode-to-keycode mapping for untranslated set 2.
> > > That breaks this ioctl.
> > > Moreover, it uses a shift of 256 instead of 128 for e0.
> > > That also breaks this ioctl.
> > 
> > It actually works pretty well on 2.6. You jsut have to pass a different
> > number on 2.6 than you do on 2.4 - that is:
> > 
> > 	setkeycodes 153 148
> > 
> > 153 is the reported scancode (e0 53 untranslated, e0 74 translated),
> > 148 is the keycode for KEY_PROG1
> > 
> > (There is still a small bug in the bitmap setting, and I'll be fixing
> > that tonight, but unless you have more than one scancode generating the
> > same keycode, it won't bite you.)
> 
> # setkeycodes 153 148
> setkeycode: code outside bounds
> usage: setkeycode scancode keycode ...
>  (where scancode is either xx or e0xx, given in hexadecimal,
>   and keycode is given in decimal)
> 
> I tried xx153, 0e153, 0exx153 and no way.
 
Too bad. Your setkeycodes seems to do too clever input data checking. 
Although the ioctl data type for scancode is an int, it insists on the
value fitting into a byte.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
