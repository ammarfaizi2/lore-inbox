Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbSJCMhz>; Thu, 3 Oct 2002 08:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263284AbSJCMhz>; Thu, 3 Oct 2002 08:37:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:4316 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263283AbSJCMhx>;
	Thu, 3 Oct 2002 08:37:53 -0400
Date: Thu, 3 Oct 2002 14:43:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, tori@ringstrom.mine.nu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003144319.A38785@ucw.cz>
References: <20021003133157.A38397@ucw.cz> <200210031242.g93Cg3Uh000144@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210031242.g93Cg3Uh000144@darkstar.example.net>; from jbradford@dial.pipex.com on Thu, Oct 03, 2002 at 01:42:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 01:42:02PM +0100, jbradford@dial.pipex.com wrote:

> > 1) The same with i8042_direct on the kernel command line.
> 
> OK, here is the dmesg output - I've cut out things not releating to
> the keyboard.  This shows a boot followed by presses of -
> 'Henkaku/Zenkaku', '???', 'space', '???', and 'Hiragana/Romaji':

> i8042.c: 00 <- i8042 (interrupt, kbd, 1) [138631]
> atkbd.c: Unknown key (set 2, scancode 0x0, on isa0060/serio0) pressed.
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199889]
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [199972]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199974]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200469]
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [200554]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200555]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200922]
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201024]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201025]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201415]
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201516]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201518]

Obviously, the keyboard doesn't know how to send these keys in Set 2.

> > 2) The same with i8042_direct and atkbd_set=3 on the kernel command line.
> > 
> > It may make the extra keyboards work and will definitely explain what's
> > happening in greater detail.
> 
> Right, this one is interesting - same keypresses as above, and this
> time the keys work, (excellent :-) ), Henkaku/Zenkaku is mapped to
> backtick, (as expected, as I am using a Russian keymap), and the other
> extra keys are not mapped to anything, (again, as to be expected).
> 
> i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37041]
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [37142]
> i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37143]
> i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41289]
> atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) pressed.
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [41382]
> i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41384]
> atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) released.
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42385]
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [42478]
> i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42480]
> i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43519]
> atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) pressed.
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [43596]
> i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43598]
> atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) released.
> i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45273]
> atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) pressed.
> i8042.c: f0 <- i8042 (interrupt, kbd, 1) [45366]
> i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45367]
> atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) released.

And it is happy in Set 3. Do you by any chance know the names of the
unknown keys so that I could add them to the Set 3 default scancode map?

> Interestingly, I wasn't able to reproduce the bashing multiple keys
> error, using i8042_direct or atkbd_set=3.

Yes, it can only happen without i8042_direct.

-- 
Vojtech Pavlik
SuSE Labs
