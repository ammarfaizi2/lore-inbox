Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTAYKww>; Sat, 25 Jan 2003 05:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTAYKww>; Sat, 25 Jan 2003 05:52:52 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:2751 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266296AbTAYKwv>;
	Sat, 25 Jan 2003 05:52:51 -0500
Date: Sat, 25 Jan 2003 12:01:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, tomita@cinet.co.jp, miura@da-cha.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
Message-ID: <20030125120113.B28830@ucw.cz>
References: <20030125113324.D28292@ucw.cz> <200301251051.h0PApiox000308@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200301251051.h0PApiox000308@darkstar.example.net>; from john@grabjohn.com on Sat, Jan 25, 2003 at 10:51:44AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 10:51:44AM +0000, John Bradford wrote:

> > > > > --- linux-2.5.59/drivers/input/keyboard/atkbd.c       2002-12-03 07:59:41.000000000 +0900
> > > > > +++ edited/linux-2.5.59/drivers/input/keyboard/atkbd.c        2003-01-24 09:13:11.000000000 +0900
> > > > > @@ -309,6 +309,12 @@
> > > > >       if (atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_GSCANSET))
> > > > >               atkbd->oldset = 2;
> > > > >
> > > > > +     if (atkbd->id == 0xab02) {
> > > > > +             printk("atkbd: jp109(106) keyboard found\n");
> > > > > +             param[0] = atkbd_set;
> > > > > +             atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET);
> > > > > +             return 5;
> > > > > +     }
> > > > >  /*
> > > > >   * For known special keyboards we can go ahead and set the correct set.
> > > > >   * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
> > > > > @@ -531,6 +537,12 @@
> > > > >       else
> > > > >               memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
> > > > >
> > > > > +     if (atkbd->set == 5) {
> > > > > +             atkbd->keycode[0x13] = 0x70;  /* Hiragana/Katakana */
> > > > > +             atkbd->keycode[0x6a] = 0x7c;  /* Yen, pipe 124*/
> > > I think he catches good point. Kernel 2.0-2.4 use keycode 124 (0x7c) for scancode 0x6a.
> > > 2.5 uses keycode 183. This breaks jp106 keymaps. We cannot type '\' and '|' from jp106
> > > keyboard on 2.5 kernel.
> > > I believe there is no impact by changing keycode 183 to 124.
> > 
> > Well, it's not so easy. Fortunately KEY_KPCOMMA can be relatively easily
> > moved elsewhere, however keys 181 to 198 are 'international and language
> > keys', defined the same way as USB/HID spec (please take a look at it).
> > Having a single one of them remapped elsewhere doesn't look so nice.
> 
> The keymapping on my Japanese keyboard changes quite a bit when it's
> set up to use set 3, instead of the default set 2.  I've temporarily
> switched back to using set 2, until I've got time to set it up
> properly, but the language keys don't function in set 2, (they
> generate the same scancode as the space bar).
> 
> Let me know if I can provide any extra info from this keyboard - it's
> an IBM 5576 Keyboard-2, part number 94X1110.

If you can provide the complete key -> scancode table for that keyboard,
or at least differences against standard US keyboard for both set 2 and
set 3, that'd be great.

-- 
Vojtech Pavlik
SuSE Labs
