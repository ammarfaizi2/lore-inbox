Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSJCNME>; Thu, 3 Oct 2002 09:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261278AbSJCNME>; Thu, 3 Oct 2002 09:12:04 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:46300 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261277AbSJCNMC>;
	Thu, 3 Oct 2002 09:12:02 -0400
Date: Thu, 3 Oct 2002 15:17:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, tori@ringstrom.mine.nu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003151718.A39115@ucw.cz>
References: <20021003144319.A38785@ucw.cz> <200210031320.g93DKnqx000460@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210031320.g93DKnqx000460@darkstar.example.net>; from jbradford@dial.pipex.com on Thu, Oct 03, 2002 at 02:20:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:20:48PM +0100, jbradford@dial.pipex.com wrote:
> > > i8042.c: 00 <- i8042 (interrupt, kbd, 1) [138631]
> > > atkbd.c: Unknown key (set 2, scancode 0x0, on isa0060/serio0) pressed.
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199889]
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [199972]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199974]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200469]
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [200554]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200555]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200922]
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201024]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201025]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201415]
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201516]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201518]
> > 
> > Obviously, the keyboard doesn't know how to send these keys in Set 2.
> 
> Ah, OK, so I need to force it to use Set 3 by default.  Passing atkbd_set=3 on it's own didn't seem to work, (only works with i8042_direct).

Yes, set 3 can only work correctly with atkbd_direct also specified.

> > > i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37041]
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [37142]
> > > i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37143]
> > > i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41289]
> > > atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) pressed.
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [41382]
> > > i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41384]
> > > atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) released.
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42385]
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [42478]
> > > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42480]
> > > i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43519]
> > > atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) pressed.
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [43596]
> > > i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43598]
> > > atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) released.
> > > i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45273]
> > > atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) pressed.
> > > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [45366]
> > > i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45367]
> > > atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) released.
> > 
> > And it is happy in Set 3.
> 
> Seems like it, yes.
> 
> > Do you by any chance know the names of the unknown keys so that I could
> > add them to the Set 3 default scancode map?
> 
> All I can tell you is a translation of what is written on the scancode 0x87 key on this particular keyboard:
> 
> 'Hiragana/Roma_characters'
> 
> I can't translate the characters on the other keys.
> 
> However, somebody else might be able to - I found this diagram of the keyboard:
> 
> http://www.pfu.co.jp/hhkeyboard/kb_collection/ibm5576-002.gif
> 
> The legends on the bottom row of keys are exactly the same as on my keyboard, and from left to right, they have the following functions:
> 
> Control
> ALT, (it says, 'Kanji/Katakana/Kanji???', but works as ALT)
> Scancode 0x85
> Space bar
> Scancode 0x86
> Scancode 0x87, (it says, 'Hiragana/Roma characters')
> ALT GR
> Control
> 
> Sorry I can't be more help than that :-).

Well, I maybe just will use the keycodes KEY_INTL1,2,... or KEY_LANG1,2,.. :)

Thanks!

> > > Interestingly, I wasn't able to reproduce the bashing multiple keys
> > > error, using i8042_direct or atkbd_set=3.
> > 
> > Yes, it can only happen without i8042_direct.
> 
> Ah, OK, cool.

-- 
Vojtech Pavlik
SuSE Labs
