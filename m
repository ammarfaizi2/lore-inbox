Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTI3Pqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTI3Pqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:46:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:13793 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261575AbTI3Pqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:46:47 -0400
Date: Tue, 30 Sep 2003 17:46:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Pau Aliagas <linuxnow@newtral.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: multimedia keys not working in 2.6.0-test6
Message-ID: <20030930154640.GA27057@ucw.cz>
References: <Pine.LNX.4.44.0309301351220.2486-100000@pau.intranet.ct> <20030930145621.GA1297@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930145621.GA1297@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 04:56:21PM +0200, Andries Brouwer wrote:

> On Tue, Sep 30, 2003 at 01:54:59PM +0200, Pau Aliagas wrote:
> 
> > These are the messages I get when pressing P1 and P2 in my laptop.
> > 
> > kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x153, data 0x74, on isa0060/serio0).
> > kernel: atkbd.c: Unknown key released (translated set 2, code 0x153, data 0xf4, on isa0060/serio0).
> > 
> > Email and browser keys report a correct code and I can bind thm to any app 
> > using xbindkeys, but with thes two there's no way.
> 
> These keys produce scancode e0 74. Untranslated e0 53.
> Entry 0x153 of atkbd_set2_keycode[] is 0, that is why
> the key is called unknown.
> 
> The normal way of assigning a keycode is by using setkeycodes.
> This uses the KDSETKEYCODE ioctl, but it is broken at present.
> 
> The reason is that it is written to use 0-127 for scancode xx
> and 128-255 for scancode pair e0 xx. (Translated set2, of course.)
> However, the current kernel untranslates what the keyboard sends
> and then uses a scancode-to-keycode mapping for untranslated set 2.
> That breaks this ioctl.
> Moreover, it uses a shift of 256 instead of 128 for e0.
> That also breaks this ioctl.

It actually works pretty well on 2.6. You jsut have to pass a different
number on 2.6 than you do on 2.4 - that is:

	setkeycodes 153 148

153 is the reported scancode (e0 53 untranslated, e0 74 translated),
148 is the keycode for KEY_PROG1

(There is still a small bug in the bitmap setting, and I'll be fixing
that tonight, but unless you have more than one scancode generating the
same keycode, it won't bite you.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
