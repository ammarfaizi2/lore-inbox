Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbSJCL0e>; Thu, 3 Oct 2002 07:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbSJCL0e>; Thu, 3 Oct 2002 07:26:34 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39385 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263252AbSJCL0c>;
	Thu, 3 Oct 2002 07:26:32 -0400
Date: Thu, 3 Oct 2002 13:31:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, tori@ringstrom.mine.nu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003133157.A38397@ucw.cz>
References: <20021003121319.B37941@ucw.cz> <200210031134.g93BYFKC000248@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210031134.g93BYFKC000248@darkstar.example.net>; from jbradford@dial.pipex.com on Thu, Oct 03, 2002 at 12:34:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:34:15PM +0100, jbradford@dial.pipex.com wrote:
> > On Thu, Oct 03, 2002 at 11:14:02AM +0100, jbradford@dial.pipex.com wrote:
> > > > 
> > > > On Thu, Oct 03, 2002 at 09:36:05AM +0100, jbradford@dial.pipex.com wrote:
> > > > > > While 2.5 has worked better than I hoped for so far, I do have a problem 
> > > > > > with the new input layer (I think) that is easily reproducible, and quite 
> > > > > > irritating.
> > > > > > 
> > > > > > If I press and hold my left Alt key, press and release the right AltGr
> > > > > > key, and then release the left Alt key, I get one of the following
> > > > > > messages in dmesg:
> > > > > 
> > > > > [snip]
> > > > > 
> > > > > > The same thing happens for a few other combinations as well. I happens 
> > > > > > both in X and in the console.
> > > > > 
> > > > > I am getting similar odd behavior with 2.5.40 and a Japanese keyboard.
> > > > > Specifically, if I bang away at repeatedly on 't', 'h', '@', and ';', I
> > > > > get unknown key messages in dmesg.
> > > > > 
> > > > > I posted about this a while ago, but I don't think anybody noticed :-)
> > > > 
> > > > Can you #define I8042_DEBUG_IO in i8042.h and send me the 'dmesg' output
> > > > of the unknown key message and data around it?
> > > 
> > > OK, that was fun - every time I managed to cause the error, by the time I'd
> > > switched to another VT, and typed dmesg, it was flooded with other keypresses
> > > :-).  I should have used a serial terminal, but anyway, here goes:
> > > 
> > > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694909]
> > > i8042.c: f0 -> i8042 (kbd-data) [694909]
> > > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694912]
> > > i8042.c: 00 -> i8042 (kbd-data) [694912]
> > > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694915]
> > > i8042.c: 41 <- i8042 (interrupt, kbd, 1) [694916]
> > > input: AT Set 2 keyboard on isa0060/serio0
> > > i8042.c: 94 <- i8042 (interrupt, kbd, 1) [694937]
> > > i8042.c: a3 <- i8042 (interrupt, kbd, 1) [694943]
> > > i8042.c: 38 <- i8042 (interrupt, kbd, 1) [696272]
> > > i8042.c: 3d <- i8042 (interrupt, kbd, 1) [696372]
> > > i8042.c: bd <- i8042 (interrupt, kbd, 1) [696440]
> > > i8042.c: b8 <- i8042 (interrupt, kbd, 1) [696446]
> > > i8042.c: 1c <- i8042 (interrupt, kbd, 1) [697112]
> > > 
> > > This was in the syslog:
> > > 
> > > Oct  3 10:54:59 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0x94, on isa0060/serio0) pressed.
> > 
> > What's on the lines just before this one from i8042.c?
> 
> Forget the above report, I've since done a more comprehensive one, (below):

Yes, that one is perfect. Now some more tests to do with the keyboard:

1) The same with i8042_direct on the kernel command line.
2) The same with i8042_direct and atkbd_set=3 on the kernel command line.

It may make the extra keyboards work and will definitely explain what's
happening in greater detail.

-- 
Vojtech Pavlik
SuSE Labs
