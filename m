Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSJCNHw>; Thu, 3 Oct 2002 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSJCNHw>; Thu, 3 Oct 2002 09:07:52 -0400
Received: from 62-190-218-74.pdu.pipex.net ([62.190.218.74]:11269 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261224AbSJCNGu>; Thu, 3 Oct 2002 09:06:50 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210031320.g93DKnqx000460@darkstar.example.net>
Subject: Re: 2.5.40: AT keyboard input problem
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 3 Oct 2002 14:20:48 +0100 (BST)
Cc: tori@ringstrom.mine.nu, linux-kernel@vger.kernel.org
In-Reply-To: <20021003144319.A38785@ucw.cz> from "Vojtech Pavlik" at Oct 03, 2002 02:43:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > i8042.c: 00 <- i8042 (interrupt, kbd, 1) [138631]
> > atkbd.c: Unknown key (set 2, scancode 0x0, on isa0060/serio0) pressed.
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199889]
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [199972]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199974]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200469]
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [200554]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200555]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200922]
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201024]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201025]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201415]
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201516]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201518]
> 
> Obviously, the keyboard doesn't know how to send these keys in Set 2.

Ah, OK, so I need to force it to use Set 3 by default.  Passing atkbd_set=3 on it's own didn't seem to work, (only works with i8042_direct).

> > i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37041]
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [37142]
> > i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37143]
> > i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41289]
> > atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) pressed.
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [41382]
> > i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41384]
> > atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) released.
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42385]
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [42478]
> > i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42480]
> > i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43519]
> > atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) pressed.
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [43596]
> > i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43598]
> > atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) released.
> > i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45273]
> > atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) pressed.
> > i8042.c: f0 <- i8042 (interrupt, kbd, 1) [45366]
> > i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45367]
> > atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) released.
> 
> And it is happy in Set 3.

Seems like it, yes.

> Do you by any chance know the names of the unknown keys so that I could
> add them to the Set 3 default scancode map?

All I can tell you is a translation of what is written on the scancode 0x87 key on this particular keyboard:

'Hiragana/Roma_characters'

I can't translate the characters on the other keys.

However, somebody else might be able to - I found this diagram of the keyboard:

http://www.pfu.co.jp/hhkeyboard/kb_collection/ibm5576-002.gif

The legends on the bottom row of keys are exactly the same as on my keyboard, and from left to right, they have the following functions:

Control
ALT, (it says, 'Kanji/Katakana/Kanji???', but works as ALT)
Scancode 0x85
Space bar
Scancode 0x86
Scancode 0x87, (it says, 'Hiragana/Roma characters')
ALT GR
Control

Sorry I can't be more help than that :-).

> > Interestingly, I wasn't able to reproduce the bashing multiple keys
> > error, using i8042_direct or atkbd_set=3.
> 
> Yes, it can only happen without i8042_direct.

Ah, OK, cool.

John.
