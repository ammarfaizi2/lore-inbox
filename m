Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUE3QJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUE3QJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUE3QJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 12:09:10 -0400
Received: from main.gmane.org ([80.91.224.249]:26570 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263942AbUE3QJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 12:09:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sun, 30 May 2004 18:08:39 +0200
Message-ID: <MPG.1b2424ed871e68c89896aa@news.gmane.org>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org> <20040530125918.GA1611@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-78-129.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 02:38:08PM +0200, Giuseppe Bilotta wrote:
> 
> > > The kernel input layer doesn't treat modifiers as special keys, and
> > > currently (include/linux/input.h) has shift, alt, ctrl and meta keys.
> > > Both left and right.  This covers all keyboards I've seen so far,
> > > including SGI, Sun, Mac, and other keyboards.
> > > 
> > > This is different from the X keysym modifiers, because the super and
> > > hyper modifiers usually don't correspond to real physical keys on the
> > > keyboard.
> > 
> > Sorry but this is untrue. My Win keys are configured as super, 
> > for example.
> 
> The Linux kernel reports them as KEY_LEFTMETA, KEY_RIGHTMETA and
> KEY_COMPOSE.

In X standard keyboards Meta is mapped as the second symbol for 
Alt.

// definition for the extra keys on 104-key "Windows95" keyboards
xkb_symbols "pc104" {
    include "us(generic101)"
    key <LALT> {	[ 	Alt_L,	Meta_L		]	};
    key <RALT> {	[	Alt_R,	Meta_R		]	};
    key <LWIN> {	[	Super_L			]	};
    key <RWIN> {	[	Super_R			]	};
    key <MENU> {	[	Menu			]	};

    // modifier mappings
    modifier_map Mod1   { Alt_L, Alt_R, Meta_L, Meta_R };
    modifier_map Mod4   { Super_L, Super_R };
}; 

// definition of Euro-style, Right "logo" key == [Mode_switch, Multi_key]
xkb_symbols "pc104euro" {
    include "us(pc104)"
    key <RALT> {        [       Mode_switch             ]       
};
    key <RWIN> {	[	Multi_key		]	};
};
 
> > > The X step could be avoided if we had a definition file for xkb for the
> > > kernel emulated keyboard.
> > 
> > That's exactly what I'm saying. But there isn't. Which is what 
> > pisses off most users.
> 
> I'm not very familiar with xkb configuration. Perhaps you'd be willing
> to write that definition file? I'll certainly help you from the kernel
> side - I can even generate a list of keycode - scancode - meaning
> relations for you.

If you do generate a list of keycode - scancode - meaning pairs 
it will surely make my life easier.

I'm not particularly familiar with xkb configuration either. I 
can *probably* make it work (i.e. test it as functional) on my 
Dell Inspiron 8200 keyboard and on a standard pc104 keyboard 
only. You probably need somebody else to work out the details 
for other keyboards, though.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

