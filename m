Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbSJCKAZ>; Thu, 3 Oct 2002 06:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSJCKAZ>; Thu, 3 Oct 2002 06:00:25 -0400
Received: from userdy22.uk.uudial.com ([62.188.8.214]:1028 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263245AbSJCKAY>; Thu, 3 Oct 2002 06:00:24 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210031014.g93AE3x8000235@darkstar.example.net>
Subject: Re: 2.5.40: AT keyboard input problem
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 3 Oct 2002 11:14:02 +0100 (BST)
Cc: tori@ringstrom.mine.nu, linux-kernel@vger.kernel.org
In-Reply-To: <20021003104840.B37411@ucw.cz> from "Vojtech Pavlik" at Oct 03, 2002 10:48:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, Oct 03, 2002 at 09:36:05AM +0100, jbradford@dial.pipex.com wrote:
> > > While 2.5 has worked better than I hoped for so far, I do have a problem 
> > > with the new input layer (I think) that is easily reproducible, and quite 
> > > irritating.
> > > 
> > > If I press and hold my left Alt key, press and release the right AltGr
> > > key, and then release the left Alt key, I get one of the following
> > > messages in dmesg:
> > 
> > [snip]
> > 
> > > The same thing happens for a few other combinations as well. I happens 
> > > both in X and in the console.
> > 
> > I am getting similar odd behavior with 2.5.40 and a Japanese keyboard.  Specifically, if I bang away at repeatedly on 't', 'h', '@', and ';', I get unknown key messages in dmesg.
> > 
> > I posted about this a while ago, but I don't think anybody noticed :-)
> 
> Can you #define I8042_DEBUG_IO in i8042.h and send me the 'dmesg' output
> of the unknown key message and data around it?

OK, that was fun - every time I managed to cause the error, by the time I'd switched to another VT, and typed dmesg, it was flooded with other keypresses :-).  I should have used a serial terminal, but anyway, here goes:

i8042.c: fa <- i8042 (interrupt, kbd, 1) [694909]
i8042.c: f0 -> i8042 (kbd-data) [694909]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [694912]
i8042.c: 00 -> i8042 (kbd-data) [694912]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [694915]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [694916]
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: 94 <- i8042 (interrupt, kbd, 1) [694937]
i8042.c: a3 <- i8042 (interrupt, kbd, 1) [694943]
i8042.c: 38 <- i8042 (interrupt, kbd, 1) [696272]
i8042.c: 3d <- i8042 (interrupt, kbd, 1) [696372]
i8042.c: bd <- i8042 (interrupt, kbd, 1) [696440]
i8042.c: b8 <- i8042 (interrupt, kbd, 1) [696446]
i8042.c: 1c <- i8042 (interrupt, kbd, 1) [697112]

This was in the syslog:

Oct  3 10:54:59 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0x94, on isa0060/serio0) pressed.

I am unable to reproduce this by pressing any single key.  Only by repeatedly pressing many keys, (I.E. bashing the keyboard like mad), does this occur, (and not always with the same scancode).  Very odd.

This particular IBM Japanese keyboard seems to be even more exotic than most, in several ways, that might be relevant:

The Henkaku/Zenkaku key, which is in the top left, below escape, does not have a scancode by default, I.E. showkey -s reports nothing when it is pressed.

The three kana shift keys, (one between alt and the spacebar, and two between alt-gr and the spacebar), which are marked differently to any other Japanese keyboard I've ever seen, all report the keycode 57, and scancode 0x39 when pressed, and scancode 0xb9 when released - the same as the space bar.  Therefore it doesn't seem possible to use them as independent keys.

The keyboard has a speaker in it, and a volume control, but it's never made a single noise, apart from a click when it's switched on, (so it does work).

This is a very strange keyboard :-).  94X1110 is the IBM part number.

John.
